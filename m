Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Marcel Holtmann <marcel@holtmann.org>
To: Jon Valvatne <jon@valvatne.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087511321.3103.32.camel@localhost.localdomain>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
	 <1087507199.3103.27.camel@localhost.localdomain>
	 <1087510775.4309.86.camel@pegasus>
	 <1087511321.3103.32.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1087511911.4309.94.camel@pegasus>
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
Date: Fri, 18 Jun 2004 00:38:31 +0200

Hi Jon,

> > show us the output of "hciconfig -a".
> 
> # hciconfig -a
> hci0:   Type: PCCARD
>         BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:1374134 acl:63939 sco:0 events:4549 errors:0
>         TX bytes:741932 acl:3358 sco:0 commands:158 errors:0
>         Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: ACCEPT MASTER 
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x21a
>         Manufacturer: Nokia Mobile Phones (1)

this looks like a card problem. Do "hciconfig hci0 features" show the
role switch support? May you try the link mode accept and slave, because
the hidd will force the role switch by itself.

> > Check with "hcidump -x" what happens when you press a button of your
> > second device.
> 
> Nothing at all, I'm afraid.

In this case it is on the link manager level and I can't debug it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
