Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE6FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BE963219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhKOGrF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:47:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:7196 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhKOGqw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 01:46:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220598248"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220598248"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="453725989"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2021 22:43:54 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 09/13] Bluetooth: Handle MSFT avdtp open event
Date:   Mon, 15 Nov 2021 12:19:10 +0530
Message-Id: <20211115064914.2345-9-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115064914.2345-1-kiran.k@intel.com>
References: <20211115064914.2345-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Controller responds with CCE event for MSFT avdtp open
command. On success MSFT avdtp open event contains
avdtp handle which needs to sent in start/suspend/close
avdtp commands.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/hci.h |  7 +++++
 net/bluetooth/hci_event.c   | 53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a7dad0125c10..dc863d055056 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2025,6 +2025,13 @@ struct msft_cp_avdtp_open {
 	__le16	omtu;
 } __packed;
 
+struct msft_rp_avdtp_open {
+	__u8	status;
+	__u8	sub_opcode;
+	__le16	avdtp_handle;
+	__u8	audio_intf_param_cnt;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4b75a6cfeee..b7ef4e8dae6c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1445,6 +1445,55 @@ static void hci_cc_le_set_ext_scan_param(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_msft_avdtp_open(struct hci_dev *hdev, struct sk_buff *skb)
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
+	sent = hci_sent_cmd_data(hdev, HCI_MSFT_AVDTP_CMD);
+
+	hconn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(sent->handle));
+
+	if (!hconn)
+		return;
+
+	/* wake up the task waiting on avdtp handle */
+}
+
+static void hci_cc_msft_avdtp_cmd(struct hci_dev *hdev, struct sk_buff *skb)
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
+	sent = hci_sent_cmd_data(hdev, HCI_MSFT_AVDTP_CMD);
+	if (!sent)
+		return;
+
+	switch (skb->data[1]) {
+	case HCI_MSFT_AVDTP_OPEN:
+		hci_cc_msft_avdtp_open(hdev, skb);
+		break;
+
+	default:
+		bt_dev_err(hdev, "Invalid MSFT sub opcode 0x%2.2x",
+			   skb->data[1]);
+		break;
+	}
+}
+
 static bool has_pending_adv_report(struct hci_dev *hdev)
 {
 	struct discovery_state *d = &hdev->discovery;
@@ -3812,6 +3861,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_transmit_power(hdev, skb);
 		break;
 
+	case HCI_MSFT_AVDTP_CMD:
+		hci_cc_msft_avdtp_cmd(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
-- 
2.17.1

