Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050718085659.20030.qmail@web15704.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: [Bluez-devel] How can I talk with others through bluetooth modules?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 18 Jul 2005 16:56:59 +0800 (CST)

Hi,
My case is as follows:
I use two CSR(Bluecore2) modlues on two arm platforms
respectively . And now,I can create ACL and SCO
connection,both l2test and scotest run well.Even,I can
transmit files using the program obex_test.
I just want to transmit voice data through bluetooth
modules so that I can talk with others using
microphone.And I connected a C145483 Codec throught
PCM interface yesterady.But I have no idea about how
to do now.which profile should I use? sdptool add
Headset?I think it"s not the right one! The hardware
is just bluetooth module,not headset! And if I add the
right profile,what should I do next?? Maybe some tools
just like btsco?
 
 [\u@\h \W]\$ hciconfig hci0 version revision
 hci0:   Type: UART
         BD Address: 4A:49:4E:00:15:2D ACL MTU: 384:4
SCO MTU: 64:8
         HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver:
1.1 (0x1) LMP Subver: 0x2c1
         Manufacturer: Cambridge Silicon Radio (10)
         Build 705
         Chip version: BlueCore02-External
         Max key size: 56 bit
         SCO mapping:  PCM

Any help will always be appreciated !

Regards
gadfly


	

	
		
___________________________________________________________ 
—≈ª¢√‚∑—G” œ‰£≠÷–π˙µ⁄“ªæ¯Œﬁ¿¨ª¯” º˛…ß»≈≥¨¥Û” œ‰
http://cn.mail.yahoo.com/?id=77071



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
