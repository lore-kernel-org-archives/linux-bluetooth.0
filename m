Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268CC04AAC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8402087F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfEFIJN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 04:09:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:13592 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfEFIJN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 04:09:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 01:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="141692811"
Received: from spoorthi-h97m-d3h.iind.intel.com ([10.223.96.21])
  by orsmga006.jf.intel.com with ESMTP; 06 May 2019 01:09:11 -0700
From:   SpoorthiX K <spoorthix.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     bharat.b.panda@intel.com
Subject: [PATCH v4] Bluetooth: Support fast advertising interval
Date:   Mon,  6 May 2019 13:48:08 +0530
Message-Id: <1557130688-11257-1-git-send-email-spoorthix.k@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Bharat Bhusan Panda <bharat.b.panda@intel.com>

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

Signed-off-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5ea633..8b31058 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1508,6 +1508,8 @@ struct hci_mgmt_chan {
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MIN	100	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MAX	150	/* msec */
 
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e8c9ef1..cb9a054 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1082,15 +1082,36 @@ void __hci_req_enable_advertising(struct hci_request *req)
 		return;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
-	cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
 
-	if (connectable)
+	if (connectable) {
 		cp.type = LE_ADV_IND;
-	else if (get_cur_adv_instance_scan_rsp_len(hdev))
-		cp.type = LE_ADV_SCAN_IND;
-	else
-		cp.type = LE_ADV_NONCONN_IND;
+		cp.min_interval = cpu_to_le16(hdev->le_adv_min_interval);
+		cp.max_interval = cpu_to_le16(hdev->le_adv_max_interval);
+	} else {
+		if (get_cur_adv_instance_scan_rsp_len(hdev)) {
+			cp.type = LE_ADV_SCAN_IND;
+		}
+		else {
+			cp.type = LE_ADV_NONCONN_IND;
+		}
+		/* As per core 4.1 spec, section 9.3.11.2: A peripheral device
+		 * entering any of the following GAP modes and sending either
+		 * non-connectable advertising events or scannable undirected
+		 * advertising events should use adv_fast_interval2 (100ms -
+		 * 150ms) for adv_fast_period(30s).
+		 *
+		 *	- Non-Discoverable Mode
+		 *	- Non-Connectable Mode
+		 *	- Limited Discoverable Mode
+		 *	- General Discoverable Mode
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
+		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+			cp.min_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
+			cp.max_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
+		}
+	}
 
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
-- 
1.9.1

