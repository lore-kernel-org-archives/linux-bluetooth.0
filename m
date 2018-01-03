Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2 10/10] Bluetooth: hci_bcm: Support Apple GPIO handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <477d9c5294b1d1df06942cd1c30238d91d900253.1514916630.git.lukas@wunner.de>
Date: Wed, 3 Jan 2018 13:55:02 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederic Danis <frederic.danis.oss@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        "Peter Y. Chuang" <peteryuchuang@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <208078A2-704E-4C75-94D1-20EDCEEC5674@holtmann.org>
References: <cover.1514916630.git.lukas@wunner.de>
 <477d9c5294b1d1df06942cd1c30238d91d900253.1514916630.git.lukas@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukas,

> Enable Bluetooth on the following Macs which provide custom ACPI methods
> to toggle the GPIOs for device wake and shutdown instead of accessing
> the pins directly:
> 
>    MacBook8,1     2015  12"
>    MacBook9,1     2016  12"
>    MacBook10,1    2017  12"
>    MacBookPro13,1 2016  13"
>    MacBookPro13,2 2016  13" with Touch Bar
>    MacBookPro13,3 2016  15" with Touch Bar
>    MacBookPro14,1 2017  13"
>    MacBookPro14,2 2017  13" with Touch Bar
>    MacBookPro14,3 2017  15" with Touch Bar
> 
> On the MacBook8,1 Bluetooth is muxed with a second device (a debug port
> on the SSD) under the control of PCH GPIO 36.  Because serdev cannot
> deal with multiple slaves yet, it is currently necessary to patch the
> DSDT and remove the SSDC device.
> 
> The custom ACPI methods are called:
> 
>    BTLP (Low Power) takes one argument, toggles device wake GPIO
>    BTPU (Power Up) tells SMC to drive shutdown GPIO high
>    BTPD (Power Down) tells SMC to drive shutdown GPIO low
>    BTRS (Reset) calls BTPD followed by BTPU
>    BTRB unknown, not present on all MacBooks
> 
> Search for the BTLP, BTPU and BTPD methods on ->probe and cache them in
> struct bcm_device if the machine is a Mac.
> 
> Additionally, set the init_speed based on a custom device property
> provided by Apple in lieu of _CRS resources.  The Broadcom UART's speed
> is fixed on Apple Macs:  Any attempt to change it results in Bluetooth
> status code 0x0c and bcm_set_baudrate() thus always returns -EBUSY.
> By setting only the init_speed and leaving oper_speed at zero, we can
> achieve that the host UART's speed is adjusted but the Broadcom UART's
> speed is left as is.
> 
> The host wake pin goes into the SMC which handles it independently
> of the OS, so there's no IRQ for it.
> 
> Thanks to Ronald Tschalär who did extensive debugging and testing of
> this patch and contributed fixes.
> 
> ACPI snippet containing the custom methods and device properties
> (taken from a MacBook8,1):
> 
>    Method (BTLP, 1, Serialized)
>    {
>        If (LEqual (Arg0, 0x00))
>        {
>            Store (0x01, GD54) /* set PCH GPIO 54 direction to input */
>        }
> 
>        If (LEqual (Arg0, 0x01))
>        {
>            Store (0x00, GD54) /* set PCH GPIO 54 direction to output */
>            Store (0x00, GP54) /* set PCH GPIO 54 value to low */
>        }
>    }
> 
>    Method (BTPU, 0, Serialized)
>    {
>        Store (0x01, \_SB.PCI0.LPCB.EC.BTPC)
>        Sleep (0x0A)
>    }
> 
>    Method (BTPD, 0, Serialized)
>    {
>        Store (0x00, \_SB.PCI0.LPCB.EC.BTPC)
>        Sleep (0x0A)
>    }
> 
>    Method (BTRS, 0, Serialized)
>    {
>        BTPD ()
>        BTPU ()
>    }
> 
>    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>    {
>        If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
>        {
>            Store (Package (0x08)
>                {
>                    "baud",
>                    Buffer (0x08)
>                    { 0xC0, 0xC6, 0x2D, 0x00, 0x00, 0x00, 0x00, 0x00 },
> 
>                    "parity",
>                    Buffer (0x08)
>                    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
> 
>                    "dataBits",
>                    Buffer (0x08)
>                    { 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
> 
>                    "stopBits",
>                    Buffer (0x08)
>                    { 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
>                }, Local0)
>            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
>            Return (Local0)
>        }
>        Return (0x00)
>    }
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=110901
> Reported-by: Leif Liddy <leif.liddy@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Max Shavrick <mxms@me.com>                     [MacBook8,1]
> Tested-by: Leif Liddy <leif.liddy@gmail.com>              [MacBook9,1]
> Tested-by: Daniel Roschka <danielroschka@phoenitydawn.de> [MacBookPro13,2]
> Tested-by: Ronald Tschalär <ronald@innovation.ch>         [MacBookPro13,3]
> Tested-by: Peter Y. Chuang <peteryuchuang@gmail.com>      [MacBookPro14,1]
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes since v1:
>  add DSDT excerpt to the commit message,
>  drop ternary operators for readability,
>  return -EIO instead of -EFAULT if ACPI method calls fail,
>  return -EOPNOTSUPP in inline stubs,
>  use network subsystem comment style. (Marcel, Hans, Andy)
>  Also, to accommodate to mandatory presence of the two GPIOs as per
>  patch [2/10], rename bcm_apple_probe() to bcm_apple_get_resources()
>  and call it from bcm_get_resources() instead of bcm_acpi_probe().
> 
> drivers/bluetooth/hci_bcm.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ad6b7c35eb8e..4e0ba38d39d2 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -29,6 +29,7 @@
> #include <linux/acpi.h>
> #include <linux/of.h>
> #include <linux/property.h>
> +#include <linux/platform_data/x86/apple.h>
> #include <linux/platform_device.h>
> #include <linux/clk.h>
> #include <linux/gpio/consumer.h>
> @@ -75,6 +76,9 @@
>  * @hu: pointer to HCI UART controller struct,
>  *	used to enable flow control during runtime suspend and system sleep
>  * @is_suspended: whether flow control is currently enabled
> + * @btlp: Apple ACPI method to toggle BT_WAKE pin ("BlueTooth Low Power")
> + * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("BlueTooth Power Up")
> + * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("BlueTooth Power Down”)
>  */

unless the Apple ACPI table really use the string “BlueTooth”, I prefer that we use the proper “Bluetooth” string here.

Regards

Marcel

