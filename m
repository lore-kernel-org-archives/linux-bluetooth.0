Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAvkfd8izSkCW7-1a_PedkY9Ceo+eDOK3V-Kxz63fR5DGaVHFQ@mail.gmail.com>
References: <CAAvkfd_baAUHfnO9JX3h2rc4BYQBzjBeWqf2tiGBMJQMG2yseA@mail.gmail.com>
 <CAOT_U5bOS63BbqoyLPhTQ_z4ve0u+obLFg8HENyMYxik00+oWA@mail.gmail.com> <CAAvkfd8izSkCW7-1a_PedkY9Ceo+eDOK3V-Kxz63fR5DGaVHFQ@mail.gmail.com>
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Thu, 29 Mar 2018 17:59:27 +0200
Message-ID: <CAOT_U5abUJeZuB4-e1T1qQF82rk4W07HVGBN0hPLVqC6TJCJbg@mail.gmail.com>
Subject: Re: Support adapter without HCI
To: David Frey <dpfrey@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> There is a closed source BLE library that
exposes GATT and GAP functions.

Can you expand on the definition on "exposes" here?
>From where to whom?


On Thu, Mar 29, 2018 at 5:38 PM, David Frey <dpfrey@gmail.com> wrote:
> Hi,
>
> I'm sorry if I was unclear. What I would like it to be able to write
> application code for Linux that uses bluez to talk to BLE devices
> connected to a bluetooth adapter.  The thing that I think might be
> problematic is fitting the adapter into the Linux kernel framework for
> bluetooth adapters.  The SoC that I want to use as an adapter does not
> present an HCI interface.  There is a closed source BLE library that
> exposes GATT and GAP functions.  So my question is really whether it
> is possible to support an adapter in the linux kernel that doesn't
> support HCI and if it is, are there any examples of drivers like that?
>
> If this is *not* possible, then I will probably have to define a
> non-standard interface (outside of bluez) for controlling the
> bluetooth feature of the chip.  That's really not ideal since any code
> that users write won't be portable to other adapters.  I guess I could
> try to implement the same DBus interfaces that are provided by Bluez,
> but this is definitely not my first choice.
>
> Thanks,
> David
>
> On Thu, Mar 29, 2018 at 1:10 AM, Alan Martinovic
> <alan.martinovic@senic.com> wrote:
>> Hi,
>> I didn't get through you question what are the actual commands
>> that are being passed via SPI to the controller once HCI has been removed?
>>
>> You want to use the API provided by the library on the controller and invoke it
>> directly from the host via SPI?
>>
>> I saw something kind of similar from Nordic:
>>     https://github.com/NordicSemiconductor/pc-ble-driver
>>
>> Would be willing to bet that they just invented something
>> that replaces HCI, but it's still a intermediate protocol that glues
>> together the host and controller, can't see how that can be avoided.
>>
>> Be Well,
>> Alan
>>
>>
>>
>>
>>
>> On Wed, Mar 28, 2018 at 8:02 PM, David Frey <dpfrey@gmail.com> wrote:
>>> Is it possible to support a bluetooth adapter in the Linux kernel in
>>> the case where the adapter doesn't present a HCI interface?  The
>>> adapter in question was originally envisioned as a standalone host,
>>> but I am interested in using it as an adapter (over SPI) controlled by
>>> another CPU running Linux.  The BLE implementation on the target is a
>>> closed source binary that provides GAP and GATT APIs.  Details of the
>>> APIs are here: http://labs.mediatek.com/api/mt7697/group___bluetooth.html
>>>
>>> If it *is* possible to support adapters which don't offer an HCI
>>> interface, then I'm hoping that someone can point me at an example or
>>> an interface definition so I can get an idea of what is required.
>>>
>>> Thanks,
>>> David
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
