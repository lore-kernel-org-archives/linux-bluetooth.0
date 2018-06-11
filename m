Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <D56466C0-2312-4F0E-AB00-66EF4BEECB1A@holtmann.org>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com> <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
 <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
 <4F0D6729-AE77-47D4-9765-FBC44181D4DE@holtmann.org> <CAL_JsqL2StWgA9gkL9i3o85-C3TNixBLmbTXzFQW8bts4phJqQ@mail.gmail.com>
 <D56466C0-2312-4F0E-AB00-66EF4BEECB1A@holtmann.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 11 Jun 2018 13:05:29 -0600
Message-ID: <CAL_JsqKi=GPYGabjrkKx+1Qv9=NnB6j7=YQhQsBwOBWGAY03tw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Mark Rutland <mark.rutland@arm.com>,
	Johan Hedberg <johan.hedberg@gmail.com>, Artiom Vaskov <velemas@gmail.com>,
	netdev <netdev@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 11, 2018 at 12:19 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Rob,
>
>>>>>>> Added support to automatically configure the SCO packet routing at =
the
>>>>>>> device setup. The SCO packets are used with the HSP / HFP profiles,=
 but in
>>>>>>> some devices (ex. CYW43438) they are routed to a PCM output by defa=
ult. This
>>>>>>> change allows sending the vendor specific HCI command to configure =
the SCO
>>>>>>> routing. The parameters of the command are loaded from the device t=
ree.
>>>>>>
>>>>>> Please wrap your commit msg.
>>>>>
>>>>>
>>>>> Sure.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Attila T=C5=91k=C3=A9s <attitokes@gmail.com>
>>>>>>> ---
>>>>>>> .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>>>>>>
>>>>>> Please split bindings to separate patch.
>>>>>
>>>>>
>>>>> Ok, I will split this in two.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>> drivers/bluetooth/hci_bcm.c                   | 72 ++++++++++++++++=
+++
>>>>>>> 2 files changed, 79 insertions(+)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> index 4194ff7e..aea3a094 100644
>>>>>>> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>>>>> @@ -21,6 +21,12 @@ Optional properties:
>>>>>>> - clocks: clock specifier if external clock provided to the control=
ler
>>>>>>> - clock-names: should be "extclk"
>>>>>>>
>>>>>>> + SCO routing parameters:
>>>>>>> + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
>>>>>>> + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
>>>>>>> + - pcm-frame-type: 0 (short), 1 (long)
>>>>>>> + - pcm-sync-mode: 0 (slave), 1 (master)
>>>>>>> + - pcm-clock-mode: 0 (slave), 1 (master)
>>>>>>
>>>>>> Are these Broadcom specific? Properties need either vendor prefix or
>>>>>> to be documented in a common location. I think these look like the
>>>>>> latter.
>>>>>
>>>>>
>>>>> These will be used as parameters of a vendor specific (Broadcom/Cypre=
ss)
>>>>> command configuring the SCO packet routing. See the Write_SCO_PCM_Int=
_Param
>>>>> command from: http://www.cypress.com/file/298311/download.
>>>>
>>>> The DT should just describe how the h/w is hooked-up. What the s/w has
>>>> to do based on that is the driver's problem which is certainly
>>>> vendor/chip specific, but that is all irrelevant to the binding.
>>>>
>>>>> What would be the property names with a Broadcom / Cypress vendor pre=
fix?
>>>>>
>>>>>   brcm,sco-routing
>>>>>   brcm,pcm-interface-rate
>>>>>   brcm,pcm-frame-type
>>>>>   brcm,pcm-sync-mode
>>>>>   brcm,pcm-clock-mode
>>>>>
>>>>> ?
>>>>
>>>> Yes.
>>>
>>> we can do this. However all pcm-* are optional if you switch the HCI tr=
ansport. And sco-routing should default to HCI if that is not present. Mean=
ing a driver should actively trying to change this. Nevertheless, it would =
be good if a driver reads the current settings.
>>>
>>> In theory we could make sco-routing generic, but so many vendors have d=
ifferent modes, that we better keep this vendor specific.
>>
>> Even if vendor specific, the properties for not HCI transport case are
>> still incomplete IMO.
>>
>> By modes, you mean PCM vs. I2S and all the flavors of timings you can
>> have within those or something else? For the former, that's often
>> going to be a process of solving what each end support and if that
>> doesn't work, then IIRC we already have properties for setting
>> modes/timing. All the same issues exist with audio codecs and this is
>> really not any different.
>
> this is what Broadcom uses to configure their PCM transport. So I think f=
or now, we make them brcm, specific and see how that goes. We can always ge=
neralize them later if enough chip manufactures provide support for it.

We already have properties doing the same thing defined in
Documentation/devicetree/bindings/sound/simple-card.txt. Use and
extend that. We don't need new properties especially for something
that is not complete. For example If I have 2 host ports (every SoC
has at least 2), how do I indicate which one is connected to BT.

Rob
