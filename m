Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C00B61B04
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhKSIR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:17:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:1480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234154AbhKSIR6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:17:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098342"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098342"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468675"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:14:54 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 01/14] Bluetooth: Refactor code to read supported codecs in getsockopt
Date:   Fri, 19 Nov 2021 13:50:14 +0530
Message-Id: <20211119082027.12809-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch moves reading of supported codecs from cache to a new
function to reuse over L2CAP sockets to be used in a2dp offload
use case.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 net/bluetooth/hci_codec.c | 83 +++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_codec.h |  2 +
 net/bluetooth/sco.c       | 91 +++------------------------------------
 3 files changed, 91 insertions(+), 85 deletions(-)

diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 38201532f58e..1e486aca3002 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -250,3 +250,86 @@ void hci_read_supported_codecs_v2(struct hci_dev *hdev)
 error:
 	kfree_skb(skb);
 }
+
+int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
+			     int __user *optlen, int len)
+{
+	int n = 0, buf_len = 0, err = 0;
+	struct hci_codec_caps *caps;
+	struct bt_codec codec;
+	u8 num_codecs = 0, i, __user *ptr;
+	struct codec_list *c;
+
+	if (!hdev->get_data_path_id) {
+		err = -EOPNOTSUPP;
+		goto error;
+	}
+
+	/* find total buffer size required to copy codec + capabilities */
+	hci_dev_lock(hdev);
+	list_for_each_entry(c, &hdev->local_codecs, list) {
+		if (c->transport != type)
+			continue;
+		num_codecs++;
+		for (i = 0, caps = c->caps; i < c->num_caps; i++) {
+			buf_len += 1 + caps->len;
+			caps = (void *)&caps->data[caps->len];
+		}
+		buf_len += sizeof(struct bt_codec);
+	}
+	hci_dev_unlock(hdev);
+
+	buf_len += sizeof(struct bt_codecs);
+	if (buf_len > len) {
+		err = -ENOBUFS;
+		goto error;
+	}
+	ptr = optval;
+
+	if (put_user(num_codecs, ptr)) {
+		err = -EFAULT;
+		goto error;
+	}
+	ptr += sizeof(num_codecs);
+
+	/* Iterate over all the codecs on required transport */
+	hci_dev_lock(hdev);
+	list_for_each_entry(c, &hdev->local_codecs, list) {
+		if (c->transport != type)
+			continue;
+
+		codec.id = c->id;
+		codec.cid = c->cid;
+		codec.vid = c->vid;
+		err = hdev->get_data_path_id(hdev, &codec.data_path);
+		if (err < 0)
+			break;
+		codec.num_caps = c->num_caps;
+		if (copy_to_user(ptr, &codec, sizeof(codec))) {
+			err = -EFAULT;
+			break;
+		}
+		ptr += sizeof(codec);
+
+		/* find codec capabilities data length */
+		n = 0;
+		for (i = 0, caps = c->caps; i < c->num_caps; i++) {
+			n += 1 + caps->len;
+			caps = (void *)&caps->data[caps->len];
+		}
+
+		/* copy codec capabilities data */
+		if (n && copy_to_user(ptr, c->caps, n)) {
+			err = -EFAULT;
+			break;
+		}
+		ptr += n;
+	}
+	hci_dev_unlock(hdev);
+
+	if (!err && put_user(buf_len, optlen))
+		err = -EFAULT;
+
+error:
+	return err;
+}
diff --git a/net/bluetooth/hci_codec.h b/net/bluetooth/hci_codec.h
index a2751930f123..6e849c7d75b9 100644
--- a/net/bluetooth/hci_codec.h
+++ b/net/bluetooth/hci_codec.h
@@ -5,3 +5,5 @@
 void hci_read_supported_codecs(struct hci_dev *hdev);
 void hci_read_supported_codecs_v2(struct hci_dev *hdev);
 void hci_codec_list_clear(struct list_head *codec_list);
+int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
+			     int __user *optlen, int len);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..6bb1b5dc0e60 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -33,6 +33,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/sco.h>
 
+#include "hci_codec.h"
+
 static bool disable_esco;
 
 static const struct proto_ops sco_sock_ops;
@@ -1032,12 +1034,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_voice voice;
 	u32 phys;
 	int pkt_status;
-	int buf_len;
-	struct codec_list *c;
-	u8 num_codecs, i, __user *ptr;
 	struct hci_dev *hdev;
-	struct hci_codec_caps *caps;
-	struct bt_codec codec;
 
 	BT_DBG("sk %p", sk);
 
@@ -1103,98 +1100,22 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CODEC:
-		num_codecs = 0;
-		buf_len = 0;
-
-		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
+				     BDADDR_BREDR);
 		if (!hdev) {
 			err = -EBADFD;
 			break;
 		}
 
 		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
-			hci_dev_put(hdev);
 			err = -EOPNOTSUPP;
-			break;
-		}
-
-		if (!hdev->get_data_path_id) {
-			hci_dev_put(hdev);
-			err = -EOPNOTSUPP;
-			break;
-		}
-
-		/* find total buffer size required to copy codec + caps */
-		hci_dev_lock(hdev);
-		list_for_each_entry(c, &hdev->local_codecs, list) {
-			if (c->transport != HCI_TRANSPORT_SCO_ESCO)
-				continue;
-			num_codecs++;
-			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
-				buf_len += 1 + caps->len;
-				caps = (void *)&caps->data[caps->len];
-			}
-			buf_len += sizeof(struct bt_codec);
-		}
-		hci_dev_unlock(hdev);
-
-		buf_len += sizeof(struct bt_codecs);
-		if (buf_len > len) {
 			hci_dev_put(hdev);
-			err = -ENOBUFS;
 			break;
 		}
-		ptr = optval;
 
-		if (put_user(num_codecs, ptr)) {
-			hci_dev_put(hdev);
-			err = -EFAULT;
-			break;
-		}
-		ptr += sizeof(num_codecs);
-
-		/* Iterate all the codecs supported over SCO and populate
-		 * codec data
-		 */
-		hci_dev_lock(hdev);
-		list_for_each_entry(c, &hdev->local_codecs, list) {
-			if (c->transport != HCI_TRANSPORT_SCO_ESCO)
-				continue;
-
-			codec.id = c->id;
-			codec.cid = c->cid;
-			codec.vid = c->vid;
-			err = hdev->get_data_path_id(hdev, &codec.data_path);
-			if (err < 0)
-				break;
-			codec.num_caps = c->num_caps;
-			if (copy_to_user(ptr, &codec, sizeof(codec))) {
-				err = -EFAULT;
-				break;
-			}
-			ptr += sizeof(codec);
-
-			/* find codec capabilities data length */
-			len = 0;
-			for (i = 0, caps = c->caps; i < c->num_caps; i++) {
-				len += 1 + caps->len;
-				caps = (void *)&caps->data[caps->len];
-			}
-
-			/* copy codec capabilities data */
-			if (len && copy_to_user(ptr, c->caps, len)) {
-				err = -EFAULT;
-				break;
-			}
-			ptr += len;
-		}
-
-		if (!err && put_user(buf_len, optlen))
-			err = -EFAULT;
-
-		hci_dev_unlock(hdev);
+		err = hci_get_supported_codecs(hdev, HCI_TRANSPORT_SCO_ESCO,
+					       optval, optlen, len);
 		hci_dev_put(hdev);
-
 		break;
 
 	default:
-- 
2.17.1

