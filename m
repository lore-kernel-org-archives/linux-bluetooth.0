Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Bluetooth: hci_ll: Add optional nvmem BD address source
Date: Tue, 12 Dec 2017 17:54:12 -0600
Message-Id: <1513122852-5135-2-git-send-email-david@lechnology.com>
In-Reply-To: <1513122852-5135-1-git-send-email-david@lechnology.com>
References: <1513122852-5135-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds an optional nvmem consumer to get a BD address from an external
source. The BD address is then set in the Bluetooth chip after the
firmware has been loaded.

This has been tested working with a TI CC2560A chip (in a LEGO MINDSTORMS
EV3).

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/bluetooth/hci_ll.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index c948e8d..9de106f 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -53,6 +53,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <linux/gpio/consumer.h>
+#include <linux/nvmem-consumer.h>
 
 #include "hci_uart.h"
 
@@ -90,6 +91,7 @@ struct ll_device {
 	struct serdev_device *serdev;
 	struct gpio_desc *enable_gpio;
 	struct clk *ext_clk;
+	bdaddr_t bdaddr;
 };
 
 struct ll_struct {
@@ -719,6 +721,18 @@ static int ll_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
+	/* Set BD address if one was specified at probe */
+	if (!bacmp(&lldev->bdaddr, BDADDR_NONE)) {
+		/* This means that there was an error getting the BD address
+		 * during probe, so mark the device as having a bad address.
+		 */
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
+	} else if (bacmp(&lldev->bdaddr, BDADDR_ANY)) {
+		err = ll_set_bdaddr(hu->hdev, &lldev->bdaddr);
+		if (err)
+			set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
+	}
+
 	/* Operational speed if any */
 	if (hu->oper_speed)
 		speed = hu->oper_speed;
@@ -749,6 +763,7 @@ static int hci_ti_probe(struct serdev_device *serdev)
 {
 	struct hci_uart *hu;
 	struct ll_device *lldev;
+	struct nvmem_cell *bdaddr_cell;
 	u32 max_speed = 3000000;
 
 	lldev = devm_kzalloc(&serdev->dev, sizeof(struct ll_device), GFP_KERNEL);
@@ -770,6 +785,52 @@ static int hci_ti_probe(struct serdev_device *serdev)
 	of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
 	hci_uart_set_speeds(hu, 115200, max_speed);
 
+	/* optional BD address from nvram */
+	bdaddr_cell = nvmem_cell_get(&serdev->dev, "bd-address");
+	if (IS_ERR(bdaddr_cell)) {
+		int err = PTR_ERR(bdaddr_cell);
+
+		if (err == -EPROBE_DEFER)
+			return err;
+
+		/* ENOENT means there is no matching nvmem cell and ENOSYS
+		 * means that nvmem is not enabled in the kernel configuration.
+		 */
+		if (err != -ENOENT && err != -ENOSYS) {
+			/* If there was some other error, give userspace a
+			 * chance to fix the problem instead of failing to load
+			 * the driver. Using BDADDR_NONE as a flag that is
+			 * tested later in the setup function.
+			 */
+			dev_warn(&serdev->dev,
+				 "Failed to get \"bd-address\" nvmem cell (%d)\n",
+				 err);
+			bacpy(&lldev->bdaddr, BDADDR_NONE);
+		}
+	} else {
+		bdaddr_t *bdaddr;
+		size_t len;
+
+		bdaddr = nvmem_cell_read(bdaddr_cell, &len);
+		nvmem_cell_put(bdaddr_cell);
+		if (IS_ERR(bdaddr)) {
+			dev_err(&serdev->dev, "Failed to read nvmem bd-address\n");
+			return PTR_ERR(bdaddr);
+		}
+		if (len != sizeof(bdaddr_t)) {
+			dev_err(&serdev->dev, "Invalid nvmem bd-address length\n");
+			kfree(bdaddr);
+			return -EINVAL;
+		}
+
+		/* As per the device tree bindings, the value from nvmem is
+		 * expected to be MSB first, but in the kernel it is expected
+		 * that bdaddr_t is LSB first.
+		 */
+		baswap(&lldev->bdaddr, bdaddr);
+		kfree(bdaddr);
+	}
+
 	return hci_uart_register_device(hu, &llp);
 }
 
-- 
2.7.4
