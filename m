Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Rfcomm connection with multiple usb dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Eller <te@identisys.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40D6E1B6.90700@identisys.de>
References: <40D6E1B6.90700@identisys.de>
Content-Type: text/plain
Message-Id: <1087821141.4328.10.camel@pegasus>
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
Date: Mon, 21 Jun 2004 14:32:21 +0200

Hi Thomas,

> I have two USB dongles connected to my system:
> 
> hciconfig <ENTER>
> 
> hci0:   Type: USB
>          BD Address: 00:02:72:B1:6E:28 ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:6901 acl:92 sco:0 events:655 errors:0
>          TX bytes:6146 acl:147 sco:0 commands:302 errors:0
> 
> hci1:   Type: USB
>          BD Address: 00:02:72:B1:6E:29 ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:147 acl:0 sco:0 events:21 errors:0
>          TX bytes:328 acl:0 sco:0 commands:20 errors:0
> 
> --------------
> 
> I try the rfcomm-command: rfcomm connect 0 xx:xx:xx:xx:xx:xx 1
> 
> This connection is made over hci0 on channel 1, activating the device 
> rfcomm0.
> 
> How can i tell rfcomm to make a connection over hci1 ??

you must use "rfcomm -i hci1 connect ...". And of course looking at the
manpage is very helpful ;)

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
