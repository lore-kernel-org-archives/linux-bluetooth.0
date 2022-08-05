Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D9C25B08
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbiHEXmz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbiHEXmv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:42:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3557B1E1
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742970; x=1691278970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TCu+Ccxnf1kJBsitLEgbY/j2cV44ZgEy0gAhm/7gSRE=;
  b=kLBN1oa2Oquxvya+L9YX+0Ipv/7LnSwvRmEFrzVOskYanuWOmiJXJk+0
   rFWER13sIP9HGKcVRabl23KpUis6im1HutKOOpT/MGsApJ4+nFZXlayjc
   Ie7jXrw2t++3rxbiVQnBKVctPyUQHDGogItnXhV4tu3KiJdcGqIyFSGCf
   jG9g51xV1bzNt9RUkWgtgha4yamkGBpnHVG95lAeECRUck0GbQGt8MoxM
   zs7NBuqydKxfddlVScH9rabiOJEhbtP3EmjlOqrrm+4VxKcVkSLbqWFjt
   dNiRexWKyf4JtzfDGqHTrjhys0kn6gpU5g29SqmwgQRqctI2Z/Y2H3O3l
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273362751"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273362751"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636661818"
Received: from bkkx-mobl.gar.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.189.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 5/9] Bluetooth: Move Adv Instance timer to hci_sync
Date:   Fri,  5 Aug 2022 16:42:32 -0700
Message-Id: <20220805234236.704986-6-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234236.704986-1-brian.gix@intel.com>
References: <20220805234236.704986-1-brian.gix@intel.com>
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
 net/bluetooth/hci_request.c      | 111 --------------------------
 net/bluetooth/hci_request.h      |   4 -
 net/bluetooth/hci_sync.c         | 129 +++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             |   5 +-
 5 files changed, 125 insertions(+), 127 deletions(-)

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
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d14e50951aec..be32fb0f5557 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -811,14 +811,6 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 			   addr_resolv);
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
@@ -1140,37 +1132,6 @@ void hci_req_reenable_advertising(struct hci_dev *hdev)
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
 static int hci_req_add_le_interleaved_scan(struct hci_request *req,
 					   unsigned long opt)
 {
@@ -1637,72 +1598,6 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
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
@@ -1977,7 +1872,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 void hci_request_setup(struct hci_dev *hdev)
 {
-	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
 }
 
@@ -1985,10 +1879,5 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 {
 	__hci_cmd_sync_cancel(hdev, ENODEV);
 
-	if (hdev->adv_instance_timeout) {
-		cancel_delayed_work_sync(&hdev->adv_instance_expire);
-		hdev->adv_instance_timeout = 0;
-	}
-
 	cancel_interleave_scan(hdev);
 }
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 41e0b84f2042..3d1b3d97ccdd 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -90,10 +90,6 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance);
 
 int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				    bool force);
-void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
-				struct hci_request *req, u8 instance,
-				bool force);
-
 int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instance);
 int __hci_req_setup_per_adv_instance(struct hci_request *req, u8 instance,
 				     u16 min_interval, u16 max_interval);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 75e7c0a01ab1..bc993dd2383d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -465,6 +465,121 @@ static void le_scan_restart(struct work_struct *work)
 	hci_dev_unlock(hdev);
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
@@ -474,6 +589,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
+	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
 }
 
 void hci_cmd_sync_clear(struct hci_dev *hdev)
@@ -1479,14 +1595,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
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
@@ -4566,6 +4674,11 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	hci_request_cancel_all(hdev);
 
+	if (hdev->adv_instance_timeout) {
+		cancel_delayed_work_sync(&hdev->adv_instance_expire);
+		hdev->adv_instance_timeout = 0;
+	}
+
 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
 	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    test_bit(HCI_UP, &hdev->flags)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 646d10401b80..11eb6e538518 100644
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

