Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Add support for BCM2E7E
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20170907202551.26796-1-hdegoede@redhat.com>
 <20170907202551.26796-2-hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <aab461af-601b-70c3-f79e-95ce0bdbbc9d@redhat.com>
Date: Sun, 1 Oct 2017 11:27:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170907202551.26796-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 07-09-17 22:25, Hans de Goede wrote:
> Tested on a GPD win with a BCM4356 PCI-E wifi/bt combo card.

Ok, so there is a bit of a snarfu with this patch, it seems
that the bluetooth part of the BCM4356A2 can be connected
via both USB and an UART and on the GPD pocket it is actually
connected through both at the same time.

This probably also explains the weird 0000:0000 vid:pid
combo on the GPD pocket which commit 9834e586fa works around.

After applying this patch, which causes the kernel to communicate
with the BT part over the UART, the BT part drops from the USB
bus and can only be reached via the UART.

When using it over USB (by not having this patch in the kernel)
I cannot get patchram to load, this might because the patchram
file from the Windows partition on the device is only meant to
be used with the device in UART mode.

In USB mode when trying to use the patchram file I get:

[   31.145258] Bluetooth: hci0: BCM: chip id 101
[   31.146265] Bluetooth: hci0: BCM: features 0x2f
[   31.162270] Bluetooth: hci0: BCM4354A2
[   31.163280] Bluetooth: hci0: BCM4354A2 (001.003.015) build 0000
[   31.744211] Bluetooth: hci0 sending frame failed (-19)
[   33.759017] Bluetooth: hci0 command 0x0c03 tx timeout
[   41.950999] Bluetooth: hci0: BCM: Reset failed (-110)
[   62.069325] Bluetooth: hci0: BCM: chip id 101
[   62.070313] Bluetooth: hci0: BCM: features 0x2f
[   62.086574] Bluetooth: hci0: BCM4354A2
[   62.087325] Bluetooth: hci0: BCM4354A2 (001.003.015) build 0000
[   62.675127] Bluetooth: hci0 sending frame failed (-19)
[   64.691105] Bluetooth: hci0 command 0x0c03 tx timeout
[   72.947944] Bluetooth: hci0: BCM: Reset failed (-110)
[   92.997864] Bluetooth: hci0: BCM: chip id 101
[   92.998367] Bluetooth: hci0: BCM: features 0x2f
[   93.014732] Bluetooth: hci0: BCM4354A2
[   93.015360] Bluetooth: hci0: BCM4354A2 (001.003.015) build 0000
[   93.658961] Bluetooth: hci0 sending frame failed (-19)
[   95.666973] Bluetooth: hci0 command 0x0c03 tx timeout

Without the patchram file it does work in USB mode.

In UART mode it works with the patchram file and I get
(with the 2 patches from this series):

[   17.663889] Bluetooth: hci0: BCM: chip id 101
[   17.664205] Bluetooth: hci0: BCM: features 0x2f
[   17.665250] Bluetooth: hci0: BCM4354A2
[   17.665256] Bluetooth: hci0: BCM4356A2 (001.003.015) build 0000
[   18.344740] Bluetooth: hci0: BCM (001.003.015) build 0273

Given that windows seems to be using the device in UART
mode and the weird 0000:0000 USB-ID, which points to the USB
bits not being configured, I believe that the device should
really be used in UART mode.

This will happen automatically with this patch series,
but with the current 4.14 bluetooth stack it will work in
USB mode, and if we then merge this series post 4.14
bluetooth will stop working without users doing a btattach
command from userspace and we will have a regression on
our hands.

I believe that as a minimum we should revert commit 9834e586fa
("Bluetooth: btusb: Add workaround for Broadcom devices without product id")
to avoid users regressing once we move this setup over to
using UART mode.

Regards,

Hans







> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/bluetooth/hci_bcm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 6a662d0161b4..4739acb5b201 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -878,6 +878,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
>   	{ "BCM2E71", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>   	{ "BCM2E7B", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
>   	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
> +	{ "BCM2E7E", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
>   	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
>   	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
>   	{ },
> 
