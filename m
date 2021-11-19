Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4EFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B6861A55
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhKSISQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:18:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:1480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234201AbhKSISP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:18:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098412"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098412"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468805"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:15:12 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 09/14] Bluetooth: Handle MSFT avdtp open event
Date:   Fri, 19 Nov 2021 13:50:22 +0530
Message-Id: <20211119082027.12809-9-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119082027.12809-1-kiran.k@intel.com>
References: <20211119082027.12809-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Handle MSFT avdtp open event

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 net/bluetooth/hci_event.c |  4 +++
 net/bluetooth/msft.c      | 57 ++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/msft.h      |  3 +++
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index efc5458b1345..70ee07e8f27e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3812,6 +3812,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_transmit_power(hdev, skb);
 		break;
 
+	case MSFT_OP_AVDTP:
+		msft_cc_avdtp(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 60ed08d65a06..5953127b3521 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -99,7 +99,6 @@ struct msft_data {
 	__u8 filter_enabled;
 };
 
-#define MSFT_OP_AVDTP			0xfc1e
 struct msft_cp_avdtp {
 	__u8	sub_opcode;
 	__u8	len;
@@ -121,6 +120,13 @@ struct msft_cp_avdtp_open {
 	__u8	caps[0];
 } __packed;
 
+struct msft_rp_avdtp_open {
+	__u8    status;
+	__u8    sub_opcode;
+	__le16  avdtp_handle;
+	__u8    audio_intf_param_cnt;
+} __packed;
+
 static int __msft_add_monitor_pattern(struct hci_dev *hdev,
 				      struct adv_monitor *monitor);
 static int __msft_remove_monitor(struct hci_dev *hdev,
@@ -916,3 +922,52 @@ int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
 fail:
 	return err;
 }
+
+static void msft_cc_avdtp_open(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct msft_rp_avdtp_open *rp;
+	struct msft_cp_avdtp_open *sent;
+	struct hci_conn *hconn;
+
+	if (skb->len < sizeof(*rp))
+		return;
+
+	rp = (void *)skb->data;
+
+	sent = hci_sent_cmd_data(hdev, MSFT_OP_AVDTP);
+
+	hconn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(sent->handle));
+
+	if (!hconn)
+		return;
+
+	/* wake up the task waiting on avdtp handle */
+}
+
+void msft_cc_avdtp(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	void *sent;
+	__u8 status;
+
+	if (skb->len < 2)
+		return;
+
+	status = skb->data[0];
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	sent = hci_sent_cmd_data(hdev, MSFT_OP_AVDTP);
+	if (!sent)
+		return;
+
+	switch (skb->data[1]) {
+	case MSFT_OP_AVDTP_OPEN:
+		msft_cc_avdtp_open(hdev, skb);
+		break;
+
+	default:
+		bt_dev_err(hdev, "Invalid MSFT sub opcode 0x%2.2x",
+			   skb->data[1]);
+		break;
+	}
+}
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index 7628c87e6358..ba26c43431dc 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -10,6 +10,8 @@
 #define MSFT_FEATURE_MASK_CURVE_VALIDITY		BIT(4)
 #define MSFT_FEATURE_MASK_CONCURRENT_ADV_MONITOR	BIT(5)
 
+#define MSFT_OP_AVDTP		0xfc1e
+
 #if IS_ENABLED(CONFIG_BT_MSFTEXT)
 
 bool msft_monitor_supported(struct hci_dev *hdev);
@@ -80,3 +82,4 @@ static inline bool msft_curve_validity(struct hci_dev *hdev)
 
 int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
 		   sockptr_t optval, int optlen);
+void msft_cc_avdtp(struct hci_dev *hdev, struct sk_buff *skb);
-- 
2.17.1

