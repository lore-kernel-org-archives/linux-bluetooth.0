Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com> <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 11 Jun 2018 09:34:09 -0600
Message-ID: <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Artiom Vaskov <velemas@gmail.com>, netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 9, 2018 at 12:26 AM, Attila T=C5=91k=C3=A9s <attitokes@gmail.co=
m> wrote:
> Hello Rob,
>
> On Fri, Jun 8, 2018 at 8:25 PM, Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Fri, Jun 8, 2018 at 10:20 AM,  <attitokes@gmail.com> wrote:
>> > From: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>> >
>> > Added support to automatically configure the SCO packet routing at the
>> > device setup. The SCO packets are used with the HSP / HFP profiles, bu=
t in
>> > some devices (ex. CYW43438) they are routed to a PCM output by default=
. This
>> > change allows sending the vendor specific HCI command to configure the=
 SCO
>> > routing. The parameters of the command are loaded from the device tree=
.
>>
>> Please wrap your commit msg.
>
>
> Sure.
>>
>>
>> >
>> > Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>> > ---
>> >  .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>>
>> Please split bindings to separate patch.
>
>
> Ok, I will split this in two.
>>
>>
>>
>>
>> >  drivers/bluetooth/hci_bcm.c                   | 72 ++++++++++++++++++=
+
>> >  2 files changed, 79 insertions(+)
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > index 4194ff7e..aea3a094 100644
>> > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>> > @@ -21,6 +21,12 @@ Optional properties:
>> >   - clocks: clock specifier if external clock provided to the controll=
er
>> >   - clock-names: should be "extclk"
>> >
>> > + SCO routing parameters:
>> > + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
>> > + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
>> > + - pcm-frame-type: 0 (short), 1 (long)
>> > + - pcm-sync-mode: 0 (slave), 1 (master)
>> > + - pcm-clock-mode: 0 (slave), 1 (master)
>>
>> Are these Broadcom specific? Properties need either vendor prefix or
>> to be documented in a common location. I think these look like the
>> latter.
>
>
> These will be used as parameters of a vendor specific (Broadcom/Cypress)
> command configuring the SCO packet routing. See the Write_SCO_PCM_Int_Par=
am
> command from: http://www.cypress.com/file/298311/download.

The DT should just describe how the h/w is hooked-up. What the s/w has
to do based on that is the driver's problem which is certainly
vendor/chip specific, but that is all irrelevant to the binding.

> What would be the property names with a Broadcom / Cypress vendor prefix?
>
>     brcm,sco-routing
>     brcm,pcm-interface-rate
>     brcm,pcm-frame-type
>     brcm,pcm-sync-mode
>     brcm,pcm-clock-mode
>
> ?

Yes.

>
>>
>>
>> However, this also looks incomplete to me. For example, which SoC
>> I2S/PCM port is BT audio connected to and how does it fit into the
>> existing audio related bindings? There's been work on HDMI audio
>> bindings which would be similar (except for the SCO over UART at
>> least).
>
>
> The I2S / PCM pins of the Bluetooth chip most likely will not be connecte=
d
> to the host SoC. When used with a SoC we probably want tor route the SCO
> packets over the UART transport. A2DP data already goes here and we proba=
bly
> want the same for HSP / HFP.

Then that should be the default with no properties.

I imagine for phones, vendors want I2S hooked up for voice calls so
audio can be routed directly to/from the modem and the power hungry
apps processor can be kept in low power modes.

> For example in the Raspberry Pi 3 B, the CYW43438's PCM output is not
> connected (there is no I2S output), But it may be connected to any other
> device in other hardware.
>
> The purpose of this command is to tell the BT chip where to send the SCO
> packets. From the driver's perspective, it does not really matters where
> these pins are connected.

Bindings are for h/w description (and config to some extent).


>> >  Example:
>> >
>> > @@ -31,5 +37,6 @@ Example:
>> >         bluetooth {
>> >                 compatible =3D "brcm,bcm43438-bt";
>> >                 max-speed =3D <921600>;
>> > +               sco-routing =3D <1>; /* 1 =3D transport (UART) */
>> >         };
>> >  };
>> > diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> > index ddbd8c6a..0e729534 100644
>> > --- a/drivers/bluetooth/hci_bcm.c
>> > +++ b/drivers/bluetooth/hci_bcm.c
>> > @@ -83,6 +83,16 @@
>> >   * @hu: pointer to HCI UART controller struct,
>> >   *     used to disable flow control during runtime suspend and system
>> > sleep
>> >   * @is_suspended: whether flow control is currently disabled
>> > + *
>> > + *  SCO routing parameters:
>> > + *   used as the parameters for the bcm_set_pcm_int_params command
>> > + *     @sco_routing:
>> > + *      >=3D 255 (skip SCO routing configuration)
>> > + *      0-3 (PCM, Transport, Codec, I2S)
>> > + *     @pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)
>> > + *     @pcm_frame_type: 0 (short), 1 (long)
>> > + *     @pcm_sync_mode: 0 (slave), 1 (master)
>> > + *     @pcm_clock_mode: 0 (slave), 1 (master)
>> >   */
>> >  struct bcm_device {
>> >         /* Must be the first member, hci_serdev.c expects this. */
>> > @@ -114,6 +124,13 @@ struct bcm_device {
>> >         struct hci_uart         *hu;
>> >         bool                    is_suspended;
>> >  #endif
>> > +
>> > +       /* SCO routing parameters */
>> > +       u8                      sco_routing;
>> > +       u8                      pcm_interface_rate;
>> > +       u8                      pcm_frame_type;
>> > +       u8                      pcm_sync_mode;
>> > +       u8                      pcm_clock_mode;
>> >  };
>> >
>> >  /* generic bcm uart resources */
>> > @@ -189,6 +206,40 @@ static int bcm_set_baudrate(struct hci_uart *hu,
>> > unsigned int speed)
>> >         return 0;
>> >  }
>> >
>> > +static int bcm_configure_sco_routing(struct hci_uart *hu, struct
>> > bcm_device *bcm_dev)
>> > +{
>> > +       struct hci_dev *hdev =3D hu->hdev;
>> > +       struct sk_buff *skb;
>> > +       struct bcm_set_pcm_int_params params;
>> > +
>> > +       if (bcm_dev->sco_routing >=3D 0xff) {
>> > +               /* SCO routing configuration should be skipped */
>> > +               return 0;
>> > +       }
>> > +
>> > +       bt_dev_dbg(hdev, "BCM: Configuring SCO routing (%d %d %d %d
>> > %d)",
>> > +                       bcm_dev->sco_routing,
>> > bcm_dev->pcm_interface_rate, bcm_dev->pcm_frame_type,
>> > +                       bcm_dev->pcm_sync_mode,
>> > bcm_dev->pcm_clock_mode);
>> > +
>> > +       params.routing =3D bcm_dev->sco_routing;
>> > +       params.rate =3D bcm_dev->pcm_interface_rate;
>> > +       params.frame_sync =3D bcm_dev->pcm_frame_type;
>> > +       params.sync_mode =3D bcm_dev->pcm_sync_mode;
>> > +       params.clock_mode =3D bcm_dev->pcm_clock_mode;
>> > +
>> > +       /* Send the SCO routing configuration command */
>> > +       skb =3D __hci_cmd_sync(hdev, 0xfc1c, sizeof(params), &params,
>> > HCI_CMD_TIMEOUT);
>> > +       if (IS_ERR(skb)) {
>> > +               int err =3D PTR_ERR(skb);
>> > +               bt_dev_err(hdev, "BCM: failed to configure SCO routing
>> > (%d)", err);
>> > +               return err;
>> > +       }
>> > +
>> > +       kfree_skb(skb);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> >  /* bcm_device_exists should be protected by bcm_device_lock */
>> >  static bool bcm_device_exists(struct bcm_device *device)
>> >  {
>> > @@ -534,6 +585,9 @@ static int bcm_setup(struct hci_uart *hu)
>> >                         host_set_baudrate(hu, speed);
>> >         }
>> >
>> > +       /* Configure SCO routing if needed */
>> > +       bcm_configure_sco_routing(hu, bcm->dev);
>> > +
>> >  finalize:
>> >         release_firmware(fw);
>> >
>> > @@ -1004,9 +1058,21 @@ static int bcm_acpi_probe(struct bcm_device *de=
v)
>> >  }
>> >  #endif /* CONFIG_ACPI */
>> >
>> > +static void read_u8_device_property(struct device *device, const char
>> > *property, u8 *destination) {
>> > +       u32 temp;
>> > +       if (device_property_read_u32(device, property, &temp) =3D=3D 0=
) {
>> > +               *destination =3D temp & 0xff;
>> > +       }
>> > +}
>> > +
>> >  static int bcm_of_probe(struct bcm_device *bdev)
>> >  {
>> >         device_property_read_u32(bdev->dev, "max-speed",
>> > &bdev->oper_speed);
>> > +       read_u8_device_property(bdev->dev, "sco-routing",
>> > &bdev->sco_routing);
>> > +       read_u8_device_property(bdev->dev, "pcm-interface-rate",
>> > &bdev->pcm_interface_rate);
>> > +       read_u8_device_property(bdev->dev, "pcm-frame-type",
>> > &bdev->pcm_frame_type);
>> > +       read_u8_device_property(bdev->dev, "pcm-sync-mode",
>> > &bdev->pcm_sync_mode);
>> > +       read_u8_device_property(bdev->dev, "pcm-clock-mode",
>> > &bdev->pcm_clock_mode);
>>
>> These are actually broken because the DT properties are 32-bit.
>>
> The properties from device tree are read as 32-bit values, then they are
> truncated to 8-bit (see the read_u8_device_property function above). Is
> anything wrong with this?
Ah, NM, I missed the wrapper.

Rob
