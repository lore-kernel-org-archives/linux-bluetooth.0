Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C8E61A8C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 21:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhKRVxA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKRVw7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 16:52:59 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9451C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 13:49:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n8so6455992plf.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 13:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjHRoERsj6fqnTT2GOZn77CXHT34lzJ7DxMccGTq0SE=;
        b=pbi6x9RD3fAyhq+RSj3CEmFZAmZwFofUVvsyaPGsghpBYCgSW5+MN9oFGiNtbnLVxd
         v4qOvUWEwr/c7x5ESBGi/KIybvySu+We/pJ0tOYBNVOLANY64mUCI+mhrtSASAZS6xZt
         1aRi+183sxCtsxmKXMHhFJJdAlPZ2XagA/ypXwlCZRhxkach1G0+VDZqjX0DKFcmG6yf
         KZKTdR0xVivksI4Ll1CinRpoBwlukxMzsHl/xJ0yGMmSI0GqjW97K9Js7FNr6P9Ff20y
         G52Ox2KKTiEAfA00B77lokI1mYoJOVVe7QhchNuAuuSr8URVY9ZJ5pJYCJcZdVttONYZ
         Wpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjHRoERsj6fqnTT2GOZn77CXHT34lzJ7DxMccGTq0SE=;
        b=v0evnO4nCBs3021VBulobjdPApOFRE3SKDpo/oDqz9M/KuOvJTI80zKaqMwNI1wret
         Ovm5d6AI0aAMoxv2z8UaLlKJ/qS/5c29L2OzQELNddmDUTPdjDSXx+9ziIoZ1xkweKt+
         3JY/AfJU2htne5tb+bp5IXkt/UOO5j+R2onZGieBA2qgDeEbCdLIWG/PcB75SGTPAaR9
         HPmirlnp2vNnzPDjbcflnDNgruk/tLGWFe0fWWnArp40OFvfZs5zHJwsmxnEYmn+ntmT
         zukyOjdnC6jLGjPywpC/jfTjPW8X5FPQS5THYcXlyumLpa/7WVBbaVsE1/p86p70JLB/
         hh+g==
X-Gm-Message-State: AOAM531yNIB809eQm9DGa+XjavYiKjBvovFoKk4FGgZSucp7O9b8qR1P
        q82lI0YcrETDS2cf19WPa0j7vII0S9w=
X-Google-Smtp-Source: ABdhPJym8VJAFBpjwLomMiJ2SoMyShmp4rkoSKthShKxwr9j2qy/pIQRIwxh+SUulj/cp8YZnwii/g==
X-Received: by 2002:a17:902:6b47:b0:142:82e1:6c92 with SMTP id g7-20020a1709026b4700b0014282e16c92mr70808967plt.84.1637272198046;
        Thu, 18 Nov 2021 13:49:58 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p21sm579328pfh.43.2021.11.18.13.49.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:49:57 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: Add support for queuing during polling interval
Date:   Thu, 18 Nov 2021 13:49:56 -0800
Message-Id: <20211118214956.946365-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
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

With use of module option:

    enable_poll_sync

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Check for intr_interval instead of enable_poll_sync when dispatching
since the former can only be changed on open/resume.

 drivers/bluetooth/btusb.c | 81 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 30a057e1d4e3..272faa40b11c 100644
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
@@ -716,6 +720,15 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
+static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (data->intr_interval)
+		/* Trigger dequeue immediatelly if an event is received */
+		schedule_delayed_work(&data->rx_work, 0);
+
+	return data->recv_event(data->hdev, skb);
+}
+
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -761,7 +774,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_event(data->hdev, skb);
+			btusb_recv_event(data, skb);
 			skb = NULL;
 		}
 	}
@@ -772,6 +785,18 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (!data->intr_interval)
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
@@ -819,7 +844,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_acl(data->hdev, skb);
+			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
 	}
@@ -971,6 +996,27 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 		usb_unanchor_urb(urb);
 	}
 
+	/* Only initialize intr_interval if URB poll sync is enabled */
+	if (!enable_poll_sync)
+		goto done;
+
+	/* The units are frames (milliseconds) for full and low speed devices,
+	 * and microframes (1/8 millisecond) for highspeed and SuperSpeed
+	 * devices.
+	 *
+	 * This is done once on open/resume so it shouldn't change even if
+	 * enable_poll_sync changes.
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
+done:
 	usb_free_urb(urb);
 
 	return err;
@@ -1430,9 +1476,12 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
+	skb_queue_purge(&data->acl_q);
+
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
@@ -1464,6 +1513,10 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
+
+	skb_queue_purge(&data->acl_q);
+
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	btusb_free_frags(data);
 
@@ -1827,6 +1880,17 @@ static void btusb_waker(struct work_struct *work)
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
@@ -3456,6 +3520,10 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
+
+	skb_queue_head_init(&data->acl_q);
+
 	init_usb_anchor(&data->deferred);
 	init_usb_anchor(&data->tx_anchor);
 	spin_lock_init(&data->txlock);
@@ -3943,6 +4011,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
 module_param(enable_autosuspend, bool, 0644);
 MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 
+module_param(enable_poll_sync, bool, 0644);
+MODULE_PARM_DESC(enable_poll_sync, "Enable URB polling interval synchronization");
+
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
-- 
2.33.1

