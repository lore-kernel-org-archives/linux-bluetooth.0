Return-Path: <ian@mnementh.co.uk>
To: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
From: Ian Molton <ian@mnementh.co.uk>
Subject: PATCH: RFC: Broadcom serdev driver
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Loic Poulain <loic.poulain@gmail.com>
Message-ID: <afbbb4ed-d1aa-2ae8-33c5-1fab8e360551@mnementh.co.uk>
Date: Tue, 4 Jul 2017 23:38:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi folks,

Here's a first cut at a serdev based BT driver. Its not complete, but it
does load, load firmware, and change speed.

One oddity I've spotted is that the chip tries to go back to 115200 baud
after loading its firmware patch, which messes up the change to
oper_speed. I've worked around this by not using the set_baudrate hook,
just setting the operating speed after firmware loading in setup.

An alternative workaround would be to teach the serdev core not to
change speed until after loading firmware.

I have a couple of patches for the Nokia driver too, I'll post them
separately.

I've not implemented wakeup, as I cannot test it (my hardware only
connects nReset)

There are a couple of functions common between this and hci_bcm.c, which
might be better moved into btbcm.c ?

no suspend / resume support yet.

Comments welcome.

-Ian

-----------------------------------------------------------------------

	This patch adds a driver for broadcom BT devices that are
attached as serdev devices.

A device tree entry such as the following is used with this driver:

        bcm34340a1: bluetooth {
                compatible = "brcm,b43430a1";
                reset-gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
		bluetooth-wakeup-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>;

		init-speed = <115200>;
                oper-speed = <400000>;
        };
---
 drivers/bluetooth/Kconfig          |  14 ++
 drivers/bluetooth/Makefile         |   1 +
 drivers/bluetooth/hci_bcm_serdev.c | 423
+++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h       |   3 +-
 4 files changed, 440 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_bcm_serdev.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index adcd093b7bb3..7a5aca5e7388 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -105,6 +105,20 @@ config BT_HCIUART_NOKIA

 	  Say Y here to compile support for Nokia's H4+ protocol.

+config BT_HCIUART_BCMBT
+	tristate "Serdev based BCM Protocol support"
+	select BT_BCM
+	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
+	depends on BT_HCIUART_H4
+	depends on PM
+	help
+	  This driver provides support for Broadcom H4 Bluetooth devices
+	  that are connected to dedicated UARTs, and are descrbed by
+	  devicetree.
+
+	  Say Y here to compile support for Nokia's H4+ protocol.
+
 config BT_HCIUART_BCSP
 	bool "BCSP protocol support"
 	depends on BT_HCIUART
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index e693ca6eeed9..5da1252e4fca 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_BT_RTL)		+= btrtl.o
 obj-$(CONFIG_BT_QCA)		+= btqca.o

 obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
+obj-$(CONFIG_BT_HCIUART_BCMBT)	+= hci_bcm_serdev.o

 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
diff --git a/drivers/bluetooth/hci_bcm_serdev.c
b/drivers/bluetooth/hci_bcm_serdev.c
new file mode 100644
index 000000000000..251a8b888e8a
--- /dev/null
+++ b/drivers/bluetooth/hci_bcm_serdev.c
@@ -0,0 +1,423 @@
+/*
+ *
+ *  Bluetooth HCI serdev driver for Broadcom devices
+ *
+ *  Copyright (C) 2017 Ian Molton <ian@mnementh.co.uk>
+ *
+ *  Parts based upon hci_nokia.c and hci_bcm.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/skbuff.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btbcm.h"
+#include "hci_uart.h"
+
+struct bcmbt_serdev_dev {
+	struct hci_uart hu;
+
+	struct serdev_device *serdev;
+
+	/* Hardware control */
+	struct gpio_desc *reset_bt;
+//	struct gpio_desc *wakeup_host;
+	struct gpio_desc *wakeup_bt;
+//	unsigned long sysclk_speed;
+
+//	int wake_irq;
+
+	/* Queues */
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+
+	/* Hardware state */
+	bool tx_enabled;
+};
+
+// -----------------------------------------------------------------------
+// FIXME: This is now a duplicate of the fn in hci_bcm.c - perhaps move to
+// btbcm.c ?
+static int bcmbt_serdev_set_baudrate(struct hci_uart *hu, unsigned int
speed)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct bcm_update_uart_baud_rate param;
+
+	if (speed > 3000000) {
+		struct bcm_write_uart_clock_setting clock;
+
+		clock.type = BCM_UART_CLOCK_48MHZ;
+
+		bt_dev_dbg(hdev, "Set Controller clock (%d)", clock.type);
+
+		/* This Broadcom specific command changes the UART's controller
+		 * clock for baud rate > 3000000.
+		 */
+		skb = __hci_cmd_sync(hdev, 0xfc45, 1, &clock, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			int err = PTR_ERR(skb);
+			bt_dev_err(hdev, "BCM: failed to write clock (%d)",
+					err);
+			return err;
+		}
+
+		kfree_skb(skb);
+	}
+
+	bt_dev_dbg(hdev, "Set Controller UART speed to %d bit/s", speed);
+
+	param.zero = cpu_to_le16(0);
+	param.baud_rate = cpu_to_le32(speed);
+
+	/* This Broadcom specific command changes the UART's controller baud
+	 * rate.
+	 */
+	skb = __hci_cmd_sync(hdev, 0xfc18, sizeof(param), &param,
+				HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+	int err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: failed to write update baudrate (%d)",
+				err);
+
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+// -----------------------------------------------------------------------
+// FIXME: This is now a duplicate of the fn in hci_bcm.c - perhaps move to
+// btbcm.c ?
+#define BCM_LM_DIAG_PKT 0x07
+#define BCM_LM_DIAG_SIZE 63
+
+#define BCM_RECV_LM_DIAG \
+	.type = BCM_LM_DIAG_PKT, \
+	.hlen = BCM_LM_DIAG_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_LM_DIAG_SIZE
+
+static int bcm_set_diag(struct hci_dev *hdev, bool enable)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct bcmbt_serdev_dev *bcm = hu->priv;
+	struct sk_buff *skb;
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	skb = bt_skb_alloc(3, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	*skb_put(skb, 1) = BCM_LM_DIAG_PKT;
+	*skb_put(skb, 1) = 0xf0;
+	*skb_put(skb, 1) = enable;
+
+	skb_queue_tail(&bcm->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	return 0;
+}
+
+// -----------------------------------------------------------------------
+
+static const struct h4_recv_pkt bcm_recv_pkts[] = {
+	{ H4_RECV_ACL,      .recv = hci_recv_frame },
+	{ H4_RECV_SCO,      .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
+	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
+};
+
+static int bcmbt_serdev_open(struct hci_uart *hu)
+{
+	struct bcmbt_serdev_dev *btdev = hu->priv;
+	struct device *dev = &hu->serdev->dev;
+
+	dev_dbg(dev, "protocol open");
+
+	pm_runtime_enable(dev);
+
+	serdev_device_open(hu->serdev);
+	serdev_device_set_flow_control(hu->serdev, true);
+	serdev_device_set_rts(hu->serdev, true);
+
+	/* Turn on power to BT module */
+	gpiod_set_value(btdev->reset_bt, 0);
+
+
+
+	return 0;
+}
+
+static int bcmbt_serdev_flush(struct hci_uart *hu)
+{
+	struct bcmbt_serdev_dev *btdev = hu->priv;
+
+	dev_dbg(&btdev->serdev->dev, "flush device");
+
+	skb_queue_purge(&btdev->txq);
+
+	return 0;
+}
+
+static int bcmbt_serdev_close(struct hci_uart *hu)
+{
+	struct bcmbt_serdev_dev *btdev = hu->priv;
+	struct device *dev = &btdev->serdev->dev;
+
+	dev_dbg(dev, "close device");
+
+	skb_queue_purge(&btdev->txq);
+
+	kfree_skb(btdev->rx_skb);
+
+	/* Turn off power to BT module */
+	gpiod_set_value(btdev->reset_bt, 1);
+	gpiod_set_value(btdev->wakeup_bt, 0);
+
+	pm_runtime_disable(&btdev->serdev->dev);
+	serdev_device_close(btdev->serdev);
+
+	return 0;
+}
+
+/* Enqueue frame for transmittion (padding, crc, etc) */
+static int bcmbt_serdev_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct bcmbt_serdev_dev *btdev = hu->priv;
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+
+	skb_queue_tail(&btdev->txq, skb);
+
+	return 0;
+}
+
+static struct sk_buff *bcmbt_serdev_dequeue(struct hci_uart *hu)
+{
+	struct bcmbt_serdev_dev *btdev = hu->priv;
+	struct device *dev = &btdev->serdev->dev;
+	struct sk_buff *result = skb_dequeue(&btdev->txq);
+
+	/* If tx enabled and we have work to do, or
+	 * tx disabled and nothing to do
+	 */
+	if (btdev->tx_enabled == !!result)
+		return result;
+
+	if (result) { /* Tx disabled, packet waiting -> Wake up BT device */
+		pm_runtime_get_sync(dev);
+		gpiod_set_value_cansleep(btdev->wakeup_bt, 1);
+
+	} else { /* Tx enabled, packet done -> Put BT device to sleep */
+		serdev_device_wait_until_sent(btdev->serdev, 0);
+		gpiod_set_value_cansleep(btdev->wakeup_bt, 0);
+		pm_runtime_put(dev);
+	}
+
+	btdev->tx_enabled = !!result;
+
+	return result;
+}
+
+
+static int bcmbt_serdev_recv(struct hci_uart *hu, const void *data, int
count)
+{
+	struct bcmbt_serdev_dev *btdev = hu->priv;
+	struct device *dev = &btdev->serdev->dev;
+	int err;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	btdev->rx_skb = h4_recv_buf(hu->hdev, btdev->rx_skb, data, count,
+				bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
+
+	if (IS_ERR(btdev->rx_skb)) {
+		err = PTR_ERR(btdev->rx_skb);
+		dev_err(dev, "Frame reassembly failed (%d)", err);
+		btdev->rx_skb = NULL;
+		return err;
+	}
+
+	return count;
+}
+
+static int bcmbt_serdev_setup(struct hci_uart *hu)
+{
+        struct bcmbt_serdev_dev *btdev = hu->priv;
+        struct device *dev = &btdev->serdev->dev;
+	char fw_name[64];
+	const struct firmware *fw;
+        int err;
+
+        dev_dbg(dev, "protocol setup");
+
+	err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
+	if (err)
+		goto out;
+
+	err = request_firmware(&fw, fw_name, dev);
+	if (err < 0) {
+		bt_dev_info(hu->hdev, "BCM: Patch %s not found", fw_name);
+		goto out;
+	}
+
+	err = btbcm_patchram(hu->hdev, fw);
+
+	release_firmware(fw);
+
+	if (err) {
+		bt_dev_info(hu->hdev, "BCM: Patch failed (%d)", err);
+		goto out;
+	}
+
+	/* FIXME: Change serial speed? */
+
+        dev_dbg(dev, "protocol setup done!");
+
+	err = btbcm_finalize(hu->hdev);
+	if (err)
+		goto out;
+
+	hu->hdev->set_diag = bcm_set_diag;
+        hu->hdev->set_bdaddr = btbcm_set_bdaddr;
+
+	if (hu->oper_speed) {
+		err = bcmbt_serdev_set_baudrate(hu, hu->oper_speed);
+                if (!err)
+			serdev_device_set_baudrate(hu->serdev, hu->oper_speed);
+	}
+
+#if 0
+	FIXME: implement irq / host wakeup
+	err = bcm_request_irq(bcm);
+        if (!err)
+                err = bcm_setup_sleep(hu);
+
+#endif
+
+out:
+        return err;
+}
+
+static const struct hci_uart_proto bcmbt_serdev_proto = {
+	.id             = HCI_UART_BCMBT,
+	.name           = "bcmbt",
+	.open           = bcmbt_serdev_open,
+	.close          = bcmbt_serdev_close,
+	.recv           = bcmbt_serdev_recv,
+	.enqueue        = bcmbt_serdev_enqueue,
+	.dequeue        = bcmbt_serdev_dequeue,
+	.flush          = bcmbt_serdev_flush,
+	.setup          = bcmbt_serdev_setup,
+};
+
+static int bcmbt_serdev_probe(struct serdev_device *serdev)
+{
+	const struct device_node *np = dev_of_node(&serdev->dev);
+	struct device *dev = &serdev->dev;
+	struct bcmbt_serdev_dev *btdev;
+	int err = 0;
+
+	btdev = devm_kzalloc(dev, sizeof(*btdev), GFP_KERNEL);
+	if (!btdev)
+		return -ENOMEM;
+
+	btdev->hu.serdev = btdev->serdev = serdev;
+	serdev_device_set_drvdata(serdev, btdev);
+
+	btdev->reset_bt = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(btdev->reset_bt))
+		btdev->reset_bt = NULL;
+
+	btdev->wakeup_bt = devm_gpiod_get(dev, "bluetooth-wakeup", GPIOD_OUT_LOW);
+	if (IS_ERR(btdev->wakeup_bt))
+		btdev->wakeup_bt = NULL;
+
+	skb_queue_head_init(&btdev->txq);
+
+	btdev->hu.priv = btdev;
+	btdev->hu.alignment = 1;
+
+	of_property_read_u32(np, "init-speed", &btdev->hu.init_speed);
+	of_property_read_u32(np, "oper-speed", &btdev->hu.oper_speed);
+
+	if(!btdev->hu.init_speed)
+		btdev->hu.init_speed = 115200;
+
+	err = hci_uart_register_device(&btdev->hu, &bcmbt_serdev_proto);
+	if (err)
+		dev_err(dev, "could not register bluetooth uart: %d", err);
+
+	return err;
+}
+
+
+static void bcmbt_serdev_remove(struct serdev_device *serdev)
+{
+	struct bcmbt_serdev_dev *btdev = serdev_device_get_drvdata(serdev);
+	struct hci_uart *hu = &btdev->hu;
+	struct hci_dev *hdev = hu->hdev;
+
+	hci_unregister_dev(hdev);
+	hci_free_dev(hdev);
+
+	cancel_work_sync(&hu->write_work);
+
+	hu->proto->close(hu);
+}
+
+static struct of_device_id bcmbt_serdev_of_match[] = {
+	{ .compatible = "brcm,b43430a1", },
+	{ }
+};
+
+static struct serdev_device_driver bcmbt_serdev_driver = {
+	.probe = bcmbt_serdev_probe,
+	.remove = bcmbt_serdev_remove,
+	.driver = {
+		.name = "bcm-serdev",
+//		.pm = FIXME - needs suspend / resume work,
+		.of_match_table = of_match_ptr(bcmbt_serdev_of_match),
+	},
+};
+
+module_serdev_device_driver(bcmbt_serdev_driver);
+
+MODULE_DEVICE_TABLE(of, bcmbt_serdev_of_match);
+MODULE_AUTHOR("Ian Molton <ian@mnementh.co.uk>");
+MODULE_DESCRIPTION("Bluetooth HCI SERDEV BCM driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 2b05e557fad0..e75ec1105cb0 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,7 +35,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)

 /* UART protocols */
-#define HCI_UART_MAX_PROTO	12
+#define HCI_UART_MAX_PROTO	13

 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -49,6 +49,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_BCMBT	12

 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
2.11.0
