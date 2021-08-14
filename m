Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A04C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AE460720
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhHNHWo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:22:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:42835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237109AbhHNHWo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 03:22:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="213817662"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="213817662"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2021 00:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="640022035"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2021 00:22:15 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v12 06/10] Bluetooth: Allow setting of codec for HFP offload use case
Date:   Sat, 14 Aug 2021 12:56:25 +0530
Message-Id: <20210814072629.11748-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210814072629.11748-1-kiran.k@intel.com>
References: <20210814072629.11748-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For HFP offload use case, controller needs to be configured
with codec data and capabilities. This patch uses Bluetooth
SIG defined command HCI_CONFIGURE_DATA_PATH to specify vendor
specific data and allows userspace modules to set the codec
via setsockopt systemcall.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes in v12:
 - check for mgmt flag before setting codec for offload use case

* changes in v11:
  - Remove changes related to Kconfig

* changes in v10:
  - patch refactor - having callback definition and usage in the same patch

 include/net/bluetooth/bluetooth.h |   2 +
 include/net/bluetooth/hci.h       |   8 ++
 include/net/bluetooth/hci_core.h  |   3 +
 net/bluetooth/sco.c               | 131 ++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 64cddff0c9c4..1a48b6732eef 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -173,6 +173,8 @@ struct bt_codecs {
 	struct bt_codec	codecs[];
 } __packed;
 
+#define CODING_FORMAT_CVSD	0x02
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c29653e34056..ad2d5dc81d07 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1251,6 +1251,14 @@ struct hci_rp_read_local_oob_ext_data {
 	__u8     rand256[16];
 } __packed;
 
+#define HCI_CONFIGURE_DATA_PATH	0x0c83
+struct hci_op_configure_data_path {
+	__u8	direction;
+	__u8	data_path_id;
+	__u8	vnd_len;
+	__u8	vnd_data[];
+} __packed;
+
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 19860e207b70..cb8346527131 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -619,6 +619,9 @@ struct hci_dev {
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
+	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
+				     struct bt_codec *codec, __u8 *vnd_len,
+				     __u8 **vnd_data);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 20d8129a9870..130ecd4a7cc8 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -69,6 +69,7 @@ struct sco_pinfo {
 	__u32		flags;
 	__u16		setting;
 	__u8		cmsg_mask;
+	struct bt_codec codec;
 	struct sco_conn	*conn;
 };
 
@@ -444,6 +445,7 @@ static void __sco_sock_close(struct sock *sk)
 		sock_set_flag(sk, SOCK_ZAPPED);
 		break;
 	}
+
 }
 
 /* Must be called on unlocked socket. */
@@ -504,6 +506,10 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_state    = BT_OPEN;
 
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
+	sco_pi(sk)->codec.id = CODING_FORMAT_CVSD;
+	sco_pi(sk)->codec.cid = 0xffff;
+	sco_pi(sk)->codec.vid = 0xffff;
+	sco_pi(sk)->codec.data_path = 0x00;
 
 	bt_sock_link(&sco_sk_list, sk);
 	return sk;
@@ -818,6 +824,63 @@ static int sco_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	return bt_sock_recvmsg(sock, msg, len, flags);
 }
 
+static int sco_configure_data_path(struct hci_dev *hdev, struct bt_codec *codec)
+{
+	__u8 vnd_len, *vnd_data = NULL;
+	struct hci_op_configure_data_path *cmd = NULL;
+	struct sk_buff *skb;
+	int err;
+
+	err = hdev->get_codec_config_data(hdev, ESCO_LINK, codec, &vnd_len,
+					  &vnd_data);
+	if (err < 0)
+		goto error;
+
+	cmd = kzalloc(sizeof(*cmd) + vnd_len, GFP_KERNEL);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	err = hdev->get_data_path_id(hdev, &cmd->data_path_id);
+	if (err < 0)
+		goto error;
+
+	cmd->vnd_len = vnd_len;
+	memcpy(cmd->vnd_data, vnd_data, vnd_len);
+
+	cmd->direction = 0x00;
+	skb = __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH,
+			     sizeof(*cmd) + vnd_len,
+			     cmd, HCI_INIT_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "configure input data path failed (%ld)",
+			   PTR_ERR(skb));
+		goto error;
+	}
+	kfree_skb(skb);
+
+	cmd->direction = 0x01;
+	skb = __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH,
+			     sizeof(*cmd) + vnd_len,
+			     cmd, HCI_INIT_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "configure output data path failed (%ld)",
+			   PTR_ERR(skb));
+		goto error;
+	}
+	kfree_skb(skb);
+
+error:
+	kfree(vnd_data);
+	kfree(cmd);
+	return err;
+}
+
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
@@ -825,6 +888,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 	int len, err = 0;
 	struct bt_voice voice;
 	u32 opt;
+	struct bt_codecs *codecs;
+	struct hci_dev *hdev;
+	__u8 buffer[255];
 
 	BT_DBG("sk %p", sk);
 
@@ -886,6 +952,71 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			sco_pi(sk)->cmsg_mask &= SCO_CMSG_PKT_STATUS;
 		break;
 
+	case BT_CODEC:
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
+				     BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+
+		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
+			hci_dev_put(hdev);
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		if (!hdev->get_codec_config_data) {
+			hci_dev_put(hdev);
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		if (optlen < sizeof(struct bt_codecs) ||
+		    optlen > sizeof(buffer)) {
+			hci_dev_put(hdev);
+			err = -EINVAL;
+			break;
+		}
+
+		if (copy_from_sockptr(buffer, optval, optlen)) {
+			hci_dev_put(hdev);
+			err = -EFAULT;
+			break;
+		}
+
+		codecs = (void *)buffer;
+
+		if (codecs->num_codecs > 1) {
+			hci_dev_put(hdev);
+			err = -EINVAL;
+			break;
+		}
+
+		/* configure data path only non-HCI data path is selected */
+		if (codecs->codecs[0].data_path) {
+			err = sco_configure_data_path(hdev, &codecs->codecs[0]);
+			if (err < 0) {
+				hci_dev_put(hdev);
+				break;
+			}
+
+			if (codecs->codecs[0].id == 0xff) {
+				sco_pi(sk)->codec.cid = codecs->codecs[0].cid;
+				sco_pi(sk)->codec.vid = codecs->codecs[0].vid;
+			}
+		}
+		sco_pi(sk)->codec.id = codecs->codecs[0].id;
+		sco_pi(sk)->codec.data_path = codecs->codecs[0].data_path;
+		hci_dev_put(hdev);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

