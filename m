Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <412E45FC.4070604@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: tim@birdsnest.maths.tcd.ie
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Confessions of an ignoramus - what is all this PIN
    stuff?
References: <412D99CA.5050209@nue.et-inf.uni-siegen.de>
    <412DD322.1080703@csr.com>
    <200408261502.13690.tim@birdsnest.maths.tcd.ie>
In-Reply-To: <200408261502.13690.tim@birdsnest.maths.tcd.ie>
Content-Type: text/plain; charset="us-ascii"
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
Date: Thu, 26 Aug 2004 21:20:12 +0100

Timothy Murphy wrote:
> On Thursday 26 August 2004 13:10, Steven Singer wrote:
>> A strong BT PIN [1] should not be your main line of defence, it should
>> be merely your first line of defence.
>
> I find this PIN business very hard to follow.
> Is there a simple account somewhere?
> (Please don't refer me to the Bluetooth Spec
> which I find more or less unintelligble.)

Let's try this:

Every Bluetooth device has a unique address. As has been noted on this
mailing list, addresses can be faked.

A pair of Bluetooth devices may share a link key. A link key is a piece
of information that only those two devices know.

When two paired devices meet again, they ask each other questions to
make sure that the other side knows the link key and is, therefore, the
same device they talked to before.

This process is known as authentication.

This leaves just the problem of how to get the two sides to agree on
a link key without sending it in the clear over the air.

The process to do this is called bonding or pairing.

In this process, the user supplies each device with some information not
known to anyone else - the PIN. The two modules use this information to
securely exchange some information from which they can generate the link
key for future meetings. After this initial exchange the PIN is
discarded (note that the link key does not depend on the PIN at all, if
you pair the same devices several times with the same PIN you will get
different link keys each time).

One slightly interesting issue is that the link key can be stored in the
Bluetooth device, or can be provided by the host (in this case BlueZ).
If it's stored in the device then you're merely authenticating that the
device is correct. If it's stored in the host then you're authenticating
the device-host pair (the device has the address, the host has the link
key).

For systems where the Bluetooth device is firmly integrated with the host
(such as in a phone) this difference is purely academic. For systems
where the Bluetooth device and the host are separable (such as where you
have a USB dongle plugged into a PC) this is an important issue. If the
link key is stored in the dongle then any device that dongle is plugged
into will be equally trustworthy to its paired devices. This might be
convenient but it's also a security risk - if someone steals the dongle
then they can get access to all the devices it's paired with. Also,
there's an HCI command to read out link keys that are stored in the
dongle so someone can 'borrow' your device, read the link keys, return
the device and then snoop all your traffic.

> I have two laptops, martha and william (my grandparents).
> I first linked to my Nokia 6310 with martha.
> For some reason the phone thinks william is also martha.
> Is this something to do with the fact that I always use the same PIN?

More likely it's to do with you using the same dongle for both PCs. The
phone probably read the name stored in the dongle once and has cached
it. On subsequent occasions when it sees the same device (that is, when
it has a connection from the same Bluetooth address), it's not bothering
to read the name, it's just displaying the cached name.

	- Steven
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
