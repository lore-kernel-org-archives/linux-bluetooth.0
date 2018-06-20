Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ec01ffb8cb16afef0e92d4355f5e839e@codeaurora.org>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-2-bgodavar@codeaurora.org> <CAL_JsqL5K-4LBEwS0ag=7M8cOp2nF+mRC+M03BinSj-YR0+b=Q@mail.gmail.com>
 <ec01ffb8cb16afef0e92d4355f5e839e@codeaurora.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 20 Jun 2018 08:54:24 -0600
Message-ID: <CAL_Jsq+e72nW7PatD3H-OLC5aQ9Y_PmmMqrnCk6dk-SdHkmtYA@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>, Thierry Escande <thierry.escande@linaro.org>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 20, 2018 at 5:33 AM, Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
> Hi Rob,
>
> please find my comments inline.
>
> On 2018-06-18 18:59, Rob Herring wrote:
>>
>> On Sat, Jun 16, 2018 at 12:27 AM, Balakrishna Godavarthi
>> <bgodavar@codeaurora.org> wrote:
>>>
>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

[...]

>>> -Example:
>>> + - vddpa-supply: Bluetooth VDD PA regulator handle
>>> + - vddio-supply: Bluetooth VDD IO regulator handle
>>> + - vddldo-supply: Bluetooth VDD LDO regulator handle. Kept under
>>> optional
>>> +                 parameters as some of the chipsets doesn't require ldo
>>> or
>>> +                 it may use from same vddio.
>>
>>
>> You need to be explicit as to which properties apply or don't apply to
>> specific compatible strings.
>>
>
> [Bala]: will update.
>
>> Supplies should be based on inputs to the chip, so if 1 regulator
>> supplies 2 inputs you still need both.
>>
> [Bala]:  sorry i did't get you, all these regulators are single output line
> regulators.
>          i.e. <supply-name>- supply, need single regulator input as a
> handle.
>          and these line regulators generate fixed voltage output.
>          please let me know, if i have cleared your query

I was referring to "it may use from same vddio". If you mean vddldo is
left disconnected, then omitting the property is fine. If you mean
vddio and vddldo are connected to the same regulator, then you should
have both properties in the binding.

Rob
