Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6ae1569005030605485547bf58@mail.gmail.com>
References: <6ae1569005030604105d08a56e@mail.gmail.com>
	 <1110111350.8302.9.camel@pegasus>
	 <6ae1569005030605485547bf58@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1110117308.8302.12.camel@pegasus>
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
Date: Sun, 06 Mar 2005 14:55:08 +0100

Hi Adis,

> Well I get this output when I run hciconfig -a
> 
> Can't open HCI socket.: Address family not supported by protocol
> What can I do to make that work?

are you sure that the kernel modules bluetooth.ko and hci_usb.ko are
loaded?

> Regarding KDE and GNOME.. I don't use any of them.
> Is there a nice command tool for that? Tryed obexftp
> but with no luck.

The latest version of obexftp and an OpenOBEX library with Bluetooth
support should work.

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
