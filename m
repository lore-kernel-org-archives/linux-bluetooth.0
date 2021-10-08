Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28473C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E2360FD8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 13:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhJHNzV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 09:55:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:60420 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233283AbhJHNzU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 09:55:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213457760"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="213457760"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 06:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="624744956"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2021 06:53:23 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/7] Bluetooth: Support reading of codecs supported over l2cap socket
Date:   Fri,  8 Oct 2021 19:28:48 +0530
Message-Id: <20211008135853.8604-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008135853.8604-1-kiran.k@intel.com>
References: <20211008135853.8604-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Codecs supported for A2DP offload use case are returned over l2cap
socket. Add BT_CODEC option to getsockopt to return the codecs.

Signed-off-by: Kiran K <kiran.k@intel.com>
Change-Id: I1592f3bb1167771bfb2cb9114438e473ea372c90
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/l2cap_sock.c  | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 63065bc01b76..451d491f7f68 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2666,6 +2666,7 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 #define hci_iso_data_flags(h)		((h) >> 14)
 
 /* codec transport types */
+#define HCI_TRANSPORT_ACL	0x00
 #define HCI_TRANSPORT_SCO_ESCO	0x01
 
 /* le24 support */
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 160c016a5dfb..06f8ea681972 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -36,6 +36,7 @@
 #include <net/bluetooth/l2cap.h>
 
 #include "smp.h"
+#include "hci_codec.h"
 
 static struct bt_sock_list l2cap_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
@@ -549,6 +550,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct bt_power pwr;
 	u32 phys;
 	int len, mode, err = 0;
+	struct hci_dev *hdev;
 
 	BT_DBG("sk %p", sk);
 
@@ -685,6 +687,18 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_CODEC:
+		hdev = hci_get_route(BDADDR_ANY, &chan->src, BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+
+		err = hci_get_supported_codecs(hdev, HCI_TRANSPORT_ACL, optval,
+					       optlen, len);
+		hci_dev_put(hdev);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

