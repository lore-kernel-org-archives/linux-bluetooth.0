Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <413E9611-A092-49CB-B86A-AD4D866D2064@holtmann.org>
References: <1418337865-3596-1-git-send-email-toshik@chromium.org>
	<413E9611-A092-49CB-B86A-AD4D866D2064@holtmann.org>
Date: Fri, 12 Dec 2014 10:52:38 -0800
Message-ID: <CALMyts4yk8_0OxAB340zpfSeYYpoQ91+bPwv1bcNp79w9Baavg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: support public address configuration
 for ath3012
From: Toshi Kikuchi <toshik@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a113f97ac980310050a09653a
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113f97ac980310050a09653a
Content-Type: text/plain; charset=UTF-8

Hi Marcel,

> +     buf[0] = 0x01;
> > +     buf[1] = 0x01;
> > +     buf[2] = 0x00;
> > +     buf[3] = 0x06;
>
> is this the length of the BD_ADDR data, then using sizeof(bdaddr_t) like
> the Marvell one does.
>

Yes, we can do that.


> Also can we make sure that this changes the address only temporary.
> Meaning after a power cycle the original address comes back. This feature
> is not designed to permanently change the BD_ADDR.


Yes. that's how it works. The change doesn't persist after a power cycle.


> > +     if (id->driver_info & BTUSB_ATH3012) {
> > +             hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
> > +     }
> > +
>
> For single lines, we do not use { }.


Right. I'll send out a fixed version shortly.

Thanks,
Toshi

--001a113f97ac980310050a09653a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,<br><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt; +=C2=A0 =
=C2=A0 =C2=A0buf[0] =3D 0x01;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[1] =3D 0x01;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[2] =3D 0x00;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0buf[3] =3D 0x06;<br>
<br>
</span>is this the length of the BD_ADDR data, then using sizeof(bdaddr_t) =
like the Marvell one does.<br></blockquote><div><br></div><div>Yes, we can =
do that.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Also can we m=
ake sure that this changes the address only temporary. Meaning after a powe=
r cycle the original address comes back. This feature is not designed to pe=
rmanently change the BD_ADDR.</blockquote><div><br></div><div>Yes. that&#39=
;s how it works. The change doesn&#39;t persist after a power cycle.=C2=A0<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt; +=C2=A0 =C2=A0 =C2=A0if (id-&gt;driver_info &amp; BTUSB_ATH3012) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdev-&gt;set_bdaddr =
=3D btusb_set_bdaddr_ath3012;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
<br>
</span>For single lines, we do not use { }.</blockquote><div><br></div><div=
>Right. I&#39;ll send out a fixed version shortly.</div><div><br></div><div=
>Thanks,</div><div>Toshi</div></div></div></div>

--001a113f97ac980310050a09653a--
