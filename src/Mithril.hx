#if !macro

private typedef Prop<T> = ?T->T;

private typedef Component<D> = {
  function new(o:D):Void;
  function view():Node;
}

class Comp<D, T:Component<D>>{
  var attrs:Null<{key:String}>;
  public function new(cl:Class<T>, arg:D, key:String){
    controller = function() return untyped __js__('new cl')(arg);
    if(key != null) attrs = {key:key};

  }
  var controller:Dynamic;
  function view(ctrl){
    return ctrl.view();
  }
}

private typedef Promize = Dynamic;

abstract Node(Dynamic) from Comp<Dynamic, Dynamic> from String from Float from Array<Node>{
  public inline function new(v:Dynamic) this = v;
}

private typedef MithrilFn = String->?Dynamic->?Node->Node;

#else // Types macros need to run
  private typedef Component<T> = Dynamic;
#end

#if !macro @:native('M') extern #end
class Mithril{

  // MACRO HELPERS
  public static macro function set(expr:haxe.macro.Expr){
    return macro function(v) $expr = v;
  }

  public static macro function setAttr(name:String, expr:haxe.macro.Expr){
    return macro Mithril.withAttr($v{name}, function(v) $expr = v);
  }

  public static macro function component<D, T:Component<D>>(expr:haxe.macro.Expr.ExprOf<Class<T>>, ?arg:haxe.macro.Expr.ExprOf<D>, ?key:haxe.macro.Expr.ExprOf<String>){
    return macro (new Mithril.Comp($expr, $arg, $key):Mithril.Node);
  }


  // REAL METHODS
  #if !macro

  public static inline function routeParam(name:String):Null<String> return (untyped route).param(name);
  public static var routeMode(get,set):String;
  static inline function get_routeMode():String return (untyped route).mode;
  static inline function set_routeMode(v:String):String return (untyped route).mode = v;

  public static inline function getRoute():String return (untyped route)();
  public static inline function setRoute(v:String):Void (untyped route)(v);
  public static function route(el:js.html.Element, def:String, routes:Dynamic):Void;

  public static function trust(code:String):Node;
  public static function prop<T>(v:T):Prop<T>;
  public static function mount(el:js.html.Element, comp:Node):Void;
  public static function withAttr(name:String, fn:Dynamic->Void):Void->Void;
  public static function request(opts:Dynamic):Promize;
  public static function startComputation():Void;
  public static function endComputation():Void;
  public static function redraw():Void;
  public static var m(get, null):MithrilFn;

  static inline function get_m():MithrilFn return untyped Mithril;
  static function __init__():Void var M = untyped __js__('m');

  #end
}

