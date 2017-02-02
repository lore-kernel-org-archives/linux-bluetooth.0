Return-Path: <carlo@endlessm.com>
MIME-Version: 1.0
References: <20170201171431.9633-1-carlo@caione.org> <D130D4FB-7AF0-46BF-9BC7-D9050C596E1A@holtmann.org>
 <CAL9uMOEvFH-mi23U_9SYDcQ7oXJQMB5cy4TL0VKp6OL7Si1ePg@mail.gmail.com> <02A0165B-9058-4663-9809-E7DA030E0878@holtmann.org>
In-Reply-To: <02A0165B-9058-4663-9809-E7DA030E0878@holtmann.org>
From: Carlo Caione <carlo@endlessm.com>
Date: Thu, 02 Feb 2017 09:40:25 +0000
Message-ID: <CAL9uMOEQyo3RmyOEs_7eM0FsRSktB+=5Jw6HCOV4Gvw6Wn66bg@mail.gmail.com>
Subject: Re: [PATCH] tools/btattach: Add detach option
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>, Carlo Caione <carlo@caione.org>,
	Linux Upstreaming Team <linux@endlessm.com>
Content-Type: multipart/alternative; boundary=f403045f91080db9bb054788f5f1
List-ID: <linux-bluetooth.vger.kernel.org>

--f403045f91080db9bb054788f5f1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Feb 2017 at 04:25, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Carlo,
>
> >>> ---
> >>> tools/btattach.c | 10 +++++++++-
> >>> 1 file changed, 9 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/btattach.c b/tools/btattach.c
> >>> index 5adbc8d..f1f115d 100644
> >>> --- a/tools/btattach.c
> >>> +++ b/tools/btattach.c
> >>> @@ -194,6 +194,7 @@ static void usage(void)
> >>>              "\t-P, --protocol <proto> Specify protocol type\n"
> >>>              "\t-S, --speed <baudrate> Specify which baudrate to use\=
n"
> >>>              "\t-N, --noflowctl        Disable flow control\n"
> >>> +             "\t-D, --detach           Open device and then fork\n"
> >>>              "\t-h, --help             Show help options\n=E2=80=9D);
> >>
> >> And is this really a good idea. I think that I had removed all the for=
k
> calls from the standard tools. Mainly since we fail to maintain the signa=
ls
> and more important child signals correctly. So we quickly end up with
> zombies or orphaned processes. My thinking instead was to leave this to
> systemd to handle.
> >
> > Interesting. Any pointer how to achieve that?
> > The problem is that I have btattach called by a systemd unit file to
> > download the firmware to the bluetooth transceiver. I also have
> > another systemd unit that must be called strictly after btattach has
> > done uploading the firmware. Since btattach is hanging on the port
> > AFAIU there is no way I can tell exactly when it is done uploading the
> > firmware. That's why I was adding this detach option, to mark the unit
> > as 'Type=3Dforking' and enforcing the ordering with
> > 'Before=3Dnext.service`.
> > Anything I am missing?
>
> why do you need to know when the firmware uploading has completed? What
> hardware is this?


The hardware is a custom ARM board based on an Amlogic SOC.
More specifically I need btattach systemd unit to run before
systemd-rfkill. This is because the rfkill driver is actually driving the
GPIO enable of the transceiver, so if systemd-rfkill runs before btattach
has completed telling to disable the radio (because we rebooted with the BT
off) this just interrupts the firmware downloading leaving the transceiver
in a non-working state.

> --
Carlo Caione  |  +39.340.80.30.096  |  Endless

--f403045f91080db9bb054788f5f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div>On Thu, 2 Feb 2017 at 04:25, Marce=
l Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Carlo,<br class=3D=
"gmail_msg">
<br class=3D"gmail_msg">
&gt;&gt;&gt; ---<br class=3D"gmail_msg">
&gt;&gt;&gt; tools/btattach.c | 10 +++++++++-<br class=3D"gmail_msg">
&gt;&gt;&gt; 1 file changed, 9 insertions(+), 1 deletion(-)<br class=3D"gma=
il_msg">
&gt;&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt;&gt; diff --git a/tools/btattach.c b/tools/btattach.c<br class=3D"g=
mail_msg">
&gt;&gt;&gt; index 5adbc8d..f1f115d 100644<br class=3D"gmail_msg">
&gt;&gt;&gt; --- a/tools/btattach.c<br class=3D"gmail_msg">
&gt;&gt;&gt; +++ b/tools/btattach.c<br class=3D"gmail_msg">
&gt;&gt;&gt; @@ -194,6 +194,7 @@ static void usage(void)<br class=3D"gmail_=
msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\t-P, --=
protocol &lt;proto&gt; Specify protocol type\n&quot;<br class=3D"gmail_msg"=
>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\t-S, --=
speed &lt;baudrate&gt; Specify which baudrate to use\n&quot;<br class=3D"gm=
ail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\t-N, --=
noflowctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 Disable flow control\n&quot;<br class=
=3D"gmail_msg">
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\t-D, -=
-detach=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Open device and then fork\n=
&quot;<br class=3D"gmail_msg">
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;\t-h, --=
help=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Show help options\n=E2=
=80=9D);<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; And is this really a good idea. I think that I had removed all the=
 fork calls from the standard tools. Mainly since we fail to maintain the s=
ignals and more important child signals correctly. So we quickly end up wit=
h zombies or orphaned processes. My thinking instead was to leave this to s=
ystemd to handle.<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; Interesting. Any pointer how to achieve that?<br class=3D"gmail_msg">
&gt; The problem is that I have btattach called by a systemd unit file to<b=
r class=3D"gmail_msg">
&gt; download the firmware to the bluetooth transceiver. I also have<br cla=
ss=3D"gmail_msg">
&gt; another systemd unit that must be called strictly after btattach has<b=
r class=3D"gmail_msg">
&gt; done uploading the firmware. Since btattach is hanging on the port<br =
class=3D"gmail_msg">
&gt; AFAIU there is no way I can tell exactly when it is done uploading the=
<br class=3D"gmail_msg">
&gt; firmware. That&#39;s why I was adding this detach option, to mark the =
unit<br class=3D"gmail_msg">
&gt; as &#39;Type=3Dforking&#39; and enforcing the ordering with<br class=
=3D"gmail_msg">
&gt; &#39;Before=3Dnext.service`.<br class=3D"gmail_msg">
&gt; Anything I am missing?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
why do you need to know when the firmware uploading has completed? What har=
dware is this?</blockquote><div><br></div><div>The hardware is a custom ARM=
 board based on an Amlogic SOC.</div><div>More specifically I need btattach=
 systemd unit to run before systemd-rfkill. This is because the rfkill driv=
er is actually driving the GPIO enable of the transceiver, so if systemd-rf=
kill runs before btattach has completed telling to disable the radio (becau=
se we rebooted with the BT off) this just interrupts the firmware downloadi=
ng leaving the transceiver in a non-working state.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"></blockquote></div></div><div dir=3D"ltr">-- <br></div><div d=
ata-smartmail=3D"gmail_signature">Carlo Caione =C2=A0| =C2=A0+39.340.80.30.=
096 =C2=A0| =C2=A0Endless</div>

--f403045f91080db9bb054788f5f1--
