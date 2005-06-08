Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] First dongle with EDR support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <5256d0b0506070651237c7503@mail.gmail.com>
References: <1117788913.3656.61.camel@pegasus>
	 <5256d0b0506070651237c7503@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1118200713.10148.3.camel@notepaq>
Mime-Version: 1.0
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
Date: Wed, 08 Jun 2005 05:18:33 +0200

Hi Pete,

> > it seems that Cellink is building the first EDR dongle. It is qualified
> > and you will find it on their website.
> > 
> > http://www.cellink.com.tw/pro-bta-6030.htm
> 
> Well I ordered one of these yesterday, it arrivied today. I plugged it
> in and away it went :-) It seems to work OK but I don't have time at
> the moment to test it out properly but doing a 'sdptool browse' finds
> my phone.
> 
> Some details:
> 
> [root@localhost ~]# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0A:94:01:8A:3A ACL MTU: 384:8 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:107 acl:0 sco:0 events:14 errors:0
>         TX bytes:300 acl:0 sco:0 commands:13 errors:0
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'localhost.localdomain-0'
>         Class: 0x120104
>         Service Classes: Networking
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x5dc LMP Ver: 1.1 (0x1) LMP Subver: 0x5dc
>         Manufacturer: Cambridge Silicon Radio (10)

this is strange. The feature bits say that it supports EDR, but the
Bluetooth version still shows 1.1.

Please do a "hciconfig hci0 version features revision" as root with the
latest bluez-utils version. I am also interersted what lsusb shows you
and what is the content of /proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
