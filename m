Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200412222331.17330.cijoml@volny.cz>
Subject: [Bluez-users] bluetooth-alsa kernel bug and alsa bug too
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
Date: Wed, 22 Dec 2004 23:31:17 +0100

Hi Marcel,

there is a bug in btsco:

when compiled and not CONFIG_SND_HWDEP, module writes bad symboles. It shou=
ld=20
have snd_hwdep in dependent modules section

I have  =20
=E2=94=82 =E2=94=82                           <M> Intel i8x0/MX440, SiS 701=
2; Ali 5455; NForce=20
Audio; AMD768/8111                                    =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                           <M> Intel i8x0/MX440; SiS 7=
013; NForce;=20
AMD768/8111 modems (EXPERIMENTAL)                              =E2=94=82 =
=E2=94=82

And this module snd_hwdep is not compiled. Possibly alsa bug too?

Michal


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
