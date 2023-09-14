Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8535EEEAA60
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 18:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjINSGB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINSGA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 14:06:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05E1FDF
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 11:05:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c336f3f449so10615195ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694714756; x=1695319556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7A+yUdbn0l7xptxTgogaRCOwAErlwth6e8R8NI7xkE=;
        b=F4NrIJgfymrCrRojVHoce6Gf9Nm0KYbOXnZhGDbyMXDYEohl7LJ3TykQRyApop4YFH
         VvnpV2a8ym6IWPZxgo65KglQfM+7bNYwjm1YMWhC3+5mFqsuI3YlrciQC5ENsIa40rwP
         qWU8A5AAhR55ULEJo5bg9ImrQmtrHB1hia8IazgctKp+Poauayuho4nRJOCIvx4XJVdf
         50+SfXO4ZB7qSu6ewIGIpjsvMCzASPTA2aN5HScjhhFYr4krLrF8O+q96vsql/wi2yTG
         dxStJc+HlNy4T1mipNbFgiehgPPjtJzO/DyT+bTDEg7xM18Q7sKo/HzaPPbDUJNZgUAp
         0DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694714756; x=1695319556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7A+yUdbn0l7xptxTgogaRCOwAErlwth6e8R8NI7xkE=;
        b=NjKGoEBHPviondum3f8nbnFHrWXT7e3/7HlnxNvKTIdsqe4+Q7ngyWjucBvWYVCdJo
         E4nwUZBG/7tyehvbypGfxTEmve7iLfFRImfNOj0AI6A9Va8JtL5LarUOlbMvUP4203jG
         R+bkcNtC9mfYhOPjnOtcmJKSu1pCNJE53Rz4LE8n3WawtGlu063dlsnPxoQp8fTDTQMu
         1o0AmVgVoUdOwy7vpjBVOU8TlAa/W2J7nabFcJzPvd9FIkTyFP9t/JMRDK4Rnai1fE1H
         PbiLUYNyL/4bSi12WyBhezEZpMwlXr4/D30Acpv4y4YuK6Sykt2nOlgn1xDO+5U8X4qh
         rtxA==
X-Gm-Message-State: AOJu0YxtpVI/JGS2cnFulbkD8gXo3URZLN3Kv6BzyuYOEBUjutADEHVq
        pyIF93A3FtQJ/mLfxls/LLJeqdpJZU8hCw==
X-Google-Smtp-Source: AGHT+IFOpBEO4bSNNRdKmTO08Cq2B8eito3tAyslNdWC3isK5U/9ZBmT4hEmZsCHrdDuM9KqNF4nIQ==
X-Received: by 2002:a17:902:e80a:b0:1bd:fbc8:299e with SMTP id u10-20020a170902e80a00b001bdfbc8299emr7939020plg.4.1694714755504;
        Thu, 14 Sep 2023 11:05:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c1f161949fsm1897608plg.96.2023.09.14.11.05.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 11:05:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_core: Remove le_restart_scan work
Date:   Thu, 14 Sep 2023 11:05:53 -0700
Message-ID: <20230914180553.3264477-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes le_restart_scan work and instead just disables controller
duplicate filtering when discovery result_filtering is enabled and
HCI_QUIRK_STRICT_DUPLICATE_FILTER is set.

Link: https://github.com/bluez/bluez/issues/573
Link: https://github.com/bluez/bluez/issues/572
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_sync.c         | 96 +++-----------------------------
 net/bluetooth/mgmt.c             | 17 ------
 3 files changed, 7 insertions(+), 107 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bbad301f5781..531795f990de 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -532,7 +532,6 @@ struct hci_dev {
 	struct work_struct	tx_work;
 
 	struct delayed_work	le_scan_disable;
-	struct delayed_work	le_scan_restart;
 
 	struct sk_buff_head	rx_q;
 	struct sk_buff_head	raw_q;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1be5763c261c..550a0276eb28 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -348,8 +348,6 @@ static void le_scan_disable(struct work_struct *work)
 	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 		goto _return;
 
-	cancel_delayed_work(&hdev->le_scan_restart);
-
 	status = hci_cmd_sync_queue(hdev, scan_disable_sync, NULL, NULL);
 	if (status) {
 		bt_dev_err(hdev, "failed to disable LE scan: %d", status);
@@ -397,71 +395,6 @@ static void le_scan_disable(struct work_struct *work)
 
 static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
 				       u8 filter_dup);
-static int hci_le_scan_restart_sync(struct hci_dev *hdev)
-{
-	/* If controller is not scanning we are done. */
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		return 0;
-
-	if (hdev->scanning_paused) {
-		bt_dev_dbg(hdev, "Scanning is paused for suspend");
-		return 0;
-	}
-
-	hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
-	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
-					   LE_SCAN_FILTER_DUP_ENABLE);
-}
-
-static void le_scan_restart(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    le_scan_restart.work);
-	unsigned long timeout, duration, scan_start, now;
-	int status;
-
-	bt_dev_dbg(hdev, "");
-
-	status = hci_le_scan_restart_sync(hdev);
-	if (status) {
-		bt_dev_err(hdev, "failed to restart LE scan: status %d",
-			   status);
-		return;
-	}
-
-	hci_dev_lock(hdev);
-
-	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
-	    !hdev->discovery.scan_start)
-		goto unlock;
-
-	/* When the scan was started, hdev->le_scan_disable has been queued
-	 * after duration from scan_start. During scan restart this job
-	 * has been canceled, and we need to queue it again after proper
-	 * timeout, to make sure that scan does not run indefinitely.
-	 */
-	duration = hdev->discovery.scan_duration;
-	scan_start = hdev->discovery.scan_start;
-	now = jiffies;
-	if (now - scan_start <= duration) {
-		int elapsed;
-
-		if (now >= scan_start)
-			elapsed = now - scan_start;
-		else
-			elapsed = ULONG_MAX - scan_start + now;
-
-		timeout = duration - elapsed;
-	} else {
-		timeout = 0;
-	}
-
-	queue_delayed_work(hdev->req_workqueue,
-			   &hdev->le_scan_disable, timeout);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
 
 static int reenable_adv_sync(struct hci_dev *hdev, void *data)
 {
@@ -630,7 +563,6 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
-	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 }
 
@@ -4960,7 +4892,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	cancel_delayed_work(&hdev->power_off);
 	cancel_delayed_work(&hdev->ncmd_timer);
 	cancel_delayed_work(&hdev->le_scan_disable);
-	cancel_delayed_work(&hdev->le_scan_restart);
 
 	hci_request_cancel_all(hdev);
 
@@ -5177,7 +5108,6 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
-			cancel_delayed_work(&hdev->le_scan_restart);
 
 			err = hci_scan_disable_sync(hdev);
 			if (err)
@@ -5687,19 +5617,18 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
-	if (hci_is_adv_monitoring(hdev)) {
+	if (hci_is_adv_monitoring(hdev) ||
+	    (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
+	    hdev->discovery.result_filtering)) {
 		/* Duplicate filter should be disabled when some advertisement
 		 * monitor is activated, otherwise AdvMon can only receive one
 		 * advertisement for one peer(*) during active scanning, and
 		 * might report loss to these peers.
 		 *
-		 * Note that different controllers have different meanings of
-		 * |duplicate|. Some of them consider packets with the same
-		 * address as duplicate, and others consider packets with the
-		 * same address and the same RSSI as duplicate. Although in the
-		 * latter case we don't need to disable duplicate filter, but
-		 * it is common to have active scanning for a short period of
-		 * time, the power impact should be neglectable.
+		 * If controller does strict duplicate filtering and the
+		 * discovery requires result filtering disables controller based
+		 * filtering since that can cause reports that would match the
+		 * host filter to not be reported.
 		 */
 		filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
 	}
@@ -5779,17 +5708,6 @@ int hci_start_discovery_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "timeout %u ms", jiffies_to_msecs(timeout));
 
-	/* When service discovery is used and the controller has a
-	 * strict duplicate filter, it is important to remember the
-	 * start and duration of the scan. This is required for
-	 * restarting scanning during the discovery phase.
-	 */
-	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
-	    hdev->discovery.result_filtering) {
-		hdev->discovery.scan_start = jiffies;
-		hdev->discovery.scan_duration = timeout;
-	}
-
 	queue_delayed_work(hdev->req_workqueue, &hdev->le_scan_disable,
 			   timeout);
 	return 0;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ba2e00646e8e..da79a2369dd7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10134,21 +10134,6 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 	return false;
 }
 
-static void restart_le_scan(struct hci_dev *hdev)
-{
-	/* If controller is not scanning we are done. */
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		return;
-
-	if (time_after(jiffies + DISCOV_LE_RESTART_DELAY,
-		       hdev->discovery.scan_start +
-		       hdev->discovery.scan_duration))
-		return;
-
-	queue_delayed_work(hdev->req_workqueue, &hdev->le_scan_restart,
-			   DISCOV_LE_RESTART_DELAY);
-}
-
 static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 			    u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
 {
@@ -10183,8 +10168,6 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 	 * scanning to ensure updated result with updated RSSI values.
 	 */
 	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)) {
-		restart_le_scan(hdev);
-
 		/* Validate RSSI value against the RSSI threshold once more. */
 		if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
 		    rssi < hdev->discovery.rssi)
-- 
2.41.0

