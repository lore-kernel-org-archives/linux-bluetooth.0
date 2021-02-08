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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D94C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112BA64E82
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhBHVeY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbhBHVdd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 16:33:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760BC061786
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 13:32:52 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o7so11125646pgl.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Feb 2021 13:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=searM4F25Q++SUxJnWhAzAHr3ZCMKui4L0vxH5Tlk58=;
        b=Arrrg+mAZaEAKKJYaRTcYy1JJMcD7x3uwDmNsYbz99kPel8XwZj5jtJPVv2IKNGAsL
         qrDF6ZVF97u8h3qgSMAJhyDF5/moI1VnxB3fjbemNfZV9t8S7U3WTsW+SpE2WwftFv1V
         P/paLiOqs+gUrDF+3QYMf8gCeTywvAZe8bVAzewTcOUjiVf83u9C567yw72DW5OXVWXV
         HrgRY8Q8/UKMCG8Vv/deZ0sUL4l8qFEe5wQMgdr+0RATMXY7c/O0XjD3GRi+qGCmE8o2
         JelfXeixEB8cp6AniozKW5500YQSp7BLMu9BkfxrgH4mhhqHYqM15qNBKT7s18ySHC5H
         kNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=searM4F25Q++SUxJnWhAzAHr3ZCMKui4L0vxH5Tlk58=;
        b=kiGqXGipLIqSCKapTJ6AYyAZ16c/oIILkmTPtCdaokwIxYPO3LOwikZtYsWkchTEtg
         tY713zPKlKfpIYXKmiiFX8m1c2e/3CnwRd01rQr25Ch8zPLn9lrrhIMWz9yf8q/WvM1M
         R8GWfHsA4UFwODIrcjBiv7BPR/t8SaCPTQTXSL1ds/vfkwXFqBkxpTwBoFrldqjDOBos
         rJb4MfbpJ/I1T+WLSQY4g9rEC17orEZEEgBXuYoXyg3OW3t0ohs+Sb1KuHh/cIVex0PH
         niICV5DX0YOxF3aDCahdHRZIyciydVUYCUyAu1yjgioqBTbu9BVsK719/DJ8rShR8y0k
         kqUA==
X-Gm-Message-State: AOAM530o0zQMD0HcVMl17CRY/psz8jobS0wOCjP6iYuyuTRmNfTwTS3C
        ErUe1URZ0yRX9+fyRJZqWr+ZAEukhCCfXg==
X-Google-Smtp-Source: ABdhPJxtrPKMj91Z/36oELHANSdda01tT25QkmpmyzxQpYBlxVGRHlWNHLNC/Phd5mby+CuzEinzRg==
X-Received: by 2002:a63:fc1c:: with SMTP id j28mr9348937pgi.281.1612819971880;
        Mon, 08 Feb 2021 13:32:51 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e198sm9311802pfh.126.2021.02.08.13.32.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:32:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for queuing during polling interval
Date:   Mon,  8 Feb 2021 13:32:49 -0800
Message-Id: <20210208213249.1712700-1-luiz.dentz@gmail.com>
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

At runtime with use of module option:

    enable_poll_sync

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Calculate the delayed_work interval based on the intr urb->interval
which is derived from endpoint bInterval.
v3: Drop use of a queue for events.
v4: Rename enable_interval to enable_poll_sync and drop use of Kconfig option.

 drivers/bluetooth/btusb.c | 84 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c9374ca46d87..66ada8217797 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -30,7 +30,7 @@
 static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
-
+static bool enable_poll_sync;
 static bool reset = true;
 
 static struct usb_driver btusb_driver;
@@ -519,8 +519,12 @@ struct btusb_data {
 
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
@@ -557,7 +561,7 @@ struct btusb_data {
 	int isoc_altsetting;
 	int suspend_count;
 
-	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
@@ -707,7 +711,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_event(data->hdev, skb);
+			data->recv_event(data, skb);
 			skb = NULL;
 		}
 	}
@@ -718,6 +722,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (!enable_poll_sync)
+		return hci_recv_frame(data->hdev, skb);
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
@@ -775,7 +791,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			hci_recv_frame(data->hdev, skb);
+			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
 	}
@@ -927,6 +943,19 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
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
@@ -1393,9 +1422,12 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
+	skb_queue_purge(&data->acl_q);
+
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
@@ -1427,6 +1459,10 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
+
+	skb_queue_purge(&data->acl_q);
+
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	btusb_free_frags(data);
 
@@ -1786,6 +1822,17 @@ static void btusb_waker(struct work_struct *work)
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
+		hci_recv_frame(data->hdev, skb);
+}
+
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -2321,10 +2368,8 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
 		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
 }
 
-static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
+static int btusb_recv_event_intel(struct btusb_data *data, struct sk_buff *skb)
 {
-	struct btusb_data *data = hci_get_drvdata(hdev);
-
 	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
 
@@ -2353,7 +2398,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	return hci_recv_frame(hdev, skb);
+	return hci_recv_frame(data->hdev, skb);
 }
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -4303,6 +4348,16 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
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
@@ -4386,6 +4441,10 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
+
+	skb_queue_head_init(&data->acl_q);
+
 	init_usb_anchor(&data->deferred);
 	init_usb_anchor(&data->tx_anchor);
 	spin_lock_init(&data->txlock);
@@ -4402,7 +4461,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk_intel;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
 	} else {
-		data->recv_event = hci_recv_frame;
+		data->recv_event = btusb_recv_evt;
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
@@ -4891,6 +4950,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
 module_param(enable_autosuspend, bool, 0644);
 MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 
+module_param(enable_poll_sync, bool, 0644);
+MODULE_PARM_DESC(enable_poll_sync, "Enable URB polling interval synchronization");
+
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
-- 
2.26.2

