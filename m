Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <55919023.200@broadcom.com>
References: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com>
 <1434576658-20730-2-git-send-email-ifaenson@broadcom.com> <E0D3336E15B58B4294723AC879BA5E942634F2@IRVEXCHMB15.corp.ad.broadcom.com>
 <CAL_JsqK9kup3sm3qgDLqtT8ajrN1ee6zfXwOoZqoq9cXQNwE_w@mail.gmail.com>
 <E0D3336E15B58B4294723AC879BA5E94263E58@IRVEXCHMB15.corp.ad.broadcom.com>
 <CAL_JsqJAUTjNehtr_Af93k71mdSREb9pLMoSyDTm1S42VkA2sQ@mail.gmail.com>
 <E0D3336E15B58B4294723AC879BA5E942640A3@IRVEXCHMB15.corp.ad.broadcom.com>
 <CAL_JsqJKyj8sDwG82jb_CzXEDBN8aznR7eF5yTOiWruW8o3cng@mail.gmail.com>
 <55844C1E.8020301@broadcom.com> <CAL_JsqLr7JZ9=i2XuWR0_FZDyxpDRwDS5dkSpzjKA-8V=-mpOw@mail.gmail.com>
 <55846B7D.1060601@broadcom.com> <55919023.200@broadcom.com>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 2 Jul 2015 13:26:03 -0500
Message-ID: <CAL_JsqJM_1VpxvRz6XCS8tA7Vfn33sV4RjquAAcAqAADnoeb=w@mail.gmail.com>
Subject: Re: FW: [PATCH v4 1/4] Broadcom Bluetooth UART Device Tree bindings
To: Arend van Spriel <arend@broadcom.com>, Grant Likely <grant.likely@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Ilya Faenson <ifaenson@broadcom.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

+ a few more DT maintainers (and frequent reviewers) as this is a
common issue only affecting every single mobile platform.

On Mon, Jun 29, 2015 at 1:36 PM, Arend van Spriel <arend@broadcom.com> wrote:
> On 06/19/15 21:20, Arend van Spriel wrote:
>>
>> On 06/19/15 20:49, Rob Herring wrote:
>>>
>>> On Fri, Jun 19, 2015 at 12:06 PM, Arend van Spriel<arend@broadcom.com>
>>> wrote:
>>>>
>>>> On 06/19/15 17:47, Rob Herring wrote:
>>>>>
>>>>>
>>>>> On Thu, Jun 18, 2015 at 3:37 PM, Ilya Faenson<ifaenson@broadcom.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> Hi Rob.
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: linux-bluetooth-owner@vger.kernel.org
>>>>>> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Rob
>>>>>> Herring
>>>>>> Sent: Thursday, June 18, 2015 3:41 PM
>>>>>> To: Ilya Faenson
>>>>>> Cc: marcel@holtmann.org; Arend Van Spriel; devicetree@vger.kernel.org;
>>>>>> linux-bluetooth@vger.kernel.org
>>>>>> Subject: Re: FW: [PATCH v4 1/4] Broadcom Bluetooth UART Device Tree
>>>>>> bindings
>>>>>>
>>>>>> On Thu, Jun 18, 2015 at 1:54 PM, Ilya Faenson<ifaenson@broadcom.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>> Hi Rob,
>>>>>>
>>>>>>
>>>>>>
>>>>>> Your emails are base64 encoded. They should be plain text for the
>>>>>> list.
>>>>>>
>>>>>> IF: The Outlook is configured to respond in the sender's format. I
>>>>>> therefore respond in the encoding you've used.
>>>>>
>>>>>
>>>>>
>>>>> I assure you that that is not the case or I would be banished from
>>>>> lists by now. Outlook is generally incapable of correctly sending
>>>>> mails to lists. The reply header above is one aspect of that. The
>>>>> other problem is your replies don't get wrapped and prefixed properly.
>>>>> That could be my client I guess, but *all* other mails are fine.
>>>>>
>>>>> My sent mails have:
>>>>>
>>>>> Content-Type: text/plain; charset=UTF-8
>>>>> Content-Transfer-Encoding: quoted-printable
>>>>>
>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Rob Herring [mailto:robherring2@gmail.com]
>>>>>>> Sent: Thursday, June 18, 2015 11:03 AM
>>>>>>> To: Ilya Faenson
>>>>>>> Cc: marcel@holtmann.org; Arend Van Spriel;
>>>>>>> devicetree@vger.kernel.org;
>>>>>>> linux-bluetooth@vger.kernel.org
>>>>>>> Subject: Re: FW: [PATCH v4 1/4] Broadcom Bluetooth UART Device Tree
>>>>>>> bindings
>>>>>>>
>>>>>>> On Wed, Jun 17, 2015 at 6:11 PM, Ilya Faenson<ifaenson@broadcom.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> + devicetree lists
>>>>>>
>>>>>>
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>> diff --git
>>>>>>>> a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>>>>>>>> b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..5dbcd57
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>>>>>>>> @@ -0,0 +1,86 @@
>>>>>>>> +btbcm
>>>>>>>> +------
>>>>>>>> +
>>>>>>>> +Required properties:
>>>>>>>> +
>>>>>>>> + - compatible : must be "brcm,brcm-bt-uart".
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> You need to describe the chip, not the interface.
>>>>>>>
>>>>>>> IF: This driver is for all Broadcom Bluetooth UART based chips.
>>>>>>
>>>>>>
>>>>>>
>>>>>> BT only chips? Most/many Broadcom chips are combo chips. I understand
>>>>>> the driver for BT is *mostly* separate from other chip functions like
>>>>>> WiFi, GPS and NFC, but the h/w is a single chip. I say most because
>>>>>> likely there are some parts shared: a voltage rail, reset line, or
>>>>>> power down line. I think some can do BT over the SDIO interface too,
>>>>>> so the interface may be shared. The DT is a description of the h/w
>>>>>> (i.e. what part # for a chip) and not a driver data structure. You
>>>>>> need to describe the whole chip in the binding. It is a Linux problem
>>>>>> if there needs to be multiple separate drivers.
>>>>>>
>>>>>> IF: Defining complete DT description for the Broadcom combo chips for
>>>>>> multiple interfaces is well beyond the scope of what I am doing. I
>>>>>> just need
>>>>>> to define a DT node for the input and output GPIOs connected to the
>>>>>> BT UART
>>>>>> chip. BT may or may not be part of the combo chip: it does not
>>>>>> really matter
>>>>>> for this exercise. I thought I would take this opportunity to place
>>>>>> some BT
>>>>>> device parameters into that node as well. If you're not comfortable
>>>>>> with
>>>>>> this, I could just call it a "GPIO set" to avoid mentioning BT and
>>>>>> UART at
>>>>>> all but it would make little sense. Still, I could consider it.
>>>>>> Would you
>>>>>> have "GPIO set" recommendations? Alternatively, NFC Marvell code
>>>>>> you're
>>>>>> referring to has parameters configured as Linux module parameters.
>>>>>> I could
>>>>>> do the same too, avoiding this device tree discussion. Let me know.
>>>>>>
>>>>>
>>>>> I don't completely follow what you mean by "GPIO set", but I'm
>>>>> guessing that is not the right path.
>>>>>
>>>>>> Generally speaking (pontification hat on :-)), what you're trying
>>>>>> to do
>>>>>> (description of the whole chip) is well beyond what say ACPI has
>>>>>> done (I was
>>>>>> involved some in the BT ACPI exercise a few years ago). BT UART
>>>>>> interface is
>>>>>> described in ACPI independently of other parts of the same combo chip.
>>>>>> Requirements like that slow down the DT development in my opinion as
>>>>>> companies are understandably reluctant to work with unrealistic
>>>>>> goals. End
>>>>>> of pontification. :-)
>>>>>>
>>>>>
>>>>> ACPI and DT are very different models in terms of abstraction and
>>>>> governance. I'm not going to hash through all the details.
>>>>>
>>>>> I'm not necessarily saying we have to have a single node, but that is
>>>>> my default position. You have convince me that the functions are
>>>>> completely independent and I cannot judge that if you are completely
>>>>> ignoring the WiFi part. From Broadcom chips I've worked with, the
>>>>> supplies at least are shared (something ACPI does not expose). Perhaps
>>>>> we could fudge that and just require the same supply has to be
>>>>> connected to each half. I still worry there could be other internal
>>>>> inter-dependencies. Perhaps BT requires the SDIO clock to be active or
>>>>> something like that. Maybe not on Broadcom chips, but on other vendors
>>>>> and I have to care about them all.
>>>>
>>>>
>>>>
>>>> All Broadcom combo chips that I know of have separate supplies, ie.
>>>> wl-reg-on and bt-reg-on. There already is a binding present for the wifi
>>>
>>>
>>> GPIOs are not supplies. For the module I'm working with (43340 based)
>>> there is a single VDDIO and VBAT supplies which are shared. Now
>>> whether the module or the chip are tying things together, I don't
>>> know. There is also a 32kHz clock input. Is that part of WiFi or BT?
>>
>>
>> True and I see where you are going here. The 32kHz clock is input for
>> low-power oscillator in the chip. That LPO provides clock for the
>> interconnect in the chip so it is not part of wifi nor bt.

We could handle this by routing clocks and regulators to every sub
node. A device with a shared GPIO (or any resource without
refcounting) would be a problem. Perhaps this is good enough. This
seemed to be the conclusion on earlier discussions[1].

Primarily, I just want to see the whole chip considered and thought
around any complications from shared resources. We can't just do the
easy part now and ignore the hard parts that cause changes later.

I'm not sure how we would handle a shared reset line. Perhaps the
first one to claim it wins control.

> Hi Rob,
>
> Haven't seen much follow up so how to move forward here.

Sorry, been (and still am) out on vacation.

> We could go for a
> devicetree node covering all functional entities on the device. However, we
> are making the chipset and users more often as not end up with a module that
> some manufacturer cooked up. So whether signals are optional or not is hard
> to say for us. Making them optional by default seems safest.
>
> So could something like below work? Just wanted to know your opinion before
> moving in that direction.

It does have the advantage of having the full chip described in one
place, but there are some issues.

> bcm43341: {
>         compatible: 'brcm,bcm43340';
>         brcm,lpo-clock: <&32khz_clk>;

What driver would handle this and instantiate the sub devices? An MFD driver?

If we place all the child nodes under their respective hosts and had a
chip/module level node separately, we would then potentially have
probe ordering issues (probably solvable though).

>         :
>         brcm_wifi: {
>                 compatible: "brcm,bcm4329-fmac";
>                 wifi-port: <&mmc3>;

This should be something generic like "mmc-parent".

This is a departure from how the wifi part is currently done. We could
take the stance that since there are no dts files actually using the
binding, we can change it breaking compatibility (if not upstream it
doesn't exist). Or we need to maintain both. Other combo chips such as
TI have the WiFi portion under SDIO host node.

The other issue potentially is does the SDIO host need to be able to
find the children easily. I think the power on the chip first so the
SDIO host can detect it issue is one example. We also have no way to
define which SDIO function this is. Putting the reg property here
would not make sense. So perhaps the phandle needs to go the other way
around having an mmc sub-node point to here.

So I think we need to keep the SDIO child node.

>                 :
>         }
>         brcm_bt: {
>                 compatible: "brcm,bcm43xx-bt-uart";
>                 bt-port: <&uart1>;

This should also be a generic name such as "uart". This needs to be
settled at wider scope of how we describe UART slave devices. It seems
to be a popular topic recently with yet another posting in the last
few days[2].

Thinking about different potential options now for a few hours, I
think we should just continue with having separate nodes for each
function under the respective host interface. The complicated cases
may just have to be solved with code rather than DT bindings.

Rob

>                 :
>         }
>         brcm_nfc: {
>                 compatible: "brcm,bcm43340-nfc";
>                 nfc-port: <&uart2>;
>                 :
>         }
> }
>

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/226343.html
[2] http://www.spinics.net/lists/linux-serial/msg18034.html
