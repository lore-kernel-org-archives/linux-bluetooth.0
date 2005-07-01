Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <537e39c905063022282fdbb14f@mail.gmail.com>
From: Jordi Jaen Pallares <jordijp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Key exchange before pairing
In-Reply-To: <1120108243.15397.138.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4175_6555460.1120195729080"
References: <537e39c905062907433980aa7f@mail.gmail.com>
	 <1120067870.15397.134.camel@pegasus>
	 <537e39c905062916247959acdf@mail.gmail.com>
	 <1120108243.15397.138.camel@pegasus>
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
Date: Fri, 1 Jul 2005 07:28:49 +0200

------=_Part_4175_6555460.1120195729080
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

first of all, thank you for your comments :-)

2005/6/30, Marcel Holtmann <marcel@holtmann.org>:
>=20
> Hi Jordi,
>=20
> > I=B4d like to generate the PIN based on the shared key derived from a
> > Diffie Hellman exchange between the bluetooth peers.
>=20
> if you wanna use Diffie Hellman, for what reason do you want to use the=
=20
> pairing and encryption of Bluetooth then.


I would like to use the pairing and encryption of bluetooth as usual, and=
=20
use only the Diffie-Hellman exchange to generate a "stronger" PIN for the=
=20
pairing.=20

> Is it possible to trigger this exchange at pairing time using my own=20
> > 'pin_helper' program ?
>=20
> To exchange data you need a connection first. This means you can only do
> this in security mode 1 and 2. The PIN helper can't be used for any of
> these task except entering a PIN.


But then, is there any other way for the peers to exchange previous=20
communication attributes than using the SDP protocol ?

Is it possible to exchange information by previously registering a new=20
service (with a fixed PSM) and then negociate the parameters directly using=
=20
L2CAP sockets ?

Regards,

Jordi


Regards
>=20
> Marcel
>=20
> -------------------------------------------------------=20
> SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
> Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to=20
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&opclick<http://=
ads.osdn.com/?ad_idt77&alloc_id%16492&opclick>
> _______________________________________________
> Bluez-users mailing list=20
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users=20
>

------=_Part_4175_6555460.1120195729080
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br><br>
first of all, thank you for your comments :-)<br>
<br><div><span class=3D"gmail_quote">2005/6/30, Marcel Holtmann &lt;<a href=
=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Hi Jordi,<br><br>&gt; I=B4d like to generate the PIN based on the shared ke=
y derived from a<br>&gt; Diffie Hellman exchange between the bluetooth peer=
s.<br><br>if you wanna use Diffie Hellman, for what reason do you want to u=
se the
<br>pairing and encryption of Bluetooth then.</blockquote><div><br>
I would like to use the pairing and encryption of bluetooth as usual,
and use only the Diffie-Hellman&nbsp; exchange to generate a &quot;stronger=
&quot;
PIN for the pairing. &nbsp;</div><br><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">&gt; Is it possible to trigger this exchange at pairing=
 time using my own
<br>
&gt; 'pin_helper' program ?<br><br>To exchange data you need a connection f=
irst. This means you can only do<br>this in security mode 1 and 2. The PIN =
helper can't be used for any of<br>these task except entering a PIN.</block=
quote>

<div><br>
But then, is there any other way for the peers to exchange previous communi=
cation attributes than using the SDP protocol ?<br>
<br>
Is it possible to exchange information by previously registering a new
service (with a fixed PSM) and then negociate the parameters directly
using L2CAP sockets ?<br>
<br>
Regards,<br>
<br>
Jordi<br>
</div><br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Regards<br><b=
r>Marcel<br><br>-------------------------------------------------------
<br><a href=3D"http://SF.Net">SF.Net</a> email is sponsored by: Discover Ea=
sy Linux Migration Strategies<br>from IBM. Find simple to follow Roadmaps, =
straightforward articles,<br>informative Webcasts and more! Get everything =
you need to get up to
<br>speed, fast. <a href=3D"http://ads.osdn.com/?ad_idt77&amp;alloc_id%1649=
2&amp;opclick">http://ads.osdn.com/?ad_idt77&amp;alloc_id=16492&amp;opclick=
</a><br>_______________________________________________<br>Bluez-users mail=
ing list
<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</=
a>

<br></blockquote></div><br>


------=_Part_4175_6555460.1120195729080--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
