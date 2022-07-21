Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DACCA488
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 23:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiGUXWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGUXWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 19:22:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E301D30F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658445760; x=1689981760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fSQ3lQR42qH8hPhuypE3oCwpDWt4vx+0YspmH8dqodg=;
  b=HAgTLuKmELQcjHwkx9WK9SvGLPV557LwkEbBY95E4JPd6t7fkkXvg7SH
   FQOKGuqQvoV/Jmov3GjTVk0BMUgn22n5jinx7lCET8Ot+m8+orNQdCQv4
   nVw1zfXx4CDS8UOnOhXFKcEBm+fJL96d7sKR5l2K0M2e3x8HnBTxxZSFf
   romVo4OO5bhKD59ElBrRjYCFWvmnQW0OqMD0kKbnLks9UcKm/o67ItGrU
   gqcdbZnXfFu0Ab3gq9JyIKkVjvLwQEeu9KhZ7/qSq80NXY4uSj3xTCRTh
   2E0r4KuR5yb/eRrEdzoFZ7nHLvoPUFpGRLxBAl3E+rc6ZAH0CtCdjoU5z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312912921"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="312912921"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631363092"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:39 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2 2/3] Bluetooth: Remove update_scan hci_request dependancy
Date:   Thu, 21 Jul 2022 16:22:24 -0700
Message-Id: <20220721232225.624426-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721232225.624426-1-brian.gix@intel.com>
References: <20220721232225.624426-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes the remaining calls to HCI_OP_WRITE_SCAN_ENABLE from
hci_request call chains, and converts them to hci_sync calls.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/hci_request.c      | 17 -----------------
 net/bluetooth/hci_request.h      |  5 -----
 net/bluetooth/hci_sync.c         | 10 ++++++++++
 net/bluetooth/mgmt.c             |  8 ++++----
 7 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bf6aa6f39632..a0a2a5665462 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -520,7 +520,6 @@ struct hci_dev {
 	struct work_struct	cmd_work;
 	struct work_struct	tx_work;
 
-	struct work_struct	scan_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
 
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 2492e3b46a8f..8a09b8d6150e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -78,6 +78,7 @@ int hci_read_clock_sync(struct hci_dev *hdev, struct hci_cp_read_clock *cp);
 
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
 int hci_update_scan_sync(struct hci_dev *hdev);
+int hci_update_scan(struct hci_dev *hdev);
 
 int hci_write_le_host_supported_sync(struct hci_dev *hdev, u8 le, u8 simul);
 int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 34bec7446d00..b32ca92fc692 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3173,7 +3173,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
 				     sizeof(cp), &cp);
 
-			hci_req_update_scan(hdev);
+			hci_update_scan(hdev);
 		}
 
 		/* Set packet type for incoming connection */
@@ -3371,7 +3371,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
 			hci_remove_link_key(hdev, &conn->dst);
 
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 	}
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9340fdbff679..3257f0f588cd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1835,21 +1835,6 @@ void __hci_req_update_scan(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-static int update_scan(struct hci_request *req, unsigned long opt)
-{
-	hci_dev_lock(req->hdev);
-	__hci_req_update_scan(req);
-	hci_dev_unlock(req->hdev);
-	return 0;
-}
-
-static void scan_update_work(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev, scan_update);
-
-	hci_req_sync(hdev, update_scan, 0, HCI_CMD_TIMEOUT, NULL);
-}
-
 static u8 get_service_classes(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid;
@@ -2348,7 +2333,6 @@ static void discov_off(struct work_struct *work)
 
 void hci_request_setup(struct hci_dev *hdev)
 {
-	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
@@ -2360,7 +2344,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 {
 	__hci_cmd_sync_cancel(hdev, ENODEV);
 
-	cancel_work_sync(&hdev->scan_update);
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 2b2fba278510..821244ad9d73 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -108,11 +108,6 @@ bool hci_req_stop_discovery(struct hci_request *req);
 
 int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec);
 
-static inline void hci_req_update_scan(struct hci_dev *hdev)
-{
-	queue_work(hdev->req_workqueue, &hdev->scan_update);
-}
-
 void __hci_req_update_scan(struct hci_request *req);
 
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a4f1b209b4f8..9844e231805e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2236,6 +2236,16 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 	return err;
 }
 
+static int update_scan_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_update_scan_sync(hdev);
+}
+
+int hci_update_scan(struct hci_dev *hdev)
+{
+	return hci_cmd_sync_queue(hdev, update_scan_sync, NULL, NULL);
+}
+
 static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
 {
 	return hci_update_passive_scan_sync(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ef8371975c4e..c6750abb0ca2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1611,7 +1611,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 		return err;
 
 	if (changed) {
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 		hci_update_passive_scan(hdev);
 		return new_settings(hdev, sk);
 	}
@@ -7115,7 +7115,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		if (err)
 			goto unlock;
 
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 
 		goto added;
 	}
@@ -7229,7 +7229,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				goto unlock;
 			}
 
-			hci_req_update_scan(hdev);
+			hci_update_scan(hdev);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -7293,7 +7293,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
-- 
2.36.1

