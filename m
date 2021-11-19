Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E0DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB8A61A55
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhKSISO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:18:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:1480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234265AbhKSISN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:18:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098402"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098402"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468788"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:15:09 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 08/14] Bluetooth: Implement MSFT avdtp open command
Date:   Fri, 19 Nov 2021 13:50:21 +0530
Message-Id: <20211119082027.12809-8-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119082027.12809-1-kiran.k@intel.com>
References: <20211119082027.12809-1-kiran.k@intel.com>
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
 include/net/bluetooth/bluetooth.h |   2 +
 net/bluetooth/l2cap_sock.c        |  27 ++++++++
 net/bluetooth/msft.c              | 104 ++++++++++++++++++++++++++++++
 net/bluetooth/msft.h              |   3 +
 4 files changed, 136 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2f31e571f34c..6d5580316493 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -177,6 +177,8 @@ struct bt_codecs {
 #define BT_CODEC_TRANSPARENT	0x03
 #define BT_CODEC_MSBC		0x05
 
+#define BT_MSFT			20
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3c293d6bd04b..6f8d8c189b41 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -37,6 +37,8 @@
 
 #include "smp.h"
 #include "hci_codec.h"
+#include "hci_request.h"
+#include "msft.h"
 
 static struct bt_sock_list l2cap_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
@@ -916,6 +918,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct l2cap_conn *conn;
 	int len, err = 0;
 	u32 opt;
+	struct hci_dev *hdev;
 
 	BT_DBG("sk %p", sk);
 
@@ -1144,6 +1147,30 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_MSFT:
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
+		if (!hci_dev_test_flag(hdev,
+				       HCI_MSFT_A2DP_OFFLOAD_CODECS_ENABLED) ||
+		    !hdev->get_data_path_id) {
+			err = -EOPNOTSUPP;
+			hci_dev_put(hdev);
+			break;
+		}
+
+		err = msft_avdtp_cmd(hdev, chan, optval, optlen);
+		hci_dev_put(hdev);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 1122097e1e49..60ed08d65a06 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -6,6 +6,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
+#include <net/bluetooth/l2cap.h>
 
 #include "hci_request.h"
 #include "mgmt_util.h"
@@ -98,6 +99,28 @@ struct msft_data {
 	__u8 filter_enabled;
 };
 
+#define MSFT_OP_AVDTP			0xfc1e
+struct msft_cp_avdtp {
+	__u8	sub_opcode;
+	__u8	len;
+	__u8	data[0];
+};
+
+#define MSFT_OP_AVDTP_OPEN			0x08
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
+	__u8	caps[0];
+} __packed;
+
 static int __msft_add_monitor_pattern(struct hci_dev *hdev,
 				      struct adv_monitor *monitor);
 static int __msft_remove_monitor(struct hci_dev *hdev,
@@ -812,3 +835,84 @@ bool msft_curve_validity(struct hci_dev *hdev)
 {
 	return hdev->msft_curve_validity;
 }
+
+static int msft_avdtp_open(struct hci_dev *hdev,
+			   struct l2cap_chan *chan,
+			   struct msft_cp_avdtp *cmd)
+{
+	struct msft_cp_avdtp_open *open_cmd;
+	struct hci_media_service_caps *caps;
+	int err = 0;
+
+	caps = (void *)cmd->data;
+
+	if (!caps || caps->category != 0x07) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	open_cmd = kzalloc(sizeof(*open_cmd) + caps->len, GFP_KERNEL);
+	if (!open_cmd) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	open_cmd->sub_opcode = MSFT_OP_AVDTP_OPEN;
+	open_cmd->handle = cpu_to_le16(chan->conn->hcon->handle);
+	open_cmd->dcid = cpu_to_le16(chan->dcid);
+	open_cmd->omtu = cpu_to_le16(chan->omtu);
+
+	/* copy codec capabilities */
+	memcpy(open_cmd->caps, caps, sizeof(*caps) + caps->len);
+
+	hci_send_cmd(hdev, MSFT_OP_AVDTP, sizeof(*open_cmd) + cmd->len,
+		     open_cmd);
+
+	/* wait until we get avdtp handle or timeout */
+fail:
+	kfree(open_cmd);
+	return err;
+}
+
+int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
+		   sockptr_t optval, int optlen)
+{
+	int err = 0;
+	struct msft_cp_avdtp *cmd;
+	u8 buffer[255];
+
+	if (!optlen) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	if (optlen > sizeof(buffer)) {
+		err = -ENOBUFS;
+		goto fail;
+	}
+
+	if (copy_from_sockptr(buffer, optval, optlen)) {
+		err = -EFAULT;
+		goto fail;
+	}
+
+	cmd = (void *)buffer;
+
+	switch (cmd->sub_opcode) {
+	case MSFT_OP_AVDTP_OPEN:
+		if (cmd->len > sizeof(buffer) - sizeof(*cmd)) {
+			err = -EINVAL;
+			break;
+		}
+		err = msft_avdtp_open(hdev, chan, cmd);
+		break;
+
+	default:
+		err = -EINVAL;
+		bt_dev_err(hdev, "Invalid MSFT avdtp sub opcode = 0x%2.2x",
+			   cmd->sub_opcode);
+		break;
+	}
+fail:
+	return err;
+}
diff --git a/net/bluetooth/msft.h b/net/bluetooth/msft.h
index b59b63dc0ea8..7628c87e6358 100644
--- a/net/bluetooth/msft.h
+++ b/net/bluetooth/msft.h
@@ -77,3 +77,6 @@ static inline bool msft_curve_validity(struct hci_dev *hdev)
 }
 
 #endif
+
+int msft_avdtp_cmd(struct hci_dev *hdev, struct l2cap_chan *chan,
+		   sockptr_t optval, int optlen);
-- 
2.17.1

