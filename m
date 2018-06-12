Return-Path: <attitokes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKi=GPYGabjrkKx+1Qv9=NnB6j7=YQhQsBwOBWGAY03tw@mail.gmail.com>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com> <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
 <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
 <4F0D6729-AE77-47D4-9765-FBC44181D4DE@holtmann.org> <CAL_JsqL2StWgA9gkL9i3o85-C3TNixBLmbTXzFQW8bts4phJqQ@mail.gmail.com>
 <D56466C0-2312-4F0E-AB00-66EF4BEECB1A@holtmann.org> <CAL_JsqKi=GPYGabjrkKx+1Qv9=NnB6j7=YQhQsBwOBWGAY03tw@mail.gmail.com>
From: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>
Date: Tue, 12 Jun 2018 20:28:19 +0300
Message-ID: <CAMoM21GrXqA_YNPSOFh6e8Ysc0bARbDUivMNJd1hbJ_UYCpTyw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To: Rob Herring <robh+dt@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>,
	Mark Rutland <mark.rutland@arm.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	Artiom Vaskov <velemas@gmail.com>, netdev <netdev@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000411ed9056e7531eb"
List-ID: <linux-bluetooth.vger.kernel.org>

--000000000000411ed9056e7531eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel, Rob,

I was thinking about doing these changes in two parts:

1. Making in hci_bcm.c the SCO routed over HCI by default

As in the Broadcom chips the SCO seems to be routed to PCM by default, this
may break the backward compatibility with some devices. I guess this would
be a problem, so we will need a way to keep this backward compatible.

2. Adding support to configure SCO routed over the other transports (PCM /
I2C / codec), based on the DT

I don't think we have clear solution yet here. The implementation could be
vendor specific or a more generic one. And there is the modes / timing
negotiation part that is unclear (at least for me).

What do you think?

Attila

On Mon, Jun 11, 2018 at 10:05 PM, Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Jun 11, 2018 at 12:19 PM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
> > Hi Rob,
> >
> >>>>>>> Added support to automatically configure the SCO packet routing a=
t
> the
> >>>>>>> device setup. The SCO packets are used with the HSP / HFP
> profiles, but in
> >>>>>>> some devices (ex. CYW43438) they are routed to a PCM output by
> default. This
> >>>>>>> change allows sending the vendor specific HCI command to configur=
e
> the SCO
> >>>>>>> routing. The parameters of the command are loaded from the device
> tree.
> >>>>>>
> >>>>>> Please wrap your commit msg.
> >>>>>
> >>>>>
> >>>>> Sure.
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
> >>>>>>> ---
> >>>>>>> .../bindings/net/broadcom-bluetooth.txt       |  7 ++
> >>>>>>
> >>>>>> Please split bindings to separate patch.
> >>>>>
> >>>>>
> >>>>> Ok, I will split this in two.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> drivers/bluetooth/hci_bcm.c                   | 72
> +++++++++++++++++++
> >>>>>>> 2 files changed, 79 insertions(+)
> >>>>>>>
> >>>>>>> diff --git
> >>>>>>> a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> >>>>>>> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> >>>>>>> index 4194ff7e..aea3a094 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.tx=
t
> >>>>>>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.tx=
t
> >>>>>>> @@ -21,6 +21,12 @@ Optional properties:
> >>>>>>> - clocks: clock specifier if external clock provided to the
> controller
> >>>>>>> - clock-names: should be "extclk"
> >>>>>>>
> >>>>>>> + SCO routing parameters:
> >>>>>>> + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
> >>>>>>> + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
> >>>>>>> + - pcm-frame-type: 0 (short), 1 (long)
> >>>>>>> + - pcm-sync-mode: 0 (slave), 1 (master)
> >>>>>>> + - pcm-clock-mode: 0 (slave), 1 (master)
> >>>>>>
> >>>>>> Are these Broadcom specific? Properties need either vendor prefix =
or
> >>>>>> to be documented in a common location. I think these look like the
> >>>>>> latter.
> >>>>>
> >>>>>
> >>>>> These will be used as parameters of a vendor specific
> (Broadcom/Cypress)
> >>>>> command configuring the SCO packet routing. See the
> Write_SCO_PCM_Int_Param
> >>>>> command from: http://www.cypress.com/file/298311/download.
> >>>>
> >>>> The DT should just describe how the h/w is hooked-up. What the s/w h=
as
> >>>> to do based on that is the driver's problem which is certainly
> >>>> vendor/chip specific, but that is all irrelevant to the binding.
> >>>>
> >>>>> What would be the property names with a Broadcom / Cypress vendor
> prefix?
> >>>>>
> >>>>>   brcm,sco-routing
> >>>>>   brcm,pcm-interface-rate
> >>>>>   brcm,pcm-frame-type
> >>>>>   brcm,pcm-sync-mode
> >>>>>   brcm,pcm-clock-mode
> >>>>>
> >>>>> ?
> >>>>
> >>>> Yes.
> >>>
> >>> we can do this. However all pcm-* are optional if you switch the HCI
> transport. And sco-routing should default to HCI if that is not present.
> Meaning a driver should actively trying to change this. Nevertheless, it
> would be good if a driver reads the current settings.
> >>>
> >>> In theory we could make sco-routing generic, but so many vendors have
> different modes, that we better keep this vendor specific.
> >>
> >> Even if vendor specific, the properties for not HCI transport case are
> >> still incomplete IMO.
> >>
> >> By modes, you mean PCM vs. I2S and all the flavors of timings you can
> >> have within those or something else? For the former, that's often
> >> going to be a process of solving what each end support and if that
> >> doesn't work, then IIRC we already have properties for setting
> >> modes/timing. All the same issues exist with audio codecs and this is
> >> really not any different.
> >
> > this is what Broadcom uses to configure their PCM transport. So I think
> for now, we make them brcm, specific and see how that goes. We can always
> generalize them later if enough chip manufactures provide support for it.
>
> We already have properties doing the same thing defined in
> Documentation/devicetree/bindings/sound/simple-card.txt. Use and
> extend that. We don't need new properties especially for something
> that is not complete. For example If I have 2 host ports (every SoC
> has at least 2), how do I indicate which one is connected to BT.
>
> Rob
>

--000000000000411ed9056e7531eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel, Rob,<div><br></div><div>I was thinking about do=
ing these changes in two parts:</div><div><br></div><div>1. Making=C2=A0<sp=
an style=3D"font-size:small;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial;float:none;display:inline">i=
n hci_bcm.c=C2=A0</span><span style=3D"font-size:small;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">the=C2=A0</span>SCO routed over HCI by default<br=
><br><span style=3D"font-size:small;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial;float:none;display:i=
nline"><span style=3D"text-decoration-style:initial;text-decoration-color:i=
nitial;float:none;display:inline">As<span>=C2=A0</span></span><span style=
=3D"text-decoration-style:initial;text-decoration-color:initial;float:none;=
display:inline">in the Broadcom chips the SCO seems to be routed to PCM by =
default, t</span>his may break the backward compatibility with some devices=
. I guess this would be a problem, so we will need a way to keep this backw=
ard compatible.</span><br></div><div><br></div><div>2. Adding support to co=
nfigure SCO routed over the other transports (PCM / I2C / codec),=C2=A0<spa=
n style=3D"font-size:small;background-color:rgb(255,255,255);text-decoratio=
n-style:initial;text-decoration-color:initial;float:none;display:inline">ba=
sed on the DT</span></div><div><br></div><div><span style=3D"font-size:smal=
l;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline">I don&#39;t think we have c=
lear solution yet here.=C2=A0</span>The implementation could be vendor spec=
ific or a more<span style=3D"font-size:small;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial;float:none;=
display:inline">=C2=A0generic one. And there is the modes / timing negotiat=
ion part that is unclear (at least for me).</span></div><div><br></div><div=
>What do you think?<br><br>Attila</div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Mon, Jun 11, 2018 at 10:05 PM, Rob Herring <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:robh+dt@kernel.org" target=3D"_blank">robh=
+dt@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 class=3D"HOEnZb"><div class=3D"h5">On Mon, Jun 11, 2018 at 12:19 PM, Marce=
l Holtmann &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@holtmann.org</=
a>&gt; wrote:<br>
&gt; Hi Rob,<br>
&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Added support to automatically configure the S=
CO packet routing at the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; device setup. The SCO packets are used with th=
e HSP / HFP profiles, but in<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; some devices (ex. CYW43438) they are routed to=
 a PCM output by default. This<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; change allows sending the vendor specific HCI =
command to configure the SCO<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; routing. The parameters of the command are loa=
ded from the device tree.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Please wrap your commit msg.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Sure.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Attila T=C5=91k=C3=A9s &lt;<a h=
ref=3D"mailto:attitokes@gmail.com">attitokes@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; .../bindings/net/broadcom-<wbr>bluetooth.txt=
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Please split bindings to separate patch.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Ok, I will split this in two.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; drivers/bluetooth/hci_bcm.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 72 ++++++++++++++++++=
+<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2 files changed, 79 insertions(+)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; diff --git<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; a/Documentation/devicetree/<wbr>bindings/net/b=
roadcom-<wbr>bluetooth.txt<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; b/Documentation/devicetree/<wbr>bindings/net/b=
roadcom-<wbr>bluetooth.txt<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; index 4194ff7e..aea3a094 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/Documentation/devicetree/<wbr>bindings/n=
et/broadcom-<wbr>bluetooth.txt<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/Documentation/devicetree/<wbr>bindings/n=
et/broadcom-<wbr>bluetooth.txt<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -21,6 +21,12 @@ Optional properties:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; - clocks: clock specifier if external clock pr=
ovided to the controller<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; - clock-names: should be &quot;extclk&quot;<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; + SCO routing parameters:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; + - sco-routing: 0-3 (PCM, Transport, Codec, I=
2S)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; + - pcm-interface-rate: 0-4 (128 Kbps - 2048 K=
bps)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; + - pcm-frame-type: 0 (short), 1 (long)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; + - pcm-sync-mode: 0 (slave), 1 (master)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; + - pcm-clock-mode: 0 (slave), 1 (master)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Are these Broadcom specific? Properties need eithe=
r vendor prefix or<br>
&gt;&gt;&gt;&gt;&gt;&gt; to be documented in a common location. I think the=
se look like the<br>
&gt;&gt;&gt;&gt;&gt;&gt; latter.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; These will be used as parameters of a vendor specific =
(Broadcom/Cypress)<br>
&gt;&gt;&gt;&gt;&gt; command configuring the SCO packet routing. See the Wr=
ite_SCO_PCM_Int_Param<br>
&gt;&gt;&gt;&gt;&gt; command from: <a href=3D"http://www.cypress.com/file/2=
98311/download" rel=3D"noreferrer" target=3D"_blank">http://www.cypress.com=
/file/<wbr>298311/download</a>.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The DT should just describe how the h/w is hooked-up. What=
 the s/w has<br>
&gt;&gt;&gt;&gt; to do based on that is the driver&#39;s problem which is c=
ertainly<br>
&gt;&gt;&gt;&gt; vendor/chip specific, but that is all irrelevant to the bi=
nding.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; What would be the property names with a Broadcom / Cyp=
ress vendor prefix?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0brcm,sco-routing<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0brcm,pcm-interface-rate<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0brcm,pcm-frame-type<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0brcm,pcm-sync-mode<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0brcm,pcm-clock-mode<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; ?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Yes.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; we can do this. However all pcm-* are optional if you switch t=
he HCI transport. And sco-routing should default to HCI if that is not pres=
ent. Meaning a driver should actively trying to change this. Nevertheless, =
it would be good if a driver reads the current settings.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In theory we could make sco-routing generic, but so many vendo=
rs have different modes, that we better keep this vendor specific.<br>
&gt;&gt;<br>
&gt;&gt; Even if vendor specific, the properties for not HCI transport case=
 are<br>
&gt;&gt; still incomplete IMO.<br>
&gt;&gt;<br>
&gt;&gt; By modes, you mean PCM vs. I2S and all the flavors of timings you =
can<br>
&gt;&gt; have within those or something else? For the former, that&#39;s of=
ten<br>
&gt;&gt; going to be a process of solving what each end support and if that=
<br>
&gt;&gt; doesn&#39;t work, then IIRC we already have properties for setting=
<br>
&gt;&gt; modes/timing. All the same issues exist with audio codecs and this=
 is<br>
&gt;&gt; really not any different.<br>
&gt;<br>
&gt; this is what Broadcom uses to configure their PCM transport. So I thin=
k for now, we make them brcm, specific and see how that goes. We can always=
 generalize them later if enough chip manufactures provide support for it.<=
br>
<br>
</div></div>We already have properties doing the same thing defined in<br>
Documentation/devicetree/<wbr>bindings/sound/simple-card.<wbr>txt. Use and<=
br>
extend that. We don&#39;t need new properties especially for something<br>
that is not complete. For example If I have 2 host ports (every SoC<br>
has at least 2), how do I indicate which one is connected to BT.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Rob<br>
</font></span></blockquote></div><br></div></div>

--000000000000411ed9056e7531eb--
