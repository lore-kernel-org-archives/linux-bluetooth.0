Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HCI Stops responding
From: Marcel Holtmann <marcel@holtmann.org>
To: axs203dd@excite.com
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20041011112240.AEDA5B6D8@xprdmailfe14.nwk.excite.com>
References: <20041011112240.AEDA5B6D8@xprdmailfe14.nwk.excite.com>
Content-Type: text/plain
Message-Id: <1097497926.9474.18.camel@notepaq>
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
Date: Mon, 11 Oct 2004 14:32:06 +0200

Hi,

> >send in more information. What does "hciconfig -a" say?
> 
> 
> 
> hci0:   Type: USB
> 
>         BD Address: 00:02:72:80:4A:F9 ACL MTU: 192:8  SCO MTU: 64:8
> 
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
> 
>         RX bytes:41034 acl:378 sco:0 events:777 errors:0
> 
>         TX bytes:126303 acl:766 sco:0 commands:15 errors:0
> 
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
> 
>         Packet type: DM1 DH1 HV1
> 
>         Link policy: RSWITCH HOLD SNIFF PARK
> 
>         Link mode: ACCEPT MASTER
> 
>         Name: 'BlueZ (0)'
> 
>         Class: 0x000100
> 
>         Service Classes: Unspecified
> 
>         Device Class: Computer, Uncategorized
> 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
> 
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> 
> 
> 
> 
> I have tried different packets also but no result... Any idea?

don't try other packet types. Leave them all on. The link manager will
use the right one. What kernel do you use? Is the hci_usb driver
compiled with SCO support?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
