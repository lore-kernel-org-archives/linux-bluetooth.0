Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18EDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1B121BE5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 21:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbhAYVsl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732600AbhAYVsR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 16:48:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B86C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 13:47:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u4so470246pjn.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 13:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlX1Ba077hyvWDmmjxJ782rrfB4TJc4X/oYfs2uNiKo=;
        b=IhXIA4spGYfcwpD06M0h0qvUHPA2scgyCC3Zpe9CQFiok4NTzIXfwth9V9MSSjISXc
         MnX9iGfPG1n1sWHC4KG5IMLnjl1GEHs9ommryDKrdQNmAyM5AztDQMyRsuw2jViXdRUC
         I2ejQEN4gWhxdAk+sg+JapMkC2OxWnXGP2rt70bAXD18XsUfK7pic4zLbV5kFa7yoic4
         JVWI0vz/KZzAh1BD7rKFORtm8IBsfWZNk6HLJZOpyb2fq1MuZkrhnhgqz3fFqX5gt9BL
         HWZUOMkyHEKK/ABX7NX/psZPLlhpEVKlHSNjQBil9M1jDSBhLxyxl0O2rjcNzqztE4xJ
         r4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlX1Ba077hyvWDmmjxJ782rrfB4TJc4X/oYfs2uNiKo=;
        b=jWaapttFy/resvdAeH1hPWcR89OmA7ztETd7vjdb0ThbF2jbxPfvXLZqZ8gweL7yfK
         R5AVcgjdntu6g4uSnOI/6OMYv5zFsRX2q+OQ2eyQ3OH6sCPHHpHa5Y8IJCEuqCEbvZhb
         aEb2K7YiBejYny0VZFMcI99omGkhRlx1fdYFaSM7i9dXz9s7bS68XMVzfwqm5ZEVldmv
         cAqlDz2u3glT+iL59j4L88Y+bQA+N9IV+dHgKnfvnmeYP6/7tyi0LgtZd7BmLXTZHfhY
         lO9V1j7Er7jR0Dh1K2hAmAqU6y3pGZgVEqW5mg58kw1ef2mFvmFRWno3t8cHgJeDc1/q
         khMw==
X-Gm-Message-State: AOAM531UmHNOavv+dV0mJWtK4e4ox4+B2ZQf+4LjxvJAifAWmGFWtJf4
        W2YBm25+QWQm/Ubi+YP/2mwY/i5BTjqhCw==
X-Google-Smtp-Source: ABdhPJw6QTbU9S9KMlghMQGL7Jawk9Gv8srJ2Wu1g+adXbB5xYgyJyu/HmVk2as6YXXiHc/B2D2Eqw==
X-Received: by 2002:a17:90b:2352:: with SMTP id ms18mr2298710pjb.138.1611611253478;
        Mon, 25 Jan 2021 13:47:33 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d10sm17166879pfn.218.2021.01.25.13.47.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:47:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add support for queuing during polling interval
Date:   Mon, 25 Jan 2021 13:47:31 -0800
Message-Id: <20210125214731.1650546-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
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

At build-time:

    CONFIG_BT_HCIBTUSB_INTERVAL=y

At runtime with use of module option:

    enable_interval

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---

v2: Calculate the delayed_work interval based on the intr urb->interval which
is derived from endpoint bInterval.

 drivers/bluetooth/Kconfig |   7 +++
 drivers/bluetooth/btusb.c | 102 ++++++++++++++++++++++++++++++++++----
 2 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4e73a531b377..2f20a853d946 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -41,6 +41,13 @@ config BT_HCIBTUSB_AUTOSUSPEND
 	  This can be overridden by passing btusb.enable_autosuspend=[y|n]
 	  on the kernel commandline.
 
+config BT_HCIBTUSB_INTERVAL
+	bool "Enable notification of USB polling interval"
+	depends on BT_HCIBTUSB
+	help
+	  Say Y here to enable notification of USB polling interval for
+	  Bluetooth USB devices by default.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b14102fba601..f2208a219b89 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -30,7 +30,7 @@
 static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
-
+static bool enable_interval = IS_ENABLED(CONFIG_BT_HCIBTUSB_INTERVAL);
 static bool reset = true;
 
 static struct usb_driver btusb_driver;
@@ -519,8 +519,13 @@ struct btusb_data {
 
 	unsigned long flags;
 
-	struct work_struct work;
-	struct work_struct waker;
+	int intr_interval;
+	struct work_struct  work;
+	struct work_struct  waker;
+	struct delayed_work rx_work;
+
+	struct sk_buff_head acl_q;
+	struct sk_buff_head evt_q;
 
 	struct usb_anchor deferred;
 	struct usb_anchor tx_anchor;
@@ -557,7 +562,7 @@ struct btusb_data {
 	int isoc_altsetting;
 	int suspend_count;
 
-	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
@@ -707,7 +712,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_event(data->hdev, skb);
+			data->recv_event(data, skb);
 			skb = NULL;
 		}
 	}
@@ -718,6 +723,25 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static int btusb_rx_queue(struct btusb_data *data, struct sk_buff *skb,
+			  struct sk_buff_head *queue, unsigned int interval)
+{
+	skb_queue_tail(queue, skb);
+
+	schedule_delayed_work(&data->rx_work, interval);
+
+	return 0;
+}
+
+static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (!enable_interval)
+		return hci_recv_frame(data->hdev, skb);
+
+	return btusb_rx_queue(data, skb, &data->acl_q,
+			      usecs_to_jiffies(data->intr_interval));
+}
+
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -765,7 +789,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			hci_recv_frame(data->hdev, skb);
+			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
 	}
@@ -917,6 +941,19 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 		usb_unanchor_urb(urb);
 	}
 
+	/* The units are frames (milliseconds) for full and low speed devices,
+	 * and microframes (1/8 millisecond) for highspeed and SuperSpeed
+	 * devices.
+	 */
+	switch (urb->dev->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:	/* units are 125us */
+		data->intr_interval = urb->interval * 125;
+		break;
+	default:
+		data->intr_interval = urb->interval * 1000;
+	}
+
 	usb_free_urb(urb);
 
 	return err;
@@ -1383,9 +1420,13 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
+	skb_queue_purge(&data->acl_q);
+	skb_queue_purge(&data->evt_q);
+
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
@@ -1417,6 +1458,11 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
+
+	skb_queue_purge(&data->acl_q);
+	skb_queue_purge(&data->evt_q);
+
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	btusb_free_frags(data);
 
@@ -1769,6 +1815,25 @@ static void btusb_waker(struct work_struct *work)
 	usb_autopm_put_interface(data->intf);
 }
 
+static void btusb_rx_dequeue(struct btusb_data *data,
+			     struct sk_buff_head *queue)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(queue)))
+		hci_recv_frame(data->hdev, skb);
+}
+
+static void btusb_rx_work(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data,
+					       rx_work.work);
+
+	/* Process HCI event packets so states changes are synchronized first */
+	btusb_rx_dequeue(data, &data->evt_q);
+	btusb_rx_dequeue(data, &data->acl_q);
+}
+
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -2304,10 +2369,8 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
 		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
 }
 
-static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
+static int btusb_recv_event_intel(struct btusb_data *data, struct sk_buff *skb)
 {
-	struct btusb_data *data = hci_get_drvdata(hdev);
-
 	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
 
@@ -2336,7 +2399,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	return hci_recv_frame(hdev, skb);
+	return hci_recv_frame(data->hdev, skb);
 }
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -4279,6 +4342,15 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_recv_evt(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (!enable_interval)
+		return hci_recv_frame(data->hdev, skb);
+
+	/* Don't delay event processing */
+	return btusb_rx_queue(data, skb, &data->evt_q, 0);
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -4362,6 +4434,11 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
+
+	skb_queue_head_init(&data->acl_q);
+	skb_queue_head_init(&data->evt_q);
+
 	init_usb_anchor(&data->deferred);
 	init_usb_anchor(&data->tx_anchor);
 	spin_lock_init(&data->txlock);
@@ -4378,7 +4455,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk_intel;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
 	} else {
-		data->recv_event = hci_recv_frame;
+		data->recv_event = btusb_recv_evt;
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
@@ -4867,6 +4944,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
 module_param(enable_autosuspend, bool, 0644);
 MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 
+module_param(enable_interval, bool, 0644);
+MODULE_PARM_DESC(enable_interval, "Enable USB polling interval by default");
+
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
-- 
2.26.2

