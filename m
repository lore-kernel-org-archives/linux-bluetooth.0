Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'Sergey Smirnov'" <svs1957@gmail.com>
Date: Wed, 11 Apr 2007 13:04:37 +0530
Message-ID: <004501c77c0b$dc64da70$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <461C8164.8010705@gmail.com>
Cc: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco: Operation not supported
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> Here hciconfig -a
> hci0:   Type: PCCARD
>         BD Address: 00:E0:03:25:7C:36 ACL MTU: 340:4 SCO MTU: 0:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:204 acl:0 sco:0 events:15 errors:0
>         TX bytes:382 acl:0 sco:0 commands:15 errors:0
>         Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'svs-zaurus-0'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing, 
> Object Transfer, Audio
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) 
> LMP Subver: 0x21a
>         Manufacturer: Nokia Mobile Phones (1)

It took me a while to understand this confusing situation.

The reason for this behaviour is very simple.
Have a look at the Features of your device: 0xbf 0x00 0x20 0x00 0x00
0x00 0x00 0x00
Here, byte 0 is 0xbf, byte 1 is 0x00. If you decode these numbers from
the bluetooth specs, bit 3 of byte 1 stands for SCO link. In your case
it is 0 which means your device does not support SCO links at all. Get
yourself a new dongle :(
Now you would ask me why does the packet type shows HV1? This is because
HV1 is mandatory if the device supports SCO link. So this is just a
mistake done by hciconfig. It should report HV1 packet type only if SCO
link bit is 1. In case it is 0 do not mention HV1.

Hope this helps.

Best Regards,

Mayank


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
