Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F10C25B08
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiHEXm6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbiHEXmw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:42:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A347A52D
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742971; x=1691278971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=efQ7iR2Grbkh6wo8mJOyg9W9VBXwIMONhZU/DckEjFI=;
  b=ixkzMY4KRIw1otAmF0Qdmhbczd5WpSyyId83GsbJekNsIzUqhDt/v9tC
   jqeve5oPNW2nE6ebKqFXSCS4D8hZ0QCYpCmfFlxnq4eWKItqmBaavKsIs
   kpUhIbEeA3ybg7fNewHBYWvaRFE94iaIMEcZO+8JAn3tYtxcuU4BFUn4I
   HRE2zYHPhnqKyk/+/C1nrQGKwDb0MvM52NAqr4+sp4dRN2ukvQtAz3lU/
   baBLuPC2iCIfBR2TuyXVbgT9zaHtaGJzVb3Zdq/CRLeYzTL1OcRI2sOQw
   q/MMwV8/GnOE22JRHl1tgOA3/hX01EF3de6eXb9yUs3j6aP13GPfsFk8n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273362755"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273362755"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636661828"
Received: from bkkx-mobl.gar.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.189.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 8/9] Bluetooth: convert hci_update_adv_data to hci_sync
Date:   Fri,  5 Aug 2022 16:42:35 -0700
Message-Id: <20220805234236.704986-9-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234236.704986-1-brian.gix@intel.com>
References: <20220805234236.704986-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_update_adv_data() is called from hci_event and hci_core due to
events from the controller. The prior function used the deprecated
hci_request method, and the new one uses hci_sync.c

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_core.c         |  2 +-
 net/bluetooth/hci_event.c        |  2 +-
 net/bluetooth/hci_request.c      | 64 --------------------------------
 net/bluetooth/hci_request.h      |  2 -
 net/bluetooth/hci_sync.c         | 20 ++++++++++
 6 files changed, 23 insertions(+), 68 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index b6b975c2ed3e..17f5a4c32f36 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -61,6 +61,7 @@ int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 
 int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance);
 int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance);
+int hci_update_adv_data(struct hci_dev *hdev, u8 instance);
 int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				   bool force);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3a5a3cc9372..9d2c33f6b065 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -714,7 +714,7 @@ static void hci_update_passive_scan_state(struct hci_dev *hdev, u8 scan)
 		hci_dev_set_flag(hdev, HCI_BREDR_ENABLED);
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-			hci_req_update_adv_data(hdev, hdev->cur_adv_instance);
+			hci_update_adv_data(hdev, hdev->cur_adv_instance);
 
 		mgmt_new_settings(hdev);
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea33dd0cd478..9ab359b15f57 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2149,7 +2149,7 @@ static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
 			adv_instance->tx_power = rp->tx_power;
 	}
 	/* Update adv data as tx power is known now */
-	hci_req_update_adv_data(hdev, cp->handle);
+	hci_update_adv_data(hdev, cp->handle);
 
 	hci_dev_unlock(hdev);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index b9875224ac7b..2e19a271d7a1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -829,70 +829,6 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 			   addr_resolv);
 }
 
-static void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
-{
-	struct hci_dev *hdev = req->hdev;
-	u8 len;
-
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return;
-
-	if (ext_adv_capable(hdev)) {
-		struct {
-			struct hci_cp_le_set_ext_adv_data cp;
-			u8 data[HCI_MAX_EXT_AD_LENGTH];
-		} pdu;
-
-		memset(&pdu, 0, sizeof(pdu));
-
-		len = eir_create_adv_data(hdev, instance, pdu.data);
-
-		/* There's nothing to do if the data hasn't changed */
-		if (hdev->adv_data_len == len &&
-		    memcmp(pdu.data, hdev->adv_data, len) == 0)
-			return;
-
-		memcpy(hdev->adv_data, pdu.data, len);
-		hdev->adv_data_len = len;
-
-		pdu.cp.length = len;
-		pdu.cp.handle = instance;
-		pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-		pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
-
-		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_DATA,
-			    sizeof(pdu.cp) + len, &pdu.cp);
-	} else {
-		struct hci_cp_le_set_adv_data cp;
-
-		memset(&cp, 0, sizeof(cp));
-
-		len = eir_create_adv_data(hdev, instance, cp.data);
-
-		/* There's nothing to do if the data hasn't changed */
-		if (hdev->adv_data_len == len &&
-		    memcmp(cp.data, hdev->adv_data, len) == 0)
-			return;
-
-		memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-		hdev->adv_data_len = len;
-
-		cp.length = len;
-
-		hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
-	}
-}
-
-int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
-{
-	struct hci_request req;
-
-	hci_req_init(&req, hdev);
-	__hci_req_update_adv_data(&req, instance);
-
-	return hci_req_run(&req, NULL);
-}
-
 static int hci_req_add_le_interleaved_scan(struct hci_request *req,
 					   unsigned long opt)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index c7185ad77c6e..7e1de871fca4 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -73,8 +73,6 @@ void hci_req_add_le_passive_scan(struct hci_request *req);
 
 void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
 
-int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance);
-
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 46eb535ff466..6de2ad730995 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6065,3 +6065,23 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 
 	return 0;
 }
+
+static int _update_adv_data_sync(struct hci_dev *hdev, void *data)
+{
+	u8 instance = *(u8 *)data;
+
+	kfree(data);
+
+	return hci_update_adv_data_sync(hdev, instance);
+}
+
+int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
+{
+	u8 *inst_ptr = kmalloc(1, GFP_KERNEL);
+
+	if (!inst_ptr)
+		return -ENOMEM;
+
+	*inst_ptr = instance;
+	return hci_cmd_sync_queue(hdev, _update_adv_data_sync, inst_ptr, NULL);
+}
-- 
2.37.1

