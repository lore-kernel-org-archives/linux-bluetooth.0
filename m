Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Thor Egil Skaug" <paxtonrd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <000501c40194$c308add0$9349edc7@thores>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-users] HCI_switch_role
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
Date: Wed, 3 Mar 2004 18:59:51 -0800

Does anyone know why the HCI_switch_role command takes a BDADDR argument
instead of
a connectionhandle?

The role_change event should be sent from both devices to their
respective sw stacks after this.

I don't understand the following from the BT specification:

1. Is the BDADDR the address of the remote device, or the local device
(to the caller)?

2. In the returned event, what bdaddr is returned to the
(HCI_switch_role) calling stack, and what bdaddr
   is returned to the stack on the remote device?
3. What if there is more than one connection between two devices?

Thor


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
