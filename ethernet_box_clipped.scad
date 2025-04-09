
// This version fits the Olimex Ethernet board with the
// unneeded header pins clipped off.


wiggle_room = 0.3;

my_fn=40;

width_inner = 38;
length_inner = 48;
height_inner = 22.5;



wall_thickness = 2.0;

width_outer = width_inner + (2 * wall_thickness);
length_outer = length_inner + (2 * wall_thickness);
height_outer = height_inner + (2 * wall_thickness);

lid_height_i = 6.0;
lid_height = lid_height_i + wall_thickness;
lid_width_i = width_inner + wall_thickness;

lid_length_i = length_inner + wall_thickness;

proper_lid_height = height_outer-wall_thickness-lid_height;

module connectorHoles() {
    ethHeight = 16.0;
    ethWidth = 17.0;
    ethYoff = 3.5;
    ribbonHeight = 6.0;
    ribbonWidth = 15.0;
    ribbonYoff = 16.5;
    #translate([0,length_outer/2,ethYoff+ethHeight/2])
        cube([ethWidth,20,ethHeight], center=true);
    #translate([0,-length_outer/2,ribbonYoff+ribbonHeight/2])
        cube([ribbonWidth,20,ribbonHeight], center=true);
}

// Interior floor of box is at z=0.
module rawBox() {
    difference() {
        translate(v=[0,0,height_inner/2]) difference() {
            cube([width_outer,length_outer,height_outer],center=true);
            cube([width_inner,length_inner,height_inner],center=true);
        }
    }
}




module lidHoles() {
    $fn = 32;
    hole_sep = 9.3;
    hole_dia = 7.0;
    for(x = [-(width_inner/2)+5 : hole_sep : (width_inner/2)-5]) {
        for(y = [-(length_inner/2)+5 : hole_sep : (length_inner/2)-5]) {
            echo(x, y);
            translate([x, y, 0]) cylinder(d=hole_dia, h=20.0, center = true);
        }
    }
}



// This does not have the connector holes!
module rawLidAtZero() {
	difference() {
		translate(v=[0,0,lid_height/2]) cube([width_outer,length_outer,lid_height],center=true);
		translate(v=[0,0,lid_height_i/2]) cube([lid_width_i,lid_length_i,lid_height_i],center=true);
        #lidHoles();
	}
}

// This does not have the connector holes!
module rawLidAtZeroWithWiggle() {
	difference() {
		translate(v=[0,0,lid_height/2]) cube([width_outer,length_outer,lid_height],center=true);
		translate(v=[0,0,lid_height_i/2]) cube([lid_width_i - wiggle_room,lid_length_i  - wiggle_room,lid_height_i],center=true);
	}
}


module lidAtProperHeight() {
    difference() {
        translate(v=[0,0,proper_lid_height]) rawLidAtZero();
        #connectorHoles();
    }
}



module lidAtProperHeightWithWiggle() {
    difference() {
        translate(v=[0,0,proper_lid_height]) rawLidAtZeroWithWiggle();
        #connectorHoles();
    }
}

module boxNoLid() {
	difference() {
		rawBox();
        connectorHoles();
		#lidAtProperHeightWithWiggle();
	}
}



module boxPrintable() {
	translate(v=[(width_outer/2)+5,0,0]) boxNoLid();
	translate(v=[(width_outer/-2)-5,0, proper_lid_height+lid_height_i]) rotate([0,180,0]) lidAtProperHeight();
}


module boxOnlyPrintable() {
	boxNoLid();
}

module lidOnlyPrintable() {
	translate(v=[0,0,lid_height]) rotate([180,0,0]) lidAtProperHeight();
}


// Square box
//boxPrintable();
boxOnlyPrintable();
//lidOnlyPrintable();

//boxNoLid();
//translate([0,0,20]) lidAtProperHeightWithWiggle();

//myBox();
//lidAtProperHeightWithWiggle();
//lidAtProperHeight();

