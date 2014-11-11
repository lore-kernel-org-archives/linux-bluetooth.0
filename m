Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8C1145D9-B0F5-4241-A3FC-07BA0519F0A5@holtmann.org>
References: <8C1145D9-B0F5-4241-A3FC-07BA0519F0A5@holtmann.org>
Date: Tue, 11 Nov 2014 13:16:37 -0800
Message-ID: <CAGXr9JG5uz-OC_NqNnAyHgsmuf7bE=j4scsoW43_FaEXp95Vuw@mail.gmail.com>
Subject: Re: Issue with Broadcom firmware loading
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Nov 8, 2014 at 12:28 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Petri,
>
> seems there is a race condition with the Broadcom firmware loading during early boot. This might well be a Broadcom USB issue with its string descriptors. For some reason the USB product ID string is initially "BCM920702 Bluetooth 4.0" as seen here:
>
> [    2.907838] usb 2-2.1: new full-speed USB device number 4 using uhci_hcd
> [    3.568156] usb 2-2.1: New USB device found, idVendor=0a5c, idProduct=21e8
> [    3.568161] usb 2-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    3.568163] usb 2-2.1: Product: BCM920702 Bluetooth 4.0
> [    3.568165] usb 2-2.1: Manufacturer: Broadcom Corp
>

Is this log after warm reboot? If yes, the device most likely already
runs hci_rev=153a firmware from previous boot, which is the likely
cause for changed product string.

> [    6.575208] bluetooth hci0: Direct firmware load for brcm/BCM920702 Bluetooth 4.0-0a5c-21e8.hcd failed with error -2
> [    6.575212] Bluetooth: hci0: BCM: patch brcm/BCM920702 Bluetooth 4.0-0a5c-21e8.hcd not found
>
> And after an unplug and replug, the USB product ID string is actually "BCM20702A0":
>
> [ 1322.414265] usb 2-2.1: new full-speed USB device number 5 using uhci_hcd
> [ 1323.040405] usb 2-2.1: New USB device found, idVendor=0a5c, idProduct=21e8
> [ 1323.040409] usb 2-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [ 1323.040411] usb 2-2.1: Product: BCM20702A0
> [ 1323.040413] usb 2-2.1: Manufacturer: Broadcom Corp
>

When the device is just plugged in and powered up, it will be running
hci_rev=1000 (default) firmware and thus reports itself as BCM20702A0.

> [ 1323.103119] Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=1000 lmp_ver=06 lmp_subver=220e
> [ 1323.906487] Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=153a lmp_ver=06 lmp_subver=220e
>
> If the USB product ID string is changing depending on if it is early boot or later, then this code is of course problematic:
>
>         snprintf(fw_name, sizeof(fw_name), "brcm/%s-%04x-%04x.hcd",
>                  udev->product ? udev->product : "BCM",
>                  le16_to_cpu(udev->descriptor.idVendor),
>                  le16_to_cpu(udev->descriptor.idProduct));
>

We could certainly drop the use of udev->product here and go with
something more generic like: BCM-BT-%04x-%04x.hcd

> I am running this on 3.17.1 kernel and wonder if something changed in the USB stack or if I have never noticed this so far.
>

I am running 3.16 kernel and don't see this. The BCM firmware patch
works every time, whether it is warm reboot or full power cycle. I
don't have the option to hotplug the device.

The device:
Bus 005 Device 002: ID 0a5c:22be Broadcom Corp. BCM2070 Bluetooth 3.0 + HS

Firmware file:
/lib/firmware/brcm/BCM20702A0-0a5c-22be.hcd

On full power cycle, log shows:
[   12.811000] Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=1000
lmp_ver=06 lmp_subver=220e
[   13.646000] Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=16b0
lmp_ver=06 lmp_subver=220e

On warm reboot, log shows:
[   12.305000] Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=16b0
lmp_ver=06 lmp_subver=220e
[   13.134000] Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=16b0
lmp_ver=06 lmp_subver=220e

Could you try 3.16 kernel in your setup and see if you can still reproduce?

-- Petri

> Regards
>
> Marcel
>
