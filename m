Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404DA19C.304@lnt.uni-saarland.de>
From: Eric Chapman <eric@lnt.uni-saarland.de>
MIME-Version: 1.0
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <404C38C7.5040805@soft.uni-linz.ac.at> <404C64E9.7080106@superbug.demon.co.uk> <404D6D91.9050602@soft.uni-linz.ac.at>
In-Reply-To: <404D6D91.9050602@soft.uni-linz.ac.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] USB Device hangs
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
Date: Tue, 09 Mar 2004 11:51:08 +0100

Hi List,

I am currently using a Axis Developer Board (Embedded Linux), for which=20
I have cross-compiled parts of BlueZ. I am using 2 Bluettooth dongles,=20
one serial and on USB. Both have a CSR BC02 chip and are rev. 16.4.
I can "hciconfig up" and "down" them, inquire via "hcitool inq". But as=20
soon as I do a "hcitool scan" or a "l2ping" using the USB dongle, the=20
whole box freezes up. With the serial one (which I have to activate=20
first using "hciattach") everything works just fine. Unfortunately I=20
need the USB for matters of speed.

Anyone got a hint where to start lookin, or how to maybe get some=20
debugging info out of hcitool (for ex.) before it crashes?

Eric

--=20
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
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
