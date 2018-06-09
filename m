Return-Path: <attitokes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com> <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
From: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>
Date: Sat, 9 Jun 2018 09:26:50 +0300
Message-ID: <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To: Rob Herring <robh+dt@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Artiom Vaskov <velemas@gmail.com>, netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary="00000000000018c254056e2f9aff"
List-ID: <linux-bluetooth.vger.kernel.org>

--00000000000018c254056e2f9aff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Fri, Jun 8, 2018 at 8:25 PM, Rob Herring <robh+dt@kernel.org> wrote:

> On Fri, Jun 8, 2018 at 10:20 AM,  <attitokes@gmail.com> wrote:
> > From: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
> >
> > Added support to automatically configure the SCO packet routing at the
> device setup. The SCO packets are used with the HSP / HFP profiles, but i=
n
> some devices (ex. CYW43438) they are routed to a PCM output by default.
> This change allows sending the vendor specific HCI command to configure t=
he
> SCO routing. The parameters of the command are loaded from the device tre=
e.
>
> Please wrap your commit msg.
>

Sure.

>
> >
> > Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
> > ---
> >  .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>
> Please split bindings to separate patch.


Ok, I will split this in two.

>


> >  drivers/bluetooth/hci_bcm.c                   | 72 +++++++++++++++++++
> >  2 files changed, 79 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.t=
xt
> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > index 4194ff7e..aea3a094 100644
> > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > @@ -21,6 +21,12 @@ Optional properties:
> >   - clocks: clock specifier if external clock provided to the controlle=
r
> >   - clock-names: should be "extclk"
> >
> > + SCO routing parameters:
> > + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
> > + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
> > + - pcm-frame-type: 0 (short), 1 (long)
> > + - pcm-sync-mode: 0 (slave), 1 (master)
> > + - pcm-clock-mode: 0 (slave), 1 (master)
>
> Are these Broadcom specific? Properties need either vendor prefix or
> to be documented in a common location. I think these look like the
> latter.


These will be used as parameters of a vendor specific (Broadcom/Cypress)
command configuring the SCO packet routing. See the Write_SCO_PCM_Int_Param
command from: http://www.cypress.com/file/298311/download.

What would be the property names with a Broadcom / Cypress vendor prefix?

    brcm,sco-routing
    brcm,pcm-interface-rate
    brcm,pcm-frame-type
    brcm,pcm-sync-mode
    brcm,pcm-clock-mode

?


>
However, this also looks incomplete to me. For example, which SoC
> I2S/PCM port is BT audio connected to and how does it fit into the
> existing audio related bindings? There's been work on HDMI audio
> bindings which would be similar (except for the SCO over UART at
> least).
>

The I2S / PCM pins of the Bluetooth chip most likely will not be connected
to the host SoC. When used with a SoC we probably want tor route the SCO
packets over the UART transport. A2DP data already goes here and we
probably want the same for HSP / HFP.

For example in the Raspberry Pi 3 B, the CYW43438's PCM output is not
connected (there is no I2S output), But it may be connected to any other
device in other hardware.

The purpose of this command is to tell the BT chip where to send the SCO
packets. From the driver's perspective, it does not really matters where
these pins are connected.

>
>
> >
> >  Example:
> >
> > @@ -31,5 +37,6 @@ Example:
> >         bluetooth {
> >                 compatible =3D "brcm,bcm43438-bt";
> >                 max-speed =3D <921600>;
> > +               sco-routing =3D <1>; /* 1 =3D transport (UART) */
> >         };
> >  };
> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> > index ddbd8c6a..0e729534 100644
> > --- a/drivers/bluetooth/hci_bcm.c
> > +++ b/drivers/bluetooth/hci_bcm.c
> > @@ -83,6 +83,16 @@
> >   * @hu: pointer to HCI UART controller struct,
> >   *     used to disable flow control during runtime suspend and system
> sleep
> >   * @is_suspended: whether flow control is currently disabled
> > + *
> > + *  SCO routing parameters:
> > + *   used as the parameters for the bcm_set_pcm_int_params command
> > + *     @sco_routing:
> > + *      >=3D 255 (skip SCO routing configuration)
> > + *      0-3 (PCM, Transport, Codec, I2S)
> > + *     @pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)
> > + *     @pcm_frame_type: 0 (short), 1 (long)
> > + *     @pcm_sync_mode: 0 (slave), 1 (master)
> > + *     @pcm_clock_mode: 0 (slave), 1 (master)
> >   */
> >  struct bcm_device {
> >         /* Must be the first member, hci_serdev.c expects this. */
> > @@ -114,6 +124,13 @@ struct bcm_device {
> >         struct hci_uart         *hu;
> >         bool                    is_suspended;
> >  #endif
> > +
> > +       /* SCO routing parameters */
> > +       u8                      sco_routing;
> > +       u8                      pcm_interface_rate;
> > +       u8                      pcm_frame_type;
> > +       u8                      pcm_sync_mode;
> > +       u8                      pcm_clock_mode;
> >  };
> >
> >  /* generic bcm uart resources */
> > @@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu,
> unsigned int speed)
> >         return 0;
> >  }
> >
> > +static int bcm_configure_sco_routing(struct hci_uart *hu, struct
> bcm_device *bcm_dev)
> > +{
> > +       struct hci_dev *hdev =3D hu->hdev;
> > +       struct sk_buff *skb;
> > +       struct bcm_set_pcm_int_params params;
> > +
> > +       if (bcm_dev->sco_routing >=3D 0xff) {
> > +               /* SCO routing configuration should be skipped */
> > +               return 0;
> > +       }
> > +
> > +       bt_dev_dbg(hdev, "BCM: Configuring SCO routing (%d %d %d %d %d)=
",
> > +                       bcm_dev->sco_routing,
> bcm_dev->pcm_interface_rate, bcm_dev->pcm_frame_type,
> > +                       bcm_dev->pcm_sync_mode, bcm_dev->pcm_clock_mode=
);
> > +
> > +       params.routing =3D bcm_dev->sco_routing;
> > +       params.rate =3D bcm_dev->pcm_interface_rate;
> > +       params.frame_sync =3D bcm_dev->pcm_frame_type;
> > +       params.sync_mode =3D bcm_dev->pcm_sync_mode;
> > +       params.clock_mode =3D bcm_dev->pcm_clock_mode;
> > +
> > +       /* Send the SCO routing configuration command */
> > +       skb =3D __hci_cmd_sync(hdev, 0xfc1c, sizeof(params), &params,
> HCI_CMD_TIMEOUT);
> > +       if (IS_ERR(skb)) {
> > +               int err =3D PTR_ERR(skb);
> > +               bt_dev_err(hdev, "BCM: failed to configure SCO routing
> (%d)", err);
> > +               return err;
> > +       }
> > +
> > +       kfree_skb(skb);
> > +
> > +       return 0;
> > +}
> > +
> >  /* bcm_device_exists should be protected by bcm_device_lock */
> >  static bool bcm_device_exists(struct bcm_device *device)
> >  {
> > @@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)
> >                         host_set_baudrate(hu, speed);
> >         }
> >
> > +       /* Configure SCO routing if needed */
> > +       bcm_configure_sco_routing(hu, bcm->dev);
> > +
> >  finalize:
> >         release_firmware(fw);
> >
> > @@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *dev=
)
> >  }
> >  #endif /* CONFIG_ACPI */
> >
> > +static void read_u8_device_property(struct device *device, const char
> *property, u8 *destination) {
> > +       u32 temp;
> > +       if (device_property_read_u32(device, property, &temp) =3D=3D 0)=
 {
> > +               *destination =3D temp & 0xff;
> > +       }
> > +}
> > +
> >  static int bcm_of_probe(struct bcm_device *bdev)
> >  {
> >         device_property_read_u32(bdev->dev, "max-speed",
> &bdev->oper_speed);
> > +       read_u8_device_property(bdev->dev, "sco-routing",
> &bdev->sco_routing);
> > +       read_u8_device_property(bdev->dev, "pcm-interface-rate",
> &bdev->pcm_interface_rate);
> > +       read_u8_device_property(bdev->dev, "pcm-frame-type",
> &bdev->pcm_frame_type);
> > +       read_u8_device_property(bdev->dev, "pcm-sync-mode",
> &bdev->pcm_sync_mode);
> > +       read_u8_device_property(bdev->dev, "pcm-clock-mode",
> &bdev->pcm_clock_mode);
>
> These are actually broken because the DT properties are 32-bit.
>
> The properties from device tree are read as 32-bit values, then they are
truncated to 8-bit (see the read_u8_device_property function above). Is
anything wrong with this?

Rob
>

Thanks,
Attila

--00000000000018c254056e2f9aff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Rob,<div><br></div><div class=3D"gmail_extra"><div c=
lass=3D"gmail_quote">On Fri, Jun 8, 2018 at 8:25 PM, Rob Herring <span dir=
=3D"ltr">&lt;<a href=3D"mailto:robh+dt@kernel.org" target=3D"_blank">robh+d=
t@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><span class=3D"gmail-">On Fri, Jun 8, 2018 at 10:20 AM,=C2=A0 =
&lt;<a href=3D"mailto:attitokes@gmail.com">attitokes@gmail.com</a>&gt; wrot=
e:<br>
&gt; From: Attila T=C5=91k=C3=A9s &lt;<a href=3D"mailto:attitokes@gmail.com=
">attitokes@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Added support to automatically configure the SCO packet routing at the=
 device setup. The SCO packets are used with the HSP / HFP profiles, but in=
 some devices (ex. CYW43438) they are routed to a PCM output by default. Th=
is change allows sending the vendor specific HCI command to configure the S=
CO routing. The parameters of the command are loaded from the device tree.<=
br>
<br>
</span>Please wrap your commit msg.<br></blockquote><div><br></div><div>Sur=
e.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt;<br>
&gt; Signed-off-by: Attila T=C5=91k=C3=A9s &lt;<a href=3D"mailto:attitokes@=
gmail.com">attitokes@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../bindings/net/broadcom-<wbr>bluetooth.txt=C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 7 ++<br>
<br>
</span>Please split bindings to separate patch.</blockquote><div><br></div>=
<div>Ok, I will split this in two.=C2=A0<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<span class=3D"gmail-"><br>
&gt;=C2=A0 drivers/bluetooth/hci_bcm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 72 +++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 79 insertions(+)<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>=
bluetooth.txt b/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>bl=
uetooth.txt<br>
&gt; index 4194ff7e..aea3a094 100644<br>
&gt; --- a/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>bluetoo=
th.txt<br>
&gt; +++ b/Documentation/devicetree/<wbr>bindings/net/broadcom-<wbr>bluetoo=
th.txt<br>
&gt; @@ -21,6 +21,12 @@ Optional properties:<br>
&gt;=C2=A0 =C2=A0- clocks: clock specifier if external clock provided to th=
e controller<br>
&gt;=C2=A0 =C2=A0- clock-names: should be &quot;extclk&quot;<br>
&gt;<br>
&gt; + SCO routing parameters:<br>
&gt; + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)<br>
&gt; + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)<br>
&gt; + - pcm-frame-type: 0 (short), 1 (long)<br>
&gt; + - pcm-sync-mode: 0 (slave), 1 (master)<br>
&gt; + - pcm-clock-mode: 0 (slave), 1 (master)<br>
<br>
</span>Are these Broadcom specific? Properties need either vendor prefix or=
<br>
to be documented in a common location. I think these look like the<br>
latter.</blockquote><div><br></div><div>These will be used as parameters of=
 a vendor specific (Broadcom/Cypress) command configuring the SCO packet ro=
uting. See the Write_SCO_PCM_Int_Param command from:=C2=A0<a href=3D"http:/=
/www.cypress.com/file/298311/download">http://www.cypress.com/file/298311/d=
ownload</a>.</div><div><br></div><div>What would be the property names with=
 a <span style=3D"font-size:small;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial;float:none;display:inl=
ine">Broadcom / Cypress=C2=A0</span>vendor prefix?</div><div><br><span styl=
e=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial;float:none;display:inline">=C2=A0 =
=C2=A0 brcm,sco-routing<br></span><span style=3D"font-size:small;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial;float:none;display:inline"><span style=3D"text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">=C2=A0 =C2=
=A0<span>=C2=A0</span></span>brcm,<span style=3D"text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline"><span style=3D=
"font-size:small;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">pcm-interfac=
e-rate</span></span><br></span><span style=3D"font-size:small;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial;float:none;display:inline"><span style=3D"text-decoration-style:initi=
al;text-decoration-color:initial;float:none;display:inline">=C2=A0 =C2=A0<s=
pan>=C2=A0</span></span>brcm,<span style=3D"text-decoration-style:initial;t=
ext-decoration-color:initial;float:none;display:inline">pcm-frame-type</spa=
n><br></span><span style=3D"font-size:small;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial;float:none;d=
isplay:inline"><span style=3D"text-decoration-style:initial;text-decoration=
-color:initial;float:none;display:inline">=C2=A0 =C2=A0<span>=C2=A0</span><=
/span>brcm,<span style=3D"text-decoration-style:initial;text-decoration-col=
or:initial;float:none;display:inline">pcm-sync-mode</span><br></span><span =
style=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-=
style:initial;text-decoration-color:initial;float:none;display:inline"><spa=
n style=3D"text-decoration-style:initial;text-decoration-color:initial;floa=
t:none;display:inline">=C2=A0 =C2=A0<span>=C2=A0</span></span>brcm,<span st=
yle=3D"text-decoration-style:initial;text-decoration-color:initial;float:no=
ne;display:inline">pcm-clock-mode</span><br></span><br>?</div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0<br></blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
However, this also looks incomplete to me. For example, which SoC<br>
I2S/PCM port is BT audio connected to and how does it fit into the<br>
existing audio related bindings? There&#39;s been work on HDMI audio<br>
bindings which would be similar (except for the SCO over UART at<br>
least).<br></blockquote><div><br></div><div>The I2S / PCM pins of the Bluet=
ooth chip most likely will not be connected to the host SoC. When used with=
 a SoC we probably want tor route the SCO packets over the UART transport. =
A2DP data already goes here and we probably want the same for HSP / HFP.</d=
iv><div><br></div><div>For example in the Raspberry Pi 3 B, the=C2=A0CYW434=
38&#39;s PCM output is not connected (there is no I2S output), But it may b=
e connected to any other device in other hardware.</div><div><br></div><div=
>The purpose of this command is to tell the BT chip where to send the SCO p=
ackets. F<span style=3D"font-size:small;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial;float:none;displ=
ay:inline">rom the driver&#39;s perspective, i</span>t does not really matt=
ers where these pins are connected.</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<div><div class=3D"gmail-h5"><br>
<br>
&gt;<br>
&gt;=C2=A0 Example:<br>
&gt;<br>
&gt; @@ -31,5 +37,6 @@ Example:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bluetooth {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatibl=
e =3D &quot;brcm,bcm43438-bt&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max-speed=
 =3D &lt;921600&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sco-routing =
=3D &lt;1&gt;; /* 1 =3D transport (UART) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 };<br>
&gt; diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c=
<br>
&gt; index ddbd8c6a..0e729534 100644<br>
&gt; --- a/drivers/bluetooth/hci_bcm.c<br>
&gt; +++ b/drivers/bluetooth/hci_bcm.c<br>
&gt; @@ -83,6 +83,16 @@<br>
&gt;=C2=A0 =C2=A0* @hu: pointer to HCI UART controller struct,<br>
&gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0 =C2=A0used to disable flow control during r=
untime suspend and system sleep<br>
&gt;=C2=A0 =C2=A0* @is_suspended: whether flow control is currently disable=
d<br>
&gt; + *<br>
&gt; + *=C2=A0 SCO routing parameters:<br>
&gt; + *=C2=A0 =C2=A0used as the parameters for the bcm_set_pcm_int_params =
command<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0@sco_routing:<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 &gt;=3D 255 (skip SCO routing configuration)<b=
r>
&gt; + *=C2=A0 =C2=A0 =C2=A0 0-3 (PCM, Transport, Codec, I2S)<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0@pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)=
<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0@pcm_frame_type: 0 (short), 1 (long)<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0@pcm_sync_mode: 0 (slave), 1 (master)<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0@pcm_clock_mode: 0 (slave), 1 (master)<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 struct bcm_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Must be the first member, hci_serd=
ev.c expects this. */<br>
&gt; @@ -114,6 +124,13 @@ struct bcm_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_uart=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*hu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_suspended;<br>
&gt;=C2=A0 #endif<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SCO routing parameters */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sco_routing;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_interface_rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_frame_type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_sync_mode;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_clock_mode;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 /* generic bcm uart resources */<br>
&gt; @@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu, =
unsigned int speed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static int bcm_configure_sco_routing(<wbr>struct hci_uart *hu, struct=
 bcm_device *bcm_dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct hci_dev *hdev =3D hu-&gt;hdev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sk_buff *skb;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bcm_set_pcm_int_params params;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bcm_dev-&gt;sco_routing &gt;=3D 0xff) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SCO routing=
 configuration should be skipped */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bt_dev_dbg(hdev, &quot;BCM: Configuring SC=
O routing (%d %d %d %d %d)&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bcm_dev-&gt;sco_routing, bcm_dev-&gt;pcm_interface_rate, bcm_=
dev-&gt;pcm_frame_type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bcm_dev-&gt;pcm_sync_mode, bcm_dev-&gt;pcm_clock_mode);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0params.routing =3D bcm_dev-&gt;sco_routing=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0params.rate =3D bcm_dev-&gt;pcm_interface_=
rate;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0params.frame_sync =3D bcm_dev-&gt;pcm_fram=
e_type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0params.sync_mode =3D bcm_dev-&gt;pcm_sync_=
mode;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0params.clock_mode =3D bcm_dev-&gt;pcm_cloc=
k_mode;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Send the SCO routing configuration comm=
and */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0skb =3D __hci_cmd_sync(hdev, 0xfc1c, sizeo=
f(params), &amp;params, HCI_CMD_TIMEOUT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(skb)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D PT=
R_ERR(skb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bt_dev_err(hde=
v, &quot;BCM: failed to configure SCO routing (%d)&quot;, err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree_skb(skb);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /* bcm_device_exists should be protected by bcm_device_lock */<b=
r>
&gt;=C2=A0 static bool bcm_device_exists(struct bcm_device *device)<br>
&gt;=C2=A0 {<br>
&gt; @@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0host_set_baudrate(hu, speed);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Configure SCO routing if needed */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0bcm_configure_sco_routing(hu, bcm-&gt;dev)=
;<br>
&gt; +<br>
&gt;=C2=A0 finalize:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0release_firmware(fw);<br>
&gt;<br>
&gt; @@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *de=
v)<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif /* CONFIG_ACPI */<br>
&gt;<br>
&gt; +static void read_u8_device_property(struct device *device, const char=
 *property, u8 *destination) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 temp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (device_property_read_u32(<wbr>device, =
property, &amp;temp) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*destination =
=3D temp &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static int bcm_of_probe(struct bcm_device *bdev)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_property_read_u32(bdev-<wbr>&g=
t;dev, &quot;max-speed&quot;, &amp;bdev-&gt;oper_speed);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev,=
 &quot;sco-routing&quot;, &amp;bdev-&gt;sco_routing);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev,=
 &quot;pcm-interface-rate&quot;, &amp;bdev-&gt;pcm_interface_rate);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev,=
 &quot;pcm-frame-type&quot;, &amp;bdev-&gt;pcm_frame_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev,=
 &quot;pcm-sync-mode&quot;, &amp;bdev-&gt;pcm_sync_mode);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0read_u8_device_property(bdev-&gt;<wbr>dev,=
 &quot;pcm-clock-mode&quot;, &amp;bdev-&gt;pcm_clock_mode);<br>
<br>
</div></div>These are actually broken because the DT properties are 32-bit.=
<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div>The properties from device tree are read as 32-bit values, th=
en they are truncated to 8-bit (see the=C2=A0<span style=3D"font-size:small=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline">read_u8_device_property func=
tion above). Is anything wrong with this?</span></div><div><span style=3D"f=
ont-size:small;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline"><br></span></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-H=
OEnZb"><font color=3D"#888888">
Rob<br></font></span></blockquote><div><br></div><div>Thanks,</div><div>Att=
ila=C2=A0</div></div><br></div></div>

--00000000000018c254056e2f9aff--
