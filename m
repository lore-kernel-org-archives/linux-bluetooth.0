Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE7EC433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403CB205C9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 08:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfHNIGw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:06:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:26875 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfHNIGw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 04:06:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 01:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="194448403"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2019 01:06:50 -0700
From:   spoorthix.k@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-bluetooth-owner@vger.kernel.org, bharat.b.panda@intel.com
Subject: [PATCH] Add support to use resolving list
Date:   Wed, 14 Aug 2019 13:48:21 +0530
Message-Id: <1565770701-7274-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

As per Core specification 5.0, Vol 2, Part E, Section 7.8.38,
following code changes implements LE add device to Resolving List.

Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci.h |   1 +
 net/bluetooth/hci_request.c | 134 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e..99a38cf36 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -420,6 +420,7 @@ enum {
 #define HCI_LE_SLAVE_FEATURES		0x08
 #define HCI_LE_PING			0x10
 #define HCI_LE_DATA_LEN_EXT		0x20
+#define HCI_LE_LL_PRIVACY		0x40
 #define HCI_LE_PHY_2M			0x01
 #define HCI_LE_PHY_CODED		0x08
 #define HCI_LE_EXT_ADV			0x10
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ca73d36..868a592 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -672,7 +672,6 @@ static void add_to_white_list(struct hci_request *req,
 
 	cp.bdaddr_type = params->addr_type;
 	bacpy(&cp.bdaddr, &params->addr);
-
 	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
 }
 
@@ -681,7 +680,7 @@ static u8 update_white_list(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	struct hci_conn_params *params;
 	struct bdaddr_list *b;
-	uint8_t white_list_entries = 0;
+	u8 white_list_entries = 0;
 
 	/* Go through the current white list programmed into the
 	 * controller one by one and check if that address is still
@@ -773,6 +772,111 @@ static u8 update_white_list(struct hci_request *req)
 	return 0x01;
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
+	cp.bdaddr_type = params->addr_type;
+	bacpy(&cp.bdaddr, &params->addr);
+	memcpy(entry->peer_irk, cp.peer_irk, 16);
+	memcpy(entry->local_irk, cp.local_irk, 16);
+	hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
+}
+
+static u8 update_resolve_list(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_conn_params *params;
+	struct bdaddr_list *b;
+	u8 resolve_list_entries = 0;
+
+	/* Go through the current resolving list programmed into the
+	 * controller one by one and check if that address is still
+	 * in the list of pending connections or list of devices to
+	 * report. If not present in either list, then queue
+	 * command to remove it from the controller.
+	 */
+
+	list_for_each_entry(b, &hdev->le_resolv_list, list) {
+		/* If the device is neither in pend_le_conns nor
+		 * pend_le_reports then remove it from the resolving list.
+		 */
+		if (!hci_pend_le_action_lookup(&hdev->pend_le_conns,
+					       &b->bdaddr, b->bdaddr_type) &&
+		    !hci_pend_le_action_lookup(&hdev->pend_le_reports,
+					       &b->bdaddr, b->bdaddr_type)) {
+			struct hci_cp_le_del_from_resolv_list cp;
+
+			cp.bdaddr_type = b->bdaddr_type;
+			bacpy(&cp.bdaddr, &b->bdaddr);
+			hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
+				    sizeof(cp), &cp);
+			continue;
+		}
+		if (hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type))
+			return 0x00;
+
+		resolve_list_entries++;
+	}
+
+	/* Since all no longer valid resolve list entries have been
+	 * removed, walk through the list of pending connections
+	 * and ensure that any new device gets programmed into
+	 * the controller.
+	 *
+	 * If the list of the devices is larger than the list of
+	 * available resolve list entries in the controller, then
+	 * just abort and return filer policy value to not use the
+	 * resolve list.
+	 */
+
+	list_for_each_entry(params, &hdev->pend_le_conns, action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
+					   &params->addr, params->addr_type))
+			continue;
+
+		if (resolve_list_entries >= hdev->le_resolv_list_size) {
+			/* Select filter policy to accept all advertising */
+			return 0x00;
+		}
+
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			return 0x00;
+		}
+		resolve_list_entries++;
+		add_to_resolve_list(req, params);
+	}
+
+	/* After adding all new pending connections, walk through
+	 * the list of pending reports and also add these to the
+	 * resolving list if there is still space.
+	 */
+
+	list_for_each_entry(params, &hdev->pend_le_reports, action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
+					   &params->addr, params->addr_type))
+			continue;
+
+		if (resolve_list_entries >= hdev->le_resolv_list_size)
+			return 0x00;
+
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			return 0x00;
+		}
+		resolve_list_entries++;
+		add_to_resolve_list(req, params);
+	}
+	return 0x02;
+}
+
 static bool scan_use_rpa(struct hci_dev *hdev)
 {
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
@@ -861,6 +965,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
 	u8 filter_policy;
+	u8 ext_filter_policy;
 
 	/* Set require_privacy to false since no SCAN_REQ are send
 	 * during passive scanning. Not using an non-resolvable address
@@ -878,6 +983,12 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	 */
 	filter_policy = update_white_list(req);
 
+	/* Adding or removing entries from the resolve list must
+	 * happen before enabling scanning. The controller does
+	 * not allow resolve list modification while scanning.
+	 */
+	ext_filter_policy = update_resolve_list(req);
+
 	/* When the controller is using random resolvable addresses and
 	 * with that having LE privacy enabled, then controllers with
 	 * Extended Scanner Filter Policies support can now enable support
@@ -888,11 +999,24 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	 * 0x02 (no whitelist) and 0x03 (whitelist enabled).
 	 */
 	if (hci_dev_test_flag(hdev, HCI_PRIVACY) &&
-	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY))
+	    (hdev->le_features[0] & HCI_LE_EXT_SCAN_POLICY) &&
+	     (!(hdev->le_features[0] & HCI_LE_LL_PRIVACY)))
 		filter_policy |= 0x02;
 
-	hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
-			   hdev->le_scan_window, own_addr_type, filter_policy);
+	if (!ext_filter_policy && (hdev->le_features[0] & HCI_LE_LL_PRIVACY)) {
+		/* If resolve list can not be used then check if
+		 * whitelist can be used and set filter policy
+		 * accordingly.
+		 */
+		ext_filter_policy = filter_policy;
+		hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
+				   hdev->le_scan_window, own_addr_type,
+				   ext_filter_policy);
+	} else {
+		hci_req_start_scan(req, LE_SCAN_PASSIVE, hdev->le_scan_interval,
+				   hdev->le_scan_window, own_addr_type,
+				   filter_policy);
+	}
 }
 
 static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
-- 
1.9.1

