Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCFBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AC160F5B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhKOGrL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:47:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:7188 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhKOGqu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 01:46:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220598242"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220598242"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:43:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="453725986"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2021 22:43:52 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 08/13] Bluetooth: Implement MSFT avdtp open command
Date:   Mon, 15 Nov 2021 12:19:09 +0530
Message-Id: <20211115064914.2345-8-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115064914.2345-1-kiran.k@intel.com>
References: <20211115064914.2345-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In A2DP offload use case, controller needs to configured
with selected codec capabilities, dcid of media transport
channel and ACL connection handle.

Controller responds with avdtp handle which needs to be
sent in other avdtp commands like start, suspend and close.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 include/net/bluetooth/hci.h       | 16 ++++++++++++
 net/bluetooth/hci_codec.c         | 43 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_codec.h         |  4 +++
 net/bluetooth/l2cap_sock.c        | 24 +++++++++++++++++
 5 files changed, 89 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2f31e571f34c..5e07cfed941d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -177,6 +177,8 @@ struct bt_codecs {
 #define BT_CODEC_TRANSPARENT	0x03
 #define BT_CODEC_MSBC		0x05
 
+#define BT_MSFT_OPEN		20
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7ea1bfce204f..a7dad0125c10 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2009,6 +2009,22 @@ struct hci_cp_le_reject_cis {
 	__u8    reason;
 } __packed;
 
+#define HCI_MSFT_AVDTP_CMD			0xfc1e
+
+#define HCI_MSFT_AVDTP_OPEN			0x08
+struct hci_media_service_caps {
+	__u8	category;
+	__u8	len;
+	__u8	data[0];
+} __packed;
+
+struct msft_cp_avdtp_open {
+	__u8	sub_opcode;
+	__le16	handle;
+	__le16	dcid;
+	__le16	omtu;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index c6bd934dcf36..e179f3bfb494 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -355,3 +355,46 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
 error:
 	return err;
 }
+
+int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
+				  sockptr_t optval, int optlen)
+{
+	struct msft_cp_avdtp_open *cmd = NULL;
+	struct hci_media_service_caps *caps;
+	int err;
+
+	if (!optlen || optlen < sizeof(*caps)) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	cmd = kzalloc(sizeof(*cmd) + optlen, GFP_KERNEL);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	cmd->sub_opcode = HCI_MSFT_AVDTP_OPEN;
+	cmd->handle = __cpu_to_le16(chan->conn->hcon->handle);
+	cmd->dcid = cpu_to_le16(chan->dcid);
+	cmd->omtu = cpu_to_le16(chan->omtu);
+	caps = (void *)(cmd + 1);
+
+	if (copy_from_sockptr(caps, optval, optlen)) {
+		err = -EFAULT;
+		goto fail;
+	}
+
+	if (caps->category != 0x07) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	hci_send_cmd(hdev, HCI_MSFT_AVDTP_CMD, sizeof(*cmd) + optlen, cmd);
+
+	/* wait until we get avdtp handle or timeout */
+
+fail:
+	kfree(cmd);
+	return err;
+}
diff --git a/net/bluetooth/hci_codec.h b/net/bluetooth/hci_codec.h
index 6e849c7d75b9..123b46a6a8ce 100644
--- a/net/bluetooth/hci_codec.h
+++ b/net/bluetooth/hci_codec.h
@@ -2,8 +2,12 @@
 
 /* Copyright (C) 2014 Intel Corporation */
 
+#include <net/bluetooth/l2cap.h>
+
 void hci_read_supported_codecs(struct hci_dev *hdev);
 void hci_read_supported_codecs_v2(struct hci_dev *hdev);
 void hci_codec_list_clear(struct list_head *codec_list);
 int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
 			     int __user *optlen, int len);
+int hci_configure_msft_avdtp_open(struct hci_dev *hdev, struct l2cap_chan *chan,
+				  sockptr_t optval, int optlen);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a883acf33e3c..fa689e576576 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -909,6 +909,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct l2cap_conn *conn;
 	int len, err = 0;
 	u32 opt;
+	struct hci_dev *hdev;
 
 	BT_DBG("sk %p", sk);
 
@@ -1137,6 +1138,29 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_MSFT_OPEN:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
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
+		err = hci_configure_msft_avdtp_open(hdev, chan, optval, optlen);
+		hci_dev_put(hdev);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

