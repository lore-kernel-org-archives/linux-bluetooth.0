Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A634C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F6860FDA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 23:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbhKHXE5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhKHXE4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Nov 2021 18:04:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC21C061570
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Nov 2021 15:02:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r5so17374276pls.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Nov 2021 15:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkZ4dR8VU8zFaDsWkHNkhfNBSaxZA8t4kmXkh/+ETj4=;
        b=BVLUx8SLS6ELcJSHjRbXe439H8XsIzmBDcE53JBzD6NzExWf9NVdO+Z327npRidA+M
         g4y5hCHWqofYWo/vb+9a5bAJ9rAiExYunvhUqbTjO1UspZ21/XZgMxe8fE00dH6Z134e
         G+WQ/zWG/sVKaKHYyDxo7qzsoskCKaodS1NRuSDDuVwBso1kT0SDcaPTUT3FEDP5PM7/
         goe7Jq6pVKxjtf4A+5JnkqaqsDeFQ2ACjA1HGnyi6dsT/X6A3H/g97ATBIRMrvxl9Hzr
         2fWGejHoGrqvfwwUtFoYL1k0+V3JWvrOFl1VdwLaclBO2e8K/1VOUQXKsDHBrtD14+aX
         4Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkZ4dR8VU8zFaDsWkHNkhfNBSaxZA8t4kmXkh/+ETj4=;
        b=mGxlWk67HgfzwNsU0OC/ZXhjKnTchZni9XfUQIahmaQh0bS9zTmBVvckqrNCMDorKA
         SwoDm6XI0rd4cZMdU+xyM80ooXfhz+8+Y8XMbhz+Y+y5R1YTC4vVdcfSonKTiBbKGVTf
         3JseVqOVzeNw/H9ME+0c2ziYiE2HHtIdQiwD3mci96HwR9pySrlDDSQryDD94QdVUOuT
         jTWMlBvwqOVNhdTADajYnXk52nD0BhuWlax8GkO62tlL0XZzwx6ESYjjYonMaR8WnWOS
         rn4Td22qb/+AU0R8augkVgBEFQ7tp6VfYZg9Go0zpXK1yHCHEiFHdmMgPQImMPj8oVcW
         JRuQ==
X-Gm-Message-State: AOAM531UJFK4MgLAFtGDYLOoGgDZuQ8kyLodsvoP5EFKEuLxj8c+4Thq
        nN0/djF/pTfJ9yBplS8yQTN9RYstPmE=
X-Google-Smtp-Source: ABdhPJx4+VglTfB71qXwr7kBVuUXhJ9zooDEryFrh/vfoZBlDIYy/orISujxlxBKWsTJagVKZRIW1A==
X-Received: by 2002:a17:902:ce85:b0:141:de7d:514e with SMTP id f5-20020a170902ce8500b00141de7d514emr2963780plg.0.1636412531322;
        Mon, 08 Nov 2021 15:02:11 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h134sm5750156pfe.67.2021.11.08.15.02.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:02:10 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for queuing during polling interval
Date:   Mon,  8 Nov 2021 15:02:10 -0800
Message-Id: <20211108230210.931731-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes btusb to queue ACL and events during a polling interval
by using of a delayed work, with the interval working as a time window
where frames received from different endpoints are considered to be
arrived at same time and then attempt to resolve potential conflics by
processing the events ahead of ACL packets.

It worth noting though that priorizing events over ACL data may result
in inverting the order compared to how they appeared over the air, for
instance there may be packets received before a disconnect event that
will be discarded and unencrypted packets received before encryption
change which would considered encrypted, because of these potential
changes on the order the support for queuing during the polling
interval is not enabled by default so platforms have the following
means to enable it:

At runtime with use of module option:

    enable_poll_sync

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 89 +++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 46d892bbde62..29aa0f346ace 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -31,7 +31,7 @@
 static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
-
+static bool enable_poll_sync;
 static bool reset = true;
 
 static struct usb_driver btusb_driver;
@@ -550,8 +550,12 @@ struct btusb_data {
 
 	unsigned long flags;
 
-	struct work_struct work;
-	struct work_struct waker;
+	int intr_interval;
+	struct work_struct  work;
+	struct work_struct  waker;
+	struct delayed_work rx_work;
+
+	struct sk_buff_head acl_q;
 
 	struct usb_anchor deferred;
 	struct usb_anchor tx_anchor;
@@ -588,8 +592,8 @@ struct btusb_data {
 	int isoc_altsetting;
 	int suspend_count;
 
-	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
@@ -761,7 +765,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_event(data->hdev, skb);
+			data->recv_event(data, skb);
 			skb = NULL;
 		}
 	}
@@ -772,6 +776,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (!enable_poll_sync)
+		return data->recv_acl(data->hdev, skb);
+
+	skb_queue_tail(&data->acl_q, skb);
+
+	schedule_delayed_work(&data->rx_work, data->intr_interval);
+
+	return 0;
+}
+
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -819,7 +835,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_acl(data->hdev, skb);
+			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
 	}
@@ -971,6 +987,19 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 		usb_unanchor_urb(urb);
 	}
 
+	/* The units are frames (milliseconds) for full and low speed devices,
+	 * and microframes (1/8 millisecond) for highspeed and SuperSpeed
+	 * devices.
+	 */
+	switch (urb->dev->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:	/* units are 125us */
+		data->intr_interval = usecs_to_jiffies(urb->interval * 125);
+		break;
+	default:
+		data->intr_interval = msecs_to_jiffies(urb->interval);
+	}
+
 	usb_free_urb(urb);
 
 	return err;
@@ -1430,9 +1459,12 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
+	skb_queue_purge(&data->acl_q);
+
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
@@ -1464,6 +1496,10 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
+
+	skb_queue_purge(&data->acl_q);
+
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	btusb_free_frags(data);
 
@@ -1827,6 +1863,17 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+static void btusb_rx_work(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data,
+					       rx_work.work);
+	struct sk_buff *skb;
+
+	/* Dequeue ACL data received during the interval */
+	while ((skb = skb_dequeue(&data->acl_q)))
+		data->recv_acl(data->hdev, skb);
+}
+
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -2028,9 +2075,9 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
-static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
+static int btusb_recv_event_intel(struct btusb_data *data, struct sk_buff *skb)
 {
-	if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+	if (btintel_test_flag(data->hdev, INTEL_BOOTLOADER)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
 
 		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
@@ -2044,7 +2091,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 				 * the device sends a vendor specific event
 				 * indicating that the bootup completed.
 				 */
-				btintel_bootup(hdev, ptr, len);
+				btintel_bootup(data->hdev, ptr, len);
 				break;
 			case 0x06:
 				/* When the firmware loading completes the
@@ -2052,13 +2099,14 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 				 * indicating the result of the firmware
 				 * loading.
 				 */
-				btintel_secure_send_result(hdev, ptr, len);
+				btintel_secure_send_result(data->hdev, ptr,
+							   len);
 				break;
 			}
 		}
 	}
 
-	return hci_recv_frame(hdev, skb);
+	return hci_recv_frame(data->hdev, skb);
 }
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -3372,6 +3420,16 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_recv_evt(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (enable_poll_sync) {
+		/* Trigger dequeue immediatelly if an event is received */
+		schedule_delayed_work(&data->rx_work, 0);
+	}
+
+	return hci_recv_frame(data->hdev, skb);
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3455,6 +3513,10 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
+
+	skb_queue_head_init(&data->acl_q);
+
 	init_usb_anchor(&data->deferred);
 	init_usb_anchor(&data->tx_anchor);
 	spin_lock_init(&data->txlock);
@@ -3468,7 +3530,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	priv_size = 0;
 
-	data->recv_event = hci_recv_frame;
+	data->recv_event = btusb_recv_evt;
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
@@ -3942,6 +4004,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
 module_param(enable_autosuspend, bool, 0644);
 MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 
+module_param(enable_poll_sync, bool, 0644);
+MODULE_PARM_DESC(enable_poll_sync, "Enable URB polling interval synchronization");
+
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
-- 
2.31.1

