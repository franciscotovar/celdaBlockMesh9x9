/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | foam-extend: Open Source CFD                    |
|  \\    /   O peration     | Version:     3.2                                |
|   \\  /    A nd           | Web:         http://www.foam-extend.org         |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    object      blockMeshDict;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

changecom(//)changequote([,])

define(calc, [esyscmd(perl -e 'printf ($1)')])

define(VCOUNT, 0)

define(vlabel, [[// ]Vertex $1 = VCOUNT define($1, VCOUNT)define([VCOUNT], incr(VCOUNT))])


define(hex2D, hex ($1b $2b $3b $4b $1t $2t $3t $4t))

define(quad2D, ($1b $2b $2t $1t))

define(frontQuad, ($1t $2t $3t $4t))

define(backQuad, ($1b $4b $3b $2b))

scale 1e-6;

define(nrcellsx, 10) 
define(nrcellsy, 10) 
define(nrcellsx2, 12)
define(nrcellsy2, 12)
define(nrcellsy3, 4)
define(origox, 0.0)
define(origoy, 0.0)

define(off_width, 100.0)

define(x0, calc(origox))
define(x1, calc(origox + off_width*2))
define(x2, calc(origox + off_width*3))
define(x3, calc(origox + off_width*4))
define(x4, calc(origox + off_width*4))
define(x5, calc(origox + off_width*5))
define(x6, calc(origox + off_width*6))
define(x7, calc(origox + off_width*7))
define(x8, calc(origox + off_width*8))
define(x9, calc(origox + off_width*9))

define(y6, calc(origoy + off_width*0))
define(y7, calc(origoy + off_width*1))
define(y8, calc(origoy + off_width*2))
define(y9, calc(origoy + off_width*3))

define(Z1, 50.0)
define(Z2, 0.0)

//vertices definition

vertices
(    
    (x0 y9 Z1) vlabel(a0b)
    (x1 y9 Z1) vlabel(a1b)
    (x2 y9 Z1) vlabel(a2b)
    (x3 y9 Z1) vlabel(a3b)

    
    (x0 y8 Z1) vlabel(a10b)
    (x1 y8 Z1) vlabel(a11b)
    (x2 y8 Z1) vlabel(a12b)
    (x3 y8 Z1) vlabel(a13b)

    (x0 y7 Z1) vlabel(a20b)
    (x1 y7 Z1) vlabel(a21b)
    (x2 y7 Z1) vlabel(a22b)
    (x3 y7 Z1) vlabel(a23b)
    
    (x0 y6 Z1) vlabel(a30b)
    (x1 y6 Z1) vlabel(a31b)
    (x2 y6 Z1) vlabel(a32b)
    (x3 y6 Z1) vlabel(a33b)


    (x0 y9 Z2) vlabel(a0t)
    (x1 y9 Z2) vlabel(a1t)
    (x2 y9 Z2) vlabel(a2t)
    (x3 y9 Z2) vlabel(a3t)

    
    (x0 y8 Z2) vlabel(a10t)
    (x1 y8 Z2) vlabel(a11t)
    (x2 y8 Z2) vlabel(a12t)
    (x3 y8 Z2) vlabel(a13t)

    
    (x0 y7 Z2) vlabel(a20t)
    (x1 y7 Z2) vlabel(a21t)
    (x2 y7 Z2) vlabel(a22t)
    (x3 y7 Z2) vlabel(a23t)

    
    (x0 y6 Z2) vlabel(a30t)
    (x1 y6 Z2) vlabel(a31t)
    (x2 y6 Z2) vlabel(a32t)
    (x3 y6 Z2) vlabel(a33t)
   
);

//blockDefinition
blocks
(
    // block1
    hex2D(a10, a11, a21, a20) pdms1
    (nrcellsx nrcellsy 1)
    simpleGrading (1 1 1)
    
    // block2
    hex2D(a11, a12, a22, a21) pdms2
    (nrcellsx nrcellsy 1)
    simpleGrading (1 1 1)
    
    // block3
    hex2D(a12, a13, a23, a22) pdms3
    (nrcellsx nrcellsy 1)
    simpleGrading (1 1 1)
    
    // block4
    hex2D(a2, a3, a13, a12) pdms4 //tjup
    (nrcellsx nrcellsy 1)
    simpleGrading (1 1 1)
    
    hex2D(a22, a23, a33, a32) pdms5 //tjdown
    (nrcellsx nrcellsy 1)
    simpleGrading (1 1 1)

   
);


//BC
patches
(
        wall walls
    (
    
	quad2D(a10,a11)
	quad2D(a11,a12)
	quad2D(a12,a2) 
	quad2D(a3,a13)   
	quad2D(a13,a23) 
	
	quad2D(a23,a33)
	quad2D(a20,a21)
	quad2D(a21,a22)
	quad2D(a22,a32)
		
    )
    
    patch inlet 
	(
		quad2D(a10,a20)

	)   

	
	patch outlet 
	(
		quad2D(a2,a3)
		quad2D(a33,a32)

	) 

    empty back
    (
      backQuad(a20, a21, a11, a10) 
      backQuad(a21, a22, a12, a11) 
      backQuad(a22, a23, a13, a12)

      backQuad(a12, a13, a3, a2) 
      backQuad(a32, a33, a23, a22) 
          
      )

      empty front
      (
      frontQuad(a20, a21, a11, a10) 
      frontQuad(a21, a22, a12, a11) 
      frontQuad(a22, a23, a13, a12)

      frontQuad(a12, a13, a3, a2) 
      frontQuad(a32, a33, a23, a22) 
         
      )

 
    
);

