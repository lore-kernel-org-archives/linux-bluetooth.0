Return-Path: <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Loic Poulain <loic.poulain@intel.com>, marcel@holtmann.org
From: Ian Molton <ian@mnementh.co.uk>
Subject: BCM43430 BT driver almost working...
Message-ID: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
Date: Thu, 29 Jun 2017 19:06:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I've been fiddling with the BCM43430 driver a bit today, and have
managed to get it to work with device tree supplying the GPIO.

I've created a dt entry that looks like:

bt_brcm {
                compatible = "brcm,b43430a1";
                wakeup-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
                ttydev = <&uart2>;
                status = "ok";
        };
};

This allows me to get the code to correlate the UART and the GPIOs,
thus: (forgive the very messy patch - this is my WIP, for illustration
only...)

The code below *works* - toggles the power GPIO, loads firmware, and
attaches fine.

However, if I uncomment the line containing:

    err = bcm_setup_sleep(hu);

The driver dies, with timeouts, thus:

Bluetooth: hci0: BCM: chip id 94
Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
Bluetooth: hci0: BCM: failed to write clock (-56)
Bluetooth: hci0: BCM (001.002.009) build 0182
Bluetooth: hci0 command 0x0c56 tx timeout
Bluetooth: hci0 command 0x0c7a tx timeout
Bluetooth: hci0 command 0x0c6d tx timeout
Bluetooth: hci0 command 0x2008 tx timeout
Bluetooth: hci0 command 0x2009 tx timeout

The "Bluetooth: hci0: BCM: failed to write clock (-56)" is a red herring
- it works fine despite this - just the bcm_setup_sleep() function seems
to trip it up.

Any thoughts?

-Ian

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f87bfdfee4ff..a164397ee2d7 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -34,6 +34,7 @@
 #include <linux/interrupt.h>
 #include <linux/dmi.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>

 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -50,6 +51,7 @@ struct bcm_device {
        struct list_head        list;

        struct platform_device  *pdev;
+       struct device_node      *of_ttydev;

        const char              *name;
        struct gpio_desc        *device_wakeup;
@@ -145,6 +147,8 @@ static bool bcm_device_exists(struct bcm_device *device)

 static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
+
+       printk("----------brcm: powered: %d\n", powered);
        if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
                clk_prepare_enable(dev->clk);

@@ -203,7 +207,6 @@ static int bcm_request_irq(struct bcm_data *bcm)

 unlock:
        mutex_unlock(&bcm_device_lock);
-
        return err;
 }

@@ -279,6 +282,7 @@ static int bcm_open(struct hci_uart *hu)

        bt_dev_dbg(hu->hdev, "hu %p", hu);

+printk("-----brcm open\n");
        bcm = kzalloc(sizeof(*bcm), GFP_KERNEL);
        if (!bcm)
                return -ENOMEM;
@@ -298,7 +302,9 @@ static int bcm_open(struct hci_uart *hu)
                 * platform device (saved during device probe) and
                 * parent of tty device used by hci_uart
                 */
-               if (hu->tty->dev->parent == dev->pdev->dev.parent) {
+               if (hu->tty->dev->parent == dev->pdev->dev.parent ||
+                       hu->tty->dev->parent->of_node == dev->of_ttydev) {
+
                        bcm->dev = dev;
                        hu->init_speed = dev->init_speed;
 #ifdef CONFIG_PM
@@ -319,6 +325,7 @@ static int bcm_close(struct hci_uart *hu)
        struct bcm_data *bcm = hu->priv;
        struct bcm_device *bdev = bcm->dev;

+printk("--a--- %s\n", __func__);
        bt_dev_dbg(hu->hdev, "hu %p", hu);

        /* Protect bcm->dev against removal of the device or driver */
@@ -366,6 +373,7 @@ static int bcm_setup(struct hci_uart *hu)
        unsigned int speed;
        int err;

+printk("--a--- %s\n", __func__);
        bt_dev_dbg(hu->hdev, "hu %p", hu);

        hu->hdev->set_diag = bcm_set_diag;
@@ -420,10 +428,10 @@ static int bcm_setup(struct hci_uart *hu)
                return err;

        err = bcm_request_irq(bcm);
-       if (!err)
-               err = bcm_setup_sleep(hu);
+//     if (!err)
+//             err = bcm_setup_sleep(hu);

-       return err;
+       return 0;
 }

 #define BCM_RECV_LM_DIAG \
@@ -705,17 +713,26 @@ static int bcm_resource(struct acpi_resource
*ares, void *data)
 static int bcm_platform_probe(struct bcm_device *dev)
 {
        struct platform_device *pdev = dev->pdev;
+       const __be32 *np;

        dev->name = dev_name(&pdev->dev);

        dev->clk = devm_clk_get(&pdev->dev, NULL);

-       dev->device_wakeup = devm_gpiod_get_optional(&pdev->dev,
-                                                    "device-wakeup",
-                                                    GPIOD_OUT_LOW);
+       dev->device_wakeup = gpiod_get(&pdev->dev, "wakeup",
GPIOD_OUT_HIGH);
+
+       np = of_get_property(dev_of_node(&pdev->dev), "ttydev", NULL);
+       dev->of_ttydev = of_find_node_by_phandle(be32_to_cpup(np));
+
+
+//     dev->device_wakeup = devm_gpiod_get_optional(&pdev->dev,
+//                                                  "device-wakeup",
+//                                                  GPIOD_OUT_LOW);
        if (IS_ERR(dev->device_wakeup))
                return PTR_ERR(dev->device_wakeup);

+       printk("bcmbt------- %p\n", dev->device_wakeup);
+
        dev->shutdown = devm_gpiod_get_optional(&pdev->dev, "shutdown",
                                                GPIOD_OUT_LOW);
        if (IS_ERR(dev->shutdown))
@@ -886,12 +903,22 @@ static const struct dev_pm_ops bcm_pm_ops = {
        SET_RUNTIME_PM_OPS(bcm_suspend_device, bcm_resume_device, NULL)
 };

+static struct of_device_id bcm_of_match[] = {
+       { .compatible = "brcm,b43430a1", },
+       { }
+};
+
 static struct platform_driver bcm_driver = {
        .probe = bcm_probe,
        .remove = bcm_remove,
        .driver = {
                .name = "hci_bcm",
                .acpi_match_table = ACPI_PTR(bcm_acpi_match),
+               .of_match_table = bcm_of_match,
                .pm = &bcm_pm_ops,
        },
 };
                                                              13
