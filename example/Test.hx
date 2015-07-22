import Mithril.*;

@:expose('Test')
class Test{
  static function run(){
    var test = new Test();
    Mithril.routeMode = 'hash';
    Mithril.route(js.Browser.document.body, '/', {
      '/':test,
      '/a':test,
      '/b':test,
    });
  }
  function new(){
  }

  function controller(){
    return {v: Mithril.routeParam('filter')};
  }

  function view(ctrl){
    switch(ctrl.v){
      case 'a', 'b':
        return [
          'This is ${ctrl.v.toUpperCase()} ',
          m('a[href=/]', {config: Mithril.route}, 'Back'),
        ];
      case _:
        return [
          'This is main ',
          m('a[href=/a]', {config: Mithril.route}, 'Go A'),
          m('a[href=/b]', {config: Mithril.route}, 'Go B'),
        ];
    }
  }
  public static function main(){}
}
