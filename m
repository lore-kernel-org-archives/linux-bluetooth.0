Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E778CC3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiHEXmx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbiHEXmt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:42:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19FF7B1F3
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742969; x=1691278969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOPWYFYJAPgrTQvyfeRJYAfCS87ac2RPkgxZVKBaLLE=;
  b=YtDMmx7d07MeEUj7cSAqUAMdvkCqXkhAt8csRzhcIEUmeDu2kgJtkW11
   zjyEUYrixLCvZvqqHLzr59i+QAnhaPD7rZRGD7LsdsCiWWKuIs2+9JMfW
   hHHY9lZGk/mEEUV2g5X2YepLz+MLydIRS0Ul1/WRMNtb6KOtd4lRlWdiA
   /AzR2xyY8OeszzZmCRB9R3B+xvXiajWsy12tQZxFB/qnV3i9VdTXZu9oT
   z8b4HEjn3y9b0REOMSPi1btuIF98fzxaiSIZ/JZZh0s+2vMUAekYpPiDb
   F13ArxjRwIWk6guzgQMwsBRlEi6wrofGXF9M8yqVTCtlKGg+B4aj5uxK0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273362748"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273362748"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636661807"
Received: from bkkx-mobl.gar.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.189.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:47 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 2/9] Bluetooth: Rework le_scan_restart for hci_sync
Date:   Fri,  5 Aug 2022 16:42:29 -0700
Message-Id: <20220805234236.704986-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234236.704986-1-brian.gix@intel.com>
References: <20220805234236.704986-1-brian.gix@intel.com>
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
index e22837510ab1..75e7c0a01ab1 100644
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

