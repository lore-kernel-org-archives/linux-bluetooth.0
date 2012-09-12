Return-Path: <cyrus@holtmann.org>
Message-ID: <5050644F.5040902@ti.com>
Date: Wed, 12 Sep 2012 13:30:39 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>,
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 02/10] battery: Implement Generic device battery
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com> <1347349100-24228-3-git-send-email-chen.ganir@ti.com> <CAAngNMbUQzxAdwo2JUjzrqkLGXFhpyRVqtz03u+3t3nfXcyxpg@mail.gmail.com> <50501416.90408@ti.com> <20120912084537.GA31700@x220.P-661HNU-F1>
In-Reply-To: <20120912084537.GA31700@x220.P-661HNU-F1>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

On 09/12/2012 11:45 AM, Johan Hedberg wrote:
> Hi Chen,
>
> On Wed, Sep 12, 2012, Chen Ganir wrote:
>>> Since this symbol is being exported, shouldn't it be prefixed with
>>> btd_ as well?
>>>
>> I will rename it to struct btd_battery. Is that ok ?
>
> Yes.
>
Thanks.

>>
>>>> +typedef void (*RefreshBattFunc) (struct device_battery *batt);
>>>
>>> I don't think we use CamelCase for anything other than D-Bus method names.
>>>
>> We use it in gattrib.h for function pointers. What is the correct
>> convention for function pointers ? same as in adapter_ops ?
>>
>>>> +
>>>> +typedef enum {
>>>> +       BATTERY_OPT_INVALID = 0,
>>>> +       BATTERY_OPT_LEVEL,
>>>> +       BATTERY_OPT_REFRESH_FUNC,
>>>> +} BatteryOption;
>>>
>>> Fix CamelCase usage here and on uses of this type as well.
>>>
>> btio.h also uses this convention. What should be the correct convention ?
>
> Both BtIO and GAttrib intend to mimic GLib-like libraries where this is
> the convention. The plan is not to let this spread to the entire code
> base (particularly with the likely move to libell in the long run), so
> please don't use CamelCase.
>
Ok. So for the battery options i'll simply change it to battery_option. 
What about the convention for defining a function pointer ?


> Johan
>


-- 
BR,
Chen Ganir
Texas Instruments
