Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <02B0CA51-A2BB-47D0-B526-229C12C8195C@holtmann.org>
References: <1402049971-7762-1-git-send-email-kiran.kumar@linaro.org>
	<02B0CA51-A2BB-47D0-B526-229C12C8195C@holtmann.org>
Date: Fri, 6 Jun 2014 16:42:06 +0530
Message-ID: <CA+RfmHbnd8qSvrnbj0zpn65SHONKG4tj_7L16+e+HOg=NczOtQ@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Do not attempt to send dlci disconnect when in BT_CONFIG.
From: Kiran Raparthy <kiran.kumar@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, Nick Pelly <npelly@google.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Peter Hurley <peter@hurleysoftware.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	"open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>,
	John Stultz <john.stultz@linaro.org>
Content-Type: multipart/alternative; boundary=047d7bdc80fc8bff6904fb28eedd
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7bdc80fc8bff6904fb28eedd
Content-Type: text/plain; charset=UTF-8

Hi Marcel,
Below are the traces used by author for submitting patch previously.

[  132.856414] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
[  132.856933] rfcomm:__rfcomm_sock_close: sk c63fca00 state 5 socket c5cb3a20
[  132.857788] rfcomm:__rfcomm_dlc_close: dlc c61ea240 state 7 dlci 38
err 0 session c63d4ba0
[  132.858612] rfcomm:rfcomm_send_disc: c63d4ba0 dlci 38
[  132.859069] rfcomm:rfcomm_send_frame: session c63d4ba0 len 4
[  132.859893] l2cap:l2cap_sock_sendmsg: sock c5cb38c0, sk c63fc800
[  132.860351] rfcomm:rfcomm_dlc_set_timer: dlc c61ea240 state 8 timeout 2000
[  133.863739] rfcomm:rfcomm_sock_release: sock c5cb3a20, sk c63fca00
[  133.864257] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
[  133.865081] rfcomm:rfcomm_sock_kill: sk c63fca00 state 5 refcnt 2
[  133.865539] rfcomm:rfcomm_sock_destruct: sk c63fca00 dlc c61ea240

Regards,
Kiran


On 6 June 2014 16:16, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kiran,
>
> > Do not attempt to send dlci disconnect when in BT_CONFIG.
> >
> > This fixes a bug where shutdown() and close() on a rfcomm socket during
> ACL
> > connection would not cause HCI Create Connection Cancel.
> >
> > This is one of the number of patches from the Android AOSP common.git
> tree,
> > which is used on almost all Android devices.  so I wanted to submit it
> for
> > review to see if it should go upstream.
> >
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Peter Hurley <peter@hurleysoftware.com>
> > Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> > Cc: Nick Pelly <npelly@google.com>
> > Cc: linux-bluetooth@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Android Kernel Team <kernel-team@android.com>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Nick Pelly <npelly@google.com>
> > [kiran: Added context to commit message]
> > Signed-off-by: Kiran Raparthy <kiran.kumar@linaro.org>
> > ---
> > net/bluetooth/rfcomm/core.c | 1 -
> > 1 file changed, 1 deletion(-)
> >
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index cf62026..6a531e7 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -456,7 +456,6 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d,
> int err)
> >
> >       switch (d->state) {
> >       case BT_CONNECT:
> > -     case BT_CONFIG:
> >       case BT_OPEN:
> >       case BT_CONNECT2:
> >               if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {
>
> you can include traces and a test program that will demonstrate this
> behavior. I am hearing about this one for the first time. Nobody else has
> indicated an issue like this before.
>
> Regards
>
> Marcel
>
>

--047d7bdc80fc8bff6904fb28eedd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,<div>Below are the traces used by author for sub=
mitting patch previously.</div><div><br></div><div><pre style=3D"color:rgb(=
0,0,0)">[=C2=A0 132.856414] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk =
c63fca00
[=C2=A0 132.856933] rfcomm:__rfcomm_sock_close: sk c63fca00 state 5 socket =
c5cb3a20
[=C2=A0 132.857788] rfcomm:__rfcomm_dlc_close: dlc c61ea240 state 7 dlci 38
err 0 session c63d4ba0
[=C2=A0 132.858612] rfcomm:rfcomm_send_disc: c63d4ba0 dlci 38
[=C2=A0 132.859069] rfcomm:rfcomm_send_frame: session c63d4ba0 len 4
[=C2=A0 132.859893] l2cap:l2cap_sock_sendmsg: sock c5cb38c0, sk c63fc800
[=C2=A0 132.860351] rfcomm:rfcomm_dlc_set_timer: dlc c61ea240 state 8 timeo=
ut 2000
[  133.863739] rfcomm:rfcomm_sock_release: sock c5cb3a20, sk c63fca00
[  133.864257] rfcomm:rfcomm_sock_shutdown: sock c5cb3a20, sk c63fca00
[  133.865081] rfcomm:rfcomm_sock_kill: sk c63fca00 state 5 refcnt 2
[  133.865539] rfcomm:rfcomm_sock_destruct: sk c63fca00 dlc c61ea240</pre><=
div style>Regards,</div><div style>Kiran</div></div></div><div class=3D"gma=
il_extra"><br><br><div class=3D"gmail_quote">On 6 June 2014 16:16, Marcel H=
oltmann <span dir=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org" target=
=3D"_blank">marcel@holtmann.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Kiran,<br>
<div><div class=3D"h5"><br>
&gt; Do not attempt to send dlci disconnect when in BT_CONFIG.<br>
&gt;<br>
&gt; This fixes a bug where shutdown() and close() on a rfcomm socket durin=
g ACL<br>
&gt; connection would not cause HCI Create Connection Cancel.<br>
&gt;<br>
&gt; This is one of the number of patches from the Android AOSP common.git =
tree,<br>
&gt; which is used on almost all Android devices. =C2=A0so I wanted to subm=
it it for<br>
&gt; review to see if it should go upstream.<br>
&gt;<br>
&gt; Cc: Marcel Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@=
holtmann.org</a>&gt;<br>
&gt; Cc: Gustavo Padovan &lt;<a href=3D"mailto:gustavo@padovan.org">gustavo=
@padovan.org</a>&gt;<br>
&gt; Cc: Johan Hedberg &lt;<a href=3D"mailto:johan.hedberg@gmail.com">johan=
.hedberg@gmail.com</a>&gt;<br>
&gt; Cc: David S. Miller &lt;<a href=3D"mailto:davem@davemloft.net">davem@d=
avemloft.net</a>&gt;<br>
&gt; Cc: Peter Hurley &lt;<a href=3D"mailto:peter@hurleysoftware.com">peter=
@hurleysoftware.com</a>&gt;<br>
&gt; Cc: Seung-Woo Kim &lt;<a href=3D"mailto:sw0312.kim@samsung.com">sw0312=
.kim@samsung.com</a>&gt;<br>
&gt; Cc: Nick Pelly &lt;<a href=3D"mailto:npelly@google.com">npelly@google.=
com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:linux-bluetooth@vger.kernel.org">linux-bluetooth=
@vger.kernel.org</a><br>
&gt; Cc: <a href=3D"mailto:netdev@vger.kernel.org">netdev@vger.kernel.org</=
a><br>
&gt; Cc: <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.=
kernel.org</a><br>
&gt; Cc: Android Kernel Team &lt;<a href=3D"mailto:kernel-team@android.com"=
>kernel-team@android.com</a>&gt;<br>
&gt; Cc: John Stultz &lt;<a href=3D"mailto:john.stultz@linaro.org">john.stu=
ltz@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Nick Pelly &lt;<a href=3D"mailto:npelly@google.com">npe=
lly@google.com</a>&gt;<br>
&gt; [kiran: Added context to commit message]<br>
&gt; Signed-off-by: Kiran Raparthy &lt;<a href=3D"mailto:kiran.kumar@linaro=
.org">kiran.kumar@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; net/bluetooth/rfcomm/core.c | 1 -<br>
&gt; 1 file changed, 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c=
<br>
&gt; index cf62026..6a531e7 100644<br>
&gt; --- a/net/bluetooth/rfcomm/core.c<br>
&gt; +++ b/net/bluetooth/rfcomm/core.c<br>
&gt; @@ -456,7 +456,6 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d=
, int err)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 switch (d-&gt;state) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 case BT_CONNECT:<br>
&gt; - =C2=A0 =C2=A0 case BT_CONFIG:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 case BT_OPEN:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 case BT_CONNECT2:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_and_clear_bi=
t(RFCOMM_DEFER_SETUP, &amp;d-&gt;flags)) {<br>
<br>
</div></div>you can include traces and a test program that will demonstrate=
 this behavior. I am hearing about this one for the first time. Nobody else=
 has indicated an issue like this before.<br>
<br>
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br></div>

--047d7bdc80fc8bff6904fb28eedd--
