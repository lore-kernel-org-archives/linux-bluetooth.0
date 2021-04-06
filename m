Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C4AC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE76E613D2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhDFSTl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:19:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53914 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbhDFSTl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 14:19:41 -0400
Received: from localhost.localdomain (p4ff9f418.dip0.t-ipconnect.de [79.249.244.24])
        by mail.holtmann.org (Postfix) with ESMTPSA id C13A5CECC5
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Apr 2021 20:27:14 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: Add support for virtio transport driver
Date:   Tue,  6 Apr 2021 20:19:24 +0200
Message-Id: <20210406181927.313769-2-marcel@holtmann.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for Bluetooth HCI transport over virtio.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig       |  10 +
 drivers/bluetooth/Makefile      |   2 +
 drivers/bluetooth/virtio_bt.c   | 401 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_bt.h  |  31 +++
 include/uapi/linux/virtio_ids.h |   1 +
 5 files changed, 445 insertions(+)
 create mode 100644 drivers/bluetooth/virtio_bt.c
 create mode 100644 include/uapi/linux/virtio_bt.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4e73a531b377..851842372c9b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -425,4 +425,14 @@ config BT_HCIRSI
 	  Say Y here to compile support for HCI over Redpine into the
 	  kernel or say M to compile as a module.
 
+config BT_VIRTIO
+	tristate "Virtio Bluetooth driver"
+	depends on VIRTIO
+	help
+	  Virtio Bluetooth support driver.
+	  This driver supports Virtio Bluetooth devices.
+
+	  Say Y here to compile support for HCI over Virtio into the
+	  kernel or say M to compile as a module.
+
 endmenu
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 1a58a3ae142c..16286ea2655d 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -26,6 +26,8 @@ obj-$(CONFIG_BT_BCM)		+= btbcm.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
 obj-$(CONFIG_BT_QCA)		+= btqca.o
 
+obj-$(CONFIG_BT_VIRTIO)		+= virtio_bt.o
+
 obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
 
 obj-$(CONFIG_BT_HCIRSI)		+= btrsi.o
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
new file mode 100644
index 000000000000..c804db7e90f8
--- /dev/null
+++ b/drivers/bluetooth/virtio_bt.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/skbuff.h>
+
+#include <uapi/linux/virtio_ids.h>
+#include <uapi/linux/virtio_bt.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#define VERSION "0.1"
+
+enum {
+	VIRTBT_VQ_TX,
+	VIRTBT_VQ_RX,
+	VIRTBT_NUM_VQS,
+};
+
+struct virtio_bluetooth {
+	struct virtio_device *vdev;
+	struct virtqueue *vqs[VIRTBT_NUM_VQS];
+	struct work_struct rx;
+	struct hci_dev *hdev;
+};
+
+static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
+{
+	struct virtqueue *vq = vbt->vqs[VIRTBT_VQ_RX];
+	struct scatterlist sg[1];
+	struct sk_buff *skb;
+	int err;
+
+	skb = alloc_skb(1000, GFP_KERNEL);
+	sg_init_one(sg, skb->data, 1000);
+
+	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	return 0;
+}
+
+static int virtbt_open(struct hci_dev *hdev)
+{
+	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+
+	if (virtbt_add_inbuf(vbt) < 0)
+		return -EIO;
+
+	virtqueue_kick(vbt->vqs[VIRTBT_VQ_RX]);
+	return 0;
+}
+
+static int virtbt_close(struct hci_dev *hdev)
+{
+	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	int i;
+
+	cancel_work_sync(&vbt->rx);
+
+	for (i = 0; i < ARRAY_SIZE(vbt->vqs); i++) {
+		struct virtqueue *vq = vbt->vqs[i];
+		struct sk_buff *skb;
+
+		while ((skb = virtqueue_detach_unused_buf(vq)))
+			kfree_skb(skb);
+	}
+
+	return 0;
+}
+
+static int virtbt_flush(struct hci_dev *hdev)
+{
+	return 0;
+}
+
+static int virtbt_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	struct scatterlist sg[1];
+	int err;
+
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	sg_init_one(sg, skb->data, skb->len);
+	err = virtqueue_add_outbuf(vbt->vqs[VIRTBT_VQ_TX], sg, 1, skb,
+				   GFP_KERNEL);
+	if (err) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	virtqueue_kick(vbt->vqs[VIRTBT_VQ_TX]);
+	return 0;
+}
+
+static int virtbt_setup_zephyr(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	/* Read Build Information */
+	skb = __hci_cmd_sync(hdev, 0xfc08, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
+
+	hci_set_fw_info(hdev, "%s", skb->data + 1);
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int virtbt_set_bdaddr_zephyr(struct hci_dev *hdev,
+				    const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+
+	/* Write BD_ADDR */
+	skb = __hci_cmd_sync(hdev, 0xfc06, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int virtbt_setup_intel(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	/* Intel Read Version */
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int virtbt_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+
+	/* Intel Write BD Address */
+	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int virtbt_setup_realtek(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	/* Read ROM Version */
+	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	bt_dev_info(hdev, "ROM version %u", *((__u8 *) (skb->data + 1)));
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int virtbt_shutdown_generic(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	/* Reset */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
+{
+	__u8 pkt_type;
+
+	pkt_type = *((__u8 *) skb->data);
+	skb_pull(skb, 1);
+
+	switch (pkt_type) {
+	case HCI_EVENT_PKT:
+	case HCI_ACLDATA_PKT:
+	case HCI_SCODATA_PKT:
+	case HCI_ISODATA_PKT:
+		hci_skb_pkt_type(skb) = pkt_type;
+		hci_recv_frame(vbt->hdev, skb);
+		break;
+	}
+}
+
+static void virtbt_rx_work(struct work_struct *work)
+{
+	struct virtio_bluetooth *vbt = container_of(work,
+						    struct virtio_bluetooth, rx);
+	struct sk_buff *skb;
+	unsigned int len;
+
+	skb = virtqueue_get_buf(vbt->vqs[VIRTBT_VQ_RX], &len);
+	if (!skb)
+		return;
+
+	skb->len = len;
+	virtbt_rx_handle(vbt, skb);
+
+	if (virtbt_add_inbuf(vbt) < 0)
+		return;
+
+	virtqueue_kick(vbt->vqs[VIRTBT_VQ_RX]);
+}
+
+static void virtbt_tx_done(struct virtqueue *vq)
+{
+	struct sk_buff *skb;
+	unsigned int len;
+
+	while ((skb = virtqueue_get_buf(vq, &len)))
+		kfree_skb(skb);
+}
+
+static void virtbt_rx_done(struct virtqueue *vq)
+{
+	struct virtio_bluetooth *vbt = vq->vdev->priv;
+
+	schedule_work(&vbt->rx);
+}
+
+static int virtbt_probe(struct virtio_device *vdev)
+{
+	vq_callback_t *callbacks[VIRTBT_NUM_VQS] = {
+		[VIRTBT_VQ_TX] = virtbt_tx_done,
+		[VIRTBT_VQ_RX] = virtbt_rx_done,
+	};
+	const char *names[VIRTBT_NUM_VQS] = {
+		[VIRTBT_VQ_TX] = "tx",
+		[VIRTBT_VQ_RX] = "rx",
+	};
+	struct virtio_bluetooth *vbt;
+	struct hci_dev *hdev;
+	int err;
+	__u8 type;
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
+		return -ENODEV;
+
+	type = virtio_cread8(vdev, offsetof(struct virtio_bt_config, type));
+
+	switch (type) {
+	case VIRTIO_BT_CONFIG_TYPE_PRIMARY:
+	case VIRTIO_BT_CONFIG_TYPE_AMP:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vbt = kzalloc(sizeof(*vbt), GFP_KERNEL);
+	if (!vbt)
+		return -ENOMEM;
+
+	vdev->priv = vbt;
+	vbt->vdev = vdev;
+
+	INIT_WORK(&vbt->rx, virtbt_rx_work);
+
+	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, callbacks,
+			      names, NULL);
+	if (err)
+		return err;
+
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	vbt->hdev = hdev;
+
+	hdev->bus = HCI_VIRTIO;
+	hdev->dev_type = type;
+	hci_set_drvdata(hdev, vbt);
+
+	hdev->open  = virtbt_open;
+	hdev->close = virtbt_close;
+	hdev->flush = virtbt_flush;
+	hdev->send  = virtbt_send_frame;
+
+	if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
+		__u16 vendor;
+
+		virtio_cread(vdev, struct virtio_bt_config, vendor, &vendor);
+
+		switch (vendor) {
+		case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
+			hdev->manufacturer = 1521;
+			hdev->setup = virtbt_setup_zephyr;
+			hdev->shutdown = virtbt_shutdown_generic;
+			hdev->set_bdaddr = virtbt_set_bdaddr_zephyr;
+			break;
+
+		case VIRTIO_BT_CONFIG_VENDOR_INTEL:
+			hdev->manufacturer = 2;
+			hdev->setup = virtbt_setup_intel;
+			hdev->shutdown = virtbt_shutdown_generic;
+			hdev->set_bdaddr = virtbt_set_bdaddr_intel;
+			set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+			set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+			break;
+
+		case VIRTIO_BT_CONFIG_VENDOR_REALTEK:
+			hdev->manufacturer = 93;
+			hdev->setup = virtbt_setup_realtek;
+			hdev->shutdown = virtbt_shutdown_generic;
+			set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+			break;
+		}
+	}
+
+	if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
+		__u16 msft_opcode;
+
+		virtio_cread(vdev, struct virtio_bt_config,
+			     msft_opcode, &msft_opcode);
+
+		hci_set_msft_opcode(hdev, msft_opcode);
+	}
+
+	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
+		hci_set_aosp_capable(hdev);
+
+	if (hci_register_dev(hdev) < 0) {
+		hci_free_dev(hdev);
+		err = -EBUSY;
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	vdev->config->del_vqs(vdev);
+	return err;
+}
+
+static void virtbt_remove(struct virtio_device *vdev)
+{
+	struct virtio_bluetooth *vbt = vdev->priv;
+	struct hci_dev *hdev = vbt->hdev;
+
+	hci_unregister_dev(hdev);
+	vdev->config->reset(vdev);
+
+	hci_free_dev(hdev);
+	vbt->hdev = NULL;
+
+	vdev->config->del_vqs(vdev);
+	kfree(vbt);
+}
+
+static struct virtio_device_id virtbt_table[] = {
+	{ VIRTIO_ID_BT, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+MODULE_DEVICE_TABLE(virtio, virtbt_table);
+
+static const unsigned int virtbt_features[] = {
+	VIRTIO_BT_F_VND_HCI,
+	VIRTIO_BT_F_MSFT_EXT,
+	VIRTIO_BT_F_AOSP_EXT,
+};
+
+static struct virtio_driver virtbt_driver = {
+	.driver.name         = KBUILD_MODNAME,
+	.driver.owner        = THIS_MODULE,
+	.feature_table       = virtbt_features,
+	.feature_table_size  = ARRAY_SIZE(virtbt_features),
+	.id_table            = virtbt_table,
+	.probe               = virtbt_probe,
+	.remove              = virtbt_remove,
+};
+
+module_virtio_driver(virtbt_driver);
+
+MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
+MODULE_DESCRIPTION("Generic Bluetooth VIRTIO driver ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
new file mode 100644
index 000000000000..0cedceaacf88
--- /dev/null
+++ b/include/uapi/linux/virtio_bt.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+#ifndef _UAPI_LINUX_VIRTIO_BT_H
+#define _UAPI_LINUX_VIRTIO_BT_H
+
+#include <linux/virtio_types.h>
+
+/* Feature bits */
+#define VIRTIO_BT_F_VND_HCI	0	/* Indicates vendor command support */
+#define VIRTIO_BT_F_MSFT_EXT	1	/* Indicates MSFT vendor support */
+#define VIRTIO_BT_F_AOSP_EXT	2	/* Indicates AOSP vendor support */
+
+enum virtio_bt_config_type {
+	VIRTIO_BT_CONFIG_TYPE_PRIMARY	= 0,
+	VIRTIO_BT_CONFIG_TYPE_AMP	= 1,
+};
+
+enum virtio_bt_config_vendor {
+	VIRTIO_BT_CONFIG_VENDOR_NONE	= 0,
+	VIRTIO_BT_CONFIG_VENDOR_ZEPHYR	= 1,
+	VIRTIO_BT_CONFIG_VENDOR_INTEL	= 2,
+	VIRTIO_BT_CONFIG_VENDOR_REALTEK	= 3,
+};
+
+struct virtio_bt_config {
+	__u8  type;
+	__u16 vendor;
+	__u16 msft_opcode;
+} __attribute__((packed));
+
+#endif /* _UAPI_LINUX_VIRTIO_BT_H */
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index bc1c0621f5ed..b4f468e9441d 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -53,6 +53,7 @@
 #define VIRTIO_ID_MEM			24 /* virtio mem */
 #define VIRTIO_ID_FS			26 /* virtio filesystem */
 #define VIRTIO_ID_PMEM			27 /* virtio pmem */
+#define VIRTIO_ID_BT			28 /* virtio bluetooth */
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.30.2

