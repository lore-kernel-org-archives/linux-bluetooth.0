Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: Re: [Bluez-devel] BCSP not working
From: Carlos AM <Carlos@naxus.biz>
To: bluez-devel lista <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1092837900.28955.124.camel@localhost.localdomain>
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
Date: Wed, 18 Aug 2004 16:05:00 +0200

The script in the last message was wrong. Sorry.
I used bcsp:
------------------------------------------------------------
#!/bin/sh
/bluez/hcid -n &
/bluez/bluezmain hciattach -n /dev/tts/2 bcsp 115200 &
/bluez/bluezmain hciconfig hci0 up
/bluez/sdpd -n &
/bluez/bluezmain sdptool add sp
#my own program
/bluez/rfcomm-server 1
------------------------------------------------------------






-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
