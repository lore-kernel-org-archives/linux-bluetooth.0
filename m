Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Remove platform_device support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
References: <20180121214645.15004-1-hdegoede@redhat.com>
 <0EA71635-F2C7-4908-B4DE-F87328A148D0@holtmann.org>
 <769dd32b-425e-3002-50b5-0d3c707706d4@redhat.com>
 <1516614127.7000.1152.camel@linux.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <0160ba20-9dc9-9921-ab12-3ac58b33e9ae@redhat.com>
Date: Mon, 22 Jan 2018 12:27:27 +0100
MIME-Version: 1.0
In-Reply-To: <1516614127.7000.1152.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 22-01-18 10:42, Andy Shevchenko wrote:
> On Mon, 2018-01-22 at 09:23 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 22-01-18 03:24, Marcel Holtmann wrote:
>>> Hi Hans,
>>>
>>>> Now that ACPI and DT devices are both enumerated as serdevs, we
>>>> can
>>>> remove platform_device support and the bcm_device_list lookup
>>>> hack.
>>>>
>>>> This also removes any races between suspend/resume and hci-uart
>>>> binding,
>>>> also making the suspend/resume code a lot simpler.
>>>>
>>>> This commit leaves manually binding to an uart using btattach
>>>> supported
>>>> (without irq/gpio and thus suspend/resume support, as before).
>>>>
>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> drivers/bluetooth/hci_bcm.c | 260 +++++---------------------------
>>>> ------------
>>>> 1 file changed, 28 insertions(+), 232 deletions(-)
>>>
>>> so I was under the assumption platforms like Intel Edison still only
>>> do platform data. See commit
>>> 212d71833315c65644efc46223db61dee7b3c68e. Has that changed?
> 
> Yes and no.
> 
> So, we need that support to satisfy users with classical Edison
> firmware.
> 
>> Ugh, I was not aware of that and the whole code to match the tty with
>> the platform_device on btattach is such a mess and I was actually
>> quite
>> happy to be able to delete this.
> 
> Good idea.
> 
>> Andy, I see that you added support for bcm bluetooth over a tty using
>> platform_data instead of ACPI enumeration. Can you change the code
>> instantiating the device to instead instantiate a serdev, so that we
>> kill the platform device support in hci_bcm.c and so that users don't
>> need to do a btattach, but instead the kernel will do the attach
>> itself
>> and things will just work ?
> 
> I'm sorry, I can't do this soon, other more priority tasks in a pocket.
> 
> The instantiation of the driver is happened in arch/x86/platform/intel-
> mid/device_libs/platform_bt.c
> 
> I would help with review of any patches till I would able to look at it
> myself.

If I manage to come up with patches do you have hardware and time to
test?

First point of order to get this working as serdev I think is to
modify drivers/tty/serdev/core.c a and then the serdev_controller_add()
function to somehow recognize the serial port in question, so
something akin to the of_serdev_register_devices(ctrl) /
acpi_serdev_register_devices(ctrl) functions for platform_devs, assuming
the tty-parent-dev on the Edison SOM is a platform_dev ?

Anyways it looks like this will be really hard to do without access
to the hardware.

Regards,

Hans
