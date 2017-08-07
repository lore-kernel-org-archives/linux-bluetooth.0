Return-Path: <loic.poulain@gmail.com>
From: Loic Poulain <loic.poulain@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	robh+dt@kernel.org,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	f.fainelli@gmail.com,
	stefan.wahren@i2se.com
Cc: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH v3 3/3] Bluetooth: hci_bcm: Add serdev support
Date: Mon,  7 Aug 2017 12:39:26 +0200
Message-Id: <1502102366-2760-3-git-send-email-loic.poulain@gmail.com>
In-Reply-To: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
References: <1502102366-2760-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add basic support for Broadcom serial slave devices.
Probe the serial device, retrieve its maximum speed and
register a new hci uart device.

Tested/compatible with bcm43438 (RPi3).

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 85 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6b42372..086d73c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -27,6 +27,8 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
@@ -34,6 +36,7 @@
 #include <linux/interrupt.h>
 #include <linux/dmi.h>
 #include <linux/pm_runtime.h>
+#include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -46,6 +49,7 @@
 
 #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
 
+/* platform device driver resources */
 struct bcm_device {
 	struct list_head	list;
 
@@ -68,6 +72,12 @@ struct bcm_device {
 #endif
 };
 
+/* serdev driver resources */
+struct bcm_serdev {
+	struct hci_uart hu;
+};
+
+/* generic bcm uart resources */
 struct bcm_data {
 	struct sk_buff		*rx_skb;
 	struct sk_buff_head	txq;
@@ -79,6 +89,14 @@ struct bcm_data {
 static DEFINE_MUTEX(bcm_device_lock);
 static LIST_HEAD(bcm_device_list);
 
+static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
+{
+	if (hu->serdev)
+		serdev_device_set_baudrate(hu->serdev, speed);
+	else
+		hci_uart_set_baudrate(hu, speed);
+}
+
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -289,6 +307,14 @@ static int bcm_open(struct hci_uart *hu)
 
 	hu->priv = bcm;
 
+	/* If this is a serdev defined device, then only use
+	 * serdev open primitive and skip the rest.
+	 */
+	if (hu->serdev) {
+		serdev_device_open(hu->serdev);
+		goto out;
+	}
+
 	if (!hu->tty->dev)
 		goto out;
 
@@ -323,6 +349,12 @@ static int bcm_close(struct hci_uart *hu)
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
+	/* If this is a serdev defined device, only use serdev
+	 * close primitive and then continue as usual.
+	 */
+	if (hu->serdev)
+		serdev_device_close(hu->serdev);
+
 	/* Protect bcm->dev against removal of the device or driver */
 	mutex_lock(&bcm_device_lock);
 	if (bcm_device_exists(bdev)) {
@@ -398,7 +430,7 @@ static int bcm_setup(struct hci_uart *hu)
 		speed = 0;
 
 	if (speed)
-		hci_uart_set_baudrate(hu, speed);
+		host_set_baudrate(hu, speed);
 
 	/* Operational speed if any */
 	if (hu->oper_speed)
@@ -411,7 +443,7 @@ static int bcm_setup(struct hci_uart *hu)
 	if (speed) {
 		err = bcm_set_baudrate(hu, speed);
 		if (!err)
-			hci_uart_set_baudrate(hu, speed);
+			host_set_baudrate(hu, speed);
 	}
 
 finalize:
@@ -903,9 +935,57 @@ static int bcm_remove(struct platform_device *pdev)
 	},
 };
 
+static int bcm_serdev_probe(struct serdev_device *serdev)
+{
+	struct bcm_serdev *bcmdev;
+	u32 speed;
+	int err;
+
+	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
+	if (!bcmdev)
+		return -ENOMEM;
+
+	bcmdev->hu.serdev = serdev;
+	serdev_device_set_drvdata(serdev, bcmdev);
+
+	err = device_property_read_u32(&serdev->dev, "max-speed", &speed);
+	if (!err)
+		bcmdev->hu.oper_speed = speed;
+
+	return hci_uart_register_device(&bcmdev->hu, &bcm_proto);
+}
+
+static void bcm_serdev_remove(struct serdev_device *serdev)
+{
+	struct bcm_serdev *bcmdev = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&bcmdev->hu);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id bcm_bluetooth_of_match[] = {
+	{ .compatible = "brcm,bcm43438-bt" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
+#endif
+
+static struct serdev_device_driver bcm_serdev_driver = {
+	.probe = bcm_serdev_probe,
+	.remove = bcm_serdev_remove,
+	.driver = {
+		.name = "hci_uart_bcm",
+		.of_match_table = of_match_ptr(bcm_bluetooth_of_match),
+	},
+};
+
 int __init bcm_init(void)
 {
+	/* For now, we need to keep both platform device
+	 * driver (ACPI generated) and serdev driver (DT).
+	 */
 	platform_driver_register(&bcm_driver);
+	serdev_device_driver_register(&bcm_serdev_driver);
 
 	return hci_uart_register_proto(&bcm_proto);
 }
@@ -913,6 +993,7 @@ int __init bcm_init(void)
 int __exit bcm_deinit(void)
 {
 	platform_driver_unregister(&bcm_driver);
+	serdev_device_driver_unregister(&bcm_serdev_driver);
 
 	return hci_uart_unregister_proto(&bcm_proto);
 }
-- 
1.9.1
