Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6112AC01-B1C4-4DF8-8085-63334761D725@holtmann.org>
References: <132658595.194181413985732727.JavaMail.weblogic@epmlwas01a>
	<6112AC01-B1C4-4DF8-8085-63334761D725@holtmann.org>
Date: Fri, 31 Oct 2014 16:03:08 +0900
Message-ID: <CAJx1FMPUkBREuxC0fGy4XDaZOV55N57e0aiOccvcy8_MOvdMgw@mail.gmail.com>
Subject: Re: [RFC] Bluetooth : Fix hci_sync miss wakeup interrupt
From: "Chanyeol,Park" <chanyeol.park@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, =?UTF-8?B?67CV7LCs7Je0?= <chanyeol.park@samsung.com>
Content-Type: multipart/alternative; boundary=bcaec51a77c8dab9b60506b296b0
List-ID: <linux-bluetooth.vger.kernel.org>

--bcaec51a77c8dab9b60506b296b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marcel

Due to internal reason I made mistake.

I raised it again.

Thanks
Chanyeol
2014. 10. 29. =EC=98=A4=EC=A0=84 2:32=EC=97=90 "Marcel Holtmann" <marcel@ho=
ltmann.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Chan-yeol,
>
> > __hci_cmd_sync_ev(), __hci_req_sync() could miss wake_up_interrupt from
> > hci_req_sync_complete() because hci_cmd_work() workquee and its reponse
> > could be completed before they are ready to get the signal through
> > add_wait_queue(), set_current_state(TASK_INTERRUPTIBLE).
> >
> > Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > net/bluetooth/hci_core.c | 18 +++++++++++-------
> > 1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index cb05d7f..c008f1f 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1147,13 +1147,15 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_de=
v
> *hdev, u16 opcode, u32 plen,
> >
> >        hdev->req_status =3D HCI_REQ_PEND;
> >
> > -       err =3D hci_req_run(&req, hci_req_sync_complete);
> > -       if (err < 0)
> > -               return ERR_PTR(err);
> > -
>
> the whole patch has whitespace damages. Please fix this.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--bcaec51a77c8dab9b60506b296b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi Marcel</p>
<p dir=3D"ltr">Due to internal reason I made mistake.</p>
<p dir=3D"ltr">I raised it again.</p>
<p dir=3D"ltr">Thanks<br>
Chanyeol</p>
<div class=3D"gmail_quote">2014. 10. 29. =EC=98=A4=EC=A0=84 2:32=EC=97=90 &=
quot;Marcel Holtmann&quot; &lt;<a href=3D"mailto:marcel@holtmann.org">marce=
l@holtmann.org</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br type=3D"att=
ribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Hi Chan-yeol,<br>
<br>
&gt; __hci_cmd_sync_ev(), __hci_req_sync() could miss wake_up_interrupt fro=
m<br>
&gt; hci_req_sync_complete() because hci_cmd_work() workquee and its repons=
e<br>
&gt; could be completed before they are ready to get the signal through<br>
&gt; add_wait_queue(), set_current_state(TASK_INTERRUPTIBLE).<br>
&gt;<br>
&gt; Signed-off-by: Chan-yeol Park &lt;<a href=3D"mailto:chanyeol.park@sams=
ung.com">chanyeol.park@samsung.com</a>&gt;<br>
&gt; Signed-off-by: Kyungmin Park &lt;<a href=3D"mailto:kyungmin.park@samsu=
ng.com">kyungmin.park@samsung.com</a>&gt;<br>
&gt; ---<br>
&gt; net/bluetooth/hci_core.c | 18 +++++++++++-------<br>
&gt; 1 file changed, 11 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c<br>
&gt; index cb05d7f..c008f1f 100644<br>
&gt; --- a/net/bluetooth/hci_core.c<br>
&gt; +++ b/net/bluetooth/hci_core.c<br>
&gt; @@ -1147,13 +1147,15 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_d=
ev *hdev, u16 opcode, u32 plen,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdev-&gt;req_status =3D HCI_REQ_PEND;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D hci_req_run(&amp;req, hci_req_sync=
_complete);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err &lt; 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR=
(err);<br>
&gt; -<br>
<br>
the whole patch has whitespace damages. Please fix this.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-blueto=
oth&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</blockquote></div>

--bcaec51a77c8dab9b60506b296b0--
