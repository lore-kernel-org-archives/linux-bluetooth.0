Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <38995981-F906-4283-AAC1-9AAEA6012BFD@holtmann.org>
References: <1395612571-5365-1-git-send-email-lukasz.rymanowski@tieto.com>
	<38995981-F906-4283-AAC1-9AAEA6012BFD@holtmann.org>
Date: Mon, 24 Mar 2014 00:04:23 +0100
Message-ID: <CAMudyAu+HGgCpikV8R-HnVobZAXASeHy_wKjUj+c16q3kCP8=Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add new debugfs parameter
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=089e01182562cc36c204f54e23aa
List-ID: <linux-bluetooth.vger.kernel.org>

--089e01182562cc36c204f54e23aa
Content-Type: text/plain; charset=ISO-8859-1

Hi Marcel,


On 23 March 2014 23:13, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Lukasz,
>
> > With this patch it is possible to control discovery interleaved
> > timeout value from debugfs. Default value is 5120 ms.
> >
> > It is useful to control it in case of automated testaces where bredrle
> > controler is doing discovery and it is waiting for inquiry results. With
> > this patch we can decrease le scan time and get inquiry results faster.
> >
> > It might be also useful in other test cases.
> >
> > Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> > ---
> > include/net/bluetooth/hci_core.h | 2 +-
> > net/bluetooth/hci_core.c         | 6 ++++++
> > net/bluetooth/mgmt.c             | 2 +-
> > 3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h
> > index 5f8bc05..2d63ade 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -194,6 +194,7 @@ struct hci_dev {
> >       __u16           le_scan_window;
> >       __u16           le_conn_min_interval;
> >       __u16           le_conn_max_interval;
> > +     __u32           discov_interl_timeout;
> >       __u8            ssp_debug_mode;
> >
> >       __u16           devid_source;
> > @@ -1205,7 +1206,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int
> event);
> > #define DISCOV_LE_SCAN_WIN            0x12
> > #define DISCOV_LE_SCAN_INT            0x12
> > #define DISCOV_LE_TIMEOUT             msecs_to_jiffies(10240)
> > -#define DISCOV_INTERLEAVED_TIMEOUT   msecs_to_jiffies(5120)
> > #define DISCOV_INTERLEAVED_INQUIRY_LEN        0x04
> > #define DISCOV_BREDR_INQUIRY_LEN      0x08
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 1c6ffaa..b2139f1 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -61,6 +61,9 @@ static void hci_notify(struct hci_dev *hdev, int event)
> >
> > /* ---- HCI debugfs entries ---- */
> >
> > +/* Discovery interleaved timeout */
> > +static u16 discov_timeout_ms = 5120;
> > +
> > static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
> >                            size_t count, loff_t *ppos)
> > {
> > @@ -1828,6 +1831,8 @@ static int __hci_init(struct hci_dev *hdev)
> >                                   &lowpan_debugfs_fops);
> >               debugfs_create_file("le_auto_conn", 0644, hdev->debugfs,
> hdev,
> >                                   &le_auto_conn_fops);
> > +             debugfs_create_u16("discov_interleaved_timeout", 0644,
> > +                                bt_debugfs, &discov_timeout_ms);
>
> please attach a second HCI controller to your system and tell me what
> happens.
>
> Well I'm aware that first controller gets default value unless you detach
and attach back after this value is chenged. So  yes, you might end with
different interleaved  timeouts for two controllers. But this is debug
stuff so I though it is ok.

I was considering to do this value per hdev but case we want to cover here
is xxx_tester on vhci and we just need to have some way to set this
interleave value before vhci  is allocated.

Other option would be to make this timeout global and we could easly change
it in the runtime. But then:
a) do it in mgmt.c where this timeout is used? well IMHO this timeout does
not belong to mgmt so I dropped it.
b) do it in hci_core.c and expose somehow to mgmt (some get_function or
export?) - well did not like it

Anyway, If this way is not acceptable then what do you suggest? IMHO if
somebody would like to use this debugfs option he will be able to use it
correctly.


Regards
>
> Marcel
>
> \Lukasz

--089e01182562cc36c204f54e23aa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,<div class=3D"gmail_extra"><br><br><div class=3D=
"gmail_quote">On 23 March 2014 23:13, Marcel Holtmann <span dir=3D"ltr">&lt=
;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.o=
rg</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Lukasz,<br>
<br>
&gt; With this patch it is possible to control discovery interleaved<br>
&gt; timeout value from debugfs. Default value is 5120 ms.<br>
&gt;<br>
&gt; It is useful to control it in case of automated testaces where bredrle=
<br>
&gt; controler is doing discovery and it is waiting for inquiry results. Wi=
th<br>
&gt; this patch we can decrease le scan time and get inquiry results faster=
.<br>
&gt;<br>
&gt; It might be also useful in other test cases.<br>
&gt;<br>
&gt; Signed-off-by: Lukasz Rymanowski &lt;<a href=3D"mailto:lukasz.rymanows=
ki@tieto.com">lukasz.rymanowski@tieto.com</a>&gt;<br>
&gt; ---<br>
&gt; include/net/bluetooth/hci_core.h | 2 +-<br>
&gt; net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | 6 ++++++<br>
&gt; net/bluetooth/mgmt.c =A0 =A0 =A0 =A0 =A0 =A0 | 2 +-<br>
&gt; 3 files changed, 8 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h<br>
&gt; index 5f8bc05..2d63ade 100644<br>
&gt; --- a/include/net/bluetooth/hci_core.h<br>
&gt; +++ b/include/net/bluetooth/hci_core.h<br>
&gt; @@ -194,6 +194,7 @@ struct hci_dev {<br>
&gt; =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 le_scan_window;<br>
&gt; =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 le_conn_min_interval;<br>
&gt; =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 le_conn_max_interval;<br>
&gt; + =A0 =A0 __u32 =A0 =A0 =A0 =A0 =A0 discov_interl_timeout;<br>
&gt; =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0ssp_debug_mode;<br>
&gt;<br>
&gt; =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 devid_source;<br>
&gt; @@ -1205,7 +1206,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, in=
t event);<br>
&gt; #define DISCOV_LE_SCAN_WIN =A0 =A0 =A0 =A0 =A0 =A00x12<br>
&gt; #define DISCOV_LE_SCAN_INT =A0 =A0 =A0 =A0 =A0 =A00x12<br>
&gt; #define DISCOV_LE_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(102=
40)<br>
&gt; -#define DISCOV_INTERLEAVED_TIMEOUT =A0 msecs_to_jiffies(5120)<br>
&gt; #define DISCOV_INTERLEAVED_INQUIRY_LEN =A0 =A0 =A0 =A00x04<br>
&gt; #define DISCOV_BREDR_INQUIRY_LEN =A0 =A0 =A00x08<br>
&gt;<br>
&gt; diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c<br>
&gt; index 1c6ffaa..b2139f1 100644<br>
&gt; --- a/net/bluetooth/hci_core.c<br>
&gt; +++ b/net/bluetooth/hci_core.c<br>
&gt; @@ -61,6 +61,9 @@ static void hci_notify(struct hci_dev *hdev, int eve=
nt)<br>
&gt;<br>
&gt; /* ---- HCI debugfs entries ---- */<br>
&gt;<br>
&gt; +/* Discovery interleaved timeout */<br>
&gt; +static u16 discov_timeout_ms =3D 5120;<br>
&gt; +<br>
&gt; static ssize_t dut_mode_read(struct file *file, char __user *user_buf,=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t count, l=
off_t *ppos)<br>
&gt; {<br>
&gt; @@ -1828,6 +1831,8 @@ static int __hci_init(struct hci_dev *hdev)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &a=
mp;lowpan_debugfs_fops);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 debugfs_create_file(&quot;le_auto_conn&quo=
t;, 0644, hdev-&gt;debugfs, hdev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &a=
mp;le_auto_conn_fops);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 debugfs_create_u16(&quot;discov_interleaved_=
timeout&quot;, 0644,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bt_de=
bugfs, &amp;discov_timeout_ms);<br>
<br>
please attach a second HCI controller to your system and tell me what happe=
ns.<br>
<br></blockquote><div>Well I&#39;m aware that first controller gets default=
 value unless you detach and attach back after this value is chenged. So =
=A0yes, you might end with different interleaved =A0timeouts for two contro=
llers. But this is debug stuff so I though it is ok.</div>
<div><br></div><div>I was considering to do this value per hdev but case we=
 want to cover here is xxx_tester on vhci and we just need to have some way=
 to set this interleave value before vhci =A0is allocated.</div><div><br>
</div><div>Other option would be to make this timeout global and we could e=
asly change it in the runtime. But then:</div><div>a) do it in mgmt.c where=
 this timeout is used? well IMHO this timeout does not belong to mgmt so I =
dropped it.</div>
<div>b) do it in hci_core.c and expose somehow to mgmt (some get_function o=
r export?) - well did not like it</div><div><br></div><div>Anyway, If this =
way is not acceptable then what do you suggest? IMHO if somebody would like=
 to use this debugfs option he will be able to use it correctly.</div>
<div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div>\Lukasz</div></div>

--089e01182562cc36c204f54e23aa--
