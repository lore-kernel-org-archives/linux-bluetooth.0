Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <80321467-10AB-489E-A47E-44B0ECEE4BE1@holtmann.org>
References: <1416419951-27659-1-git-send-email-stevenrwalter@gmail.com>
 <20141120113813.GA23288@t440s.lan> <80321467-10AB-489E-A47E-44B0ECEE4BE1@holtmann.org>
From: Steven Walter <stevenrwalter@gmail.com>
Date: Thu, 20 Nov 2014 10:51:11 -0500
Message-ID: <CAK8d-aL+3eB4WZeqO1sv9p3440EVXQiqF6QiTU5YNAKAbZ7f-w@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: automatically flushable packets aren't
 allowed on LE links
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a1139126c5e640205084c4d6d
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1139126c5e640205084c4d6d
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 20, 2014 at 8:50 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Johan,
>
> >> The bluetooth spec states that automatically flushable packets may not
> >> be sent over a LE-U link.
> >>
> >> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> >> ---
> >> net/bluetooth/l2cap_core.c | 14 ++++++++------
> >> 1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >> index 4af3821..7c4350f 100644
> >> --- a/net/bluetooth/l2cap_core.c
> >> +++ b/net/bluetooth/l2cap_core.c
> >> @@ -764,7 +764,7 @@ static void l2cap_send_cmd(struct l2cap_conn *conn,
> u8 ident, u8 code, u16 len,
> >>      if (!skb)
> >>              return;
> >>
> >> -    if (lmp_no_flush_capable(conn->hcon->hdev))
> >> +    if (lmp_no_flush_capable(conn->hcon->hdev) || conn->hcon->type ==
> LE_LINK)
> >>              flags = ACL_START_NO_FLUSH;
> >>      else
> >>              flags = ACL_START;
> >> @@ -784,7 +784,7 @@ static bool __chan_is_moving(struct l2cap_chan
> *chan)
> >> static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
> >> {
> >>      struct hci_conn *hcon = chan->conn->hcon;
> >> -    u16 flags;
> >> +    u16 flags = ACL_START;
> >>
> >>      BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
> >>             skb->priority);
> >> @@ -798,11 +798,13 @@ static void l2cap_do_send(struct l2cap_chan
> *chan, struct sk_buff *skb)
> >>              return;
> >>      }
> >>
> >> -    if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
> >> -        lmp_no_flush_capable(hcon->hdev))
> >> +    if (hcon->type == LE_LINK) {
> >> +            /* LE-U does not support auto-flushing packets */
> >>              flags = ACL_START_NO_FLUSH;
> >> -    else
> >> -            flags = ACL_START;
> >> +    } else if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
> >> +                lmp_no_flush_capable(hcon->hdev)) {
> >> +            flags = ACL_START_NO_FLUSH;
> >> +    }
> >
> > I think Marcel was after just providing a clarifying code comment in
> > both places - having two branches of an if-statement doing exactly the
> > same thing looks a bit weird to me. To make thins completely clear I'd
> > suggest adding a simple helper function that you can call from both
> > places to get the needed flags, something like the following:
>
> I am actually fine with just adding a comment explaining the complex if
> statement on why it is correct. It is just a helper for everybody to
> understand what and why it is done that way.
>

Is the comment I added sufficient, or should I add one for the other if
condition as well?  To me, the second condition is pretty straightforward:
if the caller requested it and the hardware supports it, use NO_FLUSH.  The
relationship between FLUSH/NO_FLUSH and low-energy is much less clear and
more justifies a comment, in my opinion.
-- 
-Steven Walter <stevenrwalter@gmail.com>

--001a1139126c5e640205084c4d6d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Nov 20, 2014 at 8:50 AM, Marcel Holtmann <span dir=3D"ltr">&lt;=
<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Johan,<br>
<div><div class=3D"h5"><br>
&gt;&gt; The bluetooth spec states that automatically flushable packets may=
 not<br>
&gt;&gt; be sent over a LE-U link.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Steven Walter &lt;<a href=3D"mailto:stevenrwalter@g=
mail.com">stevenrwalter@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; net/bluetooth/l2cap_core.c | 14 ++++++++------<br>
&gt;&gt; 1 file changed, 8 insertions(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core=
.c<br>
&gt;&gt; index 4af3821..7c4350f 100644<br>
&gt;&gt; --- a/net/bluetooth/l2cap_core.c<br>
&gt;&gt; +++ b/net/bluetooth/l2cap_core.c<br>
&gt;&gt; @@ -764,7 +764,7 @@ static void l2cap_send_cmd(struct l2cap_conn *=
conn, u8 ident, u8 code, u16 len,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (!skb)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 if (lmp_no_flush_capable(conn-&gt;hcon-&gt;hdev))<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 if (lmp_no_flush_capable(conn-&gt;hcon-&gt;hdev) ||=
 conn-&gt;hcon-&gt;type =3D=3D LE_LINK)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D ACL_STAR=
T_NO_FLUSH;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 else<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D ACL_STAR=
T;<br>
&gt;&gt; @@ -784,7 +784,7 @@ static bool __chan_is_moving(struct l2cap_chan=
 *chan)<br>
&gt;&gt; static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff =
*skb)<br>
&gt;&gt; {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct hci_conn *hcon =3D chan-&gt;conn-&gt;hc=
on;<br>
&gt;&gt; -=C2=A0 =C2=A0 u16 flags;<br>
&gt;&gt; +=C2=A0 =C2=A0 u16 flags =3D ACL_START;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 BT_DBG(&quot;chan %p, skb %p len %d priority %=
u&quot;, chan, skb, skb-&gt;len,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0skb-&gt;priority);<=
br>
&gt;&gt; @@ -798,11 +798,13 @@ static void l2cap_do_send(struct l2cap_chan =
*chan, struct sk_buff *skb)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 if (!test_bit(FLAG_FLUSHABLE, &amp;chan-&gt;flags) =
&amp;&amp;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 lmp_no_flush_capable(hcon-&gt;hdev))<=
br>
&gt;&gt; +=C2=A0 =C2=A0 if (hcon-&gt;type =3D=3D LE_LINK) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* LE-U does not suppor=
t auto-flushing packets */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D ACL_STAR=
T_NO_FLUSH;<br>
&gt;&gt; -=C2=A0 =C2=A0 else<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D ACL_START;<br=
>
&gt;&gt; +=C2=A0 =C2=A0 } else if (!test_bit(FLAG_FLUSHABLE, &amp;chan-&gt;=
flags) &amp;&amp;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lmp_no_fl=
ush_capable(hcon-&gt;hdev)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags =3D ACL_START_NO_=
FLUSH;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; I think Marcel was after just providing a clarifying code comment in<b=
r>
&gt; both places - having two branches of an if-statement doing exactly the=
<br>
&gt; same thing looks a bit weird to me. To make thins completely clear I&#=
39;d<br>
&gt; suggest adding a simple helper function that you can call from both<br=
>
&gt; places to get the needed flags, something like the following:<br>
<br>
</div></div>I am actually fine with just adding a comment explaining the co=
mplex if statement on why it is correct. It is just a helper for everybody =
to understand what and why it is done that way.<br></blockquote><div><br></=
div><div>Is the comment I added sufficient, or should I add one for the oth=
er if condition as well?=C2=A0 To me, the second condition is pretty straig=
htforward: if the caller requested it and the hardware supports it, use NO_=
FLUSH.=C2=A0 The relationship between FLUSH/NO_FLUSH and low-energy is much=
 less clear and more justifies a comment, in my opinion.</div></div>-- <br>=
<div class=3D"gmail_signature">-Steven Walter &lt;<a href=3D"mailto:stevenr=
walter@gmail.com">stevenrwalter@gmail.com</a>&gt;</div>
</div></div>

--001a1139126c5e640205084c4d6d--
