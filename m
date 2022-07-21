Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4138CCCA485
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 23:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiGUXWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiGUXWm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 19:22:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE148E4FD
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658445761; x=1689981761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E++36aR2JhwqMEUJTQwaWSgLCe/xBRTUIgSDTm3T7NU=;
  b=ZFy8Ow86SvL4vnP/FGVAMmVvj2YlWl19d4cjnNV8DyK2j1Gz6befoD0f
   FTvta6yAASKNc4K5wnR7ygS3Le5oPi8XgJIsOeRCzxw0vooZb4H2NMmZ8
   5z/8/yDmNd4OQbGotRhv4z0fBjXl20/lUbr74a7bHeC2roL0JcEA4wp7g
   g4DdaULEjxyA9qsSzxdRyW+RJKusCrpd2LMXwfKesUSX0kj19XZyXEdde
   v9NGyjaCD+Q5QdTSD5yx4xiyP0OvSz7tgnLSp3ZrOuVfZuiGAXf9QMuHY
   f9At3r/jDmBXvcZGidZ0hE6zMtd6ZXdMR/ae5qbx+9H8Xz2fTOeKwkLDt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312912923"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="312912923"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631363095"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:40 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2 3/3] Bluetooth: Convert delayed discov_off to hci_sync
Date:   Thu, 21 Jul 2022 16:22:25 -0700
Message-Id: <20220721232225.624426-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721232225.624426-1-brian.gix@intel.com>
References: <20220721232225.624426-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The timed ending of Discoverability was handled in hci_requst.c, with
calls using the deprecated hci_req_add() mechanism. Converted to live
inside mgmt.c using the same delayed work queue, but with hci_sync
version of hci_update_discoverable().

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_request.c | 89 -------------------------------------
 net/bluetooth/mgmt.c        | 33 ++++++++++++++
 2 files changed, 33 insertions(+), 89 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3257f0f588cd..f6b2e605159d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1875,69 +1875,6 @@ void __hci_req_update_class(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
 }
 
-static void write_iac(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_current_iac_lap cp;
-
-	if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
-		/* Limited discoverable mode */
-		cp.num_iac = min_t(u8, hdev->num_iac, 2);
-		cp.iac_lap[0] = 0x00;	/* LIAC */
-		cp.iac_lap[1] = 0x8b;
-		cp.iac_lap[2] = 0x9e;
-		cp.iac_lap[3] = 0x33;	/* GIAC */
-		cp.iac_lap[4] = 0x8b;
-		cp.iac_lap[5] = 0x9e;
-	} else {
-		/* General discoverable mode */
-		cp.num_iac = 1;
-		cp.iac_lap[0] = 0x33;	/* GIAC */
-		cp.iac_lap[1] = 0x8b;
-		cp.iac_lap[2] = 0x9e;
-	}
-
-	hci_req_add(req, HCI_OP_WRITE_CURRENT_IAC_LAP,
-		    (cp.num_iac * 3) + 1, &cp);
-}
-
-static int discoverable_update(struct hci_request *req, unsigned long opt)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	hci_dev_lock(hdev);
-
-	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
-		write_iac(req);
-		__hci_req_update_scan(req);
-		__hci_req_update_class(req);
-	}
-
-	/* Advertising instances don't use the global discoverable setting, so
-	 * only update AD if advertising was enabled using Set Advertising.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-		__hci_req_update_adv_data(req, 0x00);
-
-		/* Discoverable mode affects the local advertising
-		 * address in limited privacy mode.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY)) {
-			if (ext_adv_capable(hdev))
-				__hci_req_start_ext_adv(req, 0x00);
-			else
-				__hci_req_enable_advertising(req);
-		}
-	}
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason)
 {
@@ -2307,33 +2244,8 @@ int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
 	return err;
 }
 
-static void discov_off(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    discov_off.work);
-
-	bt_dev_dbg(hdev, "");
-
-	hci_dev_lock(hdev);
-
-	/* When discoverable timeout triggers, then just make sure
-	 * the limited discoverable flag is cleared. Even in the case
-	 * of a timeout triggered from general discoverable, it is
-	 * safe to unconditionally clear the flag.
-	 */
-	hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
-	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
-	hdev->discov_timeout = 0;
-
-	hci_dev_unlock(hdev);
-
-	hci_req_sync(hdev, discoverable_update, 0, HCI_CMD_TIMEOUT, NULL);
-	mgmt_new_settings(hdev);
-}
-
 void hci_request_setup(struct hci_dev *hdev)
 {
-	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
@@ -2344,7 +2256,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 {
 	__hci_cmd_sync_cancel(hdev, ENODEV);
 
-	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c6750abb0ca2..b1541118dcdc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1023,11 +1023,39 @@ static void rpa_expired(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
+static void discov_off(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    discov_off.work);
+
+	bt_dev_dbg(hdev, "");
+
+	hci_dev_lock(hdev);
+
+	/* When discoverable timeout triggers, then just make sure
+	 * the limited discoverable flag is cleared. Even in the case
+	 * of a timeout triggered from general discoverable, it is
+	 * safe to unconditionally clear the flag.
+	 */
+	hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
+	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
+	hdev->discov_timeout = 0;
+
+	hci_update_discoverable(hdev);
+
+	mgmt_new_settings(hdev);
+
+	hci_dev_unlock(hdev);
+}
+
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
 	if (hci_dev_test_and_set_flag(hdev, HCI_MGMT))
 		return;
 
+	BT_INFO("MGMT ver %d.%d", MGMT_VERSION, MGMT_REVISION);
+
+	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 	INIT_DELAYED_WORK(&hdev->rpa_expired, rpa_expired);
 
@@ -8875,6 +8903,11 @@ void mgmt_index_removed(struct hci_dev *hdev)
 
 	mgmt_index_event(MGMT_EV_EXT_INDEX_REMOVED, hdev, &ev, sizeof(ev),
 			 HCI_MGMT_EXT_INDEX_EVENTS);
+
+	/* Cancel any remaining timed work */
+	cancel_delayed_work_sync(&hdev->discov_off);
+	cancel_delayed_work_sync(&hdev->service_cache);
+	cancel_delayed_work_sync(&hdev->rpa_expired);
 }
 
 void mgmt_power_on(struct hci_dev *hdev, int err)
-- 
2.36.1

