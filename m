Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <B03B0FB0-08E0-4031-9E3D-FE2B7BBAF373@holtmann.org>
References: <1504509480-14082-1-git-send-email-loic.poulain@linaro.org> <B03B0FB0-08E0-4031-9E3D-FE2B7BBAF373@holtmann.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 4 Sep 2017 12:43:36 +0200
Message-ID: <CAMZdPi-R65vBiY66MQhM=JmL_tUiA-2xJudHwJewOmf2a-Uhvw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btqcomsmd: BD address setup
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: multipart/alternative; boundary="94eb2c135102d962c405585aca8b"
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c135102d962c405585aca8b
Content-Type: text/plain; charset="UTF-8"

Hi Marcel

On 4 September 2017 at 09:39, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Loic,
>
> > Bluetooth BD address can be retrieved in the same way as
> > for wcnss-wlan MAC address. This patch mainly stores the
> > local-mac-address property and sets the BD address during
> > hci device setup.
> >
> > If the default BD address is detected, mark the device as
> > unconfigured.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> > ---
> > drivers/bluetooth/btqcomsmd.c | 63 ++++++++++++++++++++++++++++++
> +++++++++++++
> > 1 file changed, 63 insertions(+)
> >
> > v2: Set device as unconfigured if default address detected
> >     Add warning if BD addr retrieved from DT
> >
> > diff --git a/drivers/bluetooth/btqcomsmd.c
> b/drivers/bluetooth/btqcomsmd.c
> > index d00c4fd..e07df69 100644
> > --- a/drivers/bluetooth/btqcomsmd.c
> > +++ b/drivers/bluetooth/btqcomsmd.c
> > @@ -15,6 +15,8 @@
> > #include <linux/module.h>
> > #include <linux/slab.h>
> > #include <linux/rpmsg.h>
> > +#include <linux/of.h>
> > +
> > #include <linux/soc/qcom/wcnss_ctrl.h>
> > #include <linux/platform_device.h>
> >
> > @@ -23,9 +25,12 @@
> >
> > #include "btqca.h"
> >
> > +#define BDADDR_QCOMSMD (&(bdaddr_t) {{0xAD, 0x5A, 0x00, 0x00, 0x00,
> 0x00}})
> > +
> > struct btqcomsmd {
> >       struct hci_dev *hdev;
> >
> > +     const bdaddr_t *addr;
>
> so lets use bdaddr here. And frankly I would really just use bdaddr_t
> bdaddr here. You have to swap the address anyway since we use
> local-mac-address.
>
> Unless of course we start using local-bd-address as DT property. Remember
> that even a WiFi address must be different from a Bluetooth address. You
> can not use the same. So the boot loader needs to understand that this is
> the Bluetooth address and not the WiFi address.
>

Yes the bootloader seems to set the same address as the wlan one but with
last bit flipped.
However I agree that this property should be updated with bt specific
naming to avoid confusion.

Regards,
Loic

--94eb2c135102d962c405585aca8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel<br><div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On 4 September 2017 at 09:39, Marcel Holtmann <span dir=
=3D"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marce=
l@holtmann.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hi Loic,<br>
<div><div class=3D"m_-1969934345854830430gmail-h5"><br>
&gt; Bluetooth BD address can be retrieved in the same way as<br>
&gt; for wcnss-wlan MAC address. This patch mainly stores the<br>
&gt; local-mac-address property and sets the BD address during<br>
&gt; hci device setup.<br>
&gt;<br>
&gt; If the default BD address is detected, mark the device as<br>
&gt; unconfigured.<br>
&gt;<br>
&gt; Signed-off-by: Loic Poulain &lt;<a href=3D"mailto:loic.poulain@linaro.=
org" target=3D"_blank">loic.poulain@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; drivers/bluetooth/btqcomsmd.c | 63 ++++++++++++++++++++++++++++++<wbr>=
+++++++++++++<br>
&gt; 1 file changed, 63 insertions(+)<br>
&gt;<br>
&gt; v2: Set device as unconfigured if default address detected<br>
&gt;=C2=A0 =C2=A0 =C2=A0Add warning if BD addr retrieved from DT<br>
&gt;<br>
&gt; diff --git a/drivers/bluetooth/btqcomsmd.<wbr>c b/drivers/bluetooth/bt=
qcomsmd.<wbr>c<br>
&gt; index d00c4fd..e07df69 100644<br>
&gt; --- a/drivers/bluetooth/btqcomsmd.<wbr>c<br>
&gt; +++ b/drivers/bluetooth/btqcomsmd.<wbr>c<br>
&gt; @@ -15,6 +15,8 @@<br>
&gt; #include &lt;linux/module.h&gt;<br>
&gt; #include &lt;linux/slab.h&gt;<br>
&gt; #include &lt;linux/rpmsg.h&gt;<br>
&gt; +#include &lt;linux/of.h&gt;<br>
&gt; +<br>
&gt; #include &lt;linux/soc/qcom/wcnss_ctrl.h&gt;<br>
&gt; #include &lt;linux/platform_device.h&gt;<br>
&gt;<br>
&gt; @@ -23,9 +25,12 @@<br>
&gt;<br>
&gt; #include &quot;btqca.h&quot;<br>
&gt;<br>
&gt; +#define BDADDR_QCOMSMD (&amp;(bdaddr_t) {{0xAD, 0x5A, 0x00, 0x00, 0x0=
0, 0x00}})<br>
&gt; +<br>
&gt; struct btqcomsmd {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_dev *hdev;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const bdaddr_t *addr;<br>
<br>
</div></div>so lets use bdaddr here. And frankly I would really just use bd=
addr_t bdaddr here. You have to swap the address anyway since we use local-=
mac-address.<br>
<br>
Unless of course we start using local-bd-address as DT property. Remember t=
hat even a WiFi address must be different from a Bluetooth address. You can=
 not use the same. So the boot loader needs to understand that this is the =
Bluetooth address and not the WiFi address.<br></blockquote><div><br></div>=
<div>Yes the bootloader seems to set the same address as the wlan one but w=
ith last bit flipped.<br>However I agree that this property should be updat=
ed with bt specific naming to avoid confusion.<br><br></div><div>Regards,<b=
r></div><div>Loic<br></div><div><div class=3D"m_-1969934345854830430gmail-h=
5"><span class=3D"m_-1969934345854830430gmail-HOEnZb"></span><br><span clas=
s=3D"m_-1969934345854830430gmail-HOEnZb"><font color=3D"#888888">
</font></span></div></div></div><br></div></div></div>

--94eb2c135102d962c405585aca8b--
