Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F100C282D7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A6120820
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 08:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBDIw5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:52:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:10145 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfBDIw5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 03:52:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 00:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="121808466"
Received: from bpanda-all-series.iind.intel.com ([10.223.96.45])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2019 00:52:56 -0800
From:   Bharat Bhusan Panda <bharat.b.panda@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Support fast advertising interval
Date:   Mon,  4 Feb 2019 14:37:47 +0530
Message-Id: <1549271267-12393-1-git-send-email-bharat.b.panda@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes made to add support for fast advertising interval as per
core 4.1 specification, section 9.3.11.2.

A peripheral device entering any of the following GAP modes and
sending either non-connectable advertising events or scannable undirected
advertising events should use adv_fast_interval2(100ms - 150ms)
for adv_fast_period(30s).
         - Non-Discoverable Mode
         - Non-Connectable Mode
         - Limited Discoverable Mode
         - General Discoverable Mode

Signed-off-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0db1b9b..868c2fb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1491,6 +1491,8 @@ struct hci_mgmt_chan {
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MIN	100	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MAX	150	/* msec */
 
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e8c9ef1..9b73061 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1092,6 +1092,33 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	else
 		cp.type = LE_ADV_NONCONN_IND;
 
+	/* As per core 4.1 spec, section 9.3.11.2: A peripheral device
+	 * entering any of the following GAP modes and sending either
+	 * non-connectable advertising events or scannable undirected
+	 * advertising events should use adv_fast_interval2(100ms - 150ms)
+	 * for adv_fast_period(30s).
+	 *
+	 *	- Non-Discoverable Mode
+	 *	- Non-Connectable Mode
+	 *	- Limited Discoverable Mode
+	 *	- General Discoverable Mode
+	 */
+	if (cp.type == LE_ADV_NONCONN_IND || cp.type == LE_ADV_SCAN_IND) {
+		/* Set the suggested min and max fast advertising interval,
+		 * only if the peripheral device has entered any of the modes
+		 * such as non-discoverable, non-connectable or limited-
+		 * discoverable.
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
+		    !hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
+		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+			cp.min_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
+			cp.max_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
+		}
+	}
+
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
-- 
1.9.1

