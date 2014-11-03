Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7D190559-F7EA-4A3B-BF1F-EB53D1715049@holtmann.org>
References: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
	<7D190559-F7EA-4A3B-BF1F-EB53D1715049@holtmann.org>
Date: Mon, 3 Nov 2014 09:52:15 -0800
Message-ID: <CAD0=r8ypbdcaFJYMHuOsrZx48G0FjmWVvUytg0ERevCHdgdc4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] add restart_le_scan
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113b39eaccdb560506f801cf
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113b39eaccdb560506f801cf
Content-Type: text/plain; charset=UTF-8

On Sun, Nov 2, 2014 at 11:42 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Jakub,
>
> the patch subject needs to start with Bluetooth:
>
I'll send fixed path today.

>
> > Currently there is no way to restart le scan. It's needed in
> > preparation for new service scan method. The way it work: it disable,
> > and then enable le scan on controller. During this restart special flag
> > is set to make sure we won't remove disable scan work from workqueue.
> >
> > Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> > ---
> > include/net/bluetooth/hci.h      |  1 +
> > include/net/bluetooth/hci_core.h |  2 ++
> > net/bluetooth/hci_core.c         | 42
> ++++++++++++++++++++++++++++++++++++++++
> > net/bluetooth/hci_event.c        |  9 ++++++---
> > 4 files changed, 51 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 6e8f249..b15d240 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -194,6 +194,7 @@ enum {
> >       HCI_FAST_CONNECTABLE,
> >       HCI_BREDR_ENABLED,
> >       HCI_LE_SCAN_INTERRUPTED,
> > +     HCI_LE_SCAN_RESTARTING,
> > };
> >
> > /* A mask for the flags that are supposed to remain when a reset happens
> > diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h
> > index b8685a7..3c585885 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -334,6 +334,7 @@ struct hci_dev {
> >       unsigned long           dev_flags;
> >
> >       struct delayed_work     le_scan_disable;
> > +     struct delayed_work     le_scan_restart;
>
> So I wonder if we need le_scan_restart delayed_work here. We might be able
> to just put that into le_scan_disable one using the HCI_LE_SCAN_RESTART
> flag.
>

When you start regular scan or service scan, you schedule le_scan_disable
to take place in around 5-10 seconds to finish scan (it depends on kind of
scan, and it's DISCOV_LE_TIMEOUT, or hdev->discov_interleaved_timeout)
During those 5-10 seconds we need to restart the scan multiple times. If
we'll try to queue the same work again, that would not work because of the
way queue_delayed_work works. We need to have a different delayed_work to
achieve that, that's why I introduced le_scan_restart.

Also it's possible to have situation when the scan is finishing, and we
call le_scan_disable, but at the same time the HCI_LE_SCAN_RESTART was just
set, and you get race condition that would cause the scan to be restarted
instead of being disabled and run all the time.
The way I wrote that right now you can't get that race condition.


> That said, I like to get this working also with the regular discovery
> procedure. It is just that there every found device will trigger the
> restart, while in the service discovery it is only the ones we care about.
> So we should expose an general mechanism here.
>

When I was initially implementing service scan, I was doing it inside
regular scan, and le_scan_restart was working fine there (later I just
extracted different opcode for the scan method). There's nothing special
now in regular, or service scan that would make le_scan_restart not work.


>
> I do not have figured every single detail our here, but that is where I
> like to go with this.
>

queue_delayed_work


>
> Regards
>
> Marcel
>
>

--001a113b39eaccdb560506f801cf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Nov 2, 2014 at 11:42 AM, Marcel Holtmann <span dir=3D"ltr">&lt;=
<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">Hi Jakub,<br>
<br>
the patch subject needs to start with Bluetooth:<br></blockquote><div>I&#39=
;ll send fixed path today.=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(=
204,204,204);border-left-style:solid;padding-left:1ex">
<div><div><br>
&gt; Currently there is no way to restart le scan. It&#39;s needed in<br>
&gt; preparation for new service scan method. The way it work: it disable,<=
br>
&gt; and then enable le scan on controller. During this restart special fla=
g<br>
&gt; is set to make sure we won&#39;t remove disable scan work from workque=
ue.<br>
&gt;<br>
&gt; Signed-off-by: Jakub Pawlowski &lt;<a href=3D"mailto:jpawlowski@google=
.com" target=3D"_blank">jpawlowski@google.com</a>&gt;<br>
&gt; ---<br>
&gt; include/net/bluetooth/hci.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; include/net/bluetooth/hci_core.h |=C2=A0 2 ++<br>
&gt; net/bluetooth/hci_core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 42 +++++++=
+++++++++++++++++++++++++++++++++<br>
&gt; net/bluetooth/hci_event.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++++-=
--<br>
&gt; 4 files changed, 51 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h=
<br>
&gt; index 6e8f249..b15d240 100644<br>
&gt; --- a/include/net/bluetooth/hci.h<br>
&gt; +++ b/include/net/bluetooth/hci.h<br>
&gt; @@ -194,6 +194,7 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0HCI_FAST_CONNECTABLE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0HCI_BREDR_ENABLED,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0HCI_LE_SCAN_INTERRUPTED,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0HCI_LE_SCAN_RESTARTING,<br>
&gt; };<br>
&gt;<br>
&gt; /* A mask for the flags that are supposed to remain when a reset happe=
ns<br>
&gt; diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h<br>
&gt; index b8685a7..3c585885 100644<br>
&gt; --- a/include/net/bluetooth/hci_core.h<br>
&gt; +++ b/include/net/bluetooth/hci_core.h<br>
&gt; @@ -334,6 +334,7 @@ struct hci_dev {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_flags;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct delayed_work=C2=A0 =C2=A0 =C2=A0le_sc=
an_disable;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct delayed_work=C2=A0 =C2=A0 =C2=A0le_scan_re=
start;<br>
<br>
</div></div>So I wonder if we need le_scan_restart delayed_work here. We mi=
ght be able to just put that into le_scan_disable one using the HCI_LE_SCAN=
_RESTART flag.<br></blockquote><div><br></div><div>When you start regular s=
can or service scan, you schedule le_scan_disable to take place in around 5=
-10 seconds to finish scan (it depends on kind of scan, and it&#39;s=C2=A0D=
ISCOV_LE_TIMEOUT, or=C2=A0hdev-&gt;discov_interleaved_timeout)</div><div>Du=
ring those 5-10 seconds we need to restart the scan multiple times. If we&#=
39;ll try to queue the same work again, that would not work because of the =
way=C2=A0queue_delayed_work works. We need to have a different delayed_work=
 to achieve that, that&#39;s why I introduced le_scan_restart.</div><div><b=
r></div><div>Also it&#39;s possible to have situation when the scan is fini=
shing, and we call le_scan_disable, but at the same time the HCI_LE_SCAN_RE=
START was just set, and you get race condition that would cause the scan to=
 be restarted instead of being disabled and run all the time.</div><div>The=
 way I wrote that right now you can&#39;t get that race condition.</div><di=
v>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex">
That said, I like to get this working also with the regular discovery proce=
dure. It is just that there every found device will trigger the restart, wh=
ile in the service discovery it is only the ones we care about. So we shoul=
d expose an general mechanism here.<br></blockquote><div><br></div><div>Whe=
n I was initially implementing service scan, I was doing it inside regular =
scan, and=C2=A0le_scan_restart was working fine there (later I just extract=
ed different opcode for the scan method). There&#39;s nothing special now i=
n regular, or service scan that would make le_scan_restart not work.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-le=
ft-style:solid;padding-left:1ex">
<br>
I do not have figured every single detail our here, but that is where I lik=
e to go with this.<br></blockquote><div><br></div><div>queue_delayed_work<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);=
border-left-style:solid;padding-left:1ex">
<br>
Regards<br>
<span><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a113b39eaccdb560506f801cf--
