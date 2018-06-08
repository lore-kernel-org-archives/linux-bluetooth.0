Return-Path: <attitokes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180608162009.22762-1-attitokes@gmail.com>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org> <20180608162009.22762-1-attitokes@gmail.com>
From: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>
Date: Fri, 8 Jun 2018 19:33:43 +0300
Message-ID: <CAMoM21EJoyNjeT_hTv1rz4hQdiZa0SQwWNPn-RHJmiDv7_pksw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To: Tokes Attila <attitokes@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Artiom Vaskov <velemas@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000009c093f056e23f644"
List-ID: <linux-bluetooth.vger.kernel.org>

--0000000000009c093f056e23f644
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Fixed the problems from the first patch.

Related to the possibility of missing device tree parameters, the pcm-*
parameters are only relevant for the sco-routing =3D 0 (PCM) case, in which
case you probably want to explicitly set that parameters. For sco-routing =
=3D
1-3 (transport, codec, i2s) the pcm- parameters seems to be ignored, so I
think it's safe to just send zeros.

Thanks,
Attila T=C5=91k=C3=A9s

On Fri, Jun 8, 2018 at 7:20 PM, <attitokes@gmail.com> wrote:

> From: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>
> Added support to automatically configure the SCO packet routing at the
> device setup. The SCO packets are used with the HSP / HFP profiles, but i=
n
> some devices (ex. CYW43438) they are routed to a PCM output by default.
> This change allows sending the vendor specific HCI command to configure t=
he
> SCO routing. The parameters of the command are loaded from the device tre=
e.
>
> Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
> ---
>  .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>  drivers/bluetooth/hci_bcm.c                   | 72 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> index 4194ff7e..aea3a094 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> @@ -21,6 +21,12 @@ Optional properties:
>   - clocks: clock specifier if external clock provided to the controller
>   - clock-names: should be "extclk"
>
> + SCO routing parameters:
> + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
> + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
> + - pcm-frame-type: 0 (short), 1 (long)
> + - pcm-sync-mode: 0 (slave), 1 (master)
> + - pcm-clock-mode: 0 (slave), 1 (master)
>
>  Example:
>
> @@ -31,5 +37,6 @@ Example:
>         bluetooth {
>                 compatible =3D "brcm,bcm43438-bt";
>                 max-speed =3D <921600>;
> +               sco-routing =3D <1>; /* 1 =3D transport (UART) */
>         };
>  };
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ddbd8c6a..0e729534 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -83,6 +83,16 @@
>   * @hu: pointer to HCI UART controller struct,
>   *     used to disable flow control during runtime suspend and system
> sleep
>   * @is_suspended: whether flow control is currently disabled
> + *
> + *  SCO routing parameters:
> + *   used as the parameters for the bcm_set_pcm_int_params command
> + *     @sco_routing:
> + *      >=3D 255 (skip SCO routing configuration)
> + *      0-3 (PCM, Transport, Codec, I2S)
> + *     @pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)
> + *     @pcm_frame_type: 0 (short), 1 (long)
> + *     @pcm_sync_mode: 0 (slave), 1 (master)
> + *     @pcm_clock_mode: 0 (slave), 1 (master)
>   */
>  struct bcm_device {
>         /* Must be the first member, hci_serdev.c expects this. */
> @@ -114,6 +124,13 @@ struct bcm_device {
>         struct hci_uart         *hu;
>         bool                    is_suspended;
>  #endif
> +
> +       /* SCO routing parameters */
> +       u8                      sco_routing;
> +       u8                      pcm_interface_rate;
> +       u8                      pcm_frame_type;
> +       u8                      pcm_sync_mode;
> +       u8                      pcm_clock_mode;
>  };
>
>  /* generic bcm uart resources */
> @@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu,
> unsigned int speed)
>         return 0;
>  }
>
> +static int bcm_configure_sco_routing(struct hci_uart *hu, struct
> bcm_device *bcm_dev)
> +{
> +       struct hci_dev *hdev =3D hu->hdev;
> +       struct sk_buff *skb;
> +       struct bcm_set_pcm_int_params params;
> +
> +       if (bcm_dev->sco_routing >=3D 0xff) {
> +               /* SCO routing configuration should be skipped */
> +               return 0;
> +       }
> +
> +       bt_dev_dbg(hdev, "BCM: Configuring SCO routing (%d %d %d %d %d)",
> +                       bcm_dev->sco_routing, bcm_dev->pcm_interface_rate=
,
> bcm_dev->pcm_frame_type,
> +                       bcm_dev->pcm_sync_mode, bcm_dev->pcm_clock_mode);
> +
> +       params.routing =3D bcm_dev->sco_routing;
> +       params.rate =3D bcm_dev->pcm_interface_rate;
> +       params.frame_sync =3D bcm_dev->pcm_frame_type;
> +       params.sync_mode =3D bcm_dev->pcm_sync_mode;
> +       params.clock_mode =3D bcm_dev->pcm_clock_mode;
> +
> +       /* Send the SCO routing configuration command */
> +       skb =3D __hci_cmd_sync(hdev, 0xfc1c, sizeof(params), &params,
> HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               int err =3D PTR_ERR(skb);
> +               bt_dev_err(hdev, "BCM: failed to configure SCO routing
> (%d)", err);
> +               return err;
> +       }
> +
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +
>  /* bcm_device_exists should be protected by bcm_device_lock */
>  static bool bcm_device_exists(struct bcm_device *device)
>  {
> @@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)
>                         host_set_baudrate(hu, speed);
>         }
>
> +       /* Configure SCO routing if needed */
> +       bcm_configure_sco_routing(hu, bcm->dev);
> +
>  finalize:
>         release_firmware(fw);
>
> @@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>  }
>  #endif /* CONFIG_ACPI */
>
> +static void read_u8_device_property(struct device *device, const char
> *property, u8 *destination) {
> +       u32 temp;
> +       if (device_property_read_u32(device, property, &temp) =3D=3D 0) {
> +               *destination =3D temp & 0xff;
> +       }
> +}
> +
>  static int bcm_of_probe(struct bcm_device *bdev)
>  {
>         device_property_read_u32(bdev->dev, "max-speed",
> &bdev->oper_speed);
> +       read_u8_device_property(bdev->dev, "sco-routing",
> &bdev->sco_routing);
> +       read_u8_device_property(bdev->dev, "pcm-interface-rate",
> &bdev->pcm_interface_rate);
> +       read_u8_device_property(bdev->dev, "pcm-frame-type",
> &bdev->pcm_frame_type);
> +       read_u8_device_property(bdev->dev, "pcm-sync-mode",
> &bdev->pcm_sync_mode);
> +       read_u8_device_property(bdev->dev, "pcm-clock-mode",
> &bdev->pcm_clock_mode);
>         return 0;
>  }
>
> @@ -1022,6 +1088,9 @@ static int bcm_probe(struct platform_device *pdev)
>         dev->dev =3D &pdev->dev;
>         dev->irq =3D platform_get_irq(pdev, 0);
>
> +       /* SCO routing configuration is disabled by default */
> +       dev->sco_routing =3D 0xff;
> +
>         if (has_acpi_companion(&pdev->dev)) {
>                 ret =3D bcm_acpi_probe(dev);
>                 if (ret)
> @@ -1281,6 +1350,9 @@ static int bcm_serdev_probe(struct serdev_device
> *serdev)
>         bcmdev->serdev_hu.serdev =3D serdev;
>         serdev_device_set_drvdata(serdev, bcmdev);
>
> +       /* SCO routing configuration is disabled by default */
> +       bcmdev->sco_routing =3D 0xff;
> +
>         if (has_acpi_companion(&serdev->dev))
>                 err =3D bcm_acpi_probe(bcmdev);
>         else
> --
> 2.17.0
>
>

--0000000000009c093f056e23f644
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:small;text-decoration-style:initi=
al;text-decoration-color:initial;float:none;display:inline">Hi Marcel,</spa=
n><div style=3D"font-size:small;text-decoration-style:initial;text-decorati=
on-color:initial"><br></div><div style=3D"font-size:small;text-decoration-s=
tyle:initial;text-decoration-color:initial">Fixed the problems from the fir=
st patch.</div><div style=3D"font-size:small;text-decoration-style:initial;=
text-decoration-color:initial"><br></div><div style=3D"font-size:small;text=
-decoration-style:initial;text-decoration-color:initial">Related to the pos=
sibility of missing device tree parameters, the pcm-* parameters are only r=
elevant for the=C2=A0<span style=3D"font-size:12.8px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial;flo=
at:none;display:inline">sco-routing =3D 0 (PCM) case, in which case you pro=
bably want to explicitly set that parameters</span>. For sco-routing =3D 1-=
3 (transport, codec, i2s) the pcm- parameters seems to be ignored, so I thi=
nk it&#39;s safe to just send zeros.=C2=A0<br><br></div><div style=3D"font-=
size:small;text-decoration-style:initial;text-decoration-color:initial">Tha=
nks,</div><div style=3D"font-size:small;text-decoration-style:initial;text-=
decoration-color:initial">Attila T=C5=91k=C3=A9s</div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Fri, Jun 8, 2018 at 7:20 PM,  <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:attitokes@gmail.com" target=3D"_blank">a=
ttitokes@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
From: Attila T=C5=91k=C3=A9s &lt;<a href=3D"mailto:attitokes@gmail.com">att=
itokes@gmail.com</a>&gt;<br>
<br>
Added support to automatically configure the SCO packet routing at the devi=
ce setup. The SCO packets are used with the HSP / HFP profiles, but in some=
 devices (ex. CYW43438) they are routed to a PCM output by default. This ch=
ange allows sending the vendor specific HCI command to configure the SCO ro=
uting. The parameters of the command are loaded from the device tree.<br>
<span class=3D""><br>
Signed-off-by: Attila T=C5=91k=C3=A9s &lt;<a href=3D"mailto:attitokes@gmail=
.com">attitokes@gmail.com</a>&gt;<br>
---<br>
</span>=C2=A0.../bindings/net/broadcom-<wbr>bluetooth.txt=C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 7 ++<br>
=C2=A0drivers/bluetooth/hci_bcm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 72 +++++++++++++++++++<br>
=C2=A02 files changed, 79 insertions(+)<br>
<br>
diff --git a/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>bluet=
ooth.txt b/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>bluetoo=
th.txt<br>
index 4194ff7e..aea3a094 100644<br>
--- a/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>bluetooth.tx=
t<br>
+++ b/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>bluetooth.tx=
t<br>
@@ -21,6 +21,12 @@ Optional properties:<br>
=C2=A0 - clocks: clock specifier if external clock provided to the controll=
er<br>
=C2=A0 - clock-names: should be &quot;extclk&quot;<br>
<br>
+ SCO routing parameters:<br>
+ - sco-routing: 0-3 (PCM, Transport, Codec, I2S)<br>
+ - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)<br>
+ - pcm-frame-type: 0 (short), 1 (long)<br>
+ - pcm-sync-mode: 0 (slave), 1 (master)<br>
+ - pcm-clock-mode: 0 (slave), 1 (master)<br>
<br>
=C2=A0Example:<br>
<br>
@@ -31,5 +37,6 @@ Example:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bluetooth {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D &quo=
t;brcm,bcm43438-bt&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max-speed =3D &lt;9=
21600&gt;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sco-routing =3D &lt=
;1&gt;; /* 1 =3D transport (UART) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0};<br>
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c<br>
index ddbd8c6a..0e729534 100644<br>
<div><div class=3D"h5">--- a/drivers/bluetooth/hci_bcm.c<br>
+++ b/drivers/bluetooth/hci_bcm.c<br>
@@ -83,6 +83,16 @@<br>
=C2=A0 * @hu: pointer to HCI UART controller struct,<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0used to disable flow control during runtime sus=
pend and system sleep<br>
=C2=A0 * @is_suspended: whether flow control is currently disabled<br>
+ *<br>
+ *=C2=A0 SCO routing parameters:<br>
+ *=C2=A0 =C2=A0used as the parameters for the bcm_set_pcm_int_params comma=
nd<br>
+ *=C2=A0 =C2=A0 =C2=A0@sco_routing:<br>
+ *=C2=A0 =C2=A0 =C2=A0 &gt;=3D 255 (skip SCO routing configuration)<br>
+ *=C2=A0 =C2=A0 =C2=A0 0-3 (PCM, Transport, Codec, I2S)<br>
+ *=C2=A0 =C2=A0 =C2=A0@pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)<br>
+ *=C2=A0 =C2=A0 =C2=A0@pcm_frame_type: 0 (short), 1 (long)<br>
+ *=C2=A0 =C2=A0 =C2=A0@pcm_sync_mode: 0 (slave), 1 (master)<br>
+ *=C2=A0 =C2=A0 =C2=A0@pcm_clock_mode: 0 (slave), 1 (master)<br>
=C2=A0 */<br>
=C2=A0struct bcm_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Must be the first member, hci_serdev.c expec=
ts this. */<br>
@@ -114,6 +124,13 @@ struct bcm_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hci_uart=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*hu;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_suspended;<br>
=C2=A0#endif<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SCO routing parameters */<br>
</div></div>+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sco_routing;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_interface_rate;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_frame_type;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_sync_mode;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_clock_mode;<br>
=C2=A0};<br>
<span class=3D"">=C2=A0<br>
=C2=A0/* generic bcm uart resources */<br>
</span>@@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu=
, unsigned int speed)<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static int bcm_configure_sco_routing(<wbr>struct hci_uart *hu, struct bcm_=
device *bcm_dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_dev *hdev =3D hu-&gt;hdev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sk_buff *skb;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm_set_pcm_int_params params;<br>
+<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bcm_dev-&gt;sco_routing &gt;=3D 0xff=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SCO routing conf=
iguration should be skipped */<br>
<span class=3D"">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
</span><span class=3D"">+=C2=A0 =C2=A0 =C2=A0 =C2=A0bt_dev_dbg(hdev, &quot;=
BCM: Configuring SCO routing (%d %d %d %d %d)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bcm_dev-&gt;sco_routing, bcm_dev-&gt;pcm_interface_rate, bcm_dev-=
&gt;pcm_frame_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bcm_dev-&gt;pcm_sync_mode, bcm_dev-&gt;pcm_clock_mode);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0params.routing =3D bcm_dev-&gt;sco_routing;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0params.rate =3D bcm_dev-&gt;pcm_interface_rate;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0params.frame_sync =3D bcm_dev-&gt;pcm_frame_typ=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0params.sync_mode =3D bcm_dev-&gt;pcm_sync_mode;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0params.clock_mode =3D bcm_dev-&gt;pcm_clock_mod=
e;<br>
+<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Send the SCO routing configuration co=
mmand */<br>
<span class=3D"">+=C2=A0 =C2=A0 =C2=A0 =C2=A0skb =3D __hci_cmd_sync(hdev, 0=
xfc1c, sizeof(params), &amp;params, HCI_CMD_TIMEOUT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(skb)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D PTR_ERR=
(skb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bt_dev_err(hdev, &q=
uot;BCM: failed to configure SCO routing (%d)&quot;, err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree_skb(skb);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
=C2=A0/* bcm_device_exists should be protected by bcm_device_lock */<br>
=C2=A0static bool bcm_device_exists(struct bcm_device *device)<br>
=C2=A0{<br>
</span>@@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 host_set_baudrate(hu, speed);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Configure SCO routing if needed */<br>
<span class=3D"">+=C2=A0 =C2=A0 =C2=A0 =C2=A0bcm_configure_sco_routing(hu, =
bcm-&gt;dev);<br>
+<br>
</span>=C2=A0finalize:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 release_firmware(fw);<br>
<br>
@@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *dev)<br=
>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_ACPI */<br>
<br>
+static void read_u8_device_property(struct device *device, const char *pro=
perty, u8 *destination) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 temp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (device_property_read_u32(<wbr>device, prope=
rty, &amp;temp) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*destination =3D te=
mp &amp; 0xff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
<span class=3D"">=C2=A0static int bcm_of_probe(struct bcm_device *bdev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_property_read_u32(bdev-<wbr>&gt;dev, &qu=
ot;max-speed&quot;, &amp;bdev-&gt;oper_speed);<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>de=
v, &quot;sco-routing&quot;, &amp;bdev-&gt;sco_routing);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev, &quo=
t;pcm-interface-rate&quot;, &amp;bdev-&gt;pcm_interface_rate);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev, &quo=
t;pcm-frame-type&quot;, &amp;bdev-&gt;pcm_frame_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev, &quo=
t;pcm-sync-mode&quot;, &amp;bdev-&gt;pcm_sync_mode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev, &quo=
t;pcm-clock-mode&quot;, &amp;bdev-&gt;pcm_clock_mode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
@@ -1022,6 +1088,9 @@ static int bcm_probe(struct platform_device *pdev)<br=
>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;dev =3D &amp;pdev-&gt;=
dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;irq =3D platform_get_irq(pdev, 0);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SCO routing configuration is disabled by def=
ault */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;sco_routing =3D 0xff;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_acpi_companion(&amp;pdev-&gt;<wbr>dev))=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D bcm_acpi_pr=
obe(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
</span>@@ -1281,6 +1350,9 @@ static int bcm_serdev_probe(struct serdev_devi=
ce *serdev)<br>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0 =C2=A0 =C2=A0 =C2=A0 bcmdev-=
&gt;serdev_hu.serdev =3D serdev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 serdev_device_set_drvdata(<wbr>serdev, bcmdev);=
<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SCO routing configuration is disabled by def=
ault */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bcmdev-&gt;sco_routing =3D 0xff;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_acpi_companion(&amp;serdev-&gt;<wbr>dev=
))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D bcm_acpi_pr=
obe(bcmdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.17.0<br>
<br>
</font></span></blockquote></div><br></div></div>

--0000000000009c093f056e23f644--
