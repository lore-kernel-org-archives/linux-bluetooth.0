Return-Path: <lukas@wunner.de>
Message-Id: <477d9c5294b1d1df06942cd1c30238d91d900253.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 10/10] Bluetooth: hci_bcm: Support Apple GPIO handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable Bluetooth on the following Macs which provide custom ACPI methods
to toggle the GPIOs for device wake and shutdown instead of accessing
the pins directly:

    MacBook8,1     2015  12"
    MacBook9,1     2016  12"
    MacBook10,1    2017  12"
    MacBookPro13,1 2016  13"
    MacBookPro13,2 2016  13" with Touch Bar
    MacBookPro13,3 2016  15" with Touch Bar
    MacBookPro14,1 2017  13"
    MacBookPro14,2 2017  13" with Touch Bar
    MacBookPro14,3 2017  15" with Touch Bar

On the MacBook8,1 Bluetooth is muxed with a second device (a debug port
on the SSD) under the control of PCH GPIO 36.  Because serdev cannot
deal with multiple slaves yet, it is currently necessary to patch the
DSDT and remove the SSDC device.

The custom ACPI methods are called:

    BTLP (Low Power) takes one argument, toggles device wake GPIO
    BTPU (Power Up) tells SMC to drive shutdown GPIO high
    BTPD (Power Down) tells SMC to drive shutdown GPIO low
    BTRS (Reset) calls BTPD followed by BTPU
    BTRB unknown, not present on all MacBooks

Search for the BTLP, BTPU and BTPD methods on ->probe and cache them in
struct bcm_device if the machine is a Mac.

Additionally, set the init_speed based on a custom device property
provided by Apple in lieu of _CRS resources.  The Broadcom UART's speed
is fixed on Apple Macs:  Any attempt to change it results in Bluetooth
status code 0x0c and bcm_set_baudrate() thus always returns -EBUSY.
By setting only the init_speed and leaving oper_speed at zero, we can
achieve that the host UART's speed is adjusted but the Broadcom UART's
speed is left as is.

The host wake pin goes into the SMC which handles it independently
of the OS, so there's no IRQ for it.

Thanks to Ronald Tschalär who did extensive debugging and testing of
this patch and contributed fixes.

ACPI snippet containing the custom methods and device properties
(taken from a MacBook8,1):

    Method (BTLP, 1, Serialized)
    {
        If (LEqual (Arg0, 0x00))
        {
            Store (0x01, GD54) /* set PCH GPIO 54 direction to input */
        }

        If (LEqual (Arg0, 0x01))
        {
            Store (0x00, GD54) /* set PCH GPIO 54 direction to output */
            Store (0x00, GP54) /* set PCH GPIO 54 value to low */
        }
    }

    Method (BTPU, 0, Serialized)
    {
        Store (0x01, \_SB.PCI0.LPCB.EC.BTPC)
        Sleep (0x0A)
    }

    Method (BTPD, 0, Serialized)
    {
        Store (0x00, \_SB.PCI0.LPCB.EC.BTPC)
        Sleep (0x0A)
    }

    Method (BTRS, 0, Serialized)
    {
        BTPD ()
        BTPU ()
    }

    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
    {
        If (LEqual (Arg0, ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
        {
            Store (Package (0x08)
                {
                    "baud",
                    Buffer (0x08)
                    { 0xC0, 0xC6, 0x2D, 0x00, 0x00, 0x00, 0x00, 0x00 },

                    "parity",
                    Buffer (0x08)
                    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },

                    "dataBits",
                    Buffer (0x08)
                    { 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },

                    "stopBits",
                    Buffer (0x08)
                    { 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
                }, Local0)
            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
            Return (Local0)
        }
        Return (0x00)
    }

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=110901
Reported-by: Leif Liddy <leif.liddy@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Cc: Loic Poulain <loic.poulain@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Tested-by: Max Shavrick <mxms@me.com>                     [MacBook8,1]
Tested-by: Leif Liddy <leif.liddy@gmail.com>              [MacBook9,1]
Tested-by: Daniel Roschka <danielroschka@phoenitydawn.de> [MacBookPro13,2]
Tested-by: Ronald Tschalär <ronald@innovation.ch>         [MacBookPro13,3]
Tested-by: Peter Y. Chuang <peteryuchuang@gmail.com>      [MacBookPro14,1]
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes since v1:
  add DSDT excerpt to the commit message,
  drop ternary operators for readability,
  return -EIO instead of -EFAULT if ACPI method calls fail,
  return -EOPNOTSUPP in inline stubs,
  use network subsystem comment style. (Marcel, Hans, Andy)
  Also, to accommodate to mandatory presence of the two GPIOs as per
  patch [2/10], rename bcm_apple_probe() to bcm_apple_get_resources()
  and call it from bcm_get_resources() instead of bcm_acpi_probe().

 drivers/bluetooth/hci_bcm.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ad6b7c35eb8e..4e0ba38d39d2 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -29,6 +29,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/property.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
@@ -75,6 +76,9 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to enable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently enabled
+ * @btlp: Apple ACPI method to toggle BT_WAKE pin ("BlueTooth Low Power")
+ * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("BlueTooth Power Up")
+ * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("BlueTooth Power Down")
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -99,6 +103,9 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+#ifdef CONFIG_ACPI
+	acpi_handle		btlp, btpu, btpd;
+#endif
 };
 
 /* generic bcm uart resources */
@@ -191,11 +198,59 @@ static bool bcm_device_exists(struct bcm_device *device)
 	return false;
 }
 
+#ifdef CONFIG_ACPI
+static int bcm_apple_get_resources(struct bcm_device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev->dev);
+	const union acpi_object *obj;
+
+	if (!adev ||
+	    ACPI_FAILURE(acpi_get_handle(adev->handle, "BTLP", &dev->btlp)) ||
+	    ACPI_FAILURE(acpi_get_handle(adev->handle, "BTPU", &dev->btpu)) ||
+	    ACPI_FAILURE(acpi_get_handle(adev->handle, "BTPD", &dev->btpd)))
+		return -ENODEV;
+
+	if (!acpi_dev_get_property(adev, "baud", ACPI_TYPE_BUFFER, &obj) &&
+	    obj->buffer.length == 8)
+		dev->init_speed = *(u64 *)obj->buffer.pointer;
+
+	return 0;
+}
+
+static int bcm_apple_set_power(struct bcm_device *dev, bool enable)
+{
+	if (ACPI_FAILURE(acpi_evaluate_object(enable ? dev->btpu : dev->btpd,
+					      NULL, NULL, NULL)))
+		return -EIO;
+
+	return 0;
+}
+
+static int bcm_apple_set_low_power(struct bcm_device *dev, bool enable)
+{
+	if (ACPI_FAILURE(acpi_execute_simple_method(dev->btlp, NULL, enable)))
+		return -EIO;
+
+	return 0;
+}
+#else
+static inline int bcm_apple_get_resources(struct bcm_device *dev)
+{ return -EOPNOTSUPP; }
+static inline int bcm_apple_set_power(struct bcm_device *dev, bool powered)
+{ return -EOPNOTSUPP; }
+static inline int bcm_apple_set_low_power(struct bcm_device *dev, bool enable)
+{ return -EOPNOTSUPP; }
+#endif
+
 static int bcm_gpio_set_device_wakeup(struct bcm_device *dev, bool awake)
 {
 	int err = 0;
 
-	gpiod_set_value(dev->device_wakeup, awake);
+	if (x86_apple_machine)
+		err = bcm_apple_set_low_power(dev, !awake);
+	else
+		gpiod_set_value(dev->device_wakeup, awake);
+
 	bt_dev_dbg(dev, "%s, delaying 15 ms", awake ? "resume" : "suspend");
 	mdelay(15);
 
@@ -212,7 +267,12 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 			return err;
 	}
 
-	gpiod_set_value(dev->shutdown, powered);
+	if (x86_apple_machine)
+		err = bcm_apple_set_power(dev, powered);
+	else
+		gpiod_set_value(dev->shutdown, powered);
+	if (err)
+		goto err_clk_disable;
 
 	err = bcm_gpio_set_device_wakeup(dev, powered);
 	if (err)
@@ -227,6 +287,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 
 err_revert_shutdown:
 	gpiod_set_value(dev->shutdown, !powered);
+err_clk_disable:
 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
 	return err;
@@ -255,6 +316,14 @@ static int bcm_request_irq(struct bcm_data *bcm)
 		goto unlock;
 	}
 
+	/* Macs wire the host wake pin to the System Management Controller,
+	 * which handles wakeup independently of the operating system.
+	 */
+	if (x86_apple_machine) {
+		err = 0;
+		goto unlock;
+	}
+
 	if (bdev->irq <= 0) {
 		err = -EOPNOTSUPP;
 		goto unlock;
@@ -846,6 +915,9 @@ static int bcm_get_resources(struct bcm_device *dev)
 {
 	dev->name = dev_name(dev->dev);
 
+	if (x86_apple_machine && !bcm_apple_get_resources(dev))
+		return 0;
+
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
 	dev->device_wakeup = devm_gpiod_get(dev->dev, "device-wakeup",
-- 
2.15.1
