Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C831C33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 08:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CCC206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 08:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGIs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:48:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:10239 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgAGIs4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 03:48:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 00:48:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,405,1571727600"; 
   d="scan'208";a="223113177"
Received: from unknown (HELO localhost.localdomain) ([10.223.165.29])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2020 00:48:54 -0800
From:   Ankit Navik <ankit.p.navik@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bleutooth: Add definitions for LE Read Tx Power
Date:   Tue,  7 Jan 2020 14:18:35 +0530
Message-Id: <1578386915-1524-1-git-send-email-ankit.p.navik@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the definitions for LE read transmit power HCI commands to
read the minimum and maximum Tx power.

Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
---
 include/net/bluetooth/hci.h      |  7 +++++++
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 07b6ece..6e8805f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1641,6 +1641,13 @@ struct hci_cp_le_ext_conn_param {
 	__le16 max_ce_len;
 } __packed;
 
+#define HCI_OP_LE_READ_TX_POWER		0x204b
+struct hci_rp_le_read_tx_power {
+	__u8 status;
+	__s8 min_tx_power;
+	__s8 max_tx_power;
+} __packed;
+
 #define HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS	0x203b
 struct hci_rp_le_read_num_supported_adv_sets {
 	__u8  status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index faebe38..88c6e55 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -418,6 +418,9 @@ struct hci_dev {
 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__u8			scan_rsp_data_len;
 
+	__s8			min_tx_power;
+	__s8			max_tx_power;
+
 	struct list_head	adv_instances;
 	unsigned int		adv_instance_cnt;
 	__u8			cur_adv_instance;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6ddc4a7..fc154cf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -988,6 +988,20 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 	hdev->adv_tx_power = rp->tx_power;
 }
 
+static void hci_cc_le_read_tx_power(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_le_read_tx_power *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->min_tx_power = rp->min_tx_power;
+	hdev->max_tx_power = rp->max_tx_power;
+}
+
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
@@ -3414,6 +3428,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_max_data_len(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_TX_POWER:
+		hci_cc_le_read_tx_power(hdev, skb);
+		break;
+
 	case HCI_OP_WRITE_LE_HOST_SUPPORTED:
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
-- 
2.7.4

