Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sdp
From: Marcel Holtmann <marcel@holtmann.org>
To: Jorge =?ISO-8859-1?Q?Gonz=E1lez?= <jorge@naxus.biz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1083853467.28356.18.camel@pancho>
References: <1083853467.28356.18.camel@pancho>
Content-Type: text/plain
Message-Id: <1083877519.4420.78.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 06 May 2004 23:05:19 +0200

Hi Jorge,

> I am trying to get working the sdp tools in order to make the PDA know
> what services are provided by a linux machine.
> 
> But I get this when I try to compile:
> -----------------------------------------
> /bin/sh ../libtool --mode=link gcc  -Wall -g -O2   -o sdptool  sdptool.o
> listattr.o setattr.o -L../libs -lsdp /usr/lib/libbluetooth.la
> libtool: link: cannot find the library `'
> -----------------------------------------
> 
> I think the problem is -lsdp which is not found. How could I get this
> library??

if you use bluez-libs prior 2.6 than install bluez-sdp.

> I dont know if this type questions are supposed to be in bluez-users or
> bluez-devel. If this is no the appropiate list for this questions I
> would be appreciate to know :D

For me it doesn't matter as long as you don't start cross-posting ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
