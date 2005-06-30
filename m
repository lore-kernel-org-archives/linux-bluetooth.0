Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c93f2a29050629233978453a1c@mail.gmail.com>
From: Embedded System <embed.sys@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problems when connect Nokia 7650 to an arm box with BlueZ
In-Reply-To: <1120108334.15397.141.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2015_15193643.1120113577891"
References: <c93f2a29050629200733f9acd6@mail.gmail.com>
	 <1120108334.15397.141.camel@pegasus>
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
Date: Thu, 30 Jun 2005 14:39:37 +0800

------=_Part_2015_15193643.1120113577891
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi, Marcel
 Thanks for the prompt reply! But for my case, the kernel is hard to change=
,=20
could you please advice me what can I do for the time being, to ensure the=
=20
data can be sent & received correctly?
 Regards,
Andy
 On 6/30/05, Marcel Holtmann <marcel@holtmann.org> wrote:=20
>=20
> Hi Andy,
>=20
> > I am currently connect Nokia 7650 to an arm box (kernel 2.4.27) via
> > Serial Profile using BlueZ(libs-2.14, utils-2.14, hcidump-1.16). The
> > problems are:
> >
> > 1. Every twice connections, one success, and the other said time out.
> > 2. After receive about 5 message from arm box, it do not send back any
> > data, from hcidump output, it simplely stalls.
> > 3. Every twice sending message from Nokia, one success, and one has no
> > effects, hcidump has no output also.
> > 4. If I start hcidump before connection, then I can never connect
> > successfully.
> >
> > But everything seems to work well when I connect the Nokia 7650 to a
> > PC.
>=20
> update bluez-libs and bluez-utils and you should also update your
> kernel. The 2.4.27 is quite old and it might have bugs.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
> Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_2015_15193643.1120113577891
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>hi, Marcel</div>
<div>&nbsp;</div>
<div>Thanks for the prompt reply! But for my case, the kernel is hard to ch=
ange, could you please advice me what can I do for the time being, to ensur=
e the data can be sent &amp; received correctly?<br>&nbsp;</div>
<div>Regards,</div>
<div>Andy<br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 6/30/05, <b class=3D"gmail_sendername">=
Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtm=
ann.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Andy,<br><br>&gt; I am curren=
tly connect Nokia 7650 to an arm box (kernel 2.4.27) via<br>&gt; Serial Pro=
file using BlueZ(
libs-2.14, utils-2.14, hcidump-1.16).&nbsp;&nbsp;The<br>&gt; problems are:<=
br>&gt;<br>&gt; 1. Every twice connections, one success, and the other said=
 time out.<br>&gt; 2. After receive about 5 message from arm box, it do not=
 send back any
<br>&gt; data, from hcidump output, it simplely stalls.<br>&gt; 3. Every tw=
ice sending message from Nokia, one success, and one has no<br>&gt; effects=
, hcidump has no output also.<br>&gt; 4. If I start hcidump before connecti=
on, then I can never connect
<br>&gt; successfully.<br>&gt;<br>&gt; But everything seems to work well wh=
en I connect the Nokia 7650 to a<br>&gt; PC.<br><br>update bluez-libs and b=
luez-utils and you should also update your<br>kernel. The 2.4.27 is quite o=
ld and it might have bugs.
<br><br>Regards<br><br>Marcel<br><br><br><br><br>--------------------------=
-----------------------------<br><a href=3D"http://SF.Net">SF.Net</a> email=
 is sponsored by: Discover Easy Linux Migration Strategies<br>from IBM. Fin=
d simple to follow Roadmaps, straightforward articles,
<br>informative Webcasts and more! Get everything you need to get up to<br>=
speed, fast. <a href=3D"http://ads.osdn.com/?ad_id=3D7477&amp;alloc_id=3D16=
492&amp;op=3Dclick">http://ads.osdn.com/?ad_id=3D7477&amp;alloc_id=3D16492&=
amp;op=3Dclick
</a><br>_______________________________________________<br>Bluez-users mail=
ing list<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-user=
s@lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquot=
e></div><br>

------=_Part_2015_15193643.1120113577891--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
