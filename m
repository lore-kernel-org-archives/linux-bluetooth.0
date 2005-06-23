Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Esther Lopez" <esther.lopez@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Can"t connect RFCOMM socket: resource temporarily unavailable
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <42BAAA89.8030201@conectiva.com.br>
Message-Id: <20050623135057.56D1F1DD01A@mrelay2.st2.lyceu.net>
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
Date: Thu, 23 Jun 2005 15:51:31 +0200

Hi Fernando

Yes, I wrote them in lower-case. (When writing the email it has =
"corrected"
the first character of the sentence)

Regards

-----Mensaje original-----
De: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] En nombre de Luiz =
Fernando
Capitulino
Enviado el: jueves, 23 de junio de 2005 14:27
Para: bluez-users@lists.sourceforge.net
Asunto: Re: [Bluez-users] Can"t connect RFCOMM socket: resource =
temporarily
unavailable

Hi Esther,

Esther Lopez wrote:
> I have also created a file: /etc/Bluetooth/my-pin:
>=20
>             #! /bin/bash
>             Echo "PIN:1111"
>=20
>=20
> In /etc/Bluetooth/hcid.conf I have changed the line corresponding to=20
> "pin helper" to:
>=20
>             Pin_helper/etc/Bluetooth/my-pin
>=20
>=20
> If I start gnome "file sharing" utility, I can send files from my =
Linux=20
> box to the Win XP one (no Pin message is shown).
>=20
>=20
> If I state: "rfcomm connect /dev/rfcomm0 <mac> 1", I can see in my Win =

> XP Pc a message to set the PIN, I put 1111, and press enter. When a =
time=20
> is elapsed, the message "Can"t connect RFCOMM socket: resource=20
> temporarily unavailable" appears
> =20
>=20
> Some idea of what is going wrong??

Yes. :)

Did you write 'Echo' instead of 'echo'? Bash is case-sensitive. Try to =
write
such commands in lower-case.

--=20
Luiz Fernando N. Capitulino


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dick
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
