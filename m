Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth-alsa kernel bug and alsa bug too
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412222331.17330.cijoml@volny.cz>
References: <200412222331.17330.cijoml@volny.cz>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1103801892.20258.64.camel@pegasus>
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
Date: Thu, 23 Dec 2004 12:38:12 +0100

Hi Michal,

> there is a bug in btsco:
>=20
> when compiled and not CONFIG_SND_HWDEP, module writes bad symboles. It =
should=20
> have snd_hwdep in dependent modules section
>=20
> I have  =20
> =E2=94=82 =E2=94=82                           <M> Intel i8x0/MX440, SiS=
 7012; Ali 5455; NForce=20
> Audio; AMD768/8111                                    =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82                           <M> Intel i8x0/MX440; S=
iS 7013; NForce;=20
> AMD768/8111 modems (EXPERIMENTAL)                              =E2=94=82=
 =E2=94=82
>=20
> And this module snd_hwdep is not compiled. Possibly alsa bug too?

it is not that easy to select hwdep from an outside driver. This is an
ALSA bug, because they don't provide a kernel option to compile hwdep
even if no other selected driver uses it. The best way is to select a
USB driver in your kernel that needs hwdep and everything will be fine.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
