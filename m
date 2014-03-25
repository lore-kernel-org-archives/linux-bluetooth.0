Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140325083837.GB5490@t440s.lan>
References: <1395735950-17968-1-git-send-email-surendra.tux@gmail.com>
	<20140325083837.GB5490@t440s.lan>
Date: Tue, 25 Mar 2014 10:09:56 -0700
Message-ID: <CADDSOjjbPEKLJU19OJ--E971pV3hv9gyAK=sO1Q=85nt7+OiVA@mail.gmail.com>
Subject: Re: [PATCH] drivers:bluetooth:ath3k.c: Fixed sparse warning for cast
 to restricted __le32
From: Surendra Patil <surendra.tux@gmail.com>
To: Surendra Patil <surendra.tux@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b5d8391e3c82604f5716b7d
List-ID: <linux-bluetooth.vger.kernel.org>

--047d7b5d8391e3c82604f5716b7d
Content-Type: text/plain; charset=ISO-8859-1

thanks for reviews.
will work on it .


On Tue, Mar 25, 2014 at 1:38 AM, Johan Hedberg <johan.hedberg@gmail.com>wrote:

> Hi,
>
> On Tue, Mar 25, 2014, Surendra Patil wrote:
> > This patch fixes below Sparse warnings -
> > drivers/bluetooth/ath3k.c:370:17: warning: cast to restricted __le32
> > drivers/bluetooth/ath3k.c:432:17: warning: cast to restricted __le32
> >
> > Signed-off-by: Surendra Patil <surendra.tux@gmail.com>
> > ---
> >  drivers/bluetooth/ath3k.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> > index be571fe..badacbc 100644
> > --- a/drivers/bluetooth/ath3k.c
> > +++ b/drivers/bluetooth/ath3k.c
> > @@ -367,7 +367,7 @@ static int ath3k_load_patch(struct usb_device *udev)
> >       }
> >
> >       snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
> > -             le32_to_cpu(fw_version.rom_version));
> > +             fw_version.rom_version);
> >
> >       ret = request_firmware(&firmware, filename, &udev->dev);
> >       if (ret < 0) {
> > @@ -429,7 +429,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
> >       }
> >
> >       snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
> > -             le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
> > +              fw_version.rom_version, clk_value, ".dfu");
> >
> >       ret = request_firmware(&firmware, filename, &udev->dev);
> >       if (ret < 0) {
>
> Are you sure this doesn't introduce a bug on big endian systems? We just
> recently applied commit b9e2535acad8f52a17e2aa843d45a6b756b59592 which
> adds this le32_to_cpu conversion. Probably the correct fix is to update
> this fw_version struct definition to use __le32 for any member that's
> expected to be in little endian format?
>
> Johan
>



-- 
Best,
Surendra Patil

--047d7b5d8391e3c82604f5716b7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thanks for reviews.<div>will work on it .</div></div><div =
class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Mar 25, 20=
14 at 1:38 AM, Johan Hedberg <span dir=3D"ltr">&lt;<a href=3D"mailto:johan.=
hedberg@gmail.com" target=3D"_blank">johan.hedberg@gmail.com</a>&gt;</span>=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<div><div class=3D"h5"><br>
On Tue, Mar 25, 2014, Surendra Patil wrote:<br>
&gt; This patch fixes below Sparse warnings -<br>
&gt; drivers/bluetooth/ath3k.c:370:17: warning: cast to restricted __le32<b=
r>
&gt; drivers/bluetooth/ath3k.c:432:17: warning: cast to restricted __le32<b=
r>
&gt;<br>
&gt; Signed-off-by: Surendra Patil &lt;<a href=3D"mailto:surendra.tux@gmail=
.com">surendra.tux@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/bluetooth/ath3k.c | 4 ++--<br>
&gt; =A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c<br>
&gt; index be571fe..badacbc 100644<br>
&gt; --- a/drivers/bluetooth/ath3k.c<br>
&gt; +++ b/drivers/bluetooth/ath3k.c<br>
&gt; @@ -367,7 +367,7 @@ static int ath3k_load_patch(struct usb_device *ude=
v)<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 snprintf(filename, ATH3K_NAME_LEN, &quot;ar3k/AthrBT_0x%08=
x.dfu&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 le32_to_cpu(fw_version.rom_version));<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 fw_version.rom_version);<br>
&gt;<br>
&gt; =A0 =A0 =A0 ret =3D request_firmware(&amp;firmware, filename, &amp;ude=
v-&gt;dev);<br>
&gt; =A0 =A0 =A0 if (ret &lt; 0) {<br>
&gt; @@ -429,7 +429,7 @@ static int ath3k_load_syscfg(struct usb_device *ud=
ev)<br>
&gt; =A0 =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 =A0 snprintf(filename, ATH3K_NAME_LEN, &quot;ar3k/ramps_0x%08x=
_%d%s&quot;,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 le32_to_cpu(fw_version.rom_version), clk_val=
ue, &quot;.dfu&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0fw_version.rom_version, clk_value, &quot;=
.dfu&quot;);<br>
&gt;<br>
&gt; =A0 =A0 =A0 ret =3D request_firmware(&amp;firmware, filename, &amp;ude=
v-&gt;dev);<br>
&gt; =A0 =A0 =A0 if (ret &lt; 0) {<br>
<br>
</div></div>Are you sure this doesn&#39;t introduce a bug on big endian sys=
tems? We just<br>
recently applied commit b9e2535acad8f52a17e2aa843d45a6b756b59592 which<br>
adds this le32_to_cpu conversion. Probably the correct fix is to update<br>
this fw_version struct definition to use __le32 for any member that&#39;s<b=
r>
expected to be in little endian format?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Johan<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr">Best,<div>Surendra Patil</div></div>
</div>

--047d7b5d8391e3c82604f5716b7d--
