Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42BAAA89.8030201@conectiva.com.br>
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can"t connect RFCOMM socket: resource temporarily
 unavailable
References: <20050623104846.8137A1EA7F3@mrelay1.st2.lyceu.net>
In-Reply-To: <20050623104846.8137A1EA7F3@mrelay1.st2.lyceu.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Date: Thu, 23 Jun 2005 09:26:49 -0300

Hi Esther,

Esther Lopez wrote:
> I have also created a file: /etc/Bluetooth/my-pin:
>=20
>             #! /bin/bash
>             Echo =93PIN:1111=94
>=20
>=20
> In /etc/Bluetooth/hcid.conf I have changed the line corresponding to=20
> =93pin helper=94 to:
>=20
>             Pin_helper/etc/Bluetooth/my-pin
>=20
>=20
> If I start gnome =93file sharing=94 utility, I can send files from my L=
inux=20
> box to the Win XP one (no Pin message is shown).
>=20
>=20
> If I state: =93rfcomm connect /dev/rfcomm0 <mac> 1=94, I can see in my =
Win=20
> XP Pc a message to set the PIN, I put 1111, and press enter. When a tim=
e=20
> is elapsed, the message =93Can"t connect RFCOMM socket: resource=20
> temporarily unavailable=94 appears
> =20
>=20
> Some idea of what is going wrong??

Yes. :)

Did you write 'Echo' instead of 'echo'? Bash is case-sensitive. Try to wr=
ite
such commands in lower-case.

--=20
Luiz Fernando N. Capitulino


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
