Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] L2Ping / Rfcomm connect : Function not
	implemented
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412131309.12167.wim.delvaux@adaptiveplanet.com>
References: <200412122356.09617.wim.delvaux@adaptiveplanet.com>
	 <200412131259.20788.wim.delvaux@adaptiveplanet.com>
	 <1102939476.8750.148.camel@pegasus>
	 <200412131309.12167.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102940092.8750.151.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 13 Dec 2004 13:14:51 +0100

Hi Wim,

> > > After a reboot (again a kernel freeze that I mailed about before) and a
> > > change in hcid.conf ... no result.
> >
> > We can't get any further without a protocol analyzer. However you might
> > wanna ask a Nokia Service Shop to update your mobile phone.
> 
>  The strange thing is 
> 
>  1. it has worked before
>  2. it works from my desktop
> 
>  with this hciconfig -a output
>  hci0:   Type: USB
>         BD Address: 00:60:57:02:71:A2 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH
>         RX bytes:3133810 acl:37666 sco:0 events:87504 errors:0
>         TX bytes:19406578 acl:115742 sco:0 commands:737 errors:0
>         Features: 0xff 0xff 0x09 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'buro-0'
>         Class: 0x100000
>         Service Classes: Object Transfer
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
>         Manufacturer: Cambridge Silicon Radio (10)
> 
>  I can connect with BNEP from the Ipaq to the desktop and actually
>  AM connected to it

it looks like a link manager problem in some way. However this can't be
debugged without a protocol analyzer.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
