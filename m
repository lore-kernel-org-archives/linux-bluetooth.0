Return-Path: <bluez-users-admin@lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: "Simi Manuel" <roses_3@operamail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] LMP format(no h/w)
Message-Id: <20050108192216.D6A50416118@ws5-2.us4.outblaze.com>
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
Date: Sat, 08 Jan 2005 20:22:16 +0100

i am not using any h/w ..i am simulating the bluetooth controller part..is =
ther any such stacks available for free...
----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] LMP format
Date: Sat, 08 Jan 2005 19:48:02 +0100

>=20
> Hi Simi,
>=20
> > i am trying to implement a link manager in C...
> > i want to know whether LMP PDUs are generated and sent by the=20
> > link manager itself or is it a part of the message sent by the=20
> > Host.
> >
> >
> > what i know about the LMP format is that it has fields like=20
> > opcode,tranaction id and a message.
> > plz correct me if i am wrong...
> >
> >
> > will the link manger respond to the layers above, if it gets any=20
> > message, inorder to take some actions???
>=20
> the host part of the protocol stack don't deal with LMP. It uses HCI and
> everything down HCI is part of the Bluetooth chip/module/dongle.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

--=20
_____________________________________________________________
Web-based SMS services available at http://www.operamail.com.
=46rom your mailbox to local or overseas cell phones.

Powered by Outblaze


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
