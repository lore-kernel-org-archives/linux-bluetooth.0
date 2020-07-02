Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95715C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D0E20780
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 22:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDKrpJMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgGBWGC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 18:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBWGB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 18:06:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E671C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2020 15:06:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so8027041pjw.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2020 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLVCAsgCYrnpTxr27cIa0AxMzfsiLcn5LAAMEfcyjfE=;
        b=tDKrpJMAT9o1aJH2sbCJBpDqxi0koKXj7Pfspk7oqLzUnYn5L5DhjgCQAAk4fTN234
         Zplu+2sBFr03j3W7L3+wFCt0/MGB0XLk0zEhBvj/G9SdCWxE7FLd/rXLwWSF0Pay+/J1
         ylF+YC3WtY7Plr3dHQaCQZym15q4KdMPa/+kLKtcSSyBvKub/tRLmqICe566cdJ1akuF
         Zjfk1TTAGHJxVAgXrU4annHUiENONtXUG0BLskHHDH8eg4Tmwt9J4tzQWG0GAKM+EL7R
         lWwRJRvGmDVudU+P7V7FoY30BxLoErQmlf1eTcqPHrJrLdGpRyDws0R8mQo+bKtsn3hM
         wMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLVCAsgCYrnpTxr27cIa0AxMzfsiLcn5LAAMEfcyjfE=;
        b=K+oFBz/91ckOD1ezGnzpFsQAYVOAh8EBRcMcpdJU9B4jkjA5Kvh4OLRG7LQIxla6yp
         3q3tZjsex3a8xP8avUDqHBsok7NsUCqXCB6mnmQKSE0sZKTHOcdTa51uH25Ix49VGo9Z
         csdcAjPomD/6IYvkVpIEfbTV5+7PU3I4KlzBMuO6Pfs0Kf/tWnjj2XTgQUClFbjWaWjm
         L18VF3oCUuMyZvGRpgZU7y9ztA+SnqIAIHfjQQUPs4PTPthd5IgahMSolf9G10198N7l
         D7LcSwH+4JcnV6NxFH+fxUdjUFzbH4k9u48FSr6+5aT91tdKljD+V4SMc9L65F4oT5/D
         FCHg==
X-Gm-Message-State: AOAM531CqaT54sR75lzOPRBbth2ystmo2SnAlYVWMwhxDZ+s5G26Ecdt
        vBC4XDNj3xDymYz9UzziyBS8ivkXFKQ=
X-Google-Smtp-Source: ABdhPJwHgiffdaMpEtoTgA+utXtko8kgsMcL7bDfVXCJHgbamE/Oey45oJwLGSv3eJ4KKjuYwwHAqg==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr29615636pls.29.1593727560549;
        Thu, 02 Jul 2020 15:06:00 -0700 (PDT)
Received: from localhost.localdomain ([192.102.209.44])
        by smtp.gmail.com with ESMTPSA id n62sm9284219pjb.42.2020.07.02.15.05.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 15:05:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: btusb: Add support for notifying the polling interval
Date:   Thu,  2 Jul 2020 15:05:58 -0700
Message-Id: <20200702220558.3467870-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables btusb to inform the polling interval used for receiving
packets, the interval is then used wih rx_work which has been changed
to be a delayed work.

The interval is then used as a time window where frames received from
different endpoints are considered to be arrived at same time.

In order to resolve potential conflicts between endpoints a dedicated
queue for events was introduced and it is now processed before the ACL
packets.

It worth noting though that priorizing events over ACL data may result
in inverting the order of the packets over the air, for instance there
may be packets received before a disconnect event that will be
discarded and unencrypted packets received before encryption change
which would considered encrypted, because of these potential inversions
the support for polling interval is not enabled by default so platforms
have the following means to enable it:

At build-time:

CONFIG_BT_HCIBTUSB_INTERVAL=y

At runtime with use of module option:

enable_interval

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/Kconfig        |  7 ++++
 drivers/bluetooth/btusb.c        | 16 +++++++--
 include/net/bluetooth/hci_core.h |  6 +++-
 net/bluetooth/hci_core.c         | 60 +++++++++++++++++++++++++-------
 4 files changed, 72 insertions(+), 17 deletions(-)

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
index faa863dd5d0a..6525b10bd40c 100644
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
@@ -711,7 +711,14 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			hci_recv_frame(data->hdev, skb);
+			if (enable_interval)
+				/* TODO: Calculate polling interval based on
+				 * endpoint bInterval?
+				 */
+				hci_recv_acl(data->hdev, skb,
+					     msecs_to_jiffies(1));
+			else
+				hci_recv_frame(data->hdev, skb);
 			skb = NULL;
 		}
 	}
@@ -3866,7 +3873,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_bulk = btusb_recv_bulk_intel;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
 	} else {
-		data->recv_event = hci_recv_frame;
+		data->recv_event = hci_recv_evt;
 		data->recv_bulk = btusb_recv_bulk;
 	}
 
@@ -4335,6 +4342,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");
 module_param(enable_autosuspend, bool, 0644);
 MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 
+module_param(enable_interval, bool, 0644);
+MODULE_PARM_DESC(enable_interval, "Enable USB polling interval by default");
+
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0de041eac844..d07d3df27ba9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -444,7 +444,7 @@ struct hci_dev {
 
 	struct delayed_work	cmd_timer;
 
-	struct work_struct	rx_work;
+	struct delayed_work	rx_work;
 	struct work_struct	cmd_work;
 	struct work_struct	tx_work;
 
@@ -457,6 +457,7 @@ struct hci_dev {
 	struct delayed_work	le_scan_restart;
 
 	struct sk_buff_head	rx_q;
+	struct sk_buff_head	ev_q;
 	struct sk_buff_head	raw_q;
 	struct sk_buff_head	cmd_q;
 
@@ -1190,6 +1191,9 @@ int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
+int hci_recv_acl(struct hci_dev *hdev, struct sk_buff *skb,
+		 unsigned int interval);
+int hci_recv_evt(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
 __printf(2, 3) void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
 __printf(2, 3) void hci_set_fw_info(struct hci_dev *hdev, const char *fmt, ...);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1920e3c5c6f6..bbf02cd24cfb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1591,10 +1591,11 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		/* Init failed, cleanup */
 		flush_work(&hdev->tx_work);
 		flush_work(&hdev->cmd_work);
-		flush_work(&hdev->rx_work);
+		cancel_delayed_work(&hdev->rx_work);
 
 		skb_queue_purge(&hdev->cmd_q);
 		skb_queue_purge(&hdev->rx_q);
+		skb_queue_purge(&hdev->ev_q);
 
 		if (hdev->flush)
 			hdev->flush(hdev);
@@ -1719,7 +1720,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Flush RX and TX works */
 	flush_work(&hdev->tx_work);
-	flush_work(&hdev->rx_work);
+	cancel_delayed_work(&hdev->rx_work);
 
 	if (hdev->discov_timeout > 0) {
 		hdev->discov_timeout = 0;
@@ -1784,6 +1785,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
+	skb_queue_purge(&hdev->ev_q);
 	skb_queue_purge(&hdev->cmd_q);
 	skb_queue_purge(&hdev->raw_q);
 
@@ -1855,6 +1857,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
+	skb_queue_purge(&hdev->ev_q);
 	skb_queue_purge(&hdev->cmd_q);
 
 	/* Avoid potential lockdep warnings from the *_flush() calls by
@@ -3603,16 +3606,17 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->adv_instances);
 	INIT_LIST_HEAD(&hdev->blocked_keys);
 
-	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->error_reset, hci_error_reset);
 	INIT_WORK(&hdev->suspend_prepare, hci_prepare_suspend);
 
+	INIT_DELAYED_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
 	skb_queue_head_init(&hdev->rx_q);
+	skb_queue_head_init(&hdev->ev_q);
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
 
@@ -3856,8 +3860,8 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);
 
-/* Receive frame from HCI drivers */
-int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+static int hci_rx_queue(struct hci_dev *hdev, struct sk_buff *skb,
+			struct sk_buff_head *queue, unsigned int interval)
 {
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
 		      && !test_bit(HCI_INIT, &hdev->flags))) {
@@ -3879,13 +3883,35 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Time stamp */
 	__net_timestamp(skb);
 
-	skb_queue_tail(&hdev->rx_q, skb);
-	queue_work(hdev->workqueue, &hdev->rx_work);
+	skb_queue_tail(queue, skb);
+
+	queue_delayed_work(hdev->workqueue, &hdev->rx_work, interval);
 
 	return 0;
 }
+
+/* Receive frame from HCI drivers */
+int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return hci_rx_queue(hdev, skb, &hdev->rx_q, 0);
+}
 EXPORT_SYMBOL(hci_recv_frame);
 
+/* Receive ACL frame from HCI drivers */
+int hci_recv_acl(struct hci_dev *hdev, struct sk_buff *skb,
+		 unsigned int interval)
+{
+	return hci_rx_queue(hdev, skb, &hdev->rx_q, interval);
+}
+EXPORT_SYMBOL(hci_recv_acl);
+
+/* Receive Event frame from HCI drivers */
+int hci_recv_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return hci_rx_queue(hdev, skb, &hdev->ev_q, 0);
+}
+EXPORT_SYMBOL(hci_recv_evt);
+
 /* Receive diagnostic message from HCI drivers */
 int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
 {
@@ -3896,7 +3922,7 @@ int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
 	__net_timestamp(skb);
 
 	skb_queue_tail(&hdev->rx_q, skb);
-	queue_work(hdev->workqueue, &hdev->rx_work);
+	queue_delayed_work(hdev->workqueue, &hdev->rx_work, 0);
 
 	return 0;
 }
@@ -4825,14 +4851,11 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
 }
 
-static void hci_rx_work(struct work_struct *work)
+static void hci_rx_dequeue(struct hci_dev *hdev, struct sk_buff_head *queue)
 {
-	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work);
 	struct sk_buff *skb;
 
-	BT_DBG("%s", hdev->name);
-
-	while ((skb = skb_dequeue(&hdev->rx_q))) {
+	while ((skb = skb_dequeue(queue))) {
 		/* Send copy to monitor */
 		hci_send_to_monitor(hdev, skb);
 
@@ -4888,6 +4911,17 @@ static void hci_rx_work(struct work_struct *work)
 	}
 }
 
+static void hci_rx_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work.work);
+
+	BT_DBG("%s", hdev->name);
+
+	/* Process HCI event packets so states changes are synchronized first */
+	hci_rx_dequeue(hdev, &hdev->ev_q);
+	hci_rx_dequeue(hdev, &hdev->rx_q);
+}
+
 static void hci_cmd_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
-- 
2.25.3

