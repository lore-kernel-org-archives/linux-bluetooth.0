Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050921051073acb32e@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple user/device model?
In-Reply-To: <1127291981.495.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_149_3838456.1127304607906"
References: <1127025473.14893.51.camel@yeti>
	 <1127216957.5168.30.camel@localhost.localdomain>
	 <1127249749.26495.1.camel@yeti>
	 <1127291981.495.1.camel@localhost.localdomain>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 21 Sep 2005 09:10:07 -0300

------=_Part_149_3838456.1127304607906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Fredrik,

I sent a lot of emails about bluetoothd specification, but I didn't
receive enough feedbacks. bluetoothd will be the main entity
responsible to handle user requests(connections, device setup,
security, ...).

Currently, we are working on hcid D-Bus services. hcid is our
playground for validate some ideas. I developed a internal version
of the bluetoothd, but I need align with bluez community and
use the new communication interface (between kernel and the userspace)
that is being developed.

There is docs about bluetoothd available at:
http://www.cin.ufpe.br/~ckt/bluez

Your feedback is welcome!

Regards,
Claudio.


On 9/21/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Fredrik,
>
> > > the idea is not bad, but it will never work this way. This is because
> > > how the Bluetooth security architecture is designed. We need a centra=
l
> > > root service that deals with the kernel side of HCI. However the
> control
> > > of pairing etc. for users will be handled over D-Bus.
> >
> > Ah. Is there any documentation on how this D-BUS interface works?
>
> Claudio has written something, but nothing is written in stone.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_149_3838456.1127304607906
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Fredrik,<br>
<br>
I sent a lot of emails about bluetoothd specification, but I didn't<br>
receive enough feedbacks. bluetoothd will be the main entity<br>
responsible to handle user requests(connections, device setup,<br>
security, ...).<br>
<br>
Currently, we are working on hcid D-Bus services. hcid is our <br>
playground for validate some ideas. I developed a internal version <br>
of the bluetoothd, but I need align with bluez community and <br>
use the new communication interface (between kernel and the userspace)<br>
that is being developed.<br>
<br>
There is docs about bluetoothd available at:<br>
<a href=3D"http://www.cin.ufpe.br/~ckt/bluez">http://www.cin.ufpe.br/~ckt/b=
luez</a><br>
<br>
Your feedback is welcome!<br>
<br>
Regards,<br>
Claudio.<br>
<br>
<br>
<div><span class=3D"gmail_quote">On 9/21/05, <b class=3D"gmail_sendername">=
Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtm=
ann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
Hi Fredrik,<br><br>&gt; &gt; the idea is not bad, but it will never work th=
is way. This is because<br>&gt; &gt; how the Bluetooth security architectur=
e is designed. We need a central<br>&gt; &gt; root service that deals with =
the kernel side of HCI. However the control
<br>&gt; &gt; of pairing etc. for users will be handled over D-Bus.<br>&gt;=
<br>&gt; Ah. Is there any documentation on how this D-BUS interface works?<=
br><br>Claudio has written something, but nothing is written in stone.<br>
<br>Regards<br><br>Marcel<br><br><br><br><br>------------------------------=
-------------------------<br>SF.Net email is sponsored by:<br>Tame your dev=
elopment challenges with Apache's Geronimo App Server.<br>Download it for f=
ree - -and be entered to win a 42&quot; plasma tv or your very
<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http://sourc=
eforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br>_______=
________________________________________<br>Bluez-devel mailing list<br><a =
href=3D"mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br>

------=_Part_149_3838456.1127304607906--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
