Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050719031114.82492.qmail@web15710.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: [Bluez-devel] Re: How can I talk with others through bluetooth modules?
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
Date: Tue, 19 Jul 2005 11:11:14 +0800 (CST)

Hi,Peter
Thanks for your reply.
 [\u@\h \W]\$ hciconfig hci0 version revision
   hci0:   Type: UART
           BD Address: 4A:49:4E:00:15:2D ACL MTU:
384:4
  SCO MTU: 64:8
           HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver:
  1.1 (0x1) LMP Subver: 0x2c1
           Manufacturer: Cambridge Silicon Radio (10)
           Build 705
           Chip version: BlueCore02-External
           Max key size: 56 bit
           SCO mapping:  PCM
I had compiled pskey,and it could reconfigure
scomap.But the revision says "SCO mapping:  PCM",so I
think sco maps PCM instead of HCI,right?
And I guess maybe there is a switch that can
open/close the PCM interface. Then,what's that?
Buy the way ,when I plug the microphone into the
Codec,I get the error messages like this: 
h4_recv:Unknown HCI packet type 00
h4_recv:Unknown HCI packet type fc
.....

So,do you have any idea?

Regards

gadfly

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
