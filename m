Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13581C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE80611AD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 08:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhDLIcA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:32:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:24858 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237019AbhDLIcA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 04:32:00 -0400
IronPort-SDR: Z0CmV6AQx/g1WQOIvtBVS0svvULXFQ7GXxuANvVvjb5mwp5zg+zNQ0Bz0Rgeocxfq60AlbSC3A
 O/yT2SSosXWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="173632833"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="173632833"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 01:31:42 -0700
IronPort-SDR: wcQNouTHA7dV9MMmEIfJey6sCGVdRYRLMlOgUtGsJRLVxz2WlK3ORqBuE9FB5s5w1Q6OK09Utg
 Qkt5qHH97BZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="451353683"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2021 01:31:40 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/3] Bluetooth: add support to enumerate codec capabilities
Date:   Mon, 12 Apr 2021 14:05:36 +0530
Message-Id: <20210412083538.18600-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

add support to enumerate local supported codec capabilities

< HCI Command: Read Local Suppor.. (0x04|0x000e) plen 7
        Codec: mSBC (0x05)
        Logical Transport Type: 0x00
        Direction: Input (Host to Controller) (0x00)
> HCI Event: Command Complete (0x0e) plen 12
      Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
        Status: Success (0x00)
        Number of codec capabilities: 1
         Capabilities #0:
        00 00 11 15 02 33

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes in v2
  add skb->len check before accessing event data

 include/net/bluetooth/hci.h |  7 ++++
 net/bluetooth/hci_event.c   | 68 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ea4ae551c426..e3f7771fe84f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1314,6 +1314,13 @@ struct hci_rp_read_local_pairing_opts {
 	__u8     max_key_size;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
+struct hci_op_read_local_codec_caps {
+	__u8	codec_id[5];
+	__u8	transport;
+	__u8	direction;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
 struct hci_rp_read_page_scan_activity {
 	__u8     status;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5e99968939ce..a4b905a76c1b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -887,6 +887,70 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 	       hdev->block_cnt, hdev->block_len);
 }
 
+static void hci_cc_read_local_codecs(struct hci_dev *hdev,
+				     struct sk_buff *skb)
+{
+	__u8 num_codecs;
+	struct hci_op_read_local_codec_caps caps;
+
+	if (skb->len < sizeof(caps))
+		return;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", skb->data[0]);
+
+	if (skb->data[0])
+		return;
+
+	/* enumerate standard codecs */
+	skb_pull(skb, 1);
+
+	if (skb->len < 1)
+		return;
+
+	num_codecs = skb->data[0];
+
+	bt_dev_dbg(hdev, "Number of standard codecs: %u", num_codecs);
+
+	skb_pull(skb, 1);
+
+	if (skb->len < num_codecs)
+		return;
+
+	while (num_codecs--) {
+		caps.codec_id[0] = skb->data[0];
+		caps.transport = 0x00;
+		caps.direction = 0x00;
+
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+			     &caps);
+
+		skb_pull(skb, 1);
+	}
+
+	/* enumerate vendor specific codecs */
+	if (skb->len < 1)
+		return;
+
+	num_codecs = skb->data[0];
+	skb_pull(skb, 1);
+
+	bt_dev_dbg(hdev, "Number of vendor specific codecs: %u", num_codecs);
+
+	if (skb->len < (num_codecs * 4))
+		return;
+
+	while (num_codecs--) {
+		caps.codec_id[0] = 0xFF;
+		memcpy(&caps.codec_id[1], skb->data, 4);
+		caps.transport = 0x00;
+		caps.direction = 0x00;
+
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+			     &caps);
+		skb_pull(skb, 4);
+	}
+}
+
 static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_clock *rp = (void *) skb->data;
@@ -3437,6 +3501,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_data_block_size(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_CODECS:
+		hci_cc_read_local_codecs(hdev, skb);
+		break;
+
 	case HCI_OP_READ_FLOW_CONTROL_MODE:
 		hci_cc_read_flow_control_mode(hdev, skb);
 		break;
-- 
2.17.1

