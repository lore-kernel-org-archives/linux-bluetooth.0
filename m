Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DD36109E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349168AbhICKyM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:54:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:35135 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349178AbhICKyL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 06:54:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206611731"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206611731"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692090409"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 03:53:09 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v14 06/12] Bluetooth: Allow setting of codec for HFP offload use case
Date:   Fri,  3 Sep 2021 16:28:07 +0530
Message-Id: <20210903105813.2440-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210903105813.2440-1-kiran.k@intel.com>
References: <20210903105813.2440-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch allows user space to set the codec that needs to
be used for HFP offload use case. The codec details are cached and
the controller is configured before opening the SCO connection.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Notes:
    * changes in v14:
     - No changes
    
    * changes in v13:
     - Only cache the codec to be set in setsockopt. Use these values
       later when opening SCO connection
    
    * changes in v12:
     - check for mgmt flag before setting codec for offload use case
    
    * changes in v11:
      - Remove changes related to Kconfig
    
    * changes in v10:
      - patch refactor - having callback definition and usage in the same patch

 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/sco.c               | 60 +++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 7e081761a1cd..727b766488db 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -69,6 +69,7 @@ struct sco_pinfo {
 	__u32		flags;
 	__u16		setting;
 	__u8		cmsg_mask;
+	struct bt_codec codec;
 	struct sco_conn	*conn;
 };
 
@@ -441,6 +442,7 @@ static void __sco_sock_close(struct sock *sk)
 		sock_set_flag(sk, SOCK_ZAPPED);
 		break;
 	}
+
 }
 
 /* Must be called on unlocked socket. */
@@ -501,6 +503,10 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_state    = BT_OPEN;
 
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
+	sco_pi(sk)->codec.id = CODING_FORMAT_CVSD;
+	sco_pi(sk)->codec.cid = 0xffff;
+	sco_pi(sk)->codec.vid = 0xffff;
+	sco_pi(sk)->codec.data_path = 0x00;
 
 	bt_sock_link(&sco_sk_list, sk);
 	return sk;
@@ -833,6 +839,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 	int len, err = 0;
 	struct bt_voice voice;
 	u32 opt;
+	struct bt_codecs *codecs;
+	struct hci_dev *hdev;
+	__u8 buffer[255];
 
 	BT_DBG("sk %p", sk);
 
@@ -894,6 +903,57 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
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
+		if (!hdev->get_data_path_id) {
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
+		sco_pi(sk)->codec = codecs->codecs[0];
+		hci_dev_put(hdev);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

