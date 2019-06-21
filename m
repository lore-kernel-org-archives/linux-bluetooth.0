Return-Path: <SRS0=Kt1c=UU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B3FC43613
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C06208C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFUJMJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:12:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:43673 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfFUJMJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jun 2019 05:12:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 02:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,399,1557212400"; 
   d="scan'208";a="154396522"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2019 02:12:08 -0700
From:   spoorthix.k@intel.com
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] LE Privacy implementation
Date:   Fri, 21 Jun 2019 14:51:41 +0530
Message-Id: <1561108901-9475-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

As per Core specification 5.0, Vol 2, Part E, Section 7.8.38,
following code changes implements LE add device to Resolving List.
< HCI Command: LE Set Scan Pa.. (0x08|0x000b) plen 7  #3 [hci0] 06:08:22.083786
        Type: Active (0x01)
        Interval: 22.500 msec (0x0024)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4           #4 [hci0] 06:08:22.084498
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Add Devic.. (0x08|0x0027) plen 39  #26 [hci0] 06:08:30.646867
        Address type: Random (0x01)
        Address: E8:E9:93:AD:7E:A2 (Static)
        Peer identity resolving key: 704baf18bc90ffffb83c2d40d2b0ffff
        Local identity resolving key: 8e4902a3ffffffff0040af18bc90ffff
> HCI Event: Command Complete (0x0e) plen 4          #27 [hci0] 06:08:30.647408
      LE Add Device To Resolving List (0x08|0x0027) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan P.. (0x08|0x000b) plen 7  #28 [hci0] 06:08:30.647456
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement, inc. directed unresolved RPA (0x02)
> HCI Event: Command Complete (0x0e) plen 4          #29 [hci0] 06:08:30.648901
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Co.. (0x08|0x000d) plen 25  #43 [hci0] 06:08:31.142393
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
> HCI Event: Command Status (0x0f) plen 4            #44 [hci0] 06:08:31.144909
      LE Create Connection (0x08|0x000d) ncmd 2
        Status: Success (0x00)
@ MGMT Command: Add Device (0x0033) plen 8      {0x0001} [hci0] 06:08:40.939043
        LE Address: E8:E9:93:AD:7E:A2 (Static)
        Action: Auto-connect remote device (0x02)

Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci.h |   1 +
 net/bluetooth/hci_request.c | 119 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 1 deletion(-)

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
index ca73d36..d4ecf71 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -773,6 +773,119 @@ static u8 update_white_list(struct hci_request *req)
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
+	uint8_t resolve_list_entries = 0;
+
+	/* Go through the current white list programmed into the
+	 * controller one by one and check if that address is still
+	 * in the list of pending connections or list of devices to
+	 * report. If not present in either list, then queue the
+	 * command to remove it from the controller.
+	 */
+	list_for_each_entry(b, &hdev->le_resolv_list, list) {
+		/* If the device is neither in pend_le_conns nor
+		 * pend_le_reports then remove it from the whitelist.
+		 */
+		if (!hci_pend_le_action_lookup(&hdev->pend_le_conns,
+                                               &b->bdaddr, b->bdaddr_type) &&
+                    !hci_pend_le_action_lookup(&hdev->pend_le_reports,
+                                               &b->bdaddr, b->bdaddr_type)) {
+                        struct hci_cp_le_del_from_resolv_list cp;
+
+                        cp.bdaddr_type = b->bdaddr_type;
+                        bacpy(&cp.bdaddr, &b->bdaddr);
+
+                        hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
+                                    sizeof(cp), &cp);
+                        continue;
+                }
+
+                if (hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
+                        /* White list can not be used with RPAs */
+                        return 0x00;
+                }
+
+                resolve_list_entries++;
+        }
+
+       /* Since all no longer valid white list entries have been
+        * removed, walk through the list of pending connections
+        * and ensure that any new device gets programmed into
+        * the controller.
+        *
+        * If the list of the devices is larger than the list of
+        * available white list entries in the controller, then
+        * just abort and return filer policy value to not use the
+        * white list.
+        */
+       list_for_each_entry(params, &hdev->pend_le_conns, action) {
+               if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
+                                          &params->addr, params->addr_type))
+                       continue;
+
+                if (resolve_list_entries >= hdev->le_resolv_list_size) {
+                        /* Select filter policy to accept all advertising */
+                        return 0x00;
+                }
+
+                if (hci_find_irk_by_addr(hdev, &params->addr,
+                                         params->addr_type)) {
+                        /* White list can not be used with RPAs */
+                        return 0x02;
+                }
+
+                resolve_list_entries++;
+                add_to_resolve_list(req, params);
+        }
+
+        /* After adding all new pending connections, walk through
+         * the list of pending reports and also add these to the
+         * white list if there is still space.
+        */
+        list_for_each_entry(params, &hdev->pend_le_reports, action) {
+                if (hci_bdaddr_list_lookup(&hdev->le_resolv_list,
+                                           &params->addr, params->addr_type))
+                        continue;
+
+                if (resolve_list_entries >= hdev->le_resolv_list_size) {
+                        /* Select filter policy to accept all advertising */
+                        return 0x00;
+                }
+
+                if (hci_find_irk_by_addr(hdev, &params->addr,
+                                         params->addr_type)) {
+                        /* White list can not be used with RPAs */
+                        return 0x02;
+                }
+
+                resolve_list_entries++;
+                add_to_resolve_list(req, params);
+        }
+       /* Select filter policy to use white list */
+        return 0x02;
+}
+
 static bool scan_use_rpa(struct hci_dev *hdev)
 {
 	return hci_dev_test_flag(hdev, HCI_PRIVACY);
@@ -876,7 +989,11 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	 * happen before enabling scanning. The controller does
 	 * not allow white list modification while scanning.
 	 */
-	filter_policy = update_white_list(req);
+
+	if (!(hdev->le_features[0] & HCI_LE_LL_PRIVACY))
+		filter_policy = update_white_list(req);
+	else
+		filter_policy = update_resolve_list(req);
 
 	/* When the controller is using random resolvable addresses and
 	 * with that having LE privacy enabled, then controllers with
-- 
1.9.1

