Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C658C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7300361178
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhDIMUe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 08:20:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:65075 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhDIMUd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 08:20:33 -0400
IronPort-SDR: 5XpCvSwNFslTURe/t7KElMknvUES53efWz67n6XMCtGN7V3au802PKmqjsRo9z3Hw8gPpUp0Wu
 /bLPyVfX1TgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173229311"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="173229311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 05:20:20 -0700
IronPort-SDR: NPHHS7tl8ORmYjfxHusYGi4cKzCt1dAP/RgyNatDmhpLiM0o5cm9Xgyhnn/P5LrkmAWMHx6U3B
 Om3/sq4IMYiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="416239796"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2021 05:20:19 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/3] Bluetooth: add support to enumerate local supports codecs v2
Date:   Fri,  9 Apr 2021 17:54:04 +0530
Message-Id: <20210409122405.29850-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409122405.29850-1-kiran.k@intel.com>
References: <20210409122405.29850-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for HCI_Read_Local_Supported_Codecs_V2 and query codec
capabilities

snoop:
> HCI Event: Command Complete (0x0e) plen 20
      Read Local Supported Codecs V2 (0x04|0x000d) ncmd 1
        Status: Success (0x00)
        Number of supported codecs: 7
          Codec: u-law log (0x00)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: A-law log (0x01)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: CVSD (0x02)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: Transparent (0x03)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: Linear PCM (0x04)
          Logical Transport Type: 0x02
            Codec supported over BR/EDR SCO and eSCO
          Codec: Reserved (0x08)
          Logical Transport Type: 0x03
            Codec supported over BR/EDR ACL
            Codec supported over BR/EDR SCO and eSCO
          Codec: mSBC (0x05)
          Logical Transport Type: 0x03
            Codec supported over BR/EDR ACL
            Codec supported over BR/EDR SCO and eSCO
        Number of vendor codecs: 0
......
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
 include/net/bluetooth/hci.h      |  2 +
 include/net/bluetooth/hci_core.h | 10 ++++
 net/bluetooth/hci_core.c         |  4 +-
 net/bluetooth/hci_event.c        | 98 ++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e3f7771fe84f..34eb9f4b027f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1314,6 +1314,8 @@ struct hci_rp_read_local_pairing_opts {
 	__u8     max_key_size;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_CODECS_V2    0x100d
+
 #define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
 struct hci_op_read_local_codec_caps {
 	__u8	codec_id[5];
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c73ac52af186..fa0c68fd3306 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1848,4 +1848,14 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+#define LOCAL_CODEC_ACL_MASK	BIT(0)
+#define LOCAL_CODEC_SCO_MASK	BIT(1)
+#define LOCAL_CODEC_LECIS_MASK	BIT(2)
+#define LOCAL_CODEC_LEBIS_MASK	BIT(3)
+
+#define LOCAL_CODEC_ACL		0x00
+#define LOCAL_CODEC_SCO		0x01
+#define LOCAL_CODEC_LECIS	0x02
+#define LOCAL_CODEC_LEBIS	0x03
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fd12f1652bdf..230aeedd6d00 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -839,7 +839,9 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_set_event_mask_page_2(req);
 
 	/* Read local codec list if the HCI command is supported */
-	if (hdev->commands[29] & 0x20)
+	if (hdev->commands[45] & 0x04)
+		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL);
+	else if (hdev->commands[29] & 0x20)
 		hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
 
 	/* Read local pairing options if the HCI command is supported */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ceed5a5d332b..a16723c89dc6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -939,6 +939,100 @@ static void hci_cc_read_local_codecs(struct hci_dev *hdev,
 	}
 }
 
+static void hci_cc_read_local_codecs_v2(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	__u8 num_codecs, transport;
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
+	bt_dev_info(hdev, "Number of standard codecs: %u", num_codecs);
+
+	skb_pull(skb, 1);
+	ptr = (__u8 *)skb->data;
+
+	skb_pull(skb, num_codecs * 2);
+
+	while (num_codecs--) {
+		caps.codec_id[0] = *ptr++;
+		transport = *ptr++;
+		caps.direction = 0x00;
+
+		if (transport & LOCAL_CODEC_ACL_MASK) {
+			caps.transport = LOCAL_CODEC_ACL;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+
+		if (transport & LOCAL_CODEC_SCO_MASK) {
+			caps.transport = LOCAL_CODEC_SCO;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+
+		if (transport & LOCAL_CODEC_LEBIS_MASK) {
+			caps.transport = LOCAL_CODEC_LEBIS;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+
+		if (transport & LOCAL_CODEC_LECIS_MASK) {
+			caps.transport = LOCAL_CODEC_LECIS;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+	}
+
+	/* enumerate vendor specific codecs */
+	num_codecs = skb->data[0];
+	skb_pull(skb, 1);
+
+	bt_dev_info(hdev, "Number of vendor specific codecs: %u", num_codecs);
+
+	ptr = (__u8 *)skb->data;
+
+	while (num_codecs--) {
+		caps.codec_id[0] = 0xFF;
+		memcpy(&caps.codec_id[1], ptr, 4);
+		ptr += 4;
+		transport = *ptr++;
+		caps.direction = 0x00;
+
+		if (transport & LOCAL_CODEC_ACL_MASK) {
+			caps.transport = LOCAL_CODEC_ACL;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+
+		if (transport & LOCAL_CODEC_SCO_MASK) {
+			caps.transport = LOCAL_CODEC_SCO;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+
+		if (transport & LOCAL_CODEC_LEBIS) {
+			caps.transport = LOCAL_CODEC_LEBIS;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+
+		if (transport & LOCAL_CODEC_LECIS_MASK) {
+			caps.transport = LOCAL_CODEC_LECIS;
+			hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
+				     &caps);
+		}
+	}
+}
+
 static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_rp_read_clock *rp = (void *) skb->data;
@@ -3493,6 +3587,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_read_local_codecs(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_CODECS_V2:
+		hci_cc_read_local_codecs_v2(hdev, skb);
+		break;
+
 	case HCI_OP_READ_FLOW_CONTROL_MODE:
 		hci_cc_read_flow_control_mode(hdev, skb);
 		break;
-- 
2.17.1

