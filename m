Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS-6871 isn't working
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42381514.3070701@sinister.cz>
References: <42381514.3070701@sinister.cz>
Content-Type: text/plain
Message-Id: <1110971745.9818.131.camel@pegasus>
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
Date: Wed, 16 Mar 2005 12:15:45 +0100

Hi David,

> I can't get MS-6871 BT device (USB hub with bluetooth) working.
> hciconfig shows:
> 
> hci0:   Type: USB
> ~        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
> ~        DOWN
> ~        RX bytes:0 acl:0 sco:0 events:0 errors:0
> ~        TX bytes:0 acl:0 sco:0 commands:0 errors:0
> 
> and hciconfig hci0 up:
> 
> Can't init device hci0. Input/output error(5)
> 
> with this in syslog:
> 
> hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c17e1514 err -28
> 
> Do anyone know what should I do?

is it directly connected to the USB root hub? We saw problems if another
USB hub is involved.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
