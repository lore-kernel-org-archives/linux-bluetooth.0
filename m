Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs8LvwCGo_iKcd5szvHZ-QJkiyobwBv5aSN4P_xOHsdyVA@mail.gmail.com>
References: <20170920074417.30435-1-luiz.dentz@gmail.com> <20170920074417.30435-7-luiz.dentz@gmail.com>
 <CALvjcs-THH_Mmuvj7TGDdJOSuhCqPWOPAfCfon=ady8oJ=vCCQ@mail.gmail.com>
 <CABBYNZ+DNnr8KkSQzKrEnbZjdEmbDC47hrO7VQ185+mOwuOn3g@mail.gmail.com>
 <CALvjcs9PLGbPEqN3oz9ndJnBz57Ymiw0mWAF++SSEV1ChNT_hA@mail.gmail.com>
 <CABBYNZJQKWRMGtgUfCYJmDzn7VFh6dmR7GpiyUk7HHOTtR-wCA@mail.gmail.com>
 <CALvjcs8MiNMcEfcOi3in_td7VBJbA-nE-wcZhcEz7VDFwdZR+A@mail.gmail.com>
 <CABBYNZLvomAGYvvtm1HzGSPiLPYOCAnX3R6kjsq3GPQzO9EcjQ@mail.gmail.com> <CALvjcs8LvwCGo_iKcd5szvHZ-QJkiyobwBv5aSN4P_xOHsdyVA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Oct 2017 14:57:40 +0300
Message-ID: <CABBYNZK1EhXevECEiFfpa+4+d_ViQrw=6=4w1rgNCa6xQzohpQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] gatt: Implement AcquireWrite for server
To: Yunhan Wang <yunhanw@nestlabs.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Sat, Sep 30, 2017 at 6:39 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
> Hi, Luiz
>
> On Fri, Sep 29, 2017 at 1:02 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Yunhan,
>>
>> On Fri, Sep 29, 2017 at 10:50 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
>>> Hi, Luiz
>>>
>>> I see. Great! Thanks for your explanation.
>>
>> Please comment inline on the list.
>>
>>> Maybe it is good to have both solutions in current bluez?
>>> 1. AcquireWrite, write data passing via fd, mtu passing by DBUS, we
>>> can take advantage of fd under high load.
>>> 2. Write, write data and mtu passing over DBUS, we still can fully use
>>> DBUS under low load.
>>
>> Well that is actually a 3 type of transfer since regular WriteValue
>> already exists which defeat a little bit the purpose of WriteAcquired
>> since we can no longer determine if the server supports fd mode or
>> not, I think it is too much and the server has to either to decide if
>> unfragmented D-Bus transfer is fine is not, if not then fd passing
>> shall be the only mechanism.
>>
> I agree, it is three type of transfer,
> regular write,
> regular write with mtu support(application is responsible for packet
> fragmentation)
> fd with pipe (application is responsible for packet fragmentation),

There is no advantage on having to call AcquireWrite and then _not_
use the fd but WriteValue, so IMO it makes no sense to offer something
that has no benefit.

> now we have two kind of transfer(regular write, acquire write) in
> code, add third one is pretty straightforward and only small code
> change.
>
> I read two articles(https://blogs.gnome.org/abustany/2010/05/20/ipc-performance-the-return-of-the-report/,
> https://lists.freedesktop.org/archives/dbus/2014-October/016363.html),
> I agree that fd with pipe is more efficent, and eliminate several
> copy, and benefit for byte streaming although there is minor
> vulnerability mentioned in above article,  I hope engineer in
> peripheral application can still have another choice, regular write
> with mtu, when traffic is low or it is experiment purpose. Considering
> these are pretty similar, easy to integrate, engineer still can easily
> switch them between fd with pipe and regular write.

Regular D-Bus WriteValue and fd passing via AcquireWrite do cover all
cases... too many choices is actually a bad thing to an API as it
increases the complexity of the code and number of bugs, so normally
we target to have as little APIs as possible.

>> Considering how easy it was to add support for fd passing on the
>> bluetoothctl I don't thing it is that big of deal really, or there is
>> something else preventing this to happen in your end?
>>
> Yes, fd passing is pretty easy and efficent, it is not big deal to
> integrate it, using this way, in my end, for gatt write with response
> from central to peripheral, I can see written value and length in
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/gatt.c#n688,
> but I cannot see any response back for GATT write from peripheral to
> central. It seems this only support GATT write without response even
> though I have removed the check
> here(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/gatt.c#n1360).
> Any idea?
>
> In contrast, for regular WriteValue, I can see write response  from
> peripheral to central.

Ive sent a fix for this, the responses shall be generated with either
WriteValue or fd write, though we the later we assume that if the data
could be written to the pipe then it should be okay to reply right
there while with WriteValue we actually wait for the reply (adds
latency).

>>> which means the only light change is to add mtu passing over DBUS in 2. Write
>>>
>>> Finally both solutions can be available to bluez users.
>>>
>>> Thanks
>>> Best wishes
>>> Yunhan
