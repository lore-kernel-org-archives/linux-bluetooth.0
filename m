Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940D9C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BEB6135F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348565AbhERKkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 06:40:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:23240 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242442AbhERKkM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 06:40:12 -0400
IronPort-SDR: S/WJ7B8iecVdYi2rZDEVS4ynXTCZuiTG9rs22gdurrJ3Hr+0rBONM0lqayBjDrQ054mFOJxKkt
 7o2U6snuQIAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187804821"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187804821"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:38:54 -0700
IronPort-SDR: rUU9sU86OnSpGuIlmOpuy+qpjKGz/1MdVk29fjm0fFg34uxk8s7a65bZmgqkOYklVTxn2Lnwpa
 DfCxX62HDomg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433017849"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2021 03:38:52 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 5/9] Bluetooth: Add BT_CODEC option for getsockopt for SCO socket
Date:   Tue, 18 May 2021 16:12:28 +0530
Message-Id: <20210518104232.5431-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518104232.5431-1-kiran.k@intel.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add BT_CODEC option for getsockopt systemcall over SCO socket
to expose the codecs supported by controller

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/bluetooth.h |  20 ++++++
 include/net/bluetooth/hci.h       |   4 ++
 net/bluetooth/sco.c               | 109 ++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

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
index 731d48ca873a..9658600ae5de 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2626,6 +2626,10 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 #define hci_iso_data_len(h)		((h) & 0x3fff)
 #define hci_iso_data_flags(h)		((h) >> 14)
 
+/* codec transport types */
+#define TRANSPORT_BREDR		0x00
+#define TRANSPORT_SCO_ESCO	0x01
+
 /* le24 support */
 static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
 {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3bd41563f118..d66293d1cba4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -948,6 +948,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_voice voice;
 	u32 phys;
 	int pkt_status;
+	struct codec_list *c;
+	u8 num_codecs, i, __user *ptr;
+	struct hci_dev *hdev;
+	struct hci_codec_caps *caps;
+	__u8	data_path;
 
 	BT_DBG("sk %p", sk);
 
@@ -1012,6 +1017,110 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_CODEC:
+		num_codecs = 0;
+		len = 0;
+
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+
+		if (!test_bit(HCI_QUIRK_HFP_OFFLOAD_CODECS_SUPPORTED, &hdev->quirks)) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		if (!hdev->get_data_path_id) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		hci_dev_lock(hdev);
+		list_for_each_entry(c, &hdev->local_codecs, list) {
+			if (c->transport != TRANSPORT_SCO_ESCO)
+				continue;
+			num_codecs++;
+			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
+				len += 1 + caps->len;
+				caps = (void *)&caps->data[caps->len];
+			}
+			len += sizeof(struct bt_codec);
+		}
+		hci_dev_unlock(hdev);
+
+		if (len > 255) {
+			err = -ENOMEM;
+			break;
+		}
+
+		ptr = optval;
+		if (put_user(num_codecs, ptr)) {
+			err = -EFAULT;
+			break;
+		}
+		ptr += sizeof(num_codecs);
+
+		hci_dev_lock(hdev);
+		list_for_each_entry(c, &hdev->local_codecs, list) {
+			if (c->transport != TRANSPORT_SCO_ESCO)
+				continue;
+
+			if (put_user(c->id, ptr)) {
+				err = -EFAULT;
+				goto unlock;
+			}
+			ptr += sizeof(c->id);
+
+			if (put_user(c->cid, ptr)) {
+				err = -EFAULT;
+				goto unlock;
+			}
+			ptr += sizeof(c->cid);
+
+			if (put_user(c->vid, ptr)) {
+				err = -EFAULT;
+				goto unlock;
+			}
+			ptr += sizeof(c->vid);
+
+			err = hdev->get_data_path_id(hdev);
+			if (err < 0) {
+				err = -EFAULT;
+				goto unlock;
+			}
+			data_path = (__u8)err;
+			if (put_user(data_path, ptr)) {
+				err = -EFAULT;
+				goto unlock;
+			}
+			ptr += sizeof(data_path);
+
+			if (put_user(c->num_caps, ptr)) {
+				err = -EFAULT;
+				goto unlock;
+			}
+			ptr += sizeof(c->num_caps);
+
+			len = 0;
+			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
+				len += 1 + caps->len;
+				caps = (void *)&caps->data[caps->len];
+			}
+
+			if (len && copy_to_user(ptr, c->caps, len)) {
+				err = -EFAULT;
+				goto unlock;
+			}
+			ptr += len;
+		}
+unlock:
+		hci_dev_unlock(hdev);
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

