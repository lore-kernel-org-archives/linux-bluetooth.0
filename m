Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhikui Chen <zhikui.chen@po.uni-stuttgart.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40E41A18.8050201@po.uni-stuttgart.de>
References: <40E40440.8070109@po.uni-stuttgart.de>
	 <1088685238.4540.190.camel@pegasus>  <40E40A44.60008@po.uni-stuttgart.de>
	 <1088687188.4540.202.camel@pegasus> <40E412AA.4070908@po.uni-stuttgart.de>
	 <1088689181.4540.216.camel@pegasus> <40E416AB.2040904@po.uni-stuttgart.de>
	 <1088690093.4540.218.camel@pegasus>  <40E41A18.8050201@po.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1088691084.4540.232.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Help for bluez-bluefw-1.0.
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
Date: Thu, 01 Jul 2004 16:11:24 +0200

Hi Zhikui,

> After I loaded uhci_hcd, I got:
> [root@localhost root]# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy:
>         Link mode: SLAVE ACCEPT
> Normally, the report should have a non-zero value for some parameters, 
> the module uhci_hcd is not correct choice? or ehci_hcd or ohci_hcd?

use "hciconfig hci0 up" and follow the newbie howtos from my site.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
