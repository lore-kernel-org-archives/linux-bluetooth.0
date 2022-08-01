Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E01C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 17:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiHARPs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiHARP3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 13:15:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF81BE30
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659374124; x=1690910124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ubByN/k0jvw0lBhFP2NJ6N9W+tk65guQOLiFXn7Bbw4=;
  b=gmC1IUElXG3vtB8/Pxoys2qHWgt4LfblkuUz081llP/87bfRCa2GuM0L
   ZAtJuQc9ysznpKepb5bUOHQtpU4wZFAuQIUVpNflpc+a2th+EB1A41DAe
   jDA7a6VHVUcmgnJTLIrOzN5wNP+1u/Nc90uaLiDbJmNj1WfTQvIR3KUGH
   Ajfhje1fQh7356gMtrJ8XnHuq21Sme88xdBoOBTAiSy85W5f+ApyQh0Pb
   4EQtrT/0KLjBGrKfjVwtub+jjAe5AC9CufdL6OtctM9K2qrKRTKR2LtsZ
   BzHqkf8qEgGaGYgBvI5GiqIB8Phbch5kZBQXN9FWkmudtDV0l0rPoxeKf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276104774"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="276104774"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="847899632"
Received: from gestarne-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.120.49])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:16 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v6 06/10] Bluetooth: Move Adv Instance timer to hci_sync
Date:   Mon,  1 Aug 2022 10:15:01 -0700
Message-Id: <20220801171505.1271059-7-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801171505.1271059-1-brian.gix@intel.com>
References: <20220801171505.1271059-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Advertising Instance expiration timer adv_instance_expire was
handled with the deprecated hci_request mechanism, rather than it's
replacement: hci_sync.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |   3 +-
 net/bluetooth/hci_core.c         |   2 -
 net/bluetooth/hci_request.c      | 120 ----------------------------
 net/bluetooth/hci_request.h      |   7 --
 net/bluetooth/hci_sync.c         | 131 ++++++++++++++++++++++++++++---
 net/bluetooth/mgmt.c             |   5 +-
 6 files changed, 126 insertions(+), 142 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 3843f5060c73..aea950440b9d 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -72,7 +72,8 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
 int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 				u8 instance, bool force);
 int hci_disable_advertising_sync(struct hci_dev *hdev);
-
+int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
+				u8 instance, bool force);
 int hci_update_passive_scan_sync(struct hci_dev *hdev);
 int hci_update_passive_scan(struct hci_dev *hdev);
 int hci_read_rssi_sync(struct hci_dev *hdev, __le16 handle);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3a5a3cc9372..3209b39899c1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2524,8 +2524,6 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_DELAYED_WORK(&hdev->cmd_timer, hci_cmd_timeout);
 	INIT_DELAYED_WORK(&hdev->ncmd_timer, hci_ncmd_timeout);
 
-	hci_request_setup(hdev);
-
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fe70be6e1981..9b9013c93f5b 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -398,14 +398,6 @@ static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
 	return false;
 }
 
-static void cancel_adv_timeout(struct hci_dev *hdev)
-{
-	if (hdev->adv_instance_timeout) {
-		hdev->adv_instance_timeout = 0;
-		cancel_delayed_work(&hdev->adv_instance_expire);
-	}
-}
-
 static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
 {
 	return hci_adv_instance_is_scannable(hdev, hdev->cur_adv_instance);
@@ -727,37 +719,6 @@ void hci_req_reenable_advertising(struct hci_dev *hdev)
 	hci_req_run(&req, adv_enable_complete);
 }
 
-static void adv_timeout_expire(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    adv_instance_expire.work);
-
-	struct hci_request req;
-	u8 instance;
-
-	bt_dev_dbg(hdev, "");
-
-	hci_dev_lock(hdev);
-
-	hdev->adv_instance_timeout = 0;
-
-	instance = hdev->cur_adv_instance;
-	if (instance == 0x00)
-		goto unlock;
-
-	hci_req_init(&req, hdev);
-
-	hci_req_clear_adv_instance(hdev, NULL, &req, instance, false);
-
-	if (list_empty(&hdev->adv_instances))
-		__hci_req_disable_advertising(&req);
-
-	hci_req_run(&req, NULL);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
 			   u8 *own_addr_type, bdaddr_t *rand_addr)
@@ -1168,72 +1129,6 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 	return 0;
 }
 
-/* For a single instance:
- * - force == true: The instance will be removed even when its remaining
- *   lifetime is not zero.
- * - force == false: the instance will be deactivated but kept stored unless
- *   the remaining lifetime is zero.
- *
- * For instance == 0x00:
- * - force == true: All instances will be removed regardless of their timeout
- *   setting.
- * - force == false: Only instances that have a timeout will be removed.
- */
-void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
-				struct hci_request *req, u8 instance,
-				bool force)
-{
-	struct adv_info *adv_instance, *n, *next_instance = NULL;
-	int err;
-	u8 rem_inst;
-
-	/* Cancel any timeout concerning the removed instance(s). */
-	if (!instance || hdev->cur_adv_instance == instance)
-		cancel_adv_timeout(hdev);
-
-	/* Get the next instance to advertise BEFORE we remove
-	 * the current one. This can be the same instance again
-	 * if there is only one instance.
-	 */
-	if (instance && hdev->cur_adv_instance == instance)
-		next_instance = hci_get_next_instance(hdev, instance);
-
-	if (instance == 0x00) {
-		list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances,
-					 list) {
-			if (!(force || adv_instance->timeout))
-				continue;
-
-			rem_inst = adv_instance->instance;
-			err = hci_remove_adv_instance(hdev, rem_inst);
-			if (!err)
-				mgmt_advertising_removed(sk, hdev, rem_inst);
-		}
-	} else {
-		adv_instance = hci_find_adv_instance(hdev, instance);
-
-		if (force || (adv_instance && adv_instance->timeout &&
-			      !adv_instance->remaining_time)) {
-			/* Don't advertise a removed instance. */
-			if (next_instance &&
-			    next_instance->instance == instance)
-				next_instance = NULL;
-
-			err = hci_remove_adv_instance(hdev, instance);
-			if (!err)
-				mgmt_advertising_removed(sk, hdev, instance);
-		}
-	}
-
-	if (!req || !hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
-		return;
-
-	if (next_instance && !ext_adv_capable(hdev))
-		__hci_req_schedule_adv_instance(req, next_instance->instance,
-						false);
-}
-
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      bool use_rpa, u8 *own_addr_type)
 {
@@ -1505,18 +1400,3 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	return 0;
 }
-
-void hci_request_setup(struct hci_dev *hdev)
-{
-	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
-}
-
-void hci_request_cancel_all(struct hci_dev *hdev)
-{
-	__hci_cmd_sync_cancel(hdev, ENODEV);
-
-	if (hdev->adv_instance_timeout) {
-		cancel_delayed_work_sync(&hdev->adv_instance_expire);
-		hdev->adv_instance_timeout = 0;
-	}
-}
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 093ad8ec469d..30a28550d90c 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -84,10 +84,6 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance);
 
 int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				    bool force);
-void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
-				struct hci_request *req, u8 instance,
-				bool force);
-
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
 int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instance);
@@ -109,6 +105,3 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason);
-
-void hci_request_setup(struct hci_dev *hdev);
-void hci_request_cancel_all(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bf4a87c51548..bb664fa9f95e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -523,6 +523,121 @@ static void interleave_scan(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, add_le_interleaved_scan_sync, NULL, NULL);
 }
 
+static void cancel_adv_timeout(struct hci_dev *hdev)
+{
+	if (hdev->adv_instance_timeout) {
+		hdev->adv_instance_timeout = 0;
+		cancel_delayed_work(&hdev->adv_instance_expire);
+	}
+}
+
+/* For a single instance:
+ * - force == true: The instance will be removed even when its remaining
+ *   lifetime is not zero.
+ * - force == false: the instance will be deactivated but kept stored unless
+ *   the remaining lifetime is zero.
+ *
+ * For instance == 0x00:
+ * - force == true: All instances will be removed regardless of their timeout
+ *   setting.
+ * - force == false: Only instances that have a timeout will be removed.
+ */
+int hci_clear_adv_instance_sync(struct hci_dev *hdev, struct sock *sk,
+				u8 instance, bool force)
+{
+	struct adv_info *adv_instance, *n, *next_instance = NULL;
+	int err;
+	u8 rem_inst;
+
+	/* Cancel any timeout concerning the removed instance(s). */
+	if (!instance || hdev->cur_adv_instance == instance)
+		cancel_adv_timeout(hdev);
+
+	/* Get the next instance to advertise BEFORE we remove
+	 * the current one. This can be the same instance again
+	 * if there is only one instance.
+	 */
+	if (instance && hdev->cur_adv_instance == instance)
+		next_instance = hci_get_next_instance(hdev, instance);
+
+	if (instance == 0x00) {
+		list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances,
+					 list) {
+			if (!(force || adv_instance->timeout))
+				continue;
+
+			rem_inst = adv_instance->instance;
+			err = hci_remove_adv_instance(hdev, rem_inst);
+			if (!err)
+				mgmt_advertising_removed(sk, hdev, rem_inst);
+		}
+	} else {
+		adv_instance = hci_find_adv_instance(hdev, instance);
+
+		if (force || (adv_instance && adv_instance->timeout &&
+			      !adv_instance->remaining_time)) {
+			/* Don't advertise a removed instance. */
+			if (next_instance &&
+			    next_instance->instance == instance)
+				next_instance = NULL;
+
+			err = hci_remove_adv_instance(hdev, instance);
+			if (!err)
+				mgmt_advertising_removed(sk, hdev, instance);
+		}
+	}
+
+	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return 0;
+
+	if (next_instance && !ext_adv_capable(hdev))
+		return hci_schedule_adv_instance_sync(hdev,
+						      next_instance->instance,
+						      false);
+
+	return 0;
+}
+
+static int adv_timeout_expire_sync(struct hci_dev *hdev, void *data)
+{
+	u8 instance = *(u8 *)data;
+
+	kfree(data);
+
+	hci_clear_adv_instance_sync(hdev, NULL, instance, false);
+
+	if (list_empty(&hdev->adv_instances))
+		return hci_disable_advertising_sync(hdev);
+
+	return 0;
+}
+
+static void adv_timeout_expire(struct work_struct *work)
+{
+	u8 *inst_ptr;
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    adv_instance_expire.work);
+
+	bt_dev_dbg(hdev, "");
+
+	hci_dev_lock(hdev);
+
+	hdev->adv_instance_timeout = 0;
+
+	if (hdev->cur_adv_instance == 0x00)
+		goto unlock;
+
+	inst_ptr = kmalloc(1, GFP_KERNEL);
+	if (!inst_ptr)
+		goto unlock;
+
+	*inst_ptr = hdev->cur_adv_instance;
+	hci_cmd_sync_queue(hdev, adv_timeout_expire_sync, inst_ptr, NULL);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 void hci_cmd_sync_init(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
@@ -533,6 +648,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
 	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan);
+	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 }
 
 void hci_cmd_sync_clear(struct hci_dev *hdev)
@@ -1538,14 +1654,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-static void cancel_adv_timeout(struct hci_dev *hdev)
-{
-	if (hdev->adv_instance_timeout) {
-		hdev->adv_instance_timeout = 0;
-		cancel_delayed_work(&hdev->adv_instance_expire);
-	}
-}
-
 static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct {
@@ -4619,7 +4727,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	cancel_delayed_work(&hdev->le_scan_restart);
 	cancel_interleave_scan(hdev);
 
-	hci_request_cancel_all(hdev);
+	__hci_cmd_sync_cancel(hdev, ENODEV);
+
+	if (hdev->adv_instance_timeout) {
+		cancel_delayed_work_sync(&hdev->adv_instance_expire);
+		hdev->adv_instance_timeout = 0;
+	}
 
 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
 	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8cfafd7a0576..a6af51d39caa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2058,6 +2058,8 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	int err;
 
 	if (!val) {
+		hci_clear_adv_instance_sync(hdev, NULL, 0x00, true);
+
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			hci_disable_advertising_sync(hdev);
 
@@ -2131,9 +2133,6 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	val = !!cp->val;
 	enabled = lmp_host_le_capable(hdev);
 
-	if (!val)
-		hci_req_clear_adv_instance(hdev, NULL, NULL, 0x00, true);
-
 	if (!hdev_is_powered(hdev) || val == enabled) {
 		bool changed = false;
 
-- 
2.37.1

