Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Tobias Sprafke" <webmaster@baxter-net.de>
To: "Eric Chapman" <eric@lnt.uni-saarland.de>,
   <bluez-devel@lists.sourceforge.net>
Subject: AW: [Bluez-devel] Re: Bluez on Axis DevBoard 82
Message-ID: <DGELJAKAPGMFDACACGBEKEJECCAA.webmaster@baxter-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <404C7FC9.7010002@lnt.uni-saarland.de>
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
Date: Mon, 8 Mar 2004 16:59:28 +0100

Hi Eric, hi Marcel,

with "kernel part of bluez" I really mean this part of bluez,
which could be configured in the linux kernel.
After installing the Axis-DevBoard-Software, there isn't a submenu for
Bluetooth anymore
when running "make xconfig" ...


Right, the best way to install bluez, is to write an own
"Bluez-Toplevel-Makefile".
Read more about an example for a Makefile at:
http://mhonarc.axis.se/bluetooth-dev/msg04154.html

Regards
Tobias Sprafke

Mobile: +49 (0) 177 64 32 313
Fon:    +49 (0) 208 75 10 123
E-Mail: tobias.sprafke@baxter-net.de

-----Urspr=FCngliche Nachricht-----
Von: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net]Im Auftrag von Eric
Chapman
Gesendet: Montag, 8. M=E4rz 2004 15:15
An: bluez-devel@lists.sourceforge.net
Betreff: [Bluez-devel] Re: Bluez on Axis DevBoard 82


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
hcid poses a problem because of the need for ybison to parse the conf fil=
e.
At this point the trouble is to get these things to compile using the
axis top-level makefile so that the binaries may be flashed to the board
and be used as applications

greets, Eric

--
Eric Chapman

-----------------
Lehrstuhl f=FCr Nachrichtentechnik
Universit=E4t des Saarlandes

--
Eric Chapman

-----------------
Lehrstuhl f=FCr Nachrichtentechnik
Universit=E4t des Saarlandes
Postfach 15 11 50
D-66041 Saarbr=FCcken
Tel: +49 681 302 3975
Fax: +49 681 302 3972
Web: www.lnt.uni-saarland.de




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
