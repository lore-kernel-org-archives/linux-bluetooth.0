Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 22:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiGUW5k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 18:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiGUW5i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 18:57:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0F8E1E7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 15:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658444257; x=1689980257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQLc3H0s4kMhXqmbDASyL0hyYIMuc8kPav62/KluWKI=;
  b=L44xNBbkVVVWjilqcx+IW02DIrrZc54cyKJBA15eKzzx/rY1qwVNytMZ
   XkM09DgK8123XgVfjkiQT2iLlqNXZizDPNF0Ufb+FXl9yeU1yLK1a3bCd
   bkyKVrh5mvQMSMXQL8wY/uJhZUQefM5toPb6T1glyvctb70bvFzIGvd/c
   IRb04JOPAn2MiFlkEzckEasbL4Oj5s5xx9xjhPV4u3crBXHVow0ZY6prI
   O9dkMoZVtJQzHmgAZ6AqT3VXBaAH8Qw1sjM6p7C4bLlabekVEsa2k24g5
   aW5NsDbKTQrTf/NUKLCzzaBzVeLGT4MviiMt5UfJhXgLJIjSdHiUMgNr5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267586482"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267586482"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="548961965"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:19 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 2/3] Bluetooth: Remove update_scan hci_request dependancy
Date:   Thu, 21 Jul 2022 15:57:04 -0700
Message-Id: <20220721225705.602002-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721225705.602002-1-brian.gix@intel.com>
References: <20220721225705.602002-1-brian.gix@intel.com>
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
index 6b76d536dce0..a6886adf8174 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -523,7 +523,6 @@ struct hci_dev {
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
index 6fe894cd3c48..9b7eff95cf19 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3178,7 +3178,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
 				     sizeof(cp), &cp);
 
-			hci_req_update_scan(hdev);
+			hci_update_scan(hdev);
 		}
 
 		/* Set packet type for incoming connection */
@@ -3376,7 +3376,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
 			hci_remove_link_key(hdev, &conn->dst);
 
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 	}
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 967df3ab118f..379eb388633f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1863,21 +1863,6 @@ void __hci_req_update_scan(struct hci_request *req)
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
@@ -2390,7 +2375,6 @@ static void discov_off(struct work_struct *work)
 
 void hci_request_setup(struct hci_dev *hdev)
 {
-	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
@@ -2402,7 +2386,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
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
index b6d194a0eb3f..c0e547b892bd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2259,6 +2259,16 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
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
index 3b5e80bfd4ad..e81491d24904 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1675,7 +1675,7 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 		return err;
 
 	if (changed) {
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 		hci_update_passive_scan(hdev);
 		return new_settings(hdev, sk);
 	}
@@ -7575,7 +7575,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		if (err)
 			goto unlock;
 
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 
 		goto added;
 	}
@@ -7689,7 +7689,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 				goto unlock;
 			}
 
-			hci_req_update_scan(hdev);
+			hci_update_scan(hdev);
 
 			device_removed(sk, hdev, &cp->addr.bdaddr,
 				       cp->addr.type);
@@ -7753,7 +7753,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			kfree(b);
 		}
 
-		hci_req_update_scan(hdev);
+		hci_update_scan(hdev);
 
 		list_for_each_entry_safe(p, tmp, &hdev->le_conn_params, list) {
 			if (p->auto_connect == HCI_AUTO_CONN_DISABLED)
-- 
2.36.1

