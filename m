Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13899C11F65
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9CA61C82
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 08:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhF3IG2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 04:06:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:5410 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232966AbhF3IG2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 04:06:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="272164641"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="272164641"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 01:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="643997952"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2021 01:03:58 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v10 04/10] Bluetooth: Allow querying of supported offload codecs over SCO socket
Date:   Wed, 30 Jun 2021 13:38:01 +0530
Message-Id: <20210630080807.12600-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630080807.12600-1-kiran.k@intel.com>
References: <20210630080807.12600-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add BT_CODEC option for getsockopt systemcall to get the details
of offload codecs supported over SCO socket

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes in v10:
  - In getsockopt, prepare data in advance and call copy_to_user
    istead of calling put_user on each field of struct bt_codec

 include/net/bluetooth/bluetooth.h | 20 +++++++
 include/net/bluetooth/hci.h       |  6 ++
 include/net/bluetooth/hci_core.h  |  3 +
 net/bluetooth/sco.c               | 95 +++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..1840756958ce 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -153,6 +153,26 @@ struct bt_voice {
 
 #define BT_SCM_PKT_STATUS	0x03
 
+#define BT_CODEC	19
+
+struct	bt_codec_caps {
+	__u8	len;
+	__u8	data[];
+} __packed;
+
+struct bt_codec {
+	__u8	id;
+	__le16	cid;
+	__le16	vid;
+	__u8	data_path;
+	__u8	num_caps;
+} __packed;
+
+struct bt_codecs {
+	__u8		num_codecs;
+	struct bt_codec	codecs[];
+} __packed;
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b4e35cf5f4b1..5e4306a46324 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2621,6 +2621,12 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 #define hci_iso_data_len(h)		((h) & 0x3fff)
 #define hci_iso_data_flags(h)		((h) >> 14)
 
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
+/* codec transport types */
+#define TRANSPORT_ACL		0x00
+#define TRANSPORT_SCO_ESCO	0x01
+#endif
+
 /* le24 support */
 static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
 {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7b8d603358b9..00c97e2ce1fd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -621,6 +621,9 @@ struct hci_dev {
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
+	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
+#endif
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d9a4e88dacbb..ddf9b6bd9ca3 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -948,6 +948,14 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_voice voice;
 	u32 phys;
 	int pkt_status;
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
+	int buf_len;
+	struct codec_list *c;
+	u8 num_codecs, i, __user *ptr;
+	struct hci_dev *hdev;
+	struct hci_codec_caps *caps;
+	struct bt_codec codec;
+#endif
 
 	BT_DBG("sk %p", sk);
 
@@ -1012,6 +1020,93 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
+	case BT_CODEC:
+		num_codecs = 0;
+		buf_len = 0;
+
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+
+		if (!hdev->get_data_path_id) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		/* find total buffer size required to copy codec + caps */
+		hci_dev_lock(hdev);
+		list_for_each_entry(c, &hdev->local_codecs, list) {
+			if (c->transport != TRANSPORT_SCO_ESCO)
+				continue;
+			num_codecs++;
+			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
+				buf_len += 1 + caps->len;
+				caps = (void *)&caps->data[caps->len];
+			}
+			buf_len += sizeof(struct bt_codec);
+		}
+		hci_dev_unlock(hdev);
+
+		buf_len += sizeof(struct bt_codecs);
+		if (buf_len > len) {
+			err = -ENOBUFS;
+			break;
+		}
+		ptr = optval;
+
+		if (put_user(num_codecs, ptr)) {
+			err = -EFAULT;
+			break;
+		}
+		ptr += sizeof(num_codecs);
+
+		/* Iterate all the codecs supported over SCO and populate
+		 * codec data
+		 */
+		hci_dev_lock(hdev);
+		list_for_each_entry(c, &hdev->local_codecs, list) {
+			if (c->transport != TRANSPORT_SCO_ESCO)
+				continue;
+
+			codec.id = c->id;
+			codec.cid = c->cid;
+			codec.vid = c->vid;
+			err = hdev->get_data_path_id(hdev, &codec.data_path);
+			if (err < 0)
+				break;
+			codec.num_caps = c->num_caps;
+			if (copy_to_user(ptr, &codec, sizeof(codec))) {
+				err = -EFAULT;
+				break;
+			}
+			ptr += sizeof(codec);
+
+			/* find codec capabilities data length */
+			len = 0;
+			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
+				len += 1 + caps->len;
+				caps = (void *)&caps->data[caps->len];
+			}
+
+			/* copy codec capabilities data */
+			if (len && copy_to_user(ptr, c->caps, len)) {
+				err = -EFAULT;
+				break;
+			}
+			ptr += len;
+		}
+
+		if (!err && put_user(buf_len, optlen))
+			err = -EFAULT;
+
+		hci_dev_unlock(hdev);
+
+		break;
+#endif
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

