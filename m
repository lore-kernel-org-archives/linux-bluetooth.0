Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F1AC19F2B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbiG3Aux (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbiG3Auv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8872EFF
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659142251; x=1690678251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5igEPgit1Y5a8wMwfRKABLVwulg9bCGDrZu9pIiaGZU=;
  b=mCS8ftliht34OSAR/RjjJQy1S2YrBA9FSXOkpkxCmy7fXZRZn2J15mw6
   SDbFDuY72aQ2biMfJfF/g8TRdSeXmR1VftH0VXf2vI75LJH5i1ZG0KFE3
   1W4e45zKe+Au0IQCHmB0mBQuzoWk1eQYde80+Ih3t+GFJQl3E8MssEN7W
   RBjAWg4/BXQRJu/g3+bZhHdofqLQOHCsYo7B67duofmV0VY8EusAmrGAf
   tgGC4sRdoFUAFE5V7ITbkC3YGluRH4D0kJ8oNvbLXTFtDv2VFBcOgcgeO
   qeYQVhGxuedYJ/Ygiwitv4iY1idM+KztKbaUC1zlyul6kP6trGT3H57CP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268644787"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268644787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660458102"
Received: from agcodina-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.26.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 02/10] Bluetooth: Rework le_scan_restart for hci_sync
Date:   Fri, 29 Jul 2022 17:50:30 -0700
Message-Id: <20220730005038.894650-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730005038.894650-1-brian.gix@intel.com>
References: <20220730005038.894650-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

le_scan_restart delayed work queue was running as a deprecated
hci_request instead of on the newer thread-safe hci_sync mechanism.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_request.c | 89 -------------------------------------
 net/bluetooth/hci_sync.c    | 75 +++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 89 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 32fefaa0d3ca..114af7350363 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1975,92 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	return 0;
 }
 
-static int le_scan_restart(struct hci_request *req, unsigned long opt)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	/* If controller is not scanning we are done. */
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		return 0;
-
-	if (hdev->scanning_paused) {
-		bt_dev_dbg(hdev, "Scanning is paused for suspend");
-		return 0;
-	}
-
-	hci_req_add_le_scan_disable(req, false);
-
-	if (use_ext_scan(hdev)) {
-		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
-
-		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
-		ext_enable_cp.enable = LE_SCAN_ENABLE;
-		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-
-		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
-			    sizeof(ext_enable_cp), &ext_enable_cp);
-	} else {
-		struct hci_cp_le_set_scan_enable cp;
-
-		memset(&cp, 0, sizeof(cp));
-		cp.enable = LE_SCAN_ENABLE;
-		cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-	}
-
-	return 0;
-}
-
-static void le_scan_restart_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    le_scan_restart.work);
-	unsigned long timeout, duration, scan_start, now;
-	u8 status;
-
-	bt_dev_dbg(hdev, "");
-
-	hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
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
-
 bool hci_req_stop_discovery(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -2158,7 +2072,6 @@ int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
 
 void hci_request_setup(struct hci_dev *hdev)
 {
-	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
 }
@@ -2167,8 +2080,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 {
 	__hci_cmd_sync_cancel(hdev, ENODEV);
 
-	cancel_delayed_work_sync(&hdev->le_scan_restart);
-
 	if (hdev->adv_instance_timeout) {
 		cancel_delayed_work_sync(&hdev->adv_instance_expire);
 		hdev->adv_instance_timeout = 0;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7dae2ee1bb82..19d57ec0feb8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -392,6 +392,79 @@ static void le_scan_disable(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
+				       u8 filter_dup);
+static int hci_le_scan_restart_sync(struct hci_dev *hdev)
+{
+	/* If controller is not scanning we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		return 0;
+
+	if (hdev->scanning_paused) {
+		bt_dev_dbg(hdev, "Scanning is paused for suspend");
+		return 0;
+	}
+
+	hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
+	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
+					   LE_SCAN_FILTER_DUP_ENABLE);
+}
+
+static int le_scan_restart_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_le_scan_restart_sync(hdev);
+}
+
+static void le_scan_restart(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    le_scan_restart.work);
+	unsigned long timeout, duration, scan_start, now;
+	int status;
+
+	bt_dev_dbg(hdev, "");
+
+	hci_dev_lock(hdev);
+
+	status = hci_cmd_sync_queue(hdev, le_scan_restart_sync, NULL, NULL);
+	if (status) {
+		bt_dev_err(hdev, "failed to restart LE scan: status %d",
+			   status);
+		goto unlock;
+	}
+
+	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
+	    !hdev->discovery.scan_start)
+		goto unlock;
+
+	/* When the scan was started, hdev->le_scan_disable has been queued
+	 * after duration from scan_start. During scan restart this job
+	 * has been canceled, and we need to queue it again after proper
+	 * timeout, to make sure that scan does not run indefinitely.
+	 */
+	duration = hdev->discovery.scan_duration;
+	scan_start = hdev->discovery.scan_start;
+	now = jiffies;
+	if (now - scan_start <= duration) {
+		int elapsed;
+
+		if (now >= scan_start)
+			elapsed = now - scan_start;
+		else
+			elapsed = ULONG_MAX - scan_start + now;
+
+		timeout = duration - elapsed;
+	} else {
+		timeout = 0;
+	}
+
+	queue_delayed_work(hdev->req_workqueue,
+			   &hdev->le_scan_disable, timeout);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 void hci_cmd_sync_init(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
@@ -400,6 +473,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
+	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
 }
 
 void hci_cmd_sync_clear(struct hci_dev *hdev)
@@ -4488,6 +4562,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	cancel_delayed_work(&hdev->power_off);
 	cancel_delayed_work(&hdev->ncmd_timer);
 	cancel_delayed_work(&hdev->le_scan_disable);
+	cancel_delayed_work(&hdev->le_scan_restart);
 
 	hci_request_cancel_all(hdev);
 
-- 
2.37.1

