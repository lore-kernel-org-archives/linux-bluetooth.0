Return-Path: <wnhuang@google.com>
MIME-Version: 1.0
In-Reply-To: <1464750564-21027-1-git-send-email-wnhuang@chromium.org>
References: <1464750564-21027-1-git-send-email-wnhuang@chromium.org>
From: Wei-Ning Huang <wnhuang@google.com>
Date: Wed, 1 Jun 2016 14:58:28 +0800
Message-ID: <CABicQ-WJR-BnXqnwHEtypf+DOo323=24G-K7-kfk=dORr_UJWw@mail.gmail.com>
Subject: Re: [PATCH] dt: bindings: fix documentation for MARVELL's bt-sd8xxx
 wireless device
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Amitkumar Karwar <akarwar@marvell.com>,
	Wei-Ning Huang <wnhuang@chromium.org>, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	Hu Xinming <huxm@marvell.com>, marcel@holtmann.org, devicetree@vger.kernel.org
Content-Type: multipart/alternative; boundary=94eb2c034a544bbeba053432045e
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c034a544bbeba053432045e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Please ignore this patch. I think we should make the driver parse 32 bit
value instead (to be consistent with mwifiex driver).

On Wed, Jun 1, 2016 at 11:09 AM, Wei-Ning Huang <wnhuang@chromium.org>
wrote:

> The property marvell,wakeup-pin and marvell,wakeup-gap-ms are read as
> u16 in the driver. Fix documentation and example accordingly.
>
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> ---
>  Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> index 14aa6cf..6a9a63c 100644
> --- a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> +++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> @@ -13,10 +13,10 @@ Optional properties:
>                       initialization. This is an array of 28 values(u8).
>
>    - marvell,wakeup-pin: It represents wakeup pin number of the bluetooth
> chip.
> -                       firmware will use the pin to wakeup host system.
> +                       firmware will use the pin to wakeup host system
> (u16).
>    - marvell,wakeup-gap-ms: wakeup gap represents wakeup latency of the
> host
>                       platform. The value will be configured to firmware.
> This
> -                     is needed to work chip's sleep feature as expected.
> +                     is needed to work chip's sleep feature as expected
> (u16).
>    - interrupt-parent: phandle of the parent interrupt controller
>    - interrupts : interrupt pin number to the cpu. Driver will request an
> irq based
>                  on this interrupt number. During system suspend, the irq
> will be
> @@ -50,7 +50,7 @@ calibration data is also available in below example.
>                         0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f
> 0x04 0x02
>                         0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00
> 0x00 0x00
>                         0x00 0x00 0xf0 0x00>;
> -               marvell,wakeup-pin =3D <0x0d>;
> -               marvell,wakeup-gap-ms =3D <0x64>;
> +               marvell,wakeup-pin =3D /bits/ 16 <0x0d>;
> +               marvell,wakeup-gap-ms =3D /bits/ 16 <0x64>;
>         };
>  };
> --
> 2.1.2
>
>


--=20
Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 | Software Engineer, Google Inc=
., Taiwan |
wnhuang@google.com | Cell: +886 910-380678

--94eb2c034a544bbeba053432045e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please ignore this patch. I think we should make the drive=
r parse 32 bit value instead (to be consistent with mwifiex driver).</div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jun 1, 201=
6 at 11:09 AM, Wei-Ning Huang <span dir=3D"ltr">&lt;<a href=3D"mailto:wnhua=
ng@chromium.org" target=3D"_blank">wnhuang@chromium.org</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">The property marvell,wakeup-pin and ma=
rvell,wakeup-gap-ms are read as<br>
u16 in the driver. Fix documentation and example accordingly.<br>
<br>
Signed-off-by: Wei-Ning Huang &lt;<a href=3D"mailto:wnhuang@chromium.org">w=
nhuang@chromium.org</a>&gt;<br>
---<br>
=C2=A0Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt | 8 ++++-=
---<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt b/=
Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt<br>
index 14aa6cf..6a9a63c 100644<br>
--- a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt<br>
+++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt<br>
@@ -13,10 +13,10 @@ Optional properties:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 initialization. This is an array of 28 values(u8).<br>
<br>
=C2=A0 =C2=A0- marvell,wakeup-pin: It represents wakeup pin number of the b=
luetooth chip.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0firmware will use the pin to wakeup host system.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0firmware will use the pin to wakeup host system (u16).<br>
=C2=A0 =C2=A0- marvell,wakeup-gap-ms: wakeup gap represents wakeup latency =
of the host<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 platform. The value will be configured to firmware. This<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0is needed to work chip&#39;s sleep feature as expected.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0is needed to work chip&#39;s sleep feature as expected (u16).<br>
=C2=A0 =C2=A0- interrupt-parent: phandle of the parent interrupt controller=
<br>
=C2=A0 =C2=A0- interrupts : interrupt pin number to the cpu. Driver will re=
quest an irq based<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on this inter=
rupt number. During system suspend, the irq will be<br>
@@ -50,7 +50,7 @@ calibration data is also available in below example.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x00 0x00 0xf0 0x00&gt;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0marvell,wakeup-pin =
=3D &lt;0x0d&gt;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0marvell,wakeup-gap-=
ms =3D &lt;0x64&gt;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0marvell,wakeup-pin =
=3D /bits/ 16 &lt;0x0d&gt;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0marvell,wakeup-gap-=
ms =3D /bits/ 16 &lt;0x64&gt;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0};<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.1.2<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><sp=
an style=3D"font-size:12.6666669845581px"><font color=3D"#444444"><span sty=
le=3D"font-family:sans-serif;line-height:19.5px;border-width:2px 0px 0px;bo=
rder-style:solid;border-color:rgb(213,15,37);padding-top:2px;margin-top:2px=
">Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 |</span><span style=3D"font-f=
amily:sans-serif;line-height:19.5px;border-width:2px 0px 0px;border-style:s=
olid;border-color:rgb(51,105,232);padding-top:2px;margin-top:2px">=C2=A0Sof=
tware Engineer, Google Inc., Taiwan |</span><span style=3D"font-family:sans=
-serif;line-height:19.5px;border-width:2px 0px 0px;border-style:solid;borde=
r-color:rgb(0,153,57);padding-top:2px;margin-top:2px">=C2=A0<a href=3D"mail=
to:wnhuang@google.com" target=3D"_blank">wnhuang@google.com</a>=C2=A0|</spa=
n></font></span><span style=3D"font-size:12.6666669845581px"><span style=3D=
"font-family:sans-serif;line-height:19.5px;border-width:2px 0px 0px;border-=
style:solid;border-color:rgb(238,178,17);padding-top:2px;margin-top:2px"><f=
ont color=3D"#444444">=C2=A0Cell: +886 910-380678</font><font color=3D"#000=
000">=C2=A0</font></span></span><br></div></div></div></div>
</div>

--94eb2c034a544bbeba053432045e--
