Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
Date: Mon, 11 Jun 2018 17:47:14 +0200
Cc: =?utf-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Artiom Vaskov <velemas@gmail.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Message-Id: <4F0D6729-AE77-47D4-9765-FBC44181D4DE@holtmann.org>
References: <280FCB2C-6DF1-4790-A89F-AF5BE3513AE5@holtmann.org>
 <20180608162009.22762-1-attitokes@gmail.com>
 <CAL_JsqKGeCEBBLNQNdymQovknRM7zt4+nNJy0YSkxRicOxkCSg@mail.gmail.com>
 <CAMoM21HshLyv+Np1vOKYTAunsPCazyP-WESiaheNXHsC078S8g@mail.gmail.com>
 <CAL_Jsq+a93Rpf3UAPBQ5QmA8KavberGXz76WCiZ7feHH5GgcDA@mail.gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rob,

>>>> Added support to automatically configure the SCO packet routing at the
>>>> device setup. The SCO packets are used with the HSP / HFP profiles, but in
>>>> some devices (ex. CYW43438) they are routed to a PCM output by default. This
>>>> change allows sending the vendor specific HCI command to configure the SCO
>>>> routing. The parameters of the command are loaded from the device tree.
>>> 
>>> Please wrap your commit msg.
>> 
>> 
>> Sure.
>>> 
>>> 
>>>> 
>>>> Signed-off-by: Attila Tőkés <attitokes@gmail.com>
>>>> ---
>>>> .../bindings/net/broadcom-bluetooth.txt       |  7 ++
>>> 
>>> Please split bindings to separate patch.
>> 
>> 
>> Ok, I will split this in two.
>>> 
>>> 
>>> 
>>> 
>>>> drivers/bluetooth/hci_bcm.c                   | 72 +++++++++++++++++++
>>>> 2 files changed, 79 insertions(+)
>>>> 
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>> b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>> index 4194ff7e..aea3a094 100644
>>>> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
>>>> @@ -21,6 +21,12 @@ Optional properties:
>>>>  - clocks: clock specifier if external clock provided to the controller
>>>>  - clock-names: should be "extclk"
>>>> 
>>>> + SCO routing parameters:
>>>> + - sco-routing: 0-3 (PCM, Transport, Codec, I2S)
>>>> + - pcm-interface-rate: 0-4 (128 Kbps - 2048 Kbps)
>>>> + - pcm-frame-type: 0 (short), 1 (long)
>>>> + - pcm-sync-mode: 0 (slave), 1 (master)
>>>> + - pcm-clock-mode: 0 (slave), 1 (master)
>>> 
>>> Are these Broadcom specific? Properties need either vendor prefix or
>>> to be documented in a common location. I think these look like the
>>> latter.
>> 
>> 
>> These will be used as parameters of a vendor specific (Broadcom/Cypress)
>> command configuring the SCO packet routing. See the Write_SCO_PCM_Int_Param
>> command from: http://www.cypress.com/file/298311/download.
> 
> The DT should just describe how the h/w is hooked-up. What the s/w has
> to do based on that is the driver's problem which is certainly
> vendor/chip specific, but that is all irrelevant to the binding.
> 
>> What would be the property names with a Broadcom / Cypress vendor prefix?
>> 
>>    brcm,sco-routing
>>    brcm,pcm-interface-rate
>>    brcm,pcm-frame-type
>>    brcm,pcm-sync-mode
>>    brcm,pcm-clock-mode
>> 
>> ?
> 
> Yes.

we can do this. However all pcm-* are optional if you switch the HCI transport. And sco-routing should default to HCI if that is not present. Meaning a driver should actively trying to change this. Nevertheless, it would be good if a driver reads the current settings.

In theory we could make sco-routing generic, but so many vendors have different modes, that we better keep this vendor specific.

Regards

Marcel
