Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D5369D45
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683405; cv=none; b=T0qCsOo3GK8j5OrERPUcg45G+wM+XyotgOhf3CJJftZcIjzjfCIW+TdwiwkToRpXCqB8x9SFRhIKKMUwkeAFcXDozkdo/I9sO7R+zalEeLN3nJWlAXKzURHl68aWDVDGsOnWII0WK8zVDi4CddCDdcSdzQ/O1nLPJaxmbmJgpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683405; c=relaxed/simple;
	bh=3nV06/fmiYZ0+kWSXWjKqVAcAfnzVoy6iwmeVaMtLYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLINVQEl6zHP10pM0G6bytuSTpNQ6pcocPs9ztSL+P6jR48Lh6QREz0qwo7JdzEz78WO6zj7GTlLMxJuH//m/9nonepsFWeaQwH4sNPUn+ead2hUYHb21htyEyT/oA6Tgdm6lO/3XqzXBUALA+sHdRtbeZdrCB/dav0NTfCXh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDV8z+8j; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDV8z+8j"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9d7464b71so4262486a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 18:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784683400; x=1785288200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTozAgYVbv8PXIg+i6zYVacsZ0ZyFrxTEXZv+6ygGlY=;
        b=iDV8z+8jFEp5UE2tZqUGcAzsHgwfxF1mGJRvgAKQN7xvGf/W/GWXMqwX1l9ivm42DN
         4QllbYOdFGBy/LaKheohXJDPKWj15OoWHhosgUsKOJXvq38HDsBtlrEWYhrcBNfR2r3b
         jqOG6ZOVAoyrx2GwlJi6dLfp8UQf/4otPo3iaF7XazDuDrr7pH+8xdzt+6xXopGjGUSy
         eQqb5kjpWndoz8qJ/H/7TVPDm9uPfDRK9zMi48Ap6vFrYKlUPVG55hT1/zlGRUfs4UmU
         +9hqhaEt7IbUgf3F6oqrfnC0IKUIzqU6WeeW9R4pGAcjgo54VSAOBXRNi0XzT76vNJKF
         Pl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784683400; x=1785288200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTozAgYVbv8PXIg+i6zYVacsZ0ZyFrxTEXZv+6ygGlY=;
        b=rdCFOWBZZGj+VwiBiPAm1pK/3RREx9IgQ0ypfP6V0643faOQ88x9LmjQkVcDGFNAng
         KQKDJFJoZ3NO+kftWvu79cd4sFECo1Uchvhgq2LgCu5HRdAFxvFLIRRbubmBFaI5e1sp
         DeOuwaN9sbkuCZT13HZxGyldu9MN2tN+3gUNGgwkLn/8GdeWeefdI+Zt1AodaLDcJ3i/
         9Mh4bs0E2F5jXCW9O3hSzDN+ZJlGHVDnChDyBpA9HFlExIiRuUM3vNHBKAMTzdqseLQW
         ATacDNaM0VirxPcHtJz9s/5XI6oHm+v81jljyuMWesxObf+trghOCf3hKlDFAf+swPgo
         U7sw==
X-Gm-Message-State: AOJu0YzLYBm77kNK+S0BgHfifadi9ke26J9RDXyKQvvF5mtcyU9E/is1
	Wdzz2HQzXnFSy/CD5+tpClFUbhms2cWqxFNeQ2EWOhJNY6p7GNK0tztFQWWg0y2SI6s=
X-Gm-Gg: AfdE7clC9j86qb/3L1oTvcj8dNrwZHI6rYeAPtUL7BAdcsb78T6/cVZewlHP8p6cYsb
	7TOiMqUOs4l+K/2KD2ZfgpoKs6kWcOExmWbqT4VCxNa8w54bdRxALVqHXZ85xx+C9UIPo5f7H2X
	q0HsppciR2poqEhhphAko+tt/do1S6+M9SlpUYItFuss7NomUelaCm5OG+w2VmlCEqoSgLJzGrM
	R6m7Okf0/srhOi3M7wfjgtGEegJxz381e4DNrOmlHqycbafVZedmGxilEndFqJlYz0BgMUBb1qF
	MWchCUBWBPcWW69LmYfLA9zlJgwAuEiSzG9BBcT/95WpefxAXRcyIoAQlRpUUv+J2ABsy7C/sqW
	cg9hmmpehFbKwhw7tMqGlL8YT3zZC9AiLGCXHtl93c+qKGxUeyuT0VeUy43//ZcdToh2hYOzyM0
	YQhN1iTo2VCMThVE/wAA==
X-Received: by 2002:a05:6830:6481:b0:7e9:d277:6e2e with SMTP id 46e09a7af769-7ed9aa456fdmr11636281a34.7.1784683399687;
        Tue, 21 Jul 2026 18:23:19 -0700 (PDT)
Received: from en1.tailc430e3.ts.net ([204.144.167.9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a108679sm304883a34.27.2026.07.21.18.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 18:23:18 -0700 (PDT)
From: Amir Abudubai <amirabudubai@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Amir Abudubai <amirabudubai@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Gate ACL delivery on HCI handle presence
Date: Tue, 21 Jul 2026 20:23:11 -0500
Message-ID: <20260722012311.35434-1-amirabudubai@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some USB devices, the interrupt-IN endpoint can lag the bulk-IN
endpoint by multiple polling intervals. Early ACL data can then reach
HCI before the Connection Complete event establishes its handle, causing
the data to be dropped for an unknown handle.

This issue was observed and the fix verified on the following adapters:
  * 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
  * 7392:c611 Edimax Technology Co., Ltd Edimax Bluetooth Adapter

Extend the existing poll_sync queue to support independent release gates
while preserving its underlying behavior. Add an optional gate which
holds ACL delivery until the HCI handle appears or a bounded timeout
expires. Anchor both time gates to packet arrival to prevent timeout
drift from accumulating as queued packets reach the FIFO head.

BT_HCIBTUSB_EARLY_ACL_HOLD controls whether the gate is enabled by
default. The force_early_acl_hold debugfs entry controls it per adapter
while the adapter is down.

Assisted-by: OpenCode:openai/gpt-5.6-sol
Signed-off-by: Amir Abudubai <amirabudubai@gmail.com>
---
 drivers/bluetooth/Kconfig |  10 ++
 drivers/bluetooth/btusb.c | 292 +++++++++++++++++++++++++++++++++-----
 2 files changed, 266 insertions(+), 36 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4e8c24d757e9..648c0d8b1496 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,6 +56,16 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
+config BT_HCIBTUSB_EARLY_ACL_HOLD
+	bool "Enable early ACL hold for Bluetooth USB devices by default"
+	depends on BT_HCIBTUSB
+	help
+	  Hold ACL packets whose connection handle is not yet known until the
+	  connection appears or a bounded timeout expires.
+
+	  Say Y here to enable early ACL hold for Bluetooth USB devices by
+	  default.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4d59b28ab30f..a59b0ed91d18 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -34,6 +34,8 @@ static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 static bool enable_poll_sync = IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC);
+static bool enable_early_acl_hold =
+	IS_ENABLED(CONFIG_BT_HCIBTUSB_EARLY_ACL_HOLD);
 static bool reset = true;
 
 static struct usb_driver btusb_driver;
@@ -956,6 +958,8 @@ struct btqca_data {
 };
 
 #define BTUSB_MAX_ISOC_FRAMES	10
+#define BTUSB_RX_RECHECK_DELAY	msecs_to_jiffies(1)
+#define BTUSB_EARLY_ACL_HOLD_MIN_US	5000U
 
 #define BTUSB_INTR_RUNNING	0
 #define BTUSB_BULK_RUNNING	1
@@ -987,7 +991,10 @@ struct btusb_data {
 	unsigned long flags;
 
 	bool poll_sync;
+	bool early_acl_hold;
 	int intr_interval;
+	unsigned long early_acl_timeout;
+	ktime_t last_event;
 	struct work_struct  work;
 	struct work_struct  waker;
 	struct delayed_work rx_work;
@@ -1252,14 +1259,100 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
-static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
+static void btusb_rx_queue_purge(struct btusb_data *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->rxlock, flags);
+	skb_queue_purge(&data->acl_q);
+	spin_unlock_irqrestore(&data->rxlock, flags);
+}
+
+static ktime_t btusb_rx_deadline(struct sk_buff *skb, unsigned long timeout)
 {
-	if (data->intr_interval) {
-		/* Trigger dequeue immediately if an event is received */
-		schedule_delayed_work(&data->rx_work, 0);
+	return ktime_add_ns(skb->tstamp, jiffies_to_nsecs(timeout));
+}
+
+static bool btusb_rx_hold_expired(struct sk_buff *skb, unsigned long timeout,
+				  ktime_t now)
+{
+	return !ktime_before(now, btusb_rx_deadline(skb, timeout));
+}
+
+static unsigned long btusb_rx_hold_delay(struct sk_buff *skb,
+					 unsigned long timeout, ktime_t now)
+{
+	s64 remaining = ktime_to_ns(ktime_sub(btusb_rx_deadline(skb, timeout),
+					      now));
+
+	if (remaining <= 0)
+		return 0;
+
+	return max_t(unsigned long, 1, nsecs_to_jiffies(remaining));
+}
+
+static bool btusb_poll_sync_should_hold(struct btusb_data *data,
+					struct sk_buff *skb, ktime_t now)
+{
+	unsigned long interval = READ_ONCE(data->intr_interval);
+
+	if (!interval || !ktime_before(data->last_event, skb->tstamp))
+		return false;
+
+	return !btusb_rx_hold_expired(skb, interval, now);
+}
+
+static bool btusb_acl_should_hold(struct btusb_data *data,
+				  struct sk_buff *skb, ktime_t now)
+{
+	unsigned long timeout = READ_ONCE(data->early_acl_timeout);
+	u16 handle;
+
+	if (!timeout || hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL) ||
+	    btusb_rx_hold_expired(skb, timeout, now) ||
+	    skb->len < HCI_ACL_HDR_SIZE)
+		return false;
+
+	handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
+
+	/* Only use the returned connection as an existence snapshot. */
+	return !hci_conn_hash_lookup_handle(data->hdev, hci_handle(handle));
+}
+
+static unsigned long btusb_rx_delay(struct btusb_data *data,
+				    struct sk_buff *skb, ktime_t now,
+				    bool poll_hold, bool acl_hold)
+{
+	unsigned long timeout;
+
+	if (poll_hold) {
+		timeout = READ_ONCE(data->intr_interval);
+		return btusb_rx_hold_delay(skb, timeout, now);
+	}
+
+	if (acl_hold) {
+		timeout = READ_ONCE(data->early_acl_timeout);
+		return min(BTUSB_RX_RECHECK_DELAY,
+			   btusb_rx_hold_delay(skb, timeout, now));
 	}
 
-	return data->recv_event(data->hdev, skb);
+	return 0;
+}
+
+static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
+{
+	int err;
+
+	err = data->recv_event(data->hdev, skb);
+
+	if (READ_ONCE(data->intr_interval))
+		data->last_event = ktime_get();
+
+	if (READ_ONCE(data->intr_interval) ||
+	    READ_ONCE(data->early_acl_timeout))
+		mod_delayed_work(system_wq, &data->rx_work, 0);
+
+	return err;
 }
 
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
@@ -1332,14 +1425,31 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
 {
-	/* Only queue ACL packet if intr_interval is set as it means
-	 * force_poll_sync has been enabled.
-	 */
-	if (!data->intr_interval)
+	bool poll_hold, acl_hold;
+	bool queue_empty;
+	ktime_t now;
+
+	if (!READ_ONCE(data->intr_interval) &&
+	    !READ_ONCE(data->early_acl_timeout))
+		return data->recv_acl(data->hdev, skb);
+
+	now = ktime_get();
+	/* hci_recv_frame() replaces this temporary monotonic arrival time. */
+	skb_set_delivery_time(skb, now, SKB_CLOCK_MONOTONIC);
+
+	queue_empty = skb_queue_empty(&data->acl_q);
+	poll_hold = btusb_poll_sync_should_hold(data, skb, now);
+	acl_hold = btusb_acl_should_hold(data, skb, now);
+
+	if (queue_empty && !poll_hold && !acl_hold)
 		return data->recv_acl(data->hdev, skb);
 
 	skb_queue_tail(&data->acl_q, skb);
-	schedule_delayed_work(&data->rx_work, data->intr_interval);
+
+	if (queue_empty)
+		schedule_delayed_work(&data->rx_work,
+				      btusb_rx_delay(data, skb, now,
+						     poll_hold, acl_hold));
 
 	return 0;
 }
@@ -1539,6 +1649,10 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct urb *urb;
 	unsigned char *buf;
+	unsigned long early_acl_timeout = 0;
+	int intr_interval = 0;
+	unsigned int hold_us;
+	unsigned int interval_us;
 	unsigned int pipe;
 	int err, size;
 
@@ -1587,27 +1701,52 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	}
 
 	/* Only initialize intr_interval if URB poll sync is enabled */
-	if (!data->poll_sync)
-		goto done;
+	if (data->poll_sync) {
+		/* The units are frames (milliseconds) for full and low speed
+		 * devices, and microframes (1/8 millisecond) for highspeed and
+		 * SuperSpeed devices.
+		 *
+		 * This is done once on open/resume so it shouldn't change even
+		 * if force_poll_sync changes.
+		 */
+		switch (urb->dev->speed) {
+		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER:
+			intr_interval = usecs_to_jiffies(urb->interval * 125);
+			break;
+		default:
+			intr_interval = msecs_to_jiffies(urb->interval);
+			break;
+		}
+	}
 
-	/* The units are frames (milliseconds) for full and low speed devices,
-	 * and microframes (1/8 millisecond) for highspeed and SuperSpeed
-	 * devices.
-	 *
-	 * This is done once on open/resume so it shouldn't change even if
-	 * force_poll_sync changes.
-	 */
-	switch (urb->dev->speed) {
-	case USB_SPEED_SUPER_PLUS:
-	case USB_SPEED_SUPER:	/* units are 125us */
-		data->intr_interval = usecs_to_jiffies(urb->interval * 125);
-		break;
-	default:
-		data->intr_interval = msecs_to_jiffies(urb->interval);
-		break;
+	interval_us = 0;
+	if (data->early_acl_hold && urb->interval > 0) {
+		switch (urb->dev->speed) {
+		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER:
+		case USB_SPEED_HIGH:
+			interval_us = urb->interval * 125;
+			break;
+		case USB_SPEED_FULL:
+			interval_us = urb->interval * USEC_PER_MSEC;
+			break;
+		default:
+			break;
+		}
 	}
 
-done:
+	if (interval_us) {
+		/* Allow an event which misses one polling window to arrive in
+		 * the next.
+		 */
+		hold_us = max(BTUSB_EARLY_ACL_HOLD_MIN_US, interval_us * 2);
+		early_acl_timeout = usecs_to_jiffies(hold_us);
+	}
+
+	WRITE_ONCE(data->intr_interval, intr_interval);
+	WRITE_ONCE(data->early_acl_timeout, early_acl_timeout);
+
 	usb_free_urb(urb);
 
 	return err;
@@ -2077,18 +2216,22 @@ static int btusb_close(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	cancel_delayed_work(&data->rx_work);
+	/* Stop queued RX delivery before shutting down the endpoints. */
+	cancel_delayed_work_sync(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
 
-	skb_queue_purge(&data->acl_q);
-
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
 	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
 
 	btusb_stop_traffic(data);
+
+	/* An in-flight URB completion may have requeued RX work. */
+	cancel_delayed_work_sync(&data->rx_work);
+
+	btusb_rx_queue_purge(data);
 	btusb_free_frags(data);
 
 	err = usb_autopm_get_interface(data->intf);
@@ -2114,9 +2257,9 @@ static int btusb_flush(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	cancel_delayed_work(&data->rx_work);
+	cancel_delayed_work_sync(&data->rx_work);
 
-	skb_queue_purge(&data->acl_q);
+	btusb_rx_queue_purge(data);
 
 	usb_kill_anchored_urbs(&data->tx_anchor);
 	btusb_free_frags(data);
@@ -2497,11 +2640,40 @@ static void btusb_rx_work(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data,
 					       rx_work.work);
+	unsigned long delay;
+	unsigned long flags;
 	struct sk_buff *skb;
+	bool poll_hold, acl_hold;
+	ktime_t now;
+
+	for (;;) {
+		spin_lock_irqsave(&data->rxlock, flags);
+		now = ktime_get();
+		skb = skb_peek(&data->acl_q);
+
+		if (!skb) {
+			spin_unlock_irqrestore(&data->rxlock, flags);
+			return;
+		}
+
+		poll_hold = btusb_poll_sync_should_hold(data, skb, now);
+		acl_hold = btusb_acl_should_hold(data, skb, now);
+		if (!poll_hold && !acl_hold) {
+			skb = skb_dequeue(&data->acl_q);
+			data->recv_acl(data->hdev, skb);
+			spin_unlock_irqrestore(&data->rxlock, flags);
+			continue;
+		}
+
+		delay = btusb_rx_delay(data, skb, now, poll_hold, acl_hold);
+		spin_unlock_irqrestore(&data->rxlock, flags);
 
-	/* Dequeue ACL data received during the interval */
-	while ((skb = skb_dequeue(&data->acl_q)))
-		data->recv_acl(data->hdev, skb);
+		/* A zero-delay event kick that raced with this worker remains
+		 * pending; schedule_delayed_work() cannot move it later.
+		 */
+		schedule_delayed_work(&data->rx_work, delay);
+		return;
+	}
 }
 
 static int btusb_setup_bcm92035(struct hci_dev *hdev)
@@ -3967,6 +4139,51 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t force_early_acl_hold_read(struct file *file,
+					 char __user *user_buf, size_t count,
+					 loff_t *ppos)
+{
+	struct btusb_data *data = file->private_data;
+	char buf[3];
+
+	buf[0] = data->early_acl_hold ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_early_acl_hold_write(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
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
+	if (data->early_acl_hold == enable)
+		return -EALREADY;
+
+	data->early_acl_hold = enable;
+
+	return count;
+}
+
+static const struct file_operations force_early_acl_hold_fops = {
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read		= force_early_acl_hold_read,
+	.write		= force_early_acl_hold_write,
+	.llseek		= default_llseek,
+};
+
 #define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS \
 		hci_opcode_pack(HCI_DRV_OGF_DRIVER_SPECIFIC, 0x0000)
 #define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE	0
@@ -4464,6 +4681,7 @@ static int btusb_probe(struct usb_interface *intf,
 		usb_enable_autosuspend(data->udev);
 
 	data->poll_sync = enable_poll_sync;
+	data->early_acl_hold = enable_early_acl_hold;
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
@@ -4473,6 +4691,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
 			    &force_poll_sync_fops);
+	debugfs_create_file("force_early_acl_hold", 0644, hdev->debugfs, data,
+			    &force_early_acl_hold_fops);
 
 	return 0;
 

base-commit: 6f55ad8fb0acd861e5c4e526b2272fc71952e1e3
-- 
2.43.0

