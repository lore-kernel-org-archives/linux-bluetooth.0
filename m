Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_uart: Retrieve UART speed from ACPI
Date: Fri,  3 Jul 2015 15:22:31 +0200
Message-Id: <1435929751-26831-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1435929751-26831-1-git-send-email-frederic.danis@linux.intel.com>
References: <1435929751-26831-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse platform_device's ACPI to retrieve UART init speed.
When BCM device is open, check if its TTY has same parent as one of the
platform devices saved. If yes, use platform_device's init speed.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 856cb48..ac64bc1 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -49,6 +49,8 @@ struct bcm_device {
 
 	struct clk		*clk;
 	bool			clk_enabled;
+
+	u32			init_speed;
 };
 
 struct bcm_data {
@@ -149,6 +151,7 @@ static int bcm_open(struct hci_uart *hu)
 		dev = list_entry(ptr, struct bcm_device, list);
 		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
 			bcm->dev = dev;
+			hu->init_speed = dev->init_speed;
 			break;
 		}
 	}
@@ -302,11 +305,29 @@ static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
 	{ },
 };
 
+static int bcm_resource(struct acpi_resource *ares, void *data)
+{
+	struct bcm_device *dev = data;
+
+	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
+		struct acpi_resource_uart_serialbus *sb;
+
+		sb = &ares->data.uart_serial_bus;
+		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART)
+			dev->init_speed = sb->default_baud_rate;
+	}
+
+	/* Always tell the ACPI core to skip this resource */
+	return 1;
+}
+
 static int bcm_acpi_probe(struct bcm_device *dev)
 {
 	struct platform_device *pdev = dev->pdev;
 	const struct acpi_device_id *id;
 	struct gpio_desc *gpio;
+	struct acpi_device *adev;
+	LIST_HEAD(resources);
 	int ret;
 
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
@@ -346,6 +367,13 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 		return -EINVAL;
 	}
 
+	/* Retrieve UART ACPI info */
+	adev = ACPI_COMPANION(&dev->pdev->dev);
+	if (!adev)
+		return 0;
+
+	acpi_dev_get_resources(adev, &resources, bcm_resource, dev);
+
 	return 0;
 }
 
-- 
1.9.1

