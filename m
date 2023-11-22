Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="karMLDlk"
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190D31B5
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 09:56:41 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d7e6df999fso34052a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700675799; x=1701280599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kim3JzKTk3qxtmodvMxlZjd7CYFwOqKdajx6VEw+zKY=;
        b=karMLDlk8SkzZ71rqopxJJj1P85ijDagQG1wxFeZIrXRFcoddw9Uux9ge8HeFt6eTD
         LCt2Q9wL0m0sA2KLqBLI6w8nHvd57D/9vov1O77OHTLdUUqC+Qt2hukzLKxwUeb5Y+Ae
         SG+4lF7TchtS4XKALPqjVzB1MhxY4RQ3D5ep5uf+ety7tLfbcZkqvj2WljoNE9IXIJci
         ZD56Pxm8zcmpoPulNS+QWS2z8Bf4nKPf6YtoiEL8JGbDusNcgjVjwDlY8Z9jIlfQH/K3
         ncpuWWBe+wz7BEZLk80gx83LmGG/9uDB+Rs8RDbHwqWGslt7YOBxj4cRUT4DeQOwI+aB
         MloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675799; x=1701280599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kim3JzKTk3qxtmodvMxlZjd7CYFwOqKdajx6VEw+zKY=;
        b=VAcoMVdsP3LQ5sr9kBe6mygFqvcUSy/V09Iny7emKuA/PPvqtBJ7wquaZqKmNaLo18
         9zHSFKQ1ol52XcYkS9CfDvX5xUYsrJ3OsEvaWjGuE4/ytzIGMGNDJ1Fwm4FsoPQ8p1Sj
         DOovaSaxxXICeloE+SuEtT0/iJxolrDilv4qYajvvDkMjoBe09nsRjMLaNYvN8KtojhX
         TYcO70aVz0b6sno/u8URFkWycGlOSR1ZnyuZrZVIn+BKJy0p3Q5QrljdBlaYobHGLT6C
         vb15WQ9RpGWXcaGXrQV65JyOOFdXXtN7uiKLzEe9c1k0J0WhcRMDBRusXGihIpb95LqC
         JYZg==
X-Gm-Message-State: AOJu0YyKoJ+0EJ/pd/kUJK6h8KrS6v4lsjVsFdAgN+uI7oghz5rZhSmX
	8t71HWq+SNaPTUTGFeXVktBfbKc+zC6P/YoY
X-Google-Smtp-Source: AGHT+IF+xXmS/LXH2Lm/tV/D6hLG8APd9ewMZIlqq1JMU28m/ktIo1apIzg8w8gg3Z0SxQqCTtQLYA==
X-Received: by 2002:a05:6870:bd4c:b0:1f4:e209:a7ea with SMTP id og12-20020a056870bd4c00b001f4e209a7eamr3557799oab.42.1700675799109;
        Wed, 22 Nov 2023 09:56:39 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id w18-20020ac87192000000b00421c272bcbasm4589969qto.11.2023.11.22.09.56.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:56:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND] Bluetooth: hci_core: Remove le_restart_scan work
Date: Wed, 22 Nov 2023 12:56:36 -0500
Message-ID: <20231122175636.866900-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 201c0809540a..eed6c9f37b12 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -534,7 +534,6 @@ struct hci_dev {
 	struct work_struct	tx_work;
 
 	struct delayed_work	le_scan_disable;
-	struct delayed_work	le_scan_restart;
 
 	struct sk_buff_head	rx_q;
 	struct sk_buff_head	raw_q;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d85a7091a116..3563a90ed2ac 100644
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
 
@@ -5178,7 +5109,6 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
-			cancel_delayed_work(&hdev->le_scan_restart);
 
 			err = hci_scan_disable_sync(hdev);
 			if (err)
@@ -5686,19 +5616,18 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
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
@@ -5778,17 +5707,6 @@ int hci_start_discovery_sync(struct hci_dev *hdev)
 
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
2.42.0

