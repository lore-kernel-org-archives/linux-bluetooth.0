Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Jorge =?ISO-8859-1?Q?Gonz=E1lez?= <jorge@naxus.biz>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1083853467.28356.18.camel@pancho>
Mime-Version: 1.0
Subject: [Bluez-devel] Sdp
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
Date: Thu, 06 May 2004 16:24:54 +0200

Hello

I am trying to get working the sdp tools in order to make the PDA know
what services are provided by a linux machine.

But I get this when I try to compile:
-----------------------------------------
/bin/sh ../libtool --mode=link gcc  -Wall -g -O2   -o sdptool  sdptool.o
listattr.o setattr.o -L../libs -lsdp /usr/lib/libbluetooth.la
libtool: link: cannot find the library `'
-----------------------------------------

I think the problem is -lsdp which is not found. How could I get this
library??


I dont know if this type questions are supposed to be in bluez-users or
bluez-devel. If this is no the appropiate list for this questions I
would be appreciate to know :D

Thanks,

Jorge



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
