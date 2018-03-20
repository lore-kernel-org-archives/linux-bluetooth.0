Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth: Add new serdev based driver for UART attached controllers
Date: Tue, 20 Mar 2018 16:26:10 +0100
Message-Id: <20180320152610.31614-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a from scratch written driver to run H:4 on serdev based system
with a Bluetooth controller attached via an UART. It is currently tested
on RPi3 and it has Broadcom integration. It is DT only and is missing
GPIO and runtime power management integration. Also Apple or ACPI
support is currently not added.

To integrate with controllers from Intel and Qualcomm, similar handling
like with btusb.c has to be done. A simple abstraction for that has been
provided to make it similar to hci_uart.

The goal is to run individual drivers on serdev capable systems so that
we can retire hci_uart on these system and continue with a lot simpler
and easier to maintain driver. It seems that hci_uart has too many race
conditions due to handling TTY and line disciplines. And fixes for that
are not really related to serdev based drivers. In a serdev only world
it makes sense to remove any of the complex code.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig   |  11 +
 drivers/bluetooth/Makefile  |   1 +
 drivers/bluetooth/btuart.c  | 506 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/h4_recv.h | 158 ++++++++++++++
 4 files changed, 676 insertions(+)
 create mode 100644 drivers/bluetooth/btuart.c
 create mode 100644 drivers/bluetooth/h4_recv.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 731ba229d5a3..1c9a2e990246 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -74,6 +74,17 @@ config BT_HCIBTSDIO
 	  Say Y here to compile support for Bluetooth SDIO devices into the
 	  kernel or say M to compile it as module (btsdio).
 
+config BT_HCIBTUART
+	tristate "HCI UART driver"
+	depends on SERIAL_DEV_BUS
+	help
+	  Bluetooth HCI UART driver.
+	  This driver is required if you want to use Bluetooth device with
+	  UART interface.
+
+	  Say Y here to compile support for Bluetooth UART devices into the
+	  kernel or say M to compile it as module (btuart).
+
 config BT_HCIUART
 	tristate "HCI UART driver"
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index e0c147129358..719a010853dd 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
 
 obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
+obj-$(CONFIG_BT_HCIBTUART)	+= btuart.o
 
 obj-$(CONFIG_BT_INTEL)		+= btintel.o
 obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
new file mode 100644
index 000000000000..03e980f01b5a
--- /dev/null
+++ b/drivers/bluetooth/btuart.c
@@ -0,0 +1,506 @@
+/*
+ *
+ *  Generic Bluetooth HCI UART driver
+ *
+ *  Copyright (C) 2015-2018  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/serdev.h>
+#include <linux/of.h>
+#include <linux/firmware.h>
+#include <asm/unaligned.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "h4_recv.h"
+#include "btbcm.h"
+
+#define VERSION "1.0"
+
+struct btuart_vnd {
+	const struct h4_recv_pkt *recv_pkts;
+	int recv_pkts_cnt;
+	unsigned int manufacturer;
+	int (*open)(struct hci_dev *hdev);
+	int (*close)(struct hci_dev *hdev);
+	int (*setup)(struct hci_dev *hdev);
+};
+
+struct btuart_dev {
+	struct hci_dev *hdev;
+	struct serdev_device *serdev;
+
+	struct work_struct tx_work;
+	unsigned long tx_state;
+	struct sk_buff_head txq;
+
+	struct sk_buff *rx_skb;
+
+	const struct btuart_vnd *vnd;
+};
+
+#define BTUART_TX_STATE_ACTIVE	1
+#define BTUART_TX_STATE_WAKEUP	2
+
+static void btuart_tx_work(struct work_struct *work)
+{
+	struct btuart_dev *bdev = container_of(work, struct btuart_dev,
+					       tx_work);
+	struct serdev_device *serdev = bdev->serdev;
+	struct hci_dev *hdev = bdev->hdev;
+
+	while (1) {
+		clear_bit(BTUART_TX_STATE_WAKEUP, &bdev->tx_state);
+
+		while (1) {
+			struct sk_buff *skb = skb_dequeue(&bdev->txq);
+			int len;
+
+			if (!skb)
+				break;
+
+			len = serdev_device_write_buf(serdev, skb->data,
+						      skb->len);
+			hdev->stat.byte_tx += len;
+
+			skb_pull(skb, len);
+			if (skb->len > 0) {
+				skb_queue_head(&bdev->txq, skb);
+				break;
+			}
+
+			switch (hci_skb_pkt_type(skb)) {
+			case HCI_COMMAND_PKT:
+				hdev->stat.cmd_tx++;
+				break;
+			case HCI_ACLDATA_PKT:
+				hdev->stat.acl_tx++;
+				break;
+			case HCI_SCODATA_PKT:
+				hdev->stat.sco_tx++;
+				break;
+			}
+
+			kfree_skb(skb);
+		}
+
+		if (!test_bit(BTUART_TX_STATE_WAKEUP, &bdev->tx_state))
+			break;
+	}
+
+	clear_bit(BTUART_TX_STATE_ACTIVE, &bdev->tx_state);
+}
+
+static int btuart_tx_wakeup(struct btuart_dev *bdev)
+{
+	if (test_and_set_bit(BTUART_TX_STATE_ACTIVE, &bdev->tx_state)) {
+		set_bit(BTUART_TX_STATE_WAKEUP, &bdev->tx_state);
+		return 0;
+	}
+
+	schedule_work(&bdev->tx_work);
+	return 0;
+}
+
+static int btuart_open(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+	int err;
+
+	err = serdev_device_open(bdev->serdev);
+	if (err) {
+		bt_dev_err(hdev, "Unable to open UART device %s",
+			   dev_name(&bdev->serdev->dev));
+		return err;
+	}
+
+	if (bdev->vnd->open) {
+		err = bdev->vnd->open(hdev);
+		if (err) {
+			serdev_device_close(bdev->serdev);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int btuart_close(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+	int err;
+
+	if (bdev->vnd->close) {
+		err = bdev->vnd->close(hdev);
+		if (err)
+			return err;
+	}
+
+	serdev_device_close(bdev->serdev);
+
+	return 0;
+}
+
+static int btuart_flush(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+
+	/* Flush any pending characters */
+	serdev_device_write_flush(bdev->serdev);
+	skb_queue_purge(&bdev->txq);
+
+	cancel_work_sync(&bdev->tx_work);
+
+	kfree_skb(bdev->rx_skb);
+	bdev->rx_skb = NULL;
+
+	return 0;
+}
+
+static int btuart_setup(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+
+	if (bdev->vnd->setup)
+		return bdev->vnd->setup(hdev);
+
+	return 0;
+}
+
+static int btuart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+	skb_queue_tail(&bdev->txq, skb);
+
+	btuart_tx_wakeup(bdev);
+	return 0;
+}
+
+static int btuart_receive_buf(struct serdev_device *serdev, const u8 *data,
+			      size_t count)
+{
+	struct btuart_dev *bdev = serdev_device_get_drvdata(serdev);
+	const struct btuart_vnd *vnd = bdev->vnd;
+
+	bdev->rx_skb = h4_recv_buf(bdev->hdev, bdev->rx_skb, data, count,
+				   vnd->recv_pkts, vnd->recv_pkts_cnt);
+	if (IS_ERR(bdev->rx_skb)) {
+		int err = PTR_ERR(bdev->rx_skb);
+		bt_dev_err(bdev->hdev, "Frame reassembly failed (%d)", err);
+		bdev->rx_skb = NULL;
+		return err;
+	}
+
+	bdev->hdev->stat.byte_rx += count;
+
+	return count;
+}
+
+static void btuart_write_wakeup(struct serdev_device *serdev)
+{
+	struct btuart_dev *bdev = serdev_device_get_drvdata(serdev);
+
+	btuart_tx_wakeup(bdev);
+}
+
+static const struct serdev_device_ops btuart_client_ops = {
+	.receive_buf = btuart_receive_buf,
+	.write_wakeup = btuart_write_wakeup,
+};
+
+#define BCM_NULL_PKT 0x00
+#define BCM_NULL_SIZE 0
+
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
+#define BCM_RECV_NULL \
+	.type = BCM_NULL_PKT, \
+	.hlen = BCM_NULL_SIZE, \
+	.loff = 0, \
+	.lsize = 0, \
+	.maxlen = BCM_NULL_SIZE
+
+static int bcm_set_diag(struct hci_dev *hdev, bool enable)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+	struct sk_buff *skb;
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	skb = bt_skb_alloc(3, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_u8(skb, BCM_LM_DIAG_PKT);
+	skb_put_u8(skb, 0xf0);
+	skb_put_u8(skb, enable);
+
+	skb_queue_tail(&bdev->txq, skb);
+	btuart_tx_wakeup(bdev);
+
+	return 0;
+}
+
+static int bcm_set_baudrate(struct btuart_dev *bdev, unsigned int speed)
+{
+	struct hci_dev *hdev = bdev->hdev;
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
+			bt_dev_err(hdev, "Failed to write clock (%d)", err);
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
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to write update baudrate (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int bcm_setup(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+	char fw_name[64];
+	const struct firmware *fw;
+	unsigned int speed;
+	int err;
+
+	hdev->set_diag = bcm_set_diag;
+	hdev->set_bdaddr = btbcm_set_bdaddr;
+
+	/* Init speed if any */
+	speed = 115200;
+
+	if (speed)
+		serdev_device_set_baudrate(bdev->serdev, speed);
+
+	/* Operational speed if any */
+	speed = 115200;
+
+	if (speed) {
+		err = bcm_set_baudrate(bdev, speed);
+		if (err)
+			bt_dev_err(hdev, "Failed to set baudrate");
+		else
+			serdev_device_set_baudrate(bdev->serdev, speed);
+	}
+
+	err = btbcm_initialize(hdev, fw_name, sizeof(fw_name));
+	if (err)
+		return err;
+
+	err = request_firmware(&fw, fw_name, &hdev->dev);
+	if (err < 0) {
+		bt_dev_warn(hdev, "Patch %s not found", fw_name);
+		return 0;
+	}
+
+	err = btbcm_patchram(bdev->hdev, fw);
+	if (err) {
+		bt_dev_err(hdev, "Patching failed (%d)", err);
+		goto finalize;
+	}
+
+	/* Init speed if any */
+	speed = 115200;
+
+	if (speed)
+		serdev_device_set_baudrate(bdev->serdev, speed);
+
+	/* Operational speed if any */
+	speed = 115200;
+
+	if (speed) {
+		err = bcm_set_baudrate(bdev, speed);
+		if (!err)
+			serdev_device_set_baudrate(bdev->serdev, speed);
+	}
+
+finalize:
+	release_firmware(fw);
+
+	err = btbcm_finalize(hdev);
+	if (err)
+		return err;
+
+	return err;
+}
+
+static const struct h4_recv_pkt bcm_recv_pkts[] = {
+	{ H4_RECV_ACL,      .recv = hci_recv_frame },
+	{ H4_RECV_SCO,      .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
+	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
+	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
+};
+
+static const struct btuart_vnd bcm_vnd = {
+	.recv_pkts	= bcm_recv_pkts,
+	.recv_pkts_cnt	= ARRAY_SIZE(bcm_recv_pkts),
+	.manufacturer	= 15,
+	.setup		= bcm_setup,
+};
+
+static const struct h4_recv_pkt default_recv_pkts[] = {
+	{ H4_RECV_ACL,      .recv = hci_recv_frame },
+	{ H4_RECV_SCO,      .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
+};
+
+static const struct btuart_vnd default_vnd = {
+	.recv_pkts	= default_recv_pkts,
+	.recv_pkts_cnt	= ARRAY_SIZE(default_recv_pkts),
+};
+
+static int btuart_probe(struct serdev_device *serdev)
+{
+	struct btuart_dev *bdev;
+	struct hci_dev *hdev;
+
+	bdev = devm_kzalloc(&serdev->dev, sizeof(*bdev), GFP_KERNEL);
+	if (!bdev)
+		return -ENOMEM;
+
+	/* Request the vendor specific data and callbacks */
+	bdev->vnd = device_get_match_data(&serdev->dev);
+	if (!bdev->vnd)
+		bdev->vnd = &default_vnd;
+
+	bdev->serdev = serdev;
+	serdev_device_set_drvdata(serdev, bdev);
+
+	serdev_device_set_client_ops(serdev, &btuart_client_ops);
+
+	INIT_WORK(&bdev->tx_work, btuart_tx_work);
+	skb_queue_head_init(&bdev->txq);
+
+	/* Initialize and register HCI device */
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		dev_err(&serdev->dev, "Can't allocate HCI device\n");
+		return -ENOMEM;
+	}
+
+	bdev->hdev = hdev;
+
+	hdev->bus = HCI_UART;
+	hci_set_drvdata(hdev, bdev);
+
+	/* Only when vendor specific setup callback is provided, consider
+	 * the manufacturer information valid. This avoids filling in the
+	 * value for Ericsson when nothing is specified.
+	 */
+	if (bdev->vnd->setup)
+		hdev->manufacturer = bdev->vnd->manufacturer;
+
+	hdev->open  = btuart_open;
+	hdev->close = btuart_close;
+	hdev->flush = btuart_flush;
+	hdev->setup = btuart_setup;
+	hdev->send  = btuart_send_frame;
+	SET_HCIDEV_DEV(hdev, &serdev->dev);
+
+	if (hci_register_dev(hdev) < 0) {
+		dev_err(&serdev->dev, "Can't register HCI device\n");
+		hci_free_dev(hdev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void btuart_remove(struct serdev_device *serdev)
+{
+	struct btuart_dev *bdev = serdev_device_get_drvdata(serdev);
+	struct hci_dev *hdev = bdev->hdev;
+
+	hci_unregister_dev(hdev);
+	hci_free_dev(hdev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id btuart_of_match_table[] = {
+	{ .compatible = "brcm,bcm43438-bt", .data = &bcm_vnd },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, btuart_of_match_table);
+#endif
+
+static struct serdev_device_driver btuart_driver = {
+	.probe = btuart_probe,
+	.remove = btuart_remove,
+	.driver = {
+		.name = "btuart",
+		.of_match_table = of_match_ptr(btuart_of_match_table),
+	},
+};
+
+module_serdev_device_driver(btuart_driver);
+
+MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
+MODULE_DESCRIPTION("Generic Bluetooth UART driver ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
new file mode 100644
index 000000000000..b0d5babca392
--- /dev/null
+++ b/drivers/bluetooth/h4_recv.h
@@ -0,0 +1,158 @@
+/*
+ *
+ *  Generic Bluetooth HCI UART driver
+ *
+ *  Copyright (C) 2015-2018  Intel Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+struct h4_recv_pkt {
+	u8  type;	/* Packet type */
+	u8  hlen;	/* Header length */
+	u8  loff;	/* Data length offset in header */
+	u8  lsize;	/* Data length field size */
+	u16 maxlen;	/* Max overall packet length */
+	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);
+};
+
+#define H4_RECV_ACL \
+	.type = HCI_ACLDATA_PKT, \
+	.hlen = HCI_ACL_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
+#define H4_RECV_SCO \
+	.type = HCI_SCODATA_PKT, \
+	.hlen = HCI_SCO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_SCO_SIZE
+
+#define H4_RECV_EVENT \
+	.type = HCI_EVENT_PKT, \
+	.hlen = HCI_EVENT_HDR_SIZE, \
+	.loff = 1, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_EVENT_SIZE
+
+static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
+					  struct sk_buff *skb,
+					  const unsigned char *buffer,
+					  int count,
+					  const struct h4_recv_pkt *pkts,
+					  int pkts_count)
+{
+	while (count) {
+		int i, len;
+
+		if (!count)
+			break;
+
+		if (!skb) {
+			for (i = 0; i < pkts_count; i++) {
+				if (buffer[0] != (&pkts[i])->type)
+					continue;
+
+				skb = bt_skb_alloc((&pkts[i])->maxlen,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				hci_skb_pkt_type(skb) = (&pkts[i])->type;
+				hci_skb_expect(skb) = (&pkts[i])->hlen;
+				break;
+			}
+
+			/* Check for invalid packet type */
+			if (!skb)
+				return ERR_PTR(-EILSEQ);
+
+			count -= 1;
+			buffer += 1;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+
+		/* Check for partial packet */
+		if (skb->len < hci_skb_expect(skb))
+			continue;
+
+		for (i = 0; i < pkts_count; i++) {
+			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
+				break;
+		}
+
+		if (i >= pkts_count) {
+			kfree_skb(skb);
+			return ERR_PTR(-EILSEQ);
+		}
+
+		if (skb->len == (&pkts[i])->hlen) {
+			u16 dlen;
+
+			switch ((&pkts[i])->lsize) {
+			case 0:
+				/* No variable data length */
+				dlen = 0;
+				break;
+			case 1:
+				/* Single octet variable length */
+				dlen = skb->data[(&pkts[i])->loff];
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			case 2:
+				/* Double octet variable length */
+				dlen = get_unaligned_le16(skb->data +
+							  (&pkts[i])->loff);
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			default:
+				/* Unsupported variable length */
+				kfree_skb(skb);
+				return ERR_PTR(-EILSEQ);
+			}
+
+			if (!dlen) {
+				/* No more data, complete frame */
+				(&pkts[i])->recv(hdev, skb);
+				skb = NULL;
+			}
+		} else {
+			/* Complete frame */
+			(&pkts[i])->recv(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	return skb;
+}
-- 
2.14.3

