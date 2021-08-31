Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05404C4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF44461008
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 11:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhHaLwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:52:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:36804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241583AbhHaLwT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 07:52:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205674714"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205674714"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 04:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="498264491"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2021 04:51:22 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v13 04/12] Bluetooth: Allow querying of supported offload codecs over SCO socket
Date:   Tue, 31 Aug 2021 17:26:29 +0530
Message-Id: <20210831115637.6713-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210831115637.6713-1-kiran.k@intel.com>
References: <20210831115637.6713-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add BT_CODEC option for getsockopt systemcall to get the details
of offload codecs supported over SCO socket

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Notes:
    * changes in v13:
     - No changes
    
    * changes in v12:
     - check for mgmt flag before querying codecs
    
    * changes in v11:
     - Remove Kconfig related changes
    
    * changes in v10:
     - In getsockopt, prepare data in advance and call copy_to_user
       instead of calling put_user on each field of struct bt_codec

 include/net/bluetooth/bluetooth.h |  20 ++++++
 include/net/bluetooth/hci.h       |   5 ++
 include/net/bluetooth/hci_core.h  |   1 +
 net/bluetooth/sco.c               | 101 ++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..64cddff0c9c4 100644
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
+	__u16	cid;
+	__u16	vid;
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
index ad88e5d44d7c..8f8664bec6f2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -331,6 +331,7 @@ enum {
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 	HCI_QUALITY_REPORT,
+	HCI_OFFLOAD_CODECS_ENABLED,
 
 	__HCI_NUM_FLAGS,
 };
@@ -2622,6 +2623,10 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 #define hci_iso_data_len(h)		((h) & 0x3fff)
 #define hci_iso_data_flags(h)		((h) >> 14)
 
+/* codec transport types */
+#define TRANSPORT_ACL		0x00
+#define TRANSPORT_SCO_ESCO	0x01
+
 /* le24 support */
 static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
 {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 585cbe7ff67d..655e2a119e7f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -619,6 +619,7 @@ struct hci_dev {
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
+	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b62c91c627e2..7e081761a1cd 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -972,6 +972,12 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_voice voice;
 	u32 phys;
 	int pkt_status;
+	int buf_len;
+	struct codec_list *c;
+	u8 num_codecs, i, __user *ptr;
+	struct hci_dev *hdev;
+	struct hci_codec_caps *caps;
+	struct bt_codec codec;
 
 	BT_DBG("sk %p", sk);
 
@@ -1036,6 +1042,101 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
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
+		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
+			hci_dev_put(hdev);
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		if (!hdev->get_data_path_id) {
+			hci_dev_put(hdev);
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
+			hci_dev_put(hdev);
+			err = -ENOBUFS;
+			break;
+		}
+		ptr = optval;
+
+		if (put_user(num_codecs, ptr)) {
+			hci_dev_put(hdev);
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
+		hci_dev_put(hdev);
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

