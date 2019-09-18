Return-Path: <SRS0=h2kO=XN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B0C4CEC9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4F21906
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfIRKZk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Sep 2019 06:25:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:7632 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfIRKZk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Sep 2019 06:25:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 03:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="199006309"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2019 03:25:38 -0700
From:   spoorthix.k@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org
Subject: [PATCH] Add support to use Resolving list
Date:   Wed, 18 Sep 2019 16:06:25 +0530
Message-Id: <1568802985-9990-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_request.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bc1e30..1574dc1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -433,6 +433,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_LL_PRIVACY		0x40
 #define HCI_LE_PHY_2M			0x01
 #define HCI_LE_PHY_CODED		0x08
 #define HCI_LE_EXT_ADV			0x10
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 621f1a9..2c0d7e8 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -670,6 +670,82 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 	}
 }
 
+static void add_to_resolve_list(struct hci_request *req,
+				struct hci_conn_params *params)
+{
+	struct hci_cp_le_add_to_resolv_list cp;
+	struct bdaddr_list_with_irk *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+
+	cp.bdaddr_type = params->addr_type;
+	bacpy(&cp.bdaddr, &params->addr);
+	memcpy(entry->peer_irk, cp.peer_irk, 16);
+	memcpy(entry->local_irk, cp.local_irk, 16);
+
+	hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
+}
+
+static void update_resolve_list(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct bdaddr_list *b;
+	struct hci_conn_params *params;
+	int err;
+	u8 resolve_list_entries = 0;
+
+	list_for_each_entry(b, &hdev->le_resolv_list, list) {
+	/* Cannot Remove or add the device to the Resolving list
+	 * whenever there is an outstanding connection.
+	 */
+		if (!hci_pend_le_action_lookup(&hdev->pend_le_conns,
+					       &b->bdaddr,
+					       b->bdaddr_type) &&
+		    !hci_pend_le_action_lookup(&hdev->pend_le_reports,
+					       &b->bdaddr,
+					       b->bdaddr_type)) {
+			struct hci_cp_le_del_from_resolv_list cp;
+
+			cp.bdaddr_type = b->bdaddr_type;
+			bacpy(&cp.bdaddr, &b->bdaddr);
+
+			hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
+				    sizeof(cp), &cp);
+		}
+	}
+	/* During background scanning/active scanning the
+	 * device BD address is populated in LE pending
+	 * connections list. So, track the list and add to Resolving
+	 * list if found by IRK.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_conns, action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
+					   &params->addr, params->addr_type))
+			resolve_list_entries++;
+
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			/* Add device to resolving list */
+			resolve_list_entries++;
+			add_to_resolve_list(req, params);
+		}
+	}
+
+	/* Device can be resolved in the Host if size of resolving
+	 * list is greater than defined in the controller.
+	 */
+	if (resolve_list_entries >= hdev->le_resolv_list_size) {
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+		if (err < 0)
+			BT_ERR("%s failed to generate new RPA",
+			       hdev->name);
+		}
+}
+
 static void add_to_white_list(struct hci_request *req,
 			      struct hci_conn_params *params)
 {
@@ -896,6 +972,12 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
 		filter_policy |= 0x02;
 
+	/* If LE Privacy is supported in controller
+	 * add the device to resolving list.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_LE_LL_PRIVACY))
+		update_resolve_list(req);
+
 	hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
 			   hdev->le_scan_window, own_addr_type, filter_policy);
 }
@@ -2513,6 +2595,12 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	if (err < 0)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
+	/* Update resolving list when privacy feature is
+	 * is enabled in the controller */
+	if (hci_dev_test_flag(hdev, HCI_LE_LL_PRIVACY)) {
+		update_resolve_list(req);
+	}
+
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
 			   own_addr_type, 0);
 	return 0;
-- 
1.9.1

