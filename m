Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4603C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7E060F5B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhKOGrX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:47:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:7203 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhKOGq6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 01:46:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220598257"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220598257"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="453726007"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2021 22:44:01 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 12/13] Bluetooth: Implment MSFT avdtp suspend command
Date:   Mon, 15 Nov 2021 12:19:13 +0530
Message-Id: <20211115064914.2345-12-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115064914.2345-1-kiran.k@intel.com>
References: <20211115064914.2345-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a2dp offload use case, to suspend streaming,
controller needs to sent MSFT avdtp suspend command. Allow BlueZ
daemon to send MSFT avdtp suspend command via setsockopt.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci.h       |  6 ++++++
 net/bluetooth/hci_codec.c         | 13 +++++++++++++
 net/bluetooth/hci_codec.h         |  1 +
 net/bluetooth/hci_event.c         |  1 +
 net/bluetooth/l2cap_sock.c        | 18 ++++++++++++++++++
 6 files changed, 40 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 6e5d64b4dc2c..149b9958f304 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -179,6 +179,7 @@ struct bt_codecs {
 
 #define BT_MSFT_OPEN		20
 #define BT_MSFT_START		21
+#define BT_MSFT_SUSPEND		22
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e4944e51067f..70b9796a8493 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2039,6 +2039,12 @@ struct msft_cp_avdtp_start {
 	__le16	avdtp_handle;
 } __packed;
 
+#define HCI_MSFT_AVDTP_SUSPEND			0x0A
+struct msft_cp_avdtp_suspend {
+	u8	sub_opcode;
+	__le16	avdtp_handle;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 61a4ce477bb0..b50dc20ca034 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -413,3 +413,16 @@ int hci_configure_msft_avdtp_start(struct hci_dev *hdev, struct sock *sk)
 
 	return hci_send_cmd(hdev, HCI_MSFT_AVDTP_CMD, sizeof(cmd), &cmd);
 }
+
+int hci_configure_msft_avdtp_suspend(struct hci_dev *hdev, struct sock *sk)
+{
+	struct msft_cp_avdtp_suspend cmd;
+
+	if (!bt_sk(sk)->avdtp_handle)
+		return -EBADFD;
+
+	cmd.sub_opcode = HCI_MSFT_AVDTP_SUSPEND;
+	cmd.avdtp_handle = cpu_to_le16(bt_sk(sk)->avdtp_handle);
+
+	return hci_send_cmd(hdev, HCI_MSFT_AVDTP_CMD, sizeof(cmd), &cmd);
+}
diff --git a/net/bluetooth/hci_codec.h b/net/bluetooth/hci_codec.h
index 0dbe55be0e59..d6dcd1a83059 100644
--- a/net/bluetooth/hci_codec.h
+++ b/net/bluetooth/hci_codec.h
@@ -12,3 +12,4 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
 int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
 				  sockptr_t optval, int optlen, struct sock *sk);
 int hci_configure_msft_avdtp_start(struct hci_dev *hdev, struct sock *sk);
+int hci_configure_msft_avdtp_suspend(struct hci_dev *hdev, struct sock *sk);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cf6dbc8746f7..ac35b0f6a203 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1493,6 +1493,7 @@ static void hci_cc_msft_avdtp_cmd(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 
 	case HCI_MSFT_AVDTP_START:
+	case HCI_MSFT_AVDTP_SUSPEND:
 		break;
 
 	default:
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 24e865345def..bd8061604880 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1180,6 +1180,24 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		hci_dev_put(hdev);
 		break;
 
+	case BT_MSFT_SUSPEND:
+		hdev = hci_get_route(BDADDR_ANY, &chan->src, BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+
+		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED) ||
+		    !hdev->get_data_path_id) {
+			err = -EOPNOTSUPP;
+			hci_dev_put(hdev);
+			break;
+		}
+
+		err = hci_configure_msft_avdtp_suspend(hdev, sk);
+		hci_dev_put(hdev);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

