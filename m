Return-Path: <ian@mnementh.co.uk>
Subject: Re: BCM43430 BT driver almost working...
From: Ian Molton <ian@mnementh.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@gmail.com>, linux-bluetooth@vger.kernel.org
References: <c4cf0689-d28e-492d-399e-968a70488e22@mnementh.co.uk>
 <d65a5225-84f5-11ae-d9ab-2175480552d8@intel.com>
 <d0c4a580-82ac-d710-8678-f147ce81a9ce@mnementh.co.uk>
 <F9B6438D-2D83-46BD-AE63-DBECB3A0B9A1@holtmann.org>
 <4078da55-c5d8-7c2d-d954-9da790982b22@mnementh.co.uk>
 <5efb7448-9208-f6e3-0c87-6b077a439b5c@mnementh.co.uk>
Message-ID: <ee3d8047-5a50-2ee8-a4e5-403e6bfc5fb3@mnementh.co.uk>
Date: Fri, 30 Jun 2017 22:17:37 +0100
MIME-Version: 1.0
In-Reply-To: <5efb7448-9208-f6e3-0c87-6b077a439b5c@mnementh.co.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Just FYI, this is what I'd come up with earlier today, which works. But
its not serdev based:

Subject: [PATCH 1/5] bluetooth: Add DT support to hci_bcm

	This patch adds minimal DT support to hci_bcm.

It takes the following parameters in its DT node:

ttydev - a phandle for the UART the device is attached to.
wakeup-gpios - a single GPIO used to control power to the chip.
init-speed - baud rate to initialise the chip at
oper-speed = baud rate to run the chip at after init.

bt_brcm {
	compatible = "brcm,b43430a1";

	ttydev = <&uart2>;
	wakeup-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
	init-speed = <115200>;
	oper-speed = <115200>;
};
---
 drivers/bluetooth/hci_bcm.c | 67
+++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index df7fa8ff9e0e..cd6312462fb0 100644
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
 	struct list_head	list;

 	struct platform_device	*pdev;
+	struct device_node	*of_tty_np;

 	const char		*name;
 	struct gpio_desc	*device_wakeup;
@@ -59,6 +61,7 @@ struct bcm_device {
 	bool			clk_enabled;

 	u32			init_speed;
+	u32			oper_speed;
 	int			irq;
 	u8			irq_polarity;

@@ -299,9 +302,13 @@ static int bcm_open(struct hci_uart *hu)
 		 * platform device (saved during device probe) and
 		 * parent of tty device used by hci_uart
 		 */
-		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
+		if (hu->tty->dev->parent == dev->pdev->dev.parent ||
+			hu->tty->dev->parent->of_node == dev->of_tty_np) {
+
 			bcm->dev = dev;
+
 			hu->init_speed = dev->init_speed;
+			hu->oper_speed = dev->oper_speed;
 #ifdef CONFIG_PM
 			dev->hu = hu;
 #endif
@@ -424,7 +431,7 @@ static int bcm_setup(struct hci_uart *hu)
 	if (!err)
 		err = bcm_setup_sleep(hu);

-	return err;
+	return 0;
 }

 #define BCM_RECV_LM_DIAG \
@@ -703,6 +710,46 @@ static int bcm_resource(struct acpi_resource *ares,
void *data)
 }
 #endif /* CONFIG_ACPI */

+#ifdef CONFIG_OF
+static int bcm_dt_probe(struct bcm_device *dev)
+{
+	struct platform_device *pdev = dev->pdev;
+	const struct device_node *np = dev_of_node(&pdev->dev);
+
+	dev->name = dev_name(&pdev->dev);
+
+	/*
+	 * If we know which ttydev btattach will use, we can match it
+	 * at when the _open() call occurs, allowing us to control
+	 * other functionality, such as wakeup GPIOs
+	 *
+	 */
+
+	dev->of_tty_np = of_parse_phandle(np, "ttydev", 0);
+	if(dev->of_tty_np) {
+		struct gpio_desc *g;
+
+		g = gpiod_get(&pdev->dev, "wakeup", GPIOD_OUT_LOW);
+			if(PTR_ERR(g))
+				dev->device_wakeup = g;
+
+		of_property_read_u32(np, "init-speed", &dev->init_speed);
+		of_property_read_u32(np, "oper-speed", &dev->oper_speed);
+	}
+
+	/*
+	 * It is entirely possible for devices with no power control GPIOs
+	 * to exist, so do not error on this case, however
+	 *
+	 */
+
+	return 0;
+}
+#else
+static int bcm_dt_probe(struct bcm_device *dev) { return 0; }
+#endif
+
+
 static int bcm_platform_probe(struct bcm_device *dev)
 {
 	struct platform_device *pdev = dev->pdev;
@@ -806,7 +853,9 @@ static int bcm_probe(struct platform_device *pdev)

 	dev->pdev = pdev;

-	if (has_acpi_companion(&pdev->dev))
+	if(pdev->dev.of_node)
+		ret = bcm_dt_probe(dev);
+	else if (has_acpi_companion(&pdev->dev))
 		ret = bcm_acpi_probe(dev);
 	else
 		ret = bcm_platform_probe(dev);
@@ -887,12 +936,24 @@ static const struct dev_pm_ops bcm_pm_ops = {
 	SET_RUNTIME_PM_OPS(bcm_suspend_device, bcm_resume_device, NULL)
 };

+#ifdef CONFIG_OF
+static struct of_device_id bcm_of_match[] = {
+	{ .compatible = "brcm,b43430a1", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, bcm_of_match);
+#endif
+
 static struct platform_driver bcm_driver = {
 	.probe = bcm_probe,
 	.remove = bcm_remove,
 	.driver = {
 		.name = "hci_bcm",
 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
+#ifdef CONFIG_OF
+		.of_match_table = bcm_of_match,
+#endif
 		.pm = &bcm_pm_ops,
 	},
 };
-- 
2.11.0
