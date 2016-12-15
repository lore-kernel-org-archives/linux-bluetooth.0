Return-Path: <rajatja@google.com>
MIME-Version: 1.0
In-Reply-To: <87shppk32a.fsf@free-electrons.com>
References: <1481742779-15105-1-git-send-email-rajatja@google.com>
 <1481742779-15105-3-git-send-email-rajatja@google.com> <87shppk32a.fsf@free-electrons.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 15 Dec 2016 10:04:10 -0800
Message-ID: <CACK8Z6ErUpOvRbUg2L7xBFCu-V+9=o+zBUeKeo-Nu+812m6bww@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: btusb: Configure Marvel to use one of the
 pins for oob wakeup
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, Amitkumar Karwar <akarwar@marvell.com>,
	Wei-Ning Huang <wnhuang@chromium.org>, Xinming Hu <huxm@marvell.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Brian Norris <briannorris@google.com>, Rajat Jain <rajatxjain@gmail.com>
Content-Type: multipart/alternative; boundary=f403045d383a2f885a0543b64a40
List-ID: <linux-bluetooth.vger.kernel.org>

--f403045d383a2f885a0543b64a40
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 12:29 AM, Gregory CLEMENT <
gregory.clement@free-electrons.com> wrote:

> Hi Rajat,
>
>  On mer., d=C3=A9c. 14 2016, Rajat Jain <rajatja@google.com> wrote:
>
> In your title unless you speak about the comic books you should do a
> s/Marvel/Marvell/ :)
>

Oops :-) Will do, thanks!


>
> Gregory
>
> > The Marvell devices may have many gpio pins, and hence for wakeup
> > on these out-of-band pins, the chip needs to be told which pin is
> > to be used for wakeup, using an hci command.
> >
> > Thus, we read the pin number etc from the device tree node and send
> > a command to the chip.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > Note that while I would have liked to name the compatible string as mor=
e
> > like "marvell, usb8997-bt", the devicetrees/bindings/usb/usb-device.txt
> > requires the compatible property to be of the form "usbVID,PID".
> >
> >  .../{marvell-bt-sd8xxx.txt =3D> marvell-bt-8xxx.txt} | 25 ++++++++-
> >  drivers/bluetooth/btusb.c                          | 59
> ++++++++++++++++++++++
> >  2 files changed, 82 insertions(+), 2 deletions(-)
> >  rename Documentation/devicetree/bindings/net/{marvell-bt-sd8xxx.txt =
=3D>
> marvell-bt-8xxx.txt} (76%)
> >
> > diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.tx=
t
> b/Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
> > similarity index 76%
> > rename from Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> > rename to Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
> > index 6a9a63c..471bef8 100644
> > --- a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> > +++ b/Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
> > @@ -1,4 +1,4 @@
> > -Marvell 8897/8997 (sd8897/sd8997) bluetooth SDIO devices
> > +Marvell 8897/8997 (sd8897/sd8997) bluetooth devices (SDIO or USB based=
)
> >  ------
> >
> >  Required properties:
> > @@ -6,11 +6,13 @@ Required properties:
> >    - compatible : should be one of the following:
> >       * "marvell,sd8897-bt"
> >       * "marvell,sd8997-bt"
> > +     * "usb1286,204e"
> >
> >  Optional properties:
> >
> >    - marvell,cal-data: Calibration data downloaded to the device during
> >                     initialization. This is an array of 28 values(u8).
> > +                   This is only applicable to SDIO devices.
> >
> >    - marvell,wakeup-pin: It represents wakeup pin number of the
> bluetooth chip.
> >                       firmware will use the pin to wakeup host system
> (u16).
> > @@ -29,7 +31,9 @@ Example:
> >  IRQ pin 119 is used as system wakeup source interrupt.
> >  wakeup pin 13 and gap 100ms are configured so that firmware can wakeup
> host
> >  using this device side pin and wakeup latency.
> > -calibration data is also available in below example.
> > +
> > +Example for SDIO device follows (calibration data is also available in
> > +below example).
> >
> >  &mmc3 {
> >       status =3D "okay";
> > @@ -54,3 +58,20 @@ calibration data is also available in below example.
> >               marvell,wakeup-gap-ms =3D /bits/ 16 <0x64>;
> >       };
> >  };
> > +
> > +Example for USB device:
> > +
> > +&usb_host1_ohci {
> > +    status =3D "okay";
> > +    #address-cells =3D <1>;
> > +    #size-cells =3D <0>;
> > +
> > +    mvl_bt1: bt@1 {
> > +     compatible =3D "usb1286,204e";
> > +     reg =3D <1>;
> > +     interrupt-parent =3D <&gpio0>;
> > +     interrupts =3D <119 IRQ_TYPE_LEVEL_LOW>;
> > +     marvell,wakeup-pin =3D /bits/ 16 <0x0d>;
> > +     marvell,wakeup-gap-ms =3D /bits/ 16 <0x64>;
> > +    };
> > +};
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 32a6f22..99d7f6d 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2343,6 +2343,58 @@ static int btusb_shutdown_intel(struct hci_dev
> *hdev)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_PM
> > +static const struct of_device_id mvl_oob_wake_match_table[] =3D {
> > +     { .compatible =3D "usb1286,204e" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, mvl_oob_wake_match_table);
> > +
> > +/* Configure an out-of-band gpio as wake-up pin, if specified in devic=
e
> tree */
> > +static int marvell_config_oob_wake(struct hci_dev *hdev)
> > +{
> > +     struct sk_buff *skb;
> > +     struct btusb_data *data =3D hci_get_drvdata(hdev);
> > +     struct device *dev =3D &data->udev->dev;
> > +     u16 pin, gap, opcode;
> > +     int ret;
> > +     u8 cmd[5];
> > +
> > +     if (!of_match_device(mvl_oob_wake_match_table, dev))
> > +             return 0;
> > +
> > +     if (of_property_read_u16(dev->of_node, "marvell,wakeup-pin",
> &pin) ||
> > +         of_property_read_u16(dev->of_node, "marvell,wakeup-gap-ms",
> &gap))
> > +             return -EINVAL;
> > +
> > +     /* Vendor specific command to configure a GPIO as wake-up pin */
> > +     opcode =3D hci_opcode_pack(0x3F, 0x59);
> > +     cmd[0] =3D opcode & 0xFF;
> > +     cmd[1] =3D opcode >> 8;
> > +     cmd[2] =3D 2; /* length of parameters that follow */
> > +     cmd[3] =3D pin;
> > +     cmd[4] =3D gap; /* time in ms, for which wakeup pin should be
> asserted */
> > +
> > +     skb =3D bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> > +     if (!skb) {
> > +             bt_dev_err(hdev, "%s: No memory\n", __func__);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     memcpy(skb_put(skb, sizeof(cmd)), cmd, sizeof(cmd));
> > +     hci_skb_pkt_type(skb) =3D HCI_COMMAND_PKT;
> > +
> > +     ret =3D btusb_send_frame(hdev, skb);
> > +     if (ret) {
> > +             bt_dev_err(hdev, "%s: configuration failed\n", __func__);
> > +             kfree_skb(skb);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
> >  static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
> >                                   const bdaddr_t *bdaddr)
> >  {
> > @@ -2917,6 +2969,13 @@ static int btusb_probe(struct usb_interface *int=
f,
> >       err =3D btusb_config_oob_wake(hdev);
> >       if (err)
> >               goto out_free_dev;
> > +
> > +     /* Marvel devices may need a specific chip configuration */
> > +     if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
> > +             err =3D marvell_config_oob_wake(hdev);
> > +             if (err)
> > +                     goto out_free_dev;
> > +     }
> >  #endif
> >       if (id->driver_info & BTUSB_CW6622)
> >               set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
> > --
> > 2.8.0.rc3.226.g39d4020
> >
>
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>

--f403045d383a2f885a0543b64a40
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Dec 15, 2016 at 12:29 AM, Gregory CLEMENT <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gregory.clement@free-electrons.com" target=3D"_blank">gr=
egory.clement@free-electrons.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi Rajat,<br>
<br>
=C2=A0On mer., d=C3=A9c. 14 2016, Rajat Jain &lt;<a href=3D"mailto:rajatja@=
google.com">rajatja@google.com</a>&gt; wrote:<br>
<br>
In your title unless you speak about the comic books you should do a<br>
s/Marvel/Marvell/ :)<br></blockquote><div><br></div><div>Oops :-) Will do, =
thanks!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Gregory<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; The Marvell devices may have many gpio pins, and hence for wakeup<br>
&gt; on these out-of-band pins, the chip needs to be told which pin is<br>
&gt; to be used for wakeup, using an hci command.<br>
&gt;<br>
&gt; Thus, we read the pin number etc from the device tree node and send<br=
>
&gt; a command to the chip.<br>
&gt;<br>
&gt; Signed-off-by: Rajat Jain &lt;<a href=3D"mailto:rajatja@google.com">ra=
jatja@google.com</a>&gt;<br>
&gt; ---<br>
&gt; Note that while I would have liked to name the compatible string as mo=
re<br>
&gt; like &quot;marvell, usb8997-bt&quot;, the devicetrees/bindings/usb/usb=
-<wbr>device.txt<br>
&gt; requires the compatible property to be of the form &quot;usbVID,PID&qu=
ot;.<br>
&gt;<br>
&gt;=C2=A0 .../{marvell-bt-sd8xxx.txt =3D&gt; marvell-bt-8xxx.txt} | 25 +++=
+++++-<br>
&gt;=C2=A0 drivers/bluetooth/btusb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 59 +++++++++++++++++=
+++++<br>
&gt;=C2=A0 2 files changed, 82 insertions(+), 2 deletions(-)<br>
&gt;=C2=A0 rename Documentation/devicetree/<wbr>bindings/net/{marvell-bt-<w=
br>sd8xxx.txt =3D&gt; marvell-bt-8xxx.txt} (76%)<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/<wbr>bindings/net/marvell-bt-<wb=
r>sd8xxx.txt b/Documentation/devicetree/<wbr>bindings/net/marvell-bt-8xxx.<=
wbr>txt<br>
&gt; similarity index 76%<br>
&gt; rename from Documentation/devicetree/<wbr>bindings/net/marvell-bt-<wbr=
>sd8xxx.txt<br>
&gt; rename to Documentation/devicetree/<wbr>bindings/net/marvell-bt-8xxx.<=
wbr>txt<br>
&gt; index 6a9a63c..471bef8 100644<br>
&gt; --- a/Documentation/devicetree/<wbr>bindings/net/marvell-bt-<wbr>sd8xx=
x.txt<br>
&gt; +++ b/Documentation/devicetree/<wbr>bindings/net/marvell-bt-8xxx.<wbr>=
txt<br>
&gt; @@ -1,4 +1,4 @@<br>
&gt; -Marvell 8897/8997 (sd8897/sd8997) bluetooth SDIO devices<br>
&gt; +Marvell 8897/8997 (sd8897/sd8997) bluetooth devices (SDIO or USB base=
d)<br>
&gt;=C2=A0 ------<br>
&gt;<br>
&gt;=C2=A0 Required properties:<br>
&gt; @@ -6,11 +6,13 @@ Required properties:<br>
&gt;=C2=A0 =C2=A0 - compatible : should be one of the following:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* &quot;marvell,sd8897-bt&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* &quot;marvell,sd8997-bt&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* &quot;usb1286,204e&quot;<br>
&gt;<br>
&gt;=C2=A0 Optional properties:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 - marvell,cal-data: Calibration data downloaded to the de=
vice during<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0initialization. This is an array of 28 values(u8).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
This is only applicable to SDIO devices.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 - marvell,wakeup-pin: It represents wakeup pin number of =
the bluetooth chip.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0firmware will use the pin to wakeup host system (u16).<br>
&gt; @@ -29,7 +31,9 @@ Example:<br>
&gt;=C2=A0 IRQ pin 119 is used as system wakeup source interrupt.<br>
&gt;=C2=A0 wakeup pin 13 and gap 100ms are configured so that firmware can =
wakeup host<br>
&gt;=C2=A0 using this device side pin and wakeup latency.<br>
&gt; -calibration data is also available in below example.<br>
&gt; +<br>
&gt; +Example for SDIO device follows (calibration data is also available i=
n<br>
&gt; +below example).<br>
&gt;<br>
&gt;=C2=A0 &amp;mmc3 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; @@ -54,3 +58,20 @@ calibration data is also available in below example=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0marvell,wakeup-g=
ap-ms =3D /bits/ 16 &lt;0x64&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 };<br>
&gt; +<br>
&gt; +Example for USB device:<br>
&gt; +<br>
&gt; +&amp;usb_host1_ohci {<br>
&gt; +=C2=A0 =C2=A0 status =3D &quot;okay&quot;;<br>
&gt; +=C2=A0 =C2=A0 #address-cells =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 #size-cells =3D &lt;0&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mvl_bt1: bt@1 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0compatible =3D &quot;usb1286,204e&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg =3D &lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0interrupt-parent =3D &lt;&amp;gpio0&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0interrupts =3D &lt;119 IRQ_TYPE_LEVEL_LOW&gt;;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0marvell,wakeup-pin =3D /bits/ 16 &lt;0x0d&gt;;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0marvell,wakeup-gap-ms =3D /bits/ 16 &lt;0x64&gt;;=
<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +};<br>
&gt; diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
&gt; index 32a6f22..99d7f6d 100644<br>
&gt; --- a/drivers/bluetooth/btusb.c<br>
&gt; +++ b/drivers/bluetooth/btusb.c<br>
&gt; @@ -2343,6 +2343,58 @@ static int btusb_shutdown_intel(struct hci_dev =
*hdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +#ifdef CONFIG_PM<br>
&gt; +static const struct of_device_id mvl_oob_wake_match_table[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;usb1286,204e&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ }<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, mvl_oob_wake_match_table);<br>
&gt; +<br>
&gt; +/* Configure an out-of-band gpio as wake-up pin, if specified in devi=
ce tree */<br>
&gt; +static int marvell_config_oob_wake(struct hci_dev *hdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct sk_buff *skb;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct btusb_data *data =3D hci_get_drvdata(hdev)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;data-&gt;udev-&gt;dev=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 pin, gap, opcode;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 cmd[5];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!of_match_device(mvl_oob_<wbr>wake_match_tabl=
e, dev))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (of_property_read_u16(dev-&gt;of_<wbr>node, &q=
uot;marvell,wakeup-pin&quot;, &amp;pin) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of_property_read_u16(dev-&gt;of_<wb=
r>node, &quot;marvell,wakeup-gap-ms&quot;, &amp;gap))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Vendor specific command to configure a GPIO as=
 wake-up pin */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0opcode =3D hci_opcode_pack(0x3F, 0x59);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[0] =3D opcode &amp; 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[1] =3D opcode &gt;&gt; 8;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[2] =3D 2; /* length of parameters that follow=
 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[3] =3D pin;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[4] =3D gap; /* time in ms, for which wakeup p=
in should be asserted */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0skb =3D bt_skb_alloc(sizeof(cmd), GFP_KERNEL);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!skb) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bt_dev_err(hdev, &quo=
t;%s: No memory\n&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0memcpy(skb_put(skb, sizeof(cmd)), cmd, sizeof(cmd=
));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hci_skb_pkt_type(skb) =3D HCI_COMMAND_PKT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D btusb_send_frame(hdev, skb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bt_dev_err(hdev, &quo=
t;%s: configuration failed\n&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree_skb(skb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 static int btusb_set_bdaddr_marvell(<wbr>struct hci_dev *hdev,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const bdaddr_t *bdad=
dr)<br>
&gt;=C2=A0 {<br>
&gt; @@ -2917,6 +2969,13 @@ static int btusb_probe(struct usb_interface *in=
tf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D btusb_config_oob_wake(hdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_free_de=
v;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Marvel devices may need a specific chip config=
uration */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (id-&gt;driver_info &amp; BTUSB_MARVELL &amp;&=
amp; data-&gt;oob_wake_irq) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D marvell_confi=
g_oob_wake(hdev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto out_free_dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (id-&gt;driver_info &amp; BTUSB_CW6622)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(HCI_QUIR=
K_BROKEN_<wbr>STORED_LINK_KEY, &amp;hdev-&gt;quirks);<br>
&gt; --<br>
&gt; 2.8.0.rc3.226.g39d4020<br>
&gt;<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Gregory Clement, Free Electrons<br>
Kernel, drivers, real-time and embedded Linux<br>
development, consulting, training and support.<br>
<a href=3D"http://free-electrons.com" rel=3D"noreferrer" target=3D"_blank">=
http://free-electrons.com</a><br>
</font></span></blockquote></div><br></div></div>

--f403045d383a2f885a0543b64a40--
