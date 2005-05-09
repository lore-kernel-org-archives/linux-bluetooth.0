Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427EE741.5000002@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] headset neo-507 not working with bluefritz 2.0
References: <427D5693.6070501@gmx.de>
In-Reply-To: <427D5693.6070501@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 08 May 2005 22:29:53 -0600

Michael

Everything looks right but the bluetooth adapter may not be ideal. We 
mostly have seen success using CSR based adapters and I'm not sure this 
one is known to work with btsco.

Brad

> hci0:   Type: USB
>         BD Address: 00:04:0E:89:BC:7F ACL MTU: 120:20  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN INQUIRY AUTH
>         RX bytes:128 acl:0 sco:0 events:16 errors:0
>         TX bytes:313 acl:0 sco:0 commands:16 errors:0
>         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ leeloo (0)'
>         Class: 0x100100
>         Service Classes: Object Transfer
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x2005 LMP Ver: 1.1 (0x1) LMP
> Subver: 0x1805
>         Manufacturer: AVM Berlin (31)
> 
> 
> hciconfig hci0 revision:
> hci0:   Type: USB
>         BD Address: 00:04:0E:89:BC:7F ACL MTU: 120:20  SCO MTU: 64:0
>         Unknown type


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
