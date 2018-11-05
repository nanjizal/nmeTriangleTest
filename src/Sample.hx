import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Rectangle;
import nme.display.BitmapData;
import nme.display.Graphics;
import nme.display.TriangleCulling;
import nme.Lib;
import trilateralXtra.fDrawing.PolyPainter;

// Derived from NME sample 09
class Sample extends Sprite 
{
   var t0:Float;
   var s0:Sprite;
   var s1:Sprite;
   
   public function new()
   {
      super();
      addChild(s0 = new Sprite());
      addChild(s1 = new Sprite());
      
      s0.scaleX = s0.scaleY = 0.5;
      s1.scaleX = s1.scaleY = 0.5;
      
      s1.x = 550/2;
      
      onLoaded( nme.Assets.getBitmapData("justin.jpg") );
   }

   function onLoaded(inData:BitmapData)
   {
      var me = this;
      t0 = haxe.Timer.stamp();
      stage.addEventListener( Event.ENTER_FRAME, function(_) { me.doUpdate(inData); } );
   }

   function doUpdate(inData:BitmapData)
   {

      var sx = 1.0/inData.width;
      var sy = 1.0/inData.height;

      var theta = (haxe.Timer.stamp()-t0);
      var cos = Math.cos(theta);
      var sin = Math.cos(theta);
      var z = sin*100;
      var w0 = 150.0/(200.0+z);
      var w1 = 150.0/(200.0-z);

      var x0 = 200;
      var y0 = 200;
      var vertices = [
        x0 + 100*cos*w0,  y0  -100*w0,
        x0 + 100*cos*w0,  y0  +100*w0,
        x0 - 100*cos*w1,  y0  +100*w1,
        x0 - 100*cos*w1,  y0  -100*w1];

      var indices = [
         0, 1, 2,
         2, 3, 0 ];

      var tex_uv = [
        100.0*sx, 0.0,
        100.0*sx, 200.0*sy,
        300.0*sx, 200.0*sy,
        300.0*sx, 0.0  ];

      var tex_uvt = [
        100.0*sx, 0.0, w0,
        100.0*sx, 200.0*sy, w0,
        300.0*sx, 200.0*sy, w1,
        300.0*sx, 0.0, w1  ];

      var cols = [ 0xffff0000,
                   0xff00ff00,
                   0xff0000ff,
                   0xffffff00,
                   0xffffffff ];
     
      var pp0 = new PolyPainter();
      pp0.graphics = s0.graphics;
      pp0.begin( ShaderMode.ImageMode );
      pp0.drawImageTriangleGradient( vertices[0], vertices[1]
                                  , vertices[2], vertices[3]
                                  , vertices[4], vertices[5]
                                  , tex_uv[0], tex_uv[1]
                                  , tex_uv[2], tex_uv[3]
                                  , tex_uv[4], tex_uv[5]
                                  , inData, cols[4], cols[4], cols[4], 0.2 );
      pp0.drawImageTriangleGradient( vertices[0], vertices[1]
                                  , vertices[6], vertices[7]
                                  , vertices[4], vertices[5]
                                  , tex_uv[0], tex_uv[1]
                                  , tex_uv[6], tex_uv[7]
                                  , tex_uv[4], tex_uv[5]
                                  , inData, cols[4], cols[4], cols[4], 0.2 );
      pp0.end();
      
      var pp1 = new PolyPainter();
      pp1.graphics = s1.graphics;
      pp1.begin( ShaderMode.GradientMode );
      pp1.drawGradientTriangle( vertices[0], vertices[1]
                                  , vertices[2], vertices[3]
                                  , vertices[4], vertices[5]
                                  , cols[0], cols[3], cols[2] );
      pp1.drawGradientTriangle( vertices[0], vertices[1]
                                  , vertices[6], vertices[7]
                                  , vertices[4], vertices[5]
                                  , cols[0], cols[1], cols[2] );
      pp1.end();
   }
}
