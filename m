Return-Path: <SRS0=DiUs=Z2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23B0C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 10:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C272207DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 10:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfLDKta (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:49:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:11533 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfLDKt3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Dec 2019 05:49:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 02:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,277,1571727600"; 
   d="scan'208";a="205350840"
Received: from unknown (HELO spoorthi-H97M-D3H.iind.intel.com) ([10.223.96.107])
  by orsmga008.jf.intel.com with ESMTP; 04 Dec 2019 02:49:27 -0800
From:   spoorthix.k@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     bharat.b.panda@intel.com
Subject: [PATCH] Add support to update Resolving list
Date:   Wed,  4 Dec 2019 16:33:11 +0530
Message-Id: <1575457391-3974-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

Code changes to add or delete the BD address to/from existing
resolving list referred from  Bluetooth Core Specification
v5.0 Vol6 Part B Section 6.3, If the link layer privacy feature
is supported by the controller, Link layer may scan devices
using RPA during background scan,the host can add newly
scanned devices to the Resolving list.
`

Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_request.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

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
index 621f1a9..5c59cce 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -670,6 +670,85 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 	}
 }
 
+static void add_to_resolve_list(struct hci_request *req,
+				struct hci_conn_params *params,
+				struct list_head *list)
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
+	list_add(&entry->list, list);
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
+			add_to_resolve_list(req, params, &hdev->le_resolv_list);
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
@@ -896,6 +975,12 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
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
-- 
1.9.1

