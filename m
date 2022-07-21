Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288A9C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 22:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiGUW5i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 18:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGUW5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 18:57:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231608E1E7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658444256; x=1689980256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUnDghkAdX3J79VH+QJzFotsgQoXuVGIOuKWvP4LkUo=;
  b=UYbrUxe+VprmmMc45vE7dtzdx0gMUtQ7c1X98GDWb+UktdO8nOFQQ6Zi
   G3s9x3X/LwNC3tKYMAqWxW0IxrfaszWzYMaOVC5u5K/h3PqfTlPKhp4uH
   /w/fxKKPB65l5tVMfeaizIfLjYvBwNWd+CSYhg/dkcKIq1wicuFsT513U
   W/T79QiniGqyP+7h14IBEGTy8dQ4pmOkHpKVpnvRNnOyP5bJNKEoqE8bN
   NlZi7tf3HhfsFZQ0nL6I4s3mJxBdA/DdWdxu/h3fueJXKIeAiph3vEPEQ
   ybHqGE+B/WKQJwdjPJcE1j8EYXtylzNx2a6SpgmCKJDjxIIWXT8fwhr7E
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267586483"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267586483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="548961969"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:19 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 3/3] Bluetooth: Convert delayed discov_off to hci_sync
Date:   Thu, 21 Jul 2022 15:57:05 -0700
Message-Id: <20220721225705.602002-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721225705.602002-1-brian.gix@intel.com>
References: <20220721225705.602002-1-brian.gix@intel.com>
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
 net/bluetooth/mgmt.c        | 32 +++++++++++++
 2 files changed, 32 insertions(+), 89 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 379eb388633f..ef790978fc99 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1903,69 +1903,6 @@ void __hci_req_update_class(struct hci_request *req)
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
@@ -2349,33 +2286,8 @@ int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
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
@@ -2386,7 +2298,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 {
 	__hci_cmd_sync_cancel(hdev, ENODEV);
 
-	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e81491d24904..9478e204b1b5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1084,6 +1084,31 @@ static void mesh_send_done(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, mesh_send_done_sync, NULL, mesh_next);
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
@@ -1091,6 +1116,7 @@ static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 
 	BT_INFO("MGMT ver %d.%d", MGMT_VERSION, MGMT_REVISION);
 
+	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 	INIT_DELAYED_WORK(&hdev->rpa_expired, rpa_expired);
 	INIT_DELAYED_WORK(&hdev->mesh_send_done, mesh_send_done);
@@ -9345,6 +9371,12 @@ void mgmt_index_removed(struct hci_dev *hdev)
 
 	mgmt_index_event(MGMT_EV_EXT_INDEX_REMOVED, hdev, &ev, sizeof(ev),
 			 HCI_MGMT_EXT_INDEX_EVENTS);
+
+	/* Cancel any remaining timed work */
+	cancel_delayed_work_sync(&hdev->discov_off);
+	cancel_delayed_work_sync(&hdev->service_cache);
+	cancel_delayed_work_sync(&hdev->rpa_expired);
+	cancel_delayed_work_sync(&hdev->mesh_send_done);
 }
 
 void mgmt_power_on(struct hci_dev *hdev, int err)
-- 
2.36.1

