Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN and security mode 3
From: Marcel Holtmann <marcel@holtmann.org>
To: Mark RISON <mrison@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY8-F97aHyJBu3pQBo0002a6ce@hotmail.com>
References: <BAY8-F97aHyJBu3pQBo0002a6ce@hotmail.com>
Content-Type: text/plain
Message-Id: <1075584286.2720.88.camel@pegasus>
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
Date: Sat, 31 Jan 2004 22:24:46 +0100

Hi Mark,

> - If in the "device" part of hcid.conf I put "auth enable" and
> "encrypt enable", does this enforce security mode 3 for all (incoming
> and outgoing) connections, or do I need to make sure appropriate
> settings are specified in other files/utilities (and if so, which?)?

yes.

> - If I only start the PAN daemon, does this guarantee that no other
> profiles will be running (i.e. only PAN will allow access to the
> laptop)?

Of course you will need hcid and sdpd, too. But if you only have pand
running you have only support for the PAN profile. To be sure check what
listen sockets /proc/bluetooth/l2cap and /proc/bluetooth/rfcomm say.

> - Can "auth enable" and "encrypt enable" in hcid.conf be overwritten
> by command-line utility/daemon arguments, or is this a bullet-proof
> way to enfore security mode 3 irrespective of "user error"?

Yes. The difference between security mode 3 and not is device dependent
and has nothing to with any local daemon. See

	hciconfig hci0 noencrypt
	hciconfig hci0 noauth

> - How does authorisation work in BlueZ?  Ideally I'd like to be able
> to specify a list of BD_ADDRs to (exclusively) authorise for PAN, but
> if it's necessary for all connection requests to be manually
> authorised, that's better than nothing.

This is currently not implemented and the best way to do this is in pand
directly. Otherwise the kernel have to control a black- or whitelist of
device addresses and I don't think that is a good idea.

> - /etc/bluetooth/link_keys appears to be where link keys resulting
> from pairing are stored.  Is this correct, and if so, what is the
> format, and will deleting this file remove all pairing information (or
> do I need to delete something else somewhere else?)?

Yes, it will remove all pairings. For the format look at the source.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
