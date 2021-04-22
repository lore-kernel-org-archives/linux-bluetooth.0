Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7349BC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B4F613DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhDVOLt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:11:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:14916 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236721AbhDVOLs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 10:11:48 -0400
IronPort-SDR: pWVf0zoG4a+H1VvWniNs3UBXuXLjD0TlRbNNmJ9MCxZ8uPwcfqacX11ke6fDanZJ0pWTGA4leH
 /6VNsS/TzoNQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="193773412"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="193773412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 07:11:13 -0700
IronPort-SDR: sDHk7e4slNYMbOQDydXWxpfoj6lfCAJrjwU+gtmOK+nO3DQxkNH8AnDIuAuVRNyYUEEbg+0hL9
 O/nX8JI8g4/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="427961188"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2021 07:11:08 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Subject: [PATCH v3 1/3] Bluetooth: add support to enumerate codec capabilities
Date:   Thu, 22 Apr 2021 19:44:47 +0530
Message-Id: <20210422141449.25155-1-kiran.k@intel.com>
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
* changes in v3
  move codec enumeration into a new init function
* changes in v2
  add skb length check before accessing data

 include/net/bluetooth/hci.h |  7 ++++
 net/bluetooth/hci_core.c    | 16 ++++++---
 net/bluetooth/hci_event.c   | 68 +++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 4 deletions(-)

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
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fd12f1652bdf..9419bbf55d90 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -838,10 +838,6 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[22] & 0x04)
 		hci_set_event_mask_page_2(req);
 
-	/* Read local codec list if the HCI command is supported */
-	if (hdev->commands[29] & 0x20)
-		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
-
 	/* Read local pairing options if the HCI command is supported */
 	if (hdev->commands[41] & 0x08)
 		hci_req_add(req, HCI_OP_READ_LOCAL_PAIRING_OPTS, 0, NULL);
@@ -907,6 +903,15 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 	return 0;
 }
 
+static int hci_init5_req(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	/* Read local codec list if the HCI command is supported */
+	if (hdev->commands[29] & 0x20)
+		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
+	return 0;
+}
 static int __hci_init(struct hci_dev *hdev)
 {
 	int err;
@@ -937,6 +942,9 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
+	err = __hci_req_sync(hdev, hci_init5_req, 0, HCI_INIT_TIMEOUT, NULL);
+	if (err < 0)
+		return err;
 	/* This function is only called when the controller is actually in
 	 * configured state. When the controller is marked as unconfigured,
 	 * this initialization procedure is not run.
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

