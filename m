Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE8C00144
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiG3Au5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiG3Auy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA19773920
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659142253; x=1690678253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=erD1VlI0xlr+4HyfUepsVBTOn1c+35rHmwf7ZvB4MTk=;
  b=IkNyCkooXgWS2rqLP+SpZ42ux+1Avvjacz2HyBP8roziA9uoxGrpfFe4
   V8H1iI6LcZJbeR85Ih28TtnW6gudmyCoG2QQ1eBnVV3XQtmAW+MLcTQyn
   wmu26p57R1qX4nTYvQ0s25vXNjmRjtA5XjzhqN8Tjyn6wCDCzugfn7+H3
   YN7E1CWVIjwj5gRlyv0/ODlXMDf4sYzt2MjmV/RDgrco6JZzSZ+ywPV6s
   RSCG9UlVPmtmRAqrT9Q+Q9vWjOzBFBpGxN3maWGR+23PCH5GWt7VBE9g/
   wzcqLXTgzqGuUYc6dNLFvud+jKBsvxjD4VYDSLMz9XMIhheyOtZB8hVii
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268644798"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268644798"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660458135"
Received: from agcodina-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.26.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:51 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 09/10] Bluetooth: convert hci_update_adv_data to hci_sync
Date:   Fri, 29 Jul 2022 17:50:37 -0700
Message-Id: <20220730005038.894650-10-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730005038.894650-1-brian.gix@intel.com>
References: <20220730005038.894650-1-brian.gix@intel.com>
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
 net/bluetooth/hci_request.h      |  3 --
 net/bluetooth/hci_sync.c         | 20 ++++++++++
 6 files changed, 23 insertions(+), 69 deletions(-)

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
index 3209b39899c1..22e373ff5293 100644
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
index 31b75253a7eb..c6bfb2e75e52 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -273,70 +273,6 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 	hci_req_add_ev(req, opcode, plen, param, 0);
 }
 
-void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
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
 static void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 			     u8 reason)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 9792c34a681c..e5ecd4e4b686 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -68,7 +68,4 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
-void __hci_req_update_adv_data(struct hci_request *req, u8 instance);
-int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance);
-
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e8d5b08a38dc..280f0fcfdedc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6120,3 +6120,23 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 
 	return 0;
 }
+
+static int _update_adv_data_sync(struct hci_dev *hdev, void *data)
+{
+	u8 instance = *(u8 *) data;
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

