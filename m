Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE76C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A02603E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhKSISZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:18:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:1480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234330AbhKSISY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:18:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098439"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468853"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:15:21 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 13/14] Bluetooth: Implment MSFT avdtp close command
Date:   Fri, 19 Nov 2021 13:50:26 +0530
Message-Id: <20211119082027.12809-13-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119082027.12809-1-kiran.k@intel.com>
References: <20211119082027.12809-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp offload use case, to tear down streaming,
controller needs to sent MSFT avdtp close command. Allow BlueZ
daemon to send MSFT avdtp close command via setsockopt.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 net/bluetooth/msft.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index b505b32289f8..20638254a396 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -139,6 +139,12 @@ struct msft_cp_avdtp_suspend {
 	__le16	avdtp_handle;
 } __packed;
 
+#define MSFT_OP_AVDTP_CLOSE			0x0B
+struct msft_cp_avdtp_close {
+	u8	sub_opcode;
+	__le16	avdtp_handle;
+} __packed;
+
 static int __msft_add_monitor_pattern(struct hci_dev *hdev,
 				      struct adv_monitor *monitor);
 static int __msft_remove_monitor(struct hci_dev *hdev,
@@ -922,6 +928,21 @@ static int msft_avdtp_suspend(struct hci_dev *hdev, struct sock *sk)
 	return hci_send_cmd(hdev, MSFT_OP_AVDTP, sizeof(cmd), &cmd);
 }
 
+static int msft_avdtp_close(struct hci_dev *hdev, struct sock *sk)
+{
+	struct msft_cp_avdtp_close cmd;
+
+	if (!bt_sk(sk)->avdtp_handle)
+		return -EBADFD;
+
+	cmd.sub_opcode = MSFT_OP_AVDTP_CLOSE;
+	cmd.avdtp_handle = cpu_to_le16(bt_sk(sk)->avdtp_handle);
+
+	bt_sk(sk)->avdtp_handle = 0;
+
+	return hci_send_cmd(hdev, MSFT_OP_AVDTP, sizeof(cmd), &cmd);
+}
+
 int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
 		   sockptr_t optval, int optlen,
 		   struct sock *sk)
@@ -964,6 +985,10 @@ int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
 		err = msft_avdtp_suspend(hdev, sk);
 		break;
 
+	case MSFT_OP_AVDTP_CLOSE:
+		err = msft_avdtp_close(hdev, sk);
+		break;
+
 	default:
 		err = -EINVAL;
 		bt_dev_err(hdev, "Invalid MSFT avdtp sub opcode = 0x%2.2x",
@@ -1023,6 +1048,7 @@ void msft_cc_avdtp(struct hci_dev *hdev, struct sk_buff *skb)
 
 	case MSFT_OP_AVDTP_START:
 	case MSFT_OP_AVDTP_SUSPEND:
+	case MSFT_OP_AVDTP_CLOSE:
 		break;
 
 	default:
-- 
2.17.1

