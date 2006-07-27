Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 27 Jul 2006 12:58:45 +0200
References: <200607271240.49400.fexpop@onlinehome.de>
	<1153997014.9543.4.camel@localhost>
In-Reply-To: <1153997014.9543.4.camel@localhost>
MIME-Version: 1.0
Message-Id: <200607271258.45178.fexpop@onlinehome.de>
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Thursday 27 July 2006 12:43, Marcel Holtmann wrote:
Hi Marcel,

thanks for replying so quickly!

> maybe the Inquiry with RSSI quirks are messing it up.

Whatever that means ;-)

> Please post the output of "hciconfig -a".

Here's the output:

hci0:   Type: USB
        BD Address: 00:00:3A:6A:1B:A0 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:592 acl:0 sco:0 events:32 errors:0
        TX bytes:337 acl:0 sco:0 commands:22 errors:0
        Features: 0xff 0xfb 0x8d 0xfe 0x9f 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'jawaka (Belkin)'
        Class: 0xbe010c
        Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio, Information
        Device Class: Computer, Laptop
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2073 LMP Ver: 2.0 (0x3) LMP Subver: 0x410e
        Manufacturer: Broadcom Corporation (15)

> What happens if you call "hciconfig hci0 inqmode 0"?

kbluetoothd finds other devices after that command! (It doesn't make my PC visible to other 
devices though). Here's the output of "hciconfig -a" afterwards:

hci0:   Type: USB
        BD Address: 00:00:3A:6A:1B:A0 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:592 acl:0 sco:0 events:32 errors:0
        TX bytes:337 acl:0 sco:0 commands:22 errors:0
        Features: 0xff 0xfb 0x8d 0xfe 0x9f 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'jawaka (Belkin)'
        Class: 0xbe010c
        Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio, Information
        Device Class: Computer, Laptop
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2073 LMP Ver: 2.0 (0x3) LMP Subver: 0x410e
        Manufacturer: Broadcom Corporation (15)


Is this a bug within the Belkin dongle? Can I change something in hcid.conf?

Kind regards,

Felix

 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
