Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Newbie problem: can't open HIDP control socket
	-?-
From: Marcel Holtmann <marcel@holtmann.org>
To: emile castelnuovo <emile.castelnuovo@tin.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <002d01c49c37$d3ab26c0$4d982001@porty>
References: <002d01c49c37$d3ab26c0$4d982001@porty>
Content-Type: text/plain; charset=windows-1251
Message-Id: <1095404950.19426.69.camel@pegasus>
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
Date: Fri, 17 Sep 2004 09:09:10 +0200

Hi Emile,

> Hi all, I=92m new to this list and bluetooth in general. I=92m trying t=
o
> make a DUN connection using my phone.
>=20
> I=92ve installed packages found in the bluez.org site rpms for the Red
> Hat and followed some tutorials.
>=20
> Everything works quite fine=85 I connect to the device, and set up a pp=
p
> connection.
>=20
> I have one only problem. When I start the Bluetooth service
> =93/etc/init.d/Bluetooth start=94 I get this error message:
>=20
> Can=92t open HIDP control socket: Invalid argument.

use a 2.6.8 or newer kernel or at least on with a -mh patch and activate
the HIDP support.

> Can anybody help me find a solution?
>=20
> I=92m not sure is this, but when I connect with my phone modem, after a
> little time it does not work anymore.

This is another problem and unrelated to the error message above.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
