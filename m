Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection failed error (110)
From: Marcel Holtmann <marcel@holtmann.org>
To: KEYUR DESAI <keyurde@nortelnetworks.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E337F6C8A5154F4C8E95349BA276D63008FBB4@zrtphxm0.corp.nortel.com>
References: 
	 <E337F6C8A5154F4C8E95349BA276D63008FBB4@zrtphxm0.corp.nortel.com>
Content-Type: text/plain; charset=iso-8859-7
Message-Id: <1098676659.6465.72.camel@pegasus>
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
Date: Mon, 25 Oct 2004 05:57:39 +0200

Hi Keyur,

> Here is my current scenario
>=20
> =20
>=20
> Hardware: Belkin Dongle
>=20
> O.S.: Fedora Core 2 Kernel 2.6.5-1.358
>=20
> =20
>=20
> =20
>=20
> Here is the problem:
>=20
> =20
>=20
> When I do=20
>=20
> #hciconfig hci0 up The device works fine.
>=20
> =20
>=20
> However on doing a hciconfig hci0 down followed by a hciconfig hci0
> up . The dongle does not work.
>=20
> It gives an error=20
>=20
> Can=A2t init device hci0. Connection timed out (110).

what kind of dongle is this (hciconfig -a) and why don't you update to
the latest Linux kernel and BlueZ utils first?

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
