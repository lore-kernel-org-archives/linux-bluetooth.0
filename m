Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C391C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD4164ED3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhBINie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:38:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34037 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhBINh7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 08:37:59 -0500
Received: from [123.112.66.2] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1l9TCd-00050T-HH; Tue, 09 Feb 2021 13:37:16 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@intel.com, luiz.dentz@gmail.com
Subject: [PATCH 1/3] Bluetooth: btusb: Add reset_hci handler
Date:   Tue,  9 Feb 2021 21:36:26 +0800
Message-Id: <20210209133629.12784-2-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209133629.12784-1-hui.wang@canonical.com>
References: <20210209133629.12784-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After users update the bluetooth firmware, they want the driver to
load the new firmware, with the current driver, users could not make
sure the driver will load the new firmware, on some laptops, they have
to run poweroff and cold boot the machine, on some desktops, they have
to wait for a couple of seconds between poweroff and cold boot, it is
very annoying to users.

Here adding a reset_hci handler, for hci on the USB bus, we provide
a generic method, this could make the device reset over the USB bus,
it will introduce calling disconnect() and probe(), but this doesn't
guarantee the hci enters bootloader mode and load the new firmware.
For Intel_new and Intel_newgen hcis, there is a method to make them
enter bootloader mode and reset over the USB bus, so we use specific
method to overwrite the generic method for those hcis.

If we have more specific methods to make some hcis enter bootloader
mode in future, we could overwrite the generic method for them like
Intel hcis.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/bluetooth/btusb.c        | 60 ++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 2 files changed, 61 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 20ef9377694f..79ec73e3d321 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -520,6 +520,7 @@ struct btusb_data {
 
 	struct work_struct work;
 	struct work_struct waker;
+	struct delayed_work reset_work;
 
 	struct usb_anchor deferred;
 	struct usb_anchor tx_anchor;
@@ -561,6 +562,8 @@ struct btusb_data {
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
+	void (*btusb_reset_hci_to_bootloader)(struct btusb_data *data);
+
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 	unsigned cmd_timeout_cnt;
 };
@@ -1384,6 +1387,7 @@ static int btusb_close(struct hci_dev *hdev)
 
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
+	cancel_delayed_work(&data->reset_work);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
@@ -3105,6 +3109,43 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
 	return 0;
 }
 
+static void btusb_intel_reset_hci_to_bootloader(struct btusb_data *btdata)
+{
+	btintel_reset_to_bootloader(btdata->hdev);
+}
+
+static void btusb_generic_reset_hci(struct btusb_data *btdata)
+{
+	struct usb_device *udev = btdata->udev;
+	struct usb_interface *intf = btdata->intf;
+	int r;
+
+	/* make sure the usb device is not rt suspended */
+	r = usb_autopm_get_interface(intf);
+	if (r < 0)
+		return;
+
+	r = usb_lock_device_for_reset(udev, NULL);
+	if (r < 0) {
+		usb_autopm_put_interface(intf);
+		return;
+	}
+
+	usb_reset_device(udev);
+
+	usb_unlock_device(udev);
+
+	usb_autopm_put_interface(intf);
+}
+
+static void btusb_reset_work(struct work_struct *work)
+{
+	struct btusb_data *btdata = container_of(work, struct btusb_data,
+						 reset_work.work);
+
+	btdata->btusb_reset_hci_to_bootloader(btdata);
+}
+
 static int btusb_shutdown_intel_new(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -3123,6 +3164,19 @@ static int btusb_shutdown_intel_new(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_reset_controller(struct hci_dev *hdev)
+{
+	struct btusb_data *btdata = hci_get_drvdata(hdev);
+
+	/* reset_work will reset the hci on the USB bus, it will introduce
+	 * calling disconnect() and probe(), so implement it in the process
+	 * context.
+	 */
+	schedule_delayed_work(&btdata->reset_work, 0);
+
+	return 0;
+}
+
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 
@@ -4354,6 +4408,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_DELAYED_WORK(&data->reset_work, btusb_reset_work);
 	init_usb_anchor(&data->deferred);
 	init_usb_anchor(&data->tx_anchor);
 	spin_lock_init(&data->txlock);
@@ -4405,6 +4460,7 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 	hdev->prevent_wake = btusb_prevent_wake;
+	hdev->reset_hci = btusb_reset_controller;
 
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
@@ -4418,6 +4474,8 @@ static int btusb_probe(struct usb_interface *intf,
 			goto out_free_dev;
 	}
 #endif
+	data->btusb_reset_hci_to_bootloader = btusb_generic_reset_hci;
+
 	if (id->driver_info & BTUSB_CW6622)
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 
@@ -4469,6 +4527,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		data->btusb_reset_hci_to_bootloader = btusb_intel_reset_hci_to_bootloader;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4489,6 +4548,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
+		data->btusb_reset_hci_to_bootloader = btusb_intel_reset_hci_to_bootloader;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
 	}
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 677a8c50b2ad..8f706baf160e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -581,6 +581,7 @@ struct hci_dev {
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
+	int (*reset_hci)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
-- 
2.25.1

