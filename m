Return-Path: <SRS0=5ENf=AZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2807AC433E3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 23:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0192065E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jul 2020 23:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUDYAelp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGNXMD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGNXMD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jul 2020 19:12:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBA8C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2020 16:12:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so72318pgc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2020 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlTzMdk+7M90bKP45e+XUoQ4Pa5aVbYqIXRRa78peiI=;
        b=BUDYAelpVEE+jj0hBMPWbsEOB3f8w3/1FKtKul+sgZHuY1+Aky/IfYQcRTZWsdJVFT
         yCNsMUO/y/etGzQ1s41YM6282aG5BipV6jNJ9v7kSuRU6Mrn/IKZHEJ90tqaysPcfP+J
         H+vmw6WuowhxdR6w2V6q3ICTw8q179VZYnece9JVFPOvSIZ1v8kpt3gPeGJh7VFEEOJY
         k9lxyTNjE0M1tiZn01C66R3ifJwRqxsG46oUv+9fBSmWfysxZ+U7PkwvVH5juq4JBqWn
         uY3nl15CHBxohQD8LSqlL05p6occOdy6ETk2MtG4MJq0Tb6iUBgnqpLmuGz+QyJcXQia
         /Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlTzMdk+7M90bKP45e+XUoQ4Pa5aVbYqIXRRa78peiI=;
        b=RA5Q4TsU/yVCU75ulSE/1v69+kofDImLHEwnLIgUrghrQ9HiFJGnLuG0XQxpf7UIJ4
         uVHb+1cz3LLulX6tEB3AXalJtqVaQuKwfL8QsH3pHT/scnllMr6+e0ZlIEEuKHtcfu1M
         BpQdkjoN5vHhHJdVld7n2qmtoSJN/fqYgOq17SYVGezJrByGv9GhHzfRCsZtkxxKsOwm
         hvyABdk2SXxr2dS8nl+U3k3hRgJk2JBRGnj4Bo7CtiWvzjiTQgsN/Pc9QaZLnvPAGW+U
         AY+EInj85r3hlr8zrdENhcIibzvJWJHSlNitugNBCN1SWpppTO95gEYk3bDvOSxonz2X
         hnow==
X-Gm-Message-State: AOAM532qp6qLJCBUP3V50PHdC3e9YG6KnfSsndBk3PjNaMjTsFhkZTdg
        c1X49qMIEw4SESBMSsNQQpEO5Jgwp+8=
X-Google-Smtp-Source: ABdhPJz1ZofVq1FZzaYJVxyE+Lb4rj+mrTgDR1zAiOAVsDw1crGw1VnlQ4sa49EgiaLy4mpuDuBxIg==
X-Received: by 2002:a63:531e:: with SMTP id h30mr5053980pgb.165.1594768322011;
        Tue, 14 Jul 2020 16:12:02 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g10sm133608pjs.20.2020.07.14.16.12.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 16:12:01 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth: btusb: Add support for queuing during polling interval
Date:   Tue, 14 Jul 2020 16:12:00 -0700
Message-Id: <20200714231200.690268-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
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
 drivers/bluetooth/Kconfig |  7 ++++
 drivers/bluetooth/btusb.c | 88 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 84 insertions(+), 11 deletions(-)

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
index faa863dd5d0a..8fcf19bc5b36 100644
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
@@ -465,8 +465,12 @@ struct btusb_data {
 
 	unsigned long flags;
 
-	struct work_struct work;
-	struct work_struct waker;
+	struct work_struct  work;
+	struct work_struct  waker;
+	struct delayed_work rx_work;
+
+	struct sk_buff_head acl_q;
+	struct sk_buff_head evt_q;
 
 	struct usb_anchor deferred;
 	struct usb_anchor tx_anchor;
@@ -503,7 +507,7 @@ struct btusb_data {
 	int isoc_altsetting;
 	int suspend_count;
 
-	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_event)(struct btusb_data *data, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
@@ -653,7 +657,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_event(data->hdev, skb);
+			data->recv_event(data, skb);
 			skb = NULL;
 		}
 	}
@@ -664,6 +668,25 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
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
+	/* TODO: Calculate polling interval based on endpoint bInterval? */
+	return btusb_rx_queue(data, skb, &data->acl_q, msecs_to_jiffies(1));
+}
+
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -711,7 +734,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			hci_recv_frame(data->hdev, skb);
+			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
 	}
@@ -1329,9 +1352,13 @@ static int btusb_close(struct hci_dev *hdev)
 
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
@@ -1363,6 +1390,11 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
+
+	skb_queue_purge(&data->acl_q);
+	skb_queue_purge(&data->evt_q);
+
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	btusb_free_frags(data);
 
@@ -1718,6 +1750,25 @@ static void btusb_waker(struct work_struct *work)
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
@@ -2155,10 +2206,8 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
 		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
 }
 
-static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
+static int btusb_recv_event_intel(struct btusb_data *data, struct sk_buff *skb)
 {
-	struct btusb_data *data = hci_get_drvdata(hdev);
-
 	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
 
@@ -2187,7 +2236,7 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	return hci_recv_frame(hdev, skb);
+	return hci_recv_frame(data->hdev, skb);
 }
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -3767,6 +3816,15 @@ static bool btusb_prevent_wake(struct hci_dev *hdev)
 	return !device_may_wakeup(&data->udev->dev);
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
@@ -3850,6 +3908,11 @@ static int btusb_probe(struct usb_interface *intf,
 
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
@@ -3866,7 +3929,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk_intel;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
 	} else {
-		data->recv_event = hci_recv_frame;
+		data->recv_event = btusb_recv_evt;
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
@@ -4335,6 +4398,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
 module_param(enable_autosuspend, bool, 0644);
 MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 
+module_param(enable_interval, bool, 0644);
+MODULE_PARM_DESC(enable_interval, "Enable USB polling interval by default");
+
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
-- 
2.25.3

