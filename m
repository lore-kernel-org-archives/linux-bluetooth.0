Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504EEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 22:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383433AbhLCWlk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359252AbhLCWlj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 17:41:39 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B09BC061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 14:38:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s137so4453016pgs.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 14:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55NxvElenEkteRCV9GpdgLFdp1nzahbHZFMTJhgArtY=;
        b=Y43TUnAbvZlQu4qQp0GAoxA61mMZY7rM8OlCXBTftvIquojRyM5Lk9PrHf853UH31y
         p2QKZRK3ZAXa3TmzsRRsa/Gk8RhAaaFxxjR8h0+prihPJoaDne+jRrYS4oRe245RdU6P
         qRVQW1f1rC2NbcliodR3A7QnyHeCZ36av41SZS+MfKNAAQM0GS/+Ql5x9AeOWkL/ZLe2
         R1W3182Tg2sKOo0ppcgHLFV73JJxq61XxBiEbt7xfVU2eVlYigeuZdG7tmZtcZ6qBhiB
         RAW+pYqOzUbAJTA4EDVTAEaiDGXZijC7okKIBZMAHTSUY+kZhp/n+y2s4GFgMzrUHtyR
         fTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55NxvElenEkteRCV9GpdgLFdp1nzahbHZFMTJhgArtY=;
        b=UrtrBhHBKUcC3w/xrqwcn+qgTpACuHsihwXqCLCldw65iJhYULrtgGMWmuCrevmd9e
         vKWMFXeUnAt2TP9rlY41UlhHrCTmxN+alpKkimZP3tsXm3ONDOfPFTnQ+YpxEr/1siZM
         3DMCweKPIqv5e/blwYpE9pbnyb2Gzu3JIR3J68aiRZSO1bT7SjIU9HL+iU3cZ14mNJEB
         sBTEMIyE7hCNO3G4gTFWF20Tg/NiuMEtLszU07rwimcxrBAx8/lgiKn26ITiWkZqws4V
         21TnmqQej8nqaSStDxFz19XcZzfyq6GYEsoCNxZcSvgWm9PKnwaniMC8qnWpOQBwMD1H
         JY0Q==
X-Gm-Message-State: AOAM533CLNUu8UgF4GiS+Znp/ifCIHad89i3VuPr368WTzlJyG9hmRRX
        +f3LlfEeoL0368PxrMHcR2PkgpTFl74=
X-Google-Smtp-Source: ABdhPJx5XAs6tC0OuOjak+ClffgzkVsG4xXso/VxRj+dn0qqiJcxqQOfJbEP5S5hXQt224RH+Saz2g==
X-Received: by 2002:a63:570b:: with SMTP id l11mr6667955pgb.480.1638571094504;
        Fri, 03 Dec 2021 14:38:14 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p124sm4153090pfg.110.2021.12.03.14.38.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:38:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: btusb: Add support for queuing during polling interval
Date:   Fri,  3 Dec 2021 14:38:13 -0800
Message-Id: <20211203223813.2326558-1-luiz.dentz@gmail.com>
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
interval is not enabled by default so it requires setting
force_poll_sync debugfs while the adapter is down.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Check for intr_interval instead of enable_poll_sync when dispatching
since the former can only be changed on open/resume.
v3: Change the way the feature is enabled from module parameter to debugfs
entry and rename it from enable_poll_sync to force_poll_sync.
v4: Cosmetic changes to address comments.

 drivers/bluetooth/btusb.c | 129 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 974b36a02375..fda5622b1d6e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -16,6 +16,7 @@
 #include <linux/of_irq.h>
 #include <linux/suspend.h>
 #include <linux/gpio/consumer.h>
+#include <linux/debugfs.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -31,7 +32,6 @@
 static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
-
 static bool reset = true;
 
 static struct usb_driver btusb_driver;
@@ -561,8 +561,13 @@ struct btusb_data {
 
 	unsigned long flags;
 
-	struct work_struct work;
-	struct work_struct waker;
+	bool poll_sync;
+	int intr_interval;
+	struct work_struct  work;
+	struct work_struct  waker;
+	struct delayed_work rx_work;
+
+	struct sk_buff_head acl_q;
 
 	struct usb_anchor deferred;
 	struct usb_anchor tx_anchor;
@@ -727,6 +732,16 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
+static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
+{
+	if (data->intr_interval) {
+		/* Trigger dequeue immediatelly if an event is received */
+		schedule_delayed_work(&data->rx_work, 0);
+	}
+
+	return data->recv_event(data->hdev, skb);
+}
+
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -772,7 +787,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_event(data->hdev, skb);
+			btusb_recv_event(data, skb);
 			skb = NULL;
 		}
 	}
@@ -783,6 +798,20 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
+static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
+{
+	/* Only queue ACL packet if intr_interval is set as it means
+	 * force_poll_sync has been enabled.
+	 */
+	if (!data->intr_interval)
+		return data->recv_acl(data->hdev, skb);
+
+	skb_queue_tail(&data->acl_q, skb);
+	schedule_delayed_work(&data->rx_work, data->intr_interval);
+
+	return 0;
+}
+
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
@@ -830,7 +859,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			data->recv_acl(data->hdev, skb);
+			btusb_recv_acl(data, skb);
 			skb = NULL;
 		}
 	}
@@ -986,6 +1015,28 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 		usb_unanchor_urb(urb);
 	}
 
+	/* Only initialize intr_interval if URB poll sync is enabled */
+	if (!data->poll_sync)
+		goto done;
+
+	/* The units are frames (milliseconds) for full and low speed devices,
+	 * and microframes (1/8 millisecond) for highspeed and SuperSpeed
+	 * devices.
+	 *
+	 * This is done once on open/resume so it shouldn't change even if
+	 * force_poll_sync changes.
+	 */
+	switch (urb->dev->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:	/* units are 125us */
+		data->intr_interval = usecs_to_jiffies(urb->interval * 125);
+		break;
+	default:
+		data->intr_interval = msecs_to_jiffies(urb->interval);
+		break;
+	}
+
+done:
 	usb_free_urb(urb);
 
 	return err;
@@ -1448,9 +1499,12 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
+	skb_queue_purge(&data->acl_q);
+
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
@@ -1482,6 +1536,10 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	cancel_delayed_work(&data->rx_work);
+
+	skb_queue_purge(&data->acl_q);
+
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	btusb_free_frags(data);
 
@@ -1845,6 +1903,17 @@ static void btusb_waker(struct work_struct *work)
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
@@ -3402,6 +3471,49 @@ static int btusb_shutdown_qca(struct hci_dev *hdev)
 	return 0;
 }
 
+static ssize_t force_poll_sync_read(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct btusb_data *data = file->private_data;
+	char buf[3];
+
+	buf[0] = data->poll_sync ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_poll_sync_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct btusb_data *data = file->private_data;
+	bool enable;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
+
+	/* Only allow changes while the adapter is down */
+	if (test_bit(HCI_UP, &data->hdev->flags))
+		return -EPERM;
+
+	if (data->poll_sync == enable)
+		return -EALREADY;
+
+	data->poll_sync = enable;
+
+	return count;
+}
+
+static const struct file_operations force_poll_sync_fops = {
+	.open		= simple_open,
+	.read		= force_poll_sync_read,
+	.write		= force_poll_sync_write,
+	.llseek		= default_llseek,
+};
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -3485,6 +3597,10 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
+
+	skb_queue_head_init(&data->acl_q);
+
 	init_usb_anchor(&data->deferred);
 	init_usb_anchor(&data->tx_anchor);
 	spin_lock_init(&data->txlock);
@@ -3750,6 +3866,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, data);
 
+	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
+			    &force_poll_sync_fops);
+
 	return 0;
 
 out_free_dev:
-- 
2.33.1

