Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A08FC7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 11:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3182080A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 11:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfGOLYs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:24:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:53955 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfGOLYs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 07:24:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 04:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="187098490"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jul 2019 04:24:46 -0700
From:   spoorthix.k@intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     bharat.b.panda@intel.com
Subject: [PATCH] v3 Fast Advertising Interval
Date:   Mon, 15 Jul 2019 17:05:22 +0530
Message-Id: <1563190522-23651-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>

Changes made to add support for fast advertising interval
as per core 4.1 specification, section 9.3.11.2.

A peripheral device entering any of the following GAP modes and
sending either non-connectable advertising events or scannable
undirected advertising events should use adv_fast_interval2
(100ms - 150ms) for adv_fast_period(30s).

         - Non-Discoverable Mode
         - Non-Connectable Mode
         - Limited Discoverable Mode
         - General Discoverable Mode

Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 32 ++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7dfe6ff..a69534d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1512,6 +1512,8 @@ struct hci_mgmt_chan {
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MIN     100     /* msec */
+#define DISCOV_LE_FAST_ADV_INT_MAX     150     /* msec */
 
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ca73d36..d42b6fd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1082,19 +1082,31 @@ void __hci_req_enable_advertising(struct hci_request *req)
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
-
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
+	if (connectable) {
+		cp.type = LE_ADV_IND;
+		cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
+		cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
+	} else {
+		if (get_cur_adv_instance_scan_rsp_len(hdev))
+			cp.type = LE_ADV_SCAN_IND;
+		else
+			cp.type = LE_ADV_NONCONN_IND;
+
+		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
+		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+			cp.min_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
+			cp.max_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
+		} else {
+			cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
+			cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
+		}
+	}
+
 	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
 
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
-- 
1.9.1

