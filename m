Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1001291519250.356@pobox.suse.cz>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
	 <alpine.LNX.2.00.1001291519250.356@pobox.suse.cz>
Date: Fri, 29 Jan 2010 09:14:59 -0800
Message-ID: <167e8a331001290914t578ffef7y16d52e40c8c54079@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: Implement Wacom quirk in the kernel
From: Ping Cheng <pinglinux@gmail.com>
To: Jiri Kosina <jkosina@suse.cz>
Cc: "Gunn, Brian" <bgunn@solekai.com>, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001636ed67247e9948047e50c6cb
List-ID: <linux-bluetooth.vger.kernel.org>

--001636ed67247e9948047e50c6cb
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jan 29, 2010 at 6:20 AM, Jiri Kosina <jkosina@suse.cz> wrote:

> From: Bastien Nocera <hadess@hadess.net>
>
> The hid-wacom driver required user-space to poke at the tablet
> to make it send data about the cursor location.
>
> This patch makes it do the same thing but in the kernel.
>
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/hid/hid-wacom.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 12dcda5..d7897b5 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -156,7 +156,9 @@ static int wacom_probe(struct hid_device *hdev,
>        struct hid_input *hidinput;
>        struct input_dev *input;
>        struct wacom_data *wdata;
> +       char rep_data[2];
>        int ret;
> +       int limit;
>
>        wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
>        if (wdata == NULL) {
> @@ -166,6 +168,7 @@ static int wacom_probe(struct hid_device *hdev,
>
>        hid_set_drvdata(hdev, wdata);
>
> +       /* Parse the HID report now */
>        ret = hid_parse(hdev);
>        if (ret) {
>                dev_err(&hdev->dev, "parse failed\n");
> @@ -178,6 +181,30 @@ static int wacom_probe(struct hid_device *hdev,
>                goto err_free;
>        }
>
> +       /* Set Wacom mode2 */
> +       rep_data[0] = 0x03; rep_data[1] = 0x00;
> +       limit =3;
> +       do {
> +               ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
> +                               HID_FEATURE_REPORT);
> +       } while (ret < 0 && limit-- > 0);
>

hdev->hid_output_raw_report error is not a hard failure, i.e., the following
four lines are unnecessay. We can continue with the rest of the code.


> +       if (ret < 0) {
> +               dev_err(&hdev->dev, "failed to poke device #1, %d\n", ret);
> +               goto err_free;
> +       }
> +
> +       /* 0x06 - high reporting speed, 0x05 - low speed */
> +       rep_data[0] = 0x06; rep_data[1] = 0x00;
> +       limit = 3;
> +       do {
> +               ret = hdev->hid_output_raw_report(hdev, rep_data, 2,
> +                               HID_FEATURE_REPORT);
> +       } while (ret < 0 && limit-- > 0);
>

Same comments apply here. "/* Note that if query fails it is not a hard
failure */" is the comments we use in the corresponding Wacom USB driver,
wacom_sys.c


> +       if (ret < 0) {
> +               dev_err(&hdev->dev, "failed to poke device #2, %d\n", ret);
> +               goto err_free;
> +       }
> +
>        hidinput = list_entry(hdev->inputs.next, struct hid_input, list);
>        input = hidinput->input;


Everything else looks good to me.

Ping

--001636ed67247e9948047e50c6cb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 29, 2010 at 6:20 AM, Jiri Kosina <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:jkosina@suse.cz">jkosina@suse.cz</a>&g=
t;</span> wrote:<br>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">From: Bastien Nocera &lt;<a href=
=3D"mailto:hadess@hadess.net">hadess@hadess.net</a>&gt;<br><br>The hid-waco=
m driver required user-space to poke at the tablet<br>
to make it send data about the cursor location.<br><br>This patch makes it =
do the same thing but in the kernel.<br><br>Signed-off-by: Bastien Nocera &=
lt;<a href=3D"mailto:hadess@hadess.net">hadess@hadess.net</a>&gt;<br>Signed=
-off-by: Jiri Kosina &lt;<a href=3D"mailto:jkosina@suse.cz">jkosina@suse.cz=
</a>&gt;<br>
---<br>=A0drivers/hid/hid-wacom.c | =A0 27 +++++++++++++++++++++++++++<br>=
=A01 files changed, 27 insertions(+), 0 deletions(-)<br><br>diff --git a/dr=
ivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c<br>index 12dcda5..d7897b5 1=
00644<br>
--- a/drivers/hid/hid-wacom.c<br>+++ b/drivers/hid/hid-wacom.c<br>@@ -156,7=
 +156,9 @@ static int wacom_probe(struct hid_device *hdev,<br>=A0 =A0 =A0 =
=A0struct hid_input *hidinput;<br>=A0 =A0 =A0 =A0struct input_dev *input;<b=
r>=A0 =A0 =A0 =A0struct wacom_data *wdata;<br>
+ =A0 =A0 =A0 char rep_data[2];<br>=A0 =A0 =A0 =A0int ret;<br>+ =A0 =A0 =A0=
 int limit;<br><br>=A0 =A0 =A0 =A0wdata =3D kzalloc(sizeof(*wdata), GFP_KER=
NEL);<br>=A0 =A0 =A0 =A0if (wdata =3D=3D NULL) {<br>@@ -166,6 +168,7 @@ sta=
tic int wacom_probe(struct hid_device *hdev,<br>
<br>=A0 =A0 =A0 =A0hid_set_drvdata(hdev, wdata);<br><br>+ =A0 =A0 =A0 /* Pa=
rse the HID report now */<br>=A0 =A0 =A0 =A0ret =3D hid_parse(hdev);<br>=A0=
 =A0 =A0 =A0if (ret) {<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&amp;hdev-=
&gt;dev, &quot;parse failed\n&quot;);<br>@@ -178,6 +181,30 @@ static int wa=
com_probe(struct hid_device *hdev,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free;<br>=A0 =A0 =A0 =A0}<br><br>+ =
=A0 =A0 =A0 /* Set Wacom mode2 */<br>+ =A0 =A0 =A0 rep_data[0] =3D 0x03; re=
p_data[1] =3D 0x00;<br>+ =A0 =A0 =A0 limit =3D3;<br>+ =A0 =A0 =A0 do {<br>+=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hdev-&gt;hid_output_raw_report(hdev, r=
ep_data, 2,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_FEATURE_R=
EPORT);<br>+ =A0 =A0 =A0 } while (ret &lt; 0 &amp;&amp; limit-- &gt; 0);<br=
></blockquote>
<div>=A0</div>
<div>hdev-&gt;hid_output_raw_report error is not a hard failure, i.e., the =
following four lines are unnecessay.=A0We can continue with the rest of the=
 code.</div>
<div>=A0</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">+ =A0 =A0 =A0 if (ret &lt; 0) {<=
br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;hdev-&gt;dev, &quot;failed to=
 poke device #1, %d\n&quot;, ret);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;<br>+ =A0 =A0 =A0 }<br>+<br>+ =
=A0 =A0 =A0 /* 0x06 - high reporting speed, 0x05 - low speed */<br>+ =A0 =
=A0 =A0 rep_data[0] =3D 0x06; rep_data[1] =3D 0x00;<br>+ =A0 =A0 =A0 limit =
=3D 3;<br>+ =A0 =A0 =A0 do {<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D hdev-=
&gt;hid_output_raw_report(hdev, rep_data, 2,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_FEATURE_R=
EPORT);<br>+ =A0 =A0 =A0 } while (ret &lt; 0 &amp;&amp; limit-- &gt; 0);<br=
></blockquote>
<div>=A0</div>
<div>Same comments apply here.=A0&quot;/* Note that if query fails it is no=
t a hard failure */&quot; is=A0the comments=A0we use in the corresponding W=
acom USB driver, wacom_sys.c</div>
<div>=A0</div>
<blockquote style=3D"BORDER-LEFT: #ccc 1px solid; MARGIN: 0px 0px 0px 0.8ex=
; PADDING-LEFT: 1ex" class=3D"gmail_quote">+ =A0 =A0 =A0 if (ret &lt; 0) {<=
br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;hdev-&gt;dev, &quot;failed to=
 poke device #2, %d\n&quot;, ret);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;<br>+ =A0 =A0 =A0 }<br>+<br>=A0=
 =A0 =A0 =A0hidinput =3D list_entry(hdev-&gt;inputs.next, struct hid_input,=
 list);<br>=A0 =A0 =A0 =A0input =3D hidinput-&gt;input;</blockquote>
<div>=A0</div>
<div>Everything else looks good to me.</div>
<div>=A0</div>
<div>Ping</div>
<div>=A0</div>
<div>=A0</div></div><br>

--001636ed67247e9948047e50c6cb--
