Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404C7FC9.7010002@lnt.uni-saarland.de>
From: Eric Chapman <eric@lnt.uni-saarland.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Re: Bluez on Axis DevBoard 82
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 08 Mar 2004 15:14:33 +0100

Hi Tobias,

At your institute we are also trying to use an axis devboard to 
experiment with bluetooth applications. One of the primary goals is to 
get Bluez running on the board

 > we need help to compile and install Bluez on the Axis Devboard 82 
with  > a cross-compiler.
 >
 > The DevBoard-Software is running on our computer and we flashed the
 > new kernel on the DevBoard successful.
 >
 > We solved the kernel part of bluez as well, but we don't know, how to
 > configure and install the other parts.

I suppose you mean that you made the Kernel USB-ready for a USB 
Bluettooth adapter?

 > We need the packages bluez-libs, -utils, -sdp and -pan on the
 > DevBoard.
 >
 > Can somebody give as an example for how to compile such a package with
 > cris-gcc?

To my knowledge (and according to axis) there is no straightforward way 
to do this. The libs, I got to compile, but they do you no good all by 
themselves. I for my part have tried to autocompile the libs, utils etc 
with no luck for axis (using command-line lib invocation, config.site an 
shell parameters the way Marcel suggests). The only way I have found to 
work is to manually write a makefile from scratch which will then 
compile hciattach, hcitool...
hcid poses a problem because of the need for ybison to parse the conf file.
At this point the trouble is to get these things to compile using the 
axis top-level makefile so that the binaries may be flashed to the board 
and be used as applications

greets, Eric

-- 
Eric Chapman

-----------------
Lehrstuhl für Nachrichtentechnik
Universität des Saarlandes

-- 
Eric Chapman

-----------------
Lehrstuhl für Nachrichtentechnik
Universität des Saarlandes
Postfach 15 11 50
D-66041 Saarbrücken
Tel: +49 681 302 3975
Fax: +49 681 302 3972
Web: www.lnt.uni-saarland.de




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
