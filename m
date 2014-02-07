Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 2/2] bluetooth: Add initial support for BT chip over SMD
Date: Fri, 7 Feb 2014 12:35:37 +0100
Message-ID: <1391772937-12802-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1391772937-12802-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1391772937-12802-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for Qualcomm chips which uses msm
shared memory driver as a transport layer.

This driver based on SMD driver found in  msm kernel branch.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 drivers/bluetooth/Kconfig   |   9 +
 drivers/bluetooth/Makefile  |   1 +
 drivers/bluetooth/hci_smd.c | 460 ++++++++++++++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci.h |   1 +
 4 files changed, 471 insertions(+)
 create mode 100644 drivers/bluetooth/hci_smd.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 11a6104..f8a46c5 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -242,4 +242,13 @@ config BT_WILINK
 
 	  Say Y here to compile support for Texas Instrument's WiLink7 driver
 	  into the kernel or say M to compile it as module.
+
+config BT_HCISMD
+        tristate "Qualcomm HCI Shared Memory Driver"
+        help
+          This enables the Bluetooth driver for Qualcomm BT devices uses SMD interface.
+
+          Say Y here to compile support for Qualcomm over SMD driver into kernel or
+          say M to compile it as module (hci_smd)
+
 endmenu
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 9fe8a87..0666e60 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BT_ATH3K)		+= ath3k.o
 obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
+obj-$(CONFIG_BT_HCISMD)		+= hci_smd.o
 
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
diff --git a/drivers/bluetooth/hci_smd.c b/drivers/bluetooth/hci_smd.c
new file mode 100644
index 0000000..9eb3675
--- /dev/null
+++ b/drivers/bluetooth/hci_smd.c
@@ -0,0 +1,460 @@
+
+/*
+ *
+ *  HCI_SMD (HCI Shared Memory Driver) is Qualcomm's Shared memory driver
+ *  for the HCI protocol.
+ *
+ *  Copyright (C) 2000-2001  Qualcomm Incorporated
+ *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
+ *  Copyright (C) 2004-2006  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011, Code Aurora Forum. All rights reserved.
+ *  Copyright (C) 2014, Intel Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include <linux/smd.h>
+
+#define VERSION "0.1"
+
+#define SMD_CMD_CHANNEL "APPS_RIVA_BT_CMD"
+#define SMD_ACL_CHANNEL "APPS_RIVA_BT_ACL"
+
+#define SMD_APPS_RIVA_BT_CMD_READY 0x01
+#define SMD_APPS_RIVA_BT_ACL_READY 0x02
+#define SMD_READY ((SMD_APPS_RIVA_BT_CMD_READY) | (SMD_APPS_RIVA_BT_ACL_READY))
+
+struct rx_work {
+	struct work_struct work;
+	struct smd_data *smd;
+	struct hci_dev *hdev;
+	u8 pkt_type;
+};
+
+struct smd_channel_data {
+	struct hci_dev *hdev;
+	struct workqueue_struct *wq;
+	struct smd_data *smd;
+};
+
+struct hci_smd_data {
+	struct hci_dev *hdev;
+
+	struct smd_channel_data *smd_cmd;
+	struct smd_channel_data *smd_acl;
+	u8 ready_flags;
+	struct completion smd_ready;
+
+	/* Protects ready_flags */
+	spinlock_t flags_lock;
+};
+
+static struct hci_smd_data hs;
+
+static void hci_smd_channel_open(struct smd_channel_data *scd)
+{
+	const char *name = scd->smd->pdev->name;
+
+	spin_lock(&hs.flags_lock);
+	if (scd->hdev) {
+		set_bit(HCI_RUNNING, &scd->hdev->flags);
+		spin_unlock(&hs.flags_lock);
+		return;
+	}
+
+	if (!strncmp(name, SMD_CMD_CHANNEL, sizeof(SMD_CMD_CHANNEL)))
+		hs.ready_flags |= SMD_APPS_RIVA_BT_CMD_READY;
+
+	if (!strncmp(name, SMD_ACL_CHANNEL, sizeof(SMD_ACL_CHANNEL)))
+		hs.ready_flags |= SMD_APPS_RIVA_BT_ACL_READY;
+
+	if ((SMD_READY & hs.ready_flags) != SMD_READY) {
+		spin_unlock(&hs.flags_lock);
+		return;
+	}
+
+	spin_unlock(&hs.flags_lock);
+	complete_all(&hs.smd_ready);
+}
+
+static void hci_smd_channel_close(struct smd_channel_data *scd)
+{
+	if (!scd->hdev)
+		return;
+
+	clear_bit(HCI_RUNNING, &scd->hdev->flags);
+}
+
+static int hci_smd_open(struct hci_dev *hdev)
+{
+	BT_DBG("hdev %s, %p", hdev->name, hdev);
+
+	set_bit(HCI_RUNNING, &hdev->flags);
+	return 0;
+}
+
+static int hci_smd_close(struct hci_dev *hdev)
+{
+	BT_DBG("hdev %s %p", hdev->name, hdev);
+
+	clear_bit(HCI_RUNNING, &hdev->flags);
+	return 0;
+}
+
+static void hci_smd_rx_work(struct work_struct *work)
+{
+	struct rx_work *wk = container_of(work, struct rx_work, work);
+	u8 type = wk->pkt_type;
+	struct smd_data *smd = wk->smd;
+	struct hci_dev *hdev = wk->hdev;
+	struct sk_buff *skb;
+	int len;
+
+	BT_DBG("hdev %p, %02x", hdev, type);
+
+	/*It s save to free work here */
+	kfree(wk);
+
+	len = smd->ops.read_avail(smd);
+	if (len > HCI_MAX_FRAME_SIZE)
+		return;
+
+	while (len) {
+		int rc = 0;
+		skb = bt_skb_alloc(len, GFP_KERNEL);
+		if (!skb)
+			return;
+
+		rc = smd->ops.read(smd, skb_put(skb, len), len);
+		if (rc < len) {
+			kfree_skb(skb);
+			return;
+		}
+
+		skb->dev = (void *)hdev;
+		bt_cb(skb)->pkt_type = type;
+		skb_orphan(skb);
+
+		rc = hci_recv_frame(hdev, skb);
+		if (rc < 0) {
+			BT_ERR("Failed to pass skb to Bluetooth module");
+			kfree_skb(skb);
+			return;
+		}
+
+		len = smd->ops.read_avail(smd);
+		if (len > HCI_MAX_FRAME_SIZE)
+			return;
+	}
+}
+
+static int hci_smd_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_smd_data *hs = hci_get_drvdata(hdev);
+	struct smd_data *smd;
+	int sent;
+
+	if (!hdev) {
+		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
+		return -ENODEV;
+	}
+
+	if (!test_bit(HCI_RUNNING, &(hdev->flags)))
+		return -EBUSY;
+
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_COMMAND_PKT:
+		smd  = hs->smd_cmd->smd;
+		sent = smd->ops.write(smd, skb->data, skb->len);
+		break;
+	case HCI_ACLDATA_PKT:
+	case HCI_SCODATA_PKT:
+		smd = hs->smd_acl->smd;
+		sent = smd->ops.write(smd, skb->data, skb->len);
+		break;
+	default:
+		BT_ERR("Unknown package");
+		kfree_skb(skb);
+		return -EPROTO;
+	}
+
+	kfree_skb(skb);
+
+	if (sent < 0) {
+		BT_ERR("Failed to send all data");
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static struct rx_work *alloc_rx_work(u8 pkt_type, struct smd_data *smd,
+							struct hci_dev *hdev)
+{
+	struct rx_work *w = kmalloc(sizeof(*w), GFP_ATOMIC);
+
+	if (!w) {
+		BT_ERR("Could not allocate work");
+		return NULL;
+	}
+
+	INIT_WORK(&w->work, hci_smd_rx_work);
+	w->pkt_type = pkt_type;
+	w->smd = smd;
+	w->hdev = hdev;
+
+	return w;
+}
+
+static void hci_smd_notify(struct platform_device *pdev,
+					unsigned int event, u8 pkt_type)
+{
+	struct smd_channel_data *scd = dev_get_drvdata(&pdev->dev);
+	struct hci_dev *hdev = scd->hdev;
+	struct rx_work *w;
+
+	if (!scd || !scd->smd) {
+		BT_ERR("SMD channel data not avaiable");
+		return;
+	}
+
+	switch (event) {
+	case SMD_EVENT_DATA:
+		w = alloc_rx_work(pkt_type, scd->smd, hdev);
+		if (w && hdev)
+			queue_work(scd->wq, &w->work);
+		else
+			BT_ERR("Read failed hdev:%p, work:%p ", hdev, w);
+		break;
+	case SMD_EVENT_OPEN:
+		hci_smd_channel_open(scd);
+		break;
+	case SMD_EVENT_CLOSE:
+		hci_smd_channel_close(scd);
+		break;
+	default:
+		break;
+	}
+}
+
+static void hci_smd_notify_cmd(struct platform_device *pdev,
+							unsigned int event)
+{
+	hci_smd_notify(pdev, event, HCI_EVENT_PKT);
+}
+
+static void hci_smd_notify_data(struct platform_device *pdev,
+							unsigned int event)
+{
+	hci_smd_notify(pdev, event, HCI_ACLDATA_PKT);
+}
+
+static int hci_smd_register(void)
+{
+	struct hci_dev *hdev;
+	int err;
+
+	BT_DBG("hci_smd_register");
+
+	/*
+	* Lets use two different worqueues for Event and ACL data so we make
+	* sure that Event will never be blocked by ACL data.
+	*/
+	hs.smd_cmd->wq = alloc_workqueue("smd_event", WQ_HIGHPRI |
+					WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	if (!hs.smd_cmd->wq) {
+		BT_ERR("Error allocating event workqueue");
+		err = -ENOMEM;
+		goto close_smd;
+	}
+
+	hs.smd_acl->wq = alloc_workqueue("data_event", WQ_HIGHPRI |
+					WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	if (!hs.smd_acl->wq) {
+		BT_ERR("Error allocating data workqueue");
+		destroy_workqueue(hs.smd_cmd->wq);
+		err = -ENOMEM;
+		goto close_smd;
+	}
+
+	/* Initialize and register HCI device */
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		BT_ERR("Error allocating HCI dev");
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	hdev->bus = HCI_SMD;
+	hci_set_drvdata(hdev, &hs);
+
+	hdev->open	= hci_smd_open;
+	hdev->close	= hci_smd_close;
+	hdev->send	= hci_smd_send_frame;
+
+	hs.smd_cmd->hdev = hdev;
+	hs.smd_acl->hdev = hdev;
+
+	err = hci_register_dev(hdev);
+	if (!err)
+		return 0;
+
+	BT_ERR("Can't register HCI device");
+	hci_free_dev(hdev);
+
+cleanup:
+	destroy_workqueue(hs.smd_cmd->wq);
+	destroy_workqueue(hs.smd_acl->wq);
+close_smd:
+	hs.smd_cmd->smd->ops.close(hs.smd_cmd->smd);
+	hs.smd_acl->smd->ops.close(hs.smd_acl->smd);
+
+	return err;
+}
+
+static int smd_cmd_channel_probe(struct platform_device *pdev)
+{
+	struct smd_data *smd = dev_get_platdata(&pdev->dev);
+	struct smd_channel_data *scd = kzalloc(sizeof(*scd), GFP_KERNEL);
+	int err;
+
+	scd->smd = smd;
+	hs.smd_cmd = scd;
+
+	dev_set_drvdata(&pdev->dev, scd);
+
+	err = smd->ops.open(smd, hci_smd_notify_cmd);
+	if (err < 0) {
+		BT_ERR("Can not open %s", SMD_CMD_CHANNEL);
+		return err;
+	}
+
+	return 0;
+}
+
+static int smd_data_channel_probe(struct platform_device *pdev)
+{
+	struct smd_data *smd = dev_get_platdata(&pdev->dev);
+	struct smd_channel_data *scd = kzalloc(sizeof(*scd), GFP_KERNEL);
+	int err;
+
+	scd->smd = smd;
+	hs.smd_acl = scd;
+
+	dev_set_drvdata(&pdev->dev, scd);
+
+	err = smd->ops.open(smd, hci_smd_notify_data);
+	if (err < 0) {
+		BT_ERR("Can not open %s", SMD_ACL_CHANNEL);
+		return err;
+	}
+
+	return 0;
+}
+
+
+static int smd_channel_remove(struct platform_device *pdev)
+{
+	struct smd_data *smd = dev_get_platdata(&pdev->dev);
+	return smd->ops.close(smd);
+}
+
+static struct platform_driver cmd_drv = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = SMD_CMD_CHANNEL,
+	},
+	.probe = smd_cmd_channel_probe,
+	.remove = smd_channel_remove,
+
+};
+
+static struct platform_driver acl_drv = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = SMD_ACL_CHANNEL,
+	},
+	.probe = smd_data_channel_probe,
+	.remove = smd_channel_remove,
+};
+
+static int __init hci_smd_init(void)
+{
+	int err;
+
+	BT_INFO("hci smd driver ver %s", VERSION);
+
+	memset(&hs, 0, sizeof(hs));
+
+	spin_lock_init(&hs.flags_lock);
+	init_completion(&hs.smd_ready);
+
+	/*
+	* SMD channels are represented by platform devices. We need them two
+	* for BT operations. Channel for BT CMD/EVENT traffic and BT ACL DATA
+	* traffic.
+	*/
+	err = platform_driver_register(&cmd_drv);
+	if (err < 0) {
+		BT_ERR("Failed to register drv: %s err: %d",
+						cmd_drv.driver.name, err);
+		return err;
+	}
+
+	err = platform_driver_register(&acl_drv);
+	if (err < 0) {
+		BT_ERR("Failed to register drv: %s, err: %d",
+						acl_drv.driver.name, err);
+		platform_driver_unregister(&cmd_drv);
+		return err;
+	}
+
+	/* Let's wait until SMD channels are ready */
+	err = wait_for_completion_killable_timeout(&hs.smd_ready,
+		msecs_to_jiffies(5000));
+	if (err <= 0)
+		return err;
+
+	return hci_smd_register();
+}
+
+static void __exit hci_smd_exit(void)
+{
+	kfree(hs.smd_cmd);
+	kfree(hs.smd_acl);
+
+	platform_driver_unregister(&cmd_drv);
+	platform_driver_unregister(&acl_drv);
+}
+
+module_init(hci_smd_init);
+module_exit(hci_smd_exit);
+
+MODULE_AUTHOR("Lukasz Rymanowski <lukasz.rymanowski@tieto.com>");
+MODULE_AUTHOR("Ankur Nandwani <ankurn@codeaurora.org>");
+MODULE_DESCRIPTION("Bluetooth SMD driver ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL v2");
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 352d3d7..149b06a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -58,6 +58,7 @@
 #define HCI_RS232	4
 #define HCI_PCI		5
 #define HCI_SDIO	6
+#define HCI_SMD		7
 
 /* HCI controller types */
 #define HCI_BREDR	0x00
-- 
1.8.4

