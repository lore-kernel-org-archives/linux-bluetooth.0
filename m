Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
To: Johan Hovold <johan@kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Gustavo F. Padovan"
 <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Tobias Regnery
 <tobias.regnery@gmail.com>,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20171011134640.3152236-1-arnd@arndb.de>
 <20171011134805.3207569-1-arnd@arndb.de>
 <ff49535c-61e1-f6da-8b2c-490dc55d5982@redhat.com>
 <C156D266-F58A-4A4E-986E-17B003BE5A37@holtmann.org>
 <8fc95eba-5ede-0451-6a05-bcf394a1f632@redhat.com>
 <0E9ED850-8F65-498C-A4EB-D3413E25CFF7@holtmann.org>
 <20171013100951.GC17356@localhost>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <fdea61a1-b072-4716-91f5-35f5b8815a6a@redhat.com>
Date: Fri, 13 Oct 2017 12:58:40 +0200
MIME-Version: 1.0
In-Reply-To: <20171013100951.GC17356@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 13-10-17 12:09, Johan Hovold wrote:
> On Thu, Oct 12, 2017 at 10:40:29AM +0200, Marcel Holtmann wrote:
>> Hi Hans,
>>
>>>>>> It is no longer possible to build BT_HCIUART into the kernel
>>>>>> when SERIAL_DEV_BUS is a loadable module, even if none of the
>>>>>> SERIAL_DEV_BUS based implementations are selected:
>>>>>> drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
>>>>>> hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
>>>>>> hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'
>>>>>> This adds a dependency to avoid the broken configuration.
>>>>>> Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
>>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>>>
>>>>> Another one I have on my TODO after the buildbot errors. In this case
>>>>> I do not believe this is the proper fix though.
>>>>>
>>>>> As pointed out in another thread discussing the series introducing
>>>>> this problem, hci_ldisc.c really should not depend on serdev,
>>>>> so the proper fix would be to have hci_bcm.c directly call
>>>>> the serdev flowcontrol and rts functions when the hci is
>>>>> backed by a serdev device, like hci_bcm.c is already doing
>>>>> when setting the baudrate, see host_set_baudrate in hci_bcm.c,
>>>>> so a similar host_set_flow_control should be added after which
>>>>> the changes to hci_ldisc.c can be reverted.
>>>>>
>>>>> If I understood Marcel correctly he prefers a single patch
>>>>> fixing this which also removes the changes from hci_ldisc.c,
>>>>> rather then a separate revert.
>>>> actually two patches is fine, but I want them as a patch series so
>>>> they are applied in a row. I think best is first to revert the
>>>> btusb.c changes and then apply the new ACPI PNP id.
>>>
>>> This is actually about a different series, but I assume the same
>>> applies for both series.
>>>
>>> My remark here was not about the btusb 0000:0000 USB ids handling +
>>> ACPI PNP ids, but about fixing hci_ldisc.c now depending on
>>> serdev.
>>>
>>> So since you now have accepted Arnd patch making hci_ldisc.c now
>>> depending on serdev more or less official (which I'm fine with),
>>> can I assume that this is going to be the final (for now / for 4.15)
>>> state of the deps situation surrounding hci_ldisc.c ?
>>>
>>> The reason I'm asking this is because my plan was to undo the
>>> changes introducing the hci_ldisc.c dependency on serdev and
>>> instead adding a host_set_flow_control helper to hci_bcm.c,
>>> so have hci_bcm.c directly call the serdev flowcontrol funcs
>>> instead of having it depend on hci_ldisc.c for this in the
>>> same way as it is already directly calling
>>> serdev_device_set_baudrate.
>>>
>>> If we are going to let hci_ldisc.c deal with tty vs serdev
>>> backed devices for flowcontrol, it makes sense to do the
>>> same for baudrate and make it save to call hci_uart_set_baudrate
>>> on a serdev backed hci_uart and drop the host_set_baudrate
>>> helper from hci_bcm.c. I can write and test a patch for this ...
>>>
>>> Either way let me know how you want to proceed. I will let
>>> this rest until I hear back from you.
>>
>> what we have currently in bluetooth-next is something that I am
>> planning to push into net-next and with that 4.15. I have not heard
>> any complaints so far and it has been baking for a while now. So yes,
>> lets remove the USB 0000:0000 device support and move them over to
>> UART serdev devices.
> 
> So, again, this doesn't seem to have anything to do with that btusb
> patch, but rather a new dependency that was added by the following
> commit by Hans from last week:
> 
> 	7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL
> 	               deref when using serdev")
> 
>> For flow control and baud rate handling, I am open for proposals to
>> simplify this or streamline it into something cleaner. I think the
>> goal should be to move towards enabling more devices for serdev
>> operation. As I mentioned the other day, there are ACPI described
>> Intel and Realtek Bluetooth controllers as well. So there is some work
>> to be done here.
>>
>> We need to keep basic btattach functionality working since in some
>> cases that is required for development boards that come via USB-UART
>> bridges. But I think he main interface should be serdev now.
>>
>> I think what we should figure out is if serdev based drivers need any
>> hci_ldisc.c infrastructure at all or if they be better separated out
>> into individual drivers. Not sure we have to make that call for 4.15
>> kernel.
> 
> Yes, and that's how things were implemented when hci_serdev.c was added.
> To some extent code was copied and duplicated from hci_ldisc.c in order
> not to depend on those helpers, but now with the above mentioned commit
> we have a serdev driver calling into the old line-discipline code, which
> then only calls into the hci-serdev implementation again.
> 
> I mentioned this when I reviewed the patch in question, but at that
> point it had already been applied.
> 
> It seems to me like effectively reverting the above mentioned commit in
> favour of small helper in hci_bcm is the right thing to do short term
> (i.e. handle it as we handle set_baudrate).
> 
> Perhaps later someone can revisit the decision to keep two separate
> implementations (hci_serdev.c and hci_ldisc.c) and see what can be done
> about code reuse in order to simplify for hci-drivers wanting to support
> both interfaces.

As indicated I would be happy to provide (and test on my hw) patches
for this. I'm fine with leaving things as is too (although I agree that
is somewhat inconsistent).

Anyways I will go and prepare (and test) a new version of the btusb
0000:0000 revert + new ACPI pnp series as Marcel has asked for.

Regards,

Hans
