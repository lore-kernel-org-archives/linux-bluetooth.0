Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <AD664D12-31A5-456B-9971-4A76BDC32BA3@holtmann.org>
References: <1504699898-28011-1-git-send-email-loic.poulain@linaro.org>
 <1504699898-28011-3-git-send-email-loic.poulain@linaro.org> <AD664D12-31A5-456B-9971-4A76BDC32BA3@holtmann.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Fri, 8 Sep 2017 09:04:15 +0200
Message-ID: <CAMZdPi8gSnS702LadCL7gRKzYbEtOBUZTYUrN1b_1wiycpC1gw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Bluetooth: btqcomsmd: retrieve BD address from DT property
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: multipart/alternative; boundary="94eb2c0867b6be0df30558a831ec"
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c0867b6be0df30558a831ec
Content-Type: text/plain; charset="UTF-8"

Hi Marcel,

>
> > +     /* The local-bd-address property is usually injected by the
> > +      * bootloader which has access to the allocated BD address.
> > +      */
> > +     if (!of_property_read_u8_array(pdev->dev.of_node,
> "local-bd-address",
> > +                                    (u8 *)&btq->bdaddr,
> sizeof(bdaddr_t))) {
> > +             BT_INFO("BD address %pMR retrieved from device-tree",
> > +                     &btq->bdaddr);
> > +     }
>
> any reason you are not using bt_dev_info here? I think it would be
> important to print the device information prefix.
>

Yes, hdev does not have any allocated name/number before being registered.
I can move this after hci_register_dev if you prefer.

Regards,
Loic

--94eb2c0867b6be0df30558a831ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,<br><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* The local-bd-address property is usually injec=
ted by the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * bootloader which has access to the allocated B=
D address.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!of_property_read_u8_array(<wbr>pdev-&gt;dev.=
of_node, &quot;local-bd-address&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u8 *)&amp;btq-&gt=
;bdaddr, sizeof(bdaddr_t))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BT_INFO(&quot;BD addr=
ess %pMR retrieved from device-tree&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;btq-&gt;bdaddr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
any reason you are not using bt_dev_info here? I think it would be importan=
t to print the device information prefix.<span class=3D"gmail-HOEnZb"><font=
 color=3D"#888888"><br></font></span></blockquote><div><br></div><div>Yes, =
hdev does not have any allocated name/number before being registered.<br></=
div><div>I can move this after hci_register_dev if you prefer.<br><br></div=
><div>Regards,<br></div>Loic</div>

--94eb2c0867b6be0df30558a831ec--
