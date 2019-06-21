Return-Path: <SRS0=Kt1c=UU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5E2C43613
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B61720449
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jun 2019 09:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFUJMk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:12:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:61249 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfFUJMj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jun 2019 05:12:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 02:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,399,1557212400"; 
   d="scan'208";a="162810915"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2019 02:12:38 -0700
From:   spoorthix.k@intel.com
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fast advertising interval
Date:   Fri, 21 Jun 2019 14:52:11 +0530
Message-Id: <1561108931-9568-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

Implemented as per Core Spec 5.0

Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 33 ++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aed17df..9b19992 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1510,6 +1510,8 @@ struct hci_mgmt_chan {
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MIN     100     /* msec */
+#define DISCOV_LE_FAST_ADV_INT_MAX     150     /* msec */
 
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d4f5bfa..c077b06 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1177,8 +1177,10 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	bool connectable;
 	u32 flags;
 
+       	BT_INFO("Entered __hci_req_enable_advertising");
 	flags = get_adv_instance_flags(hdev, hdev->cur_adv_instance);
 
+
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
 	 */
@@ -1208,15 +1210,28 @@ void __hci_req_enable_advertising(struct hci_request *req)
 		return;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
-	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
-
-	if (connectable)
-		cp.type = LE_ADV_IND;
-	else if (get_cur_adv_instance_scan_rsp_len(hdev))
-		cp.type = LE_ADV_SCAN_IND;
-	else
-		cp.type = LE_ADV_NONCONN_IND;
+       BT_INFO("__hci_req_enable_advertising");
+
+       if (connectable) {
+               BT_INFO("set adv min and max");
+                cp.type = LE_ADV_IND;
+               cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
+               cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
+       } else {
+               if (get_cur_adv_instance_scan_rsp_len(hdev))
+                       cp.type = LE_ADV_SCAN_IND;
+               else
+                       cp.type = LE_ADV_NONCONN_IND;
+
+              if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
+                       hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+                       BT_INFO("Check  HCI_DISCOVERABLE or HCI_LIMITED_DISCOVERABLE");
+                       cp.min_interval =
+                              cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
+                       cp.max_interval =
+                               cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
+               }
+       }
 
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
-- 
1.9.1

