Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9EAC19F2C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 17:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiHARPw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiHARPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 13:15:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356C63C3
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659374127; x=1690910127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tfn0fWy0ShIbfJJ2b2cyOxzRrYyGg7FXgGOVFcKZWxc=;
  b=i622k/J5LDkqDxlCzhdvwcApFE03aALWa+ncuHv5iobvj7gFejufdjF8
   I3Ye9LhMcfH5I23ju+DXtm1Aqd66jjn2ORhnvEIN4D3hM2aIpk42mHzU8
   hZJdzdjfN5PeFfGXDUGOTOjCFaoT906adllHG7Z0xiNHRNdL3HmOSKPZ9
   c4b8kX5GmT6vb0g4lgeRl/Dd6ptuTOmnm2kAM41phjFiaCF2ur2Y7T4hC
   mc9RqDSbn8acxmQFjCsjr5+gfqNqOuxvH6qxXRD0v9aBaRiGAZr1Az6jq
   AikaW6KWmmHLIffqYgfsqfdwjISpeP5CK0Hbxj+QHrhWIzjEZ9ldFE3h+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276104778"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="276104778"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="847899648"
Received: from gestarne-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.120.49])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:17 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v6 09/10] Bluetooth: convert hci_update_adv_data to hci_sync
Date:   Mon,  1 Aug 2022 10:15:04 -0700
Message-Id: <20220801171505.1271059-10-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801171505.1271059-1-brian.gix@intel.com>
References: <20220801171505.1271059-1-brian.gix@intel.com>
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
index f2f3a0e8fbaf..0b0563a245f7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6120,3 +6120,23 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 
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

