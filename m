Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01578C48BD1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B2661359
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhFHMWs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:22:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:22776 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhFHMWr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 08:22:47 -0400
IronPort-SDR: cJO/QdzVSZGjbrZU+o0KDOVCgeBP/gK0Dhh2IEpVCCb8D+ToNg6pJat7eHd1ZUkPb3kv6PHViS
 s9pJiQwQfXVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202973555"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="202973555"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 05:20:55 -0700
IronPort-SDR: YzyNSM7ONQb18zOamwcM2en8we3om1usYIUeAUDsp4sB5hWuzzHkKd2GeHcnKRFLlszLpYvJ6q
 oyzOtzakTdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619283454"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 05:20:53 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v9 05/10] Bluetooth: Add BT_CODEC option for getsockopt for SCO socket
Date:   Tue,  8 Jun 2021 17:54:50 +0530
Message-Id: <20210608122455.19583-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608122455.19583-1-kiran.k@intel.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add BT_CODEC option for getsockopt systemcall over SCO socket
to expose the codecs supported by controller

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
* changes on v9:
  - fix typos,review comments, remove quirk

 include/net/bluetooth/bluetooth.h |  20 ++++++
 include/net/bluetooth/hci.h       |   4 ++
 net/bluetooth/sco.c               | 111 +++++++++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 1 deletion(-)

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
index 45bd9af4ce61..31a5ac8918fc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2619,6 +2619,10 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 #define hci_iso_data_len(h)		((h) & 0x3fff)
 #define hci_iso_data_flags(h)		((h) >> 14)
 
+/* codec transport types */
+#define TRANSPORT_ACL		0x00
+#define TRANSPORT_SCO_ESCO	0x01
+
 /* le24 support */
 static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3])
 {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d9a4e88dacbb..98d5e24e5680 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -944,10 +944,15 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			       char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int len, err = 0, buf_len;
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
+		buf_len = 0;
+
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+
+		if (!hdev->get_data_path) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		hci_dev_lock(hdev);
+		/* find total buffer size  required to copy codec + caps */
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
+			err = hdev->get_data_path(hdev);
+			if (err < 0) {
+				err = -EFAULT;
+				goto unlock;
+			}
+
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
+
+		if (put_user(buf_len, optlen))
+			err = -EFAULT;
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

