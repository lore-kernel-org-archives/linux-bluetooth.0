Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] About Ipaq and Nokia phone
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhang <Lan.Zhang@Zoran.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E65CD2CAB74C80498703D6EF7624BB4C4ACABE@zmaex.zma.zoran.com>
References: <E65CD2CAB74C80498703D6EF7624BB4C4ACABE@zmaex.zma.zoran.com>
Content-Type: text/plain
Message-Id: <1080744196.2536.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 31 Mar 2004 16:43:16 +0200

Hi Lan,

> The "hciconfig -a" is showed below. And because I want to use the phone
> to print, so I set the linux class as a printer. 
> 
> hci0:   Type: USB
>         BD Address: 00:04:76:C8:44:48 ACL MTU: 128:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:27601 acl:487 sco:0 events:473 errors:0
>         TX bytes:69807 acl:835 sco:0 commands:18 errors:0
>         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'LINUX'
>         Class: 0x140680
>         Service Classes: Rendering, Object Transfer
>         Device Class: Imaging, Printer
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x73 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x73
>         Manufacturer: Cambridge Silicon Radio (10)

there is a way too old firmware on this Bluetooth module. You can't have
an inquiry and a connection at the same time. Try to get a dongle with a
least CSR firmware HCI 16.4.

> By the way, I try to use hcidump to catch what is going on, but it looks
> the hcidump didn't catch up the lower level signal, or inquire signals.
> Is there a way to look at that? 

First you must run it with root rights to catch all HCI packets and of
course its name is hcidump and it can only sniff on the HCI layer and
above. For link manager or baseband decoding you need a protocol
analyser.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
