Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
To: Marcel Holtmann <marcel@holtmann.org>
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
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8fc95eba-5ede-0451-6a05-bcf394a1f632@redhat.com>
Date: Thu, 12 Oct 2017 10:27:01 +0200
MIME-Version: 1.0
In-Reply-To: <C156D266-F58A-4A4E-986E-17B003BE5A37@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11-10-17 20:10, Marcel Holtmann wrote:
> Hi Hans,
> 
>>> It is no longer possible to build BT_HCIUART into the kernel
>>> when SERIAL_DEV_BUS is a loadable module, even if none of the
>>> SERIAL_DEV_BUS based implementations are selected:
>>> drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
>>> hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
>>> hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'
>>> This adds a dependency to avoid the broken configuration.
>>> Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Another one I have on my TODO after the buildbot errors. In this case
>> I do not believe this is the proper fix though.
>>
>> As pointed out in another thread discussing the series introducing
>> this problem, hci_ldisc.c really should not depend on serdev,
>> so the proper fix would be to have hci_bcm.c directly call
>> the serdev flowcontrol and rts functions when the hci is
>> backed by a serdev device, like hci_bcm.c is already doing
>> when setting the baudrate, see host_set_baudrate in hci_bcm.c,
>> so a similar host_set_flow_control should be added after which
>> the changes to hci_ldisc.c can be reverted.
>>
>> If I understood Marcel correctly he prefers a single patch
>> fixing this which also removes the changes from hci_ldisc.c,
>> rather then a separate revert.
> 
> actually two patches is fine, but I want them as a patch series so they are applied in a row. I think best is first to revert the btusb.c changes and then apply the new ACPI PNP id.

This is actually about a different series, but I assume the same
applies for both series.

My remark here was not about the btusb 0000:0000 USB ids handling +
ACPI PNP ids, but about fixing hci_ldisc.c now depending on
serdev.

So since you now have accepted Arnd patch making hci_ldisc.c now
depending on serdev more or less official (which I'm fine with),
can I assume that this is going to be the final (for now / for 4.15)
state of the deps situation surrounding hci_ldisc.c ?

The reason I'm asking this is because my plan was to undo the
changes introducing the hci_ldisc.c dependency on serdev and
instead adding a host_set_flow_control helper to hci_bcm.c,
so have hci_bcm.c directly call the serdev flowcontrol funcs
instead of having it depend on hci_ldisc.c for this in the
same way as it is already directly calling
serdev_device_set_baudrate.

If we are going to let hci_ldisc.c deal with tty vs serdev
backed devices for flowcontrol, it makes sense to do the
same for baudrate and make it save to call hci_uart_set_baudrate
on a serdev backed hci_uart and drop the host_set_baudrate
helper from hci_bcm.c. I can write and test a patch for this ...

Either way let me know how you want to proceed. I will let
this rest until I hear back from you.

Regards,

Hans
