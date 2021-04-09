Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B70C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6119561178
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhDIMUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 08:20:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:65075 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhDIMUb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 08:20:31 -0400
IronPort-SDR: BCWJBpxyTYHW2gpkoElIwTuEP/QnX1XTcbKg8yT0sPMKY259TJqRQOBR8thDbuoGfs4OROeINf
 MgPR/vWcYpqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173229305"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="173229305"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 05:20:18 -0700
IronPort-SDR: OctRtUUKm86FKKWPP9qpZ/PR4tpRZE2aW6nryfYLCd44QyGGCI1nRCaPq16gC3GXkIw//H5vJ7
 DBmhwu6Kgz7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="416239783"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2021 05:20:17 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/3] Bluetooth: add support to enumerate codec capabilities
Date:   Fri,  9 Apr 2021 17:54:03 +0530
Message-Id: <20210409122405.29850-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409122405.29850-1-kiran.k@intel.com>
References: <20210409122405.29850-1-kiran.k@intel.com>
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
 include/net/bluetooth/hci.h |  7 +++++
 net/bluetooth/hci_event.c   | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

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
index 016b2999f219..ceed5a5d332b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -887,6 +887,58 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 	       hdev->block_cnt, hdev->block_len);
 }
 
+static void hci_cc_read_local_codecs(struct hci_dev *hdev,
+				     struct sk_buff *skb)
+{
+	__u8 num_codecs;
+	__u8 *ptr;
+	struct hci_op_read_local_codec_caps caps;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", skb->data[0]);
+
+	if (skb->data[0])
+		return;
+
+	/* enumerate standard codecs */
+	skb_pull(skb, 1);
+	num_codecs = skb->data[0];
+
+	bt_dev_dbg(hdev, "Number of standard codecs: %u", num_codecs);
+
+	skb_pull(skb, 1);
+	ptr = (__u8 *)skb->data;
+
+	skb_pull(skb, num_codecs);
+
+	while (num_codecs--) {
+		caps.codec_id[0] = *ptr++;
+		caps.transport = 0x00;
+		caps.direction = 0x00;
+
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+			     &caps);
+	}
+
+	/* enumerate vendor specific codecs */
+	num_codecs = skb->data[0];
+	skb_pull(skb, 1);
+
+	bt_dev_dbg(hdev, "Number of vendor specific codecs: %u", num_codecs);
+
+	ptr = (__u8 *)skb->data;
+
+	while (num_codecs--) {
+		caps.codec_id[0] = 0xFF;
+		memcpy(&caps.codec_id[1], ptr, 4);
+		ptr += 4;
+		caps.transport = 0x00;
+		caps.direction = 0x00;
+
+		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+			     &caps);
+	}
+}
+
 static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_clock *rp = (void *) skb->data;
@@ -3437,6 +3489,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
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

