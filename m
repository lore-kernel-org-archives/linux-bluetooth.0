Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C093C4743D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA2B61359
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhFHMWw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:22:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:22782 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232547AbhFHMWv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 08:22:51 -0400
IronPort-SDR: lcLPgaXc5f5JCV47MpHEJA6wBsgSU4SrNpymDPxi9++NOCfd5GRJQtABFqXw7C4cgBtytlCrc0
 V/jnTBgbLWeg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202973568"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="202973568"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 05:20:59 -0700
IronPort-SDR: DDzhWNXGu05hNdXzoDxdMOg1GXD2vEZ/CZuE6FgMSjm98Rd+oUluE2HgJPUowF+5+TUGEyuXEC
 J+JyBJ01rEsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619283490"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 05:20:58 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v9 08/10] Bluetooth: Add BT_CODEC option for setsockopt over SCO
Date:   Tue,  8 Jun 2021 17:54:53 +0530
Message-Id: <20210608122455.19583-8-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608122455.19583-1-kiran.k@intel.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add BT_CODEC option on setsockopt system call to allow user space
audio modules to set codec. Driver also sets data path if non-HCI is
selected.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/sco.c               | 59 +++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1840756958ce..0e8802d09068 100644
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
index 98d5e24e5680..5aa6808c1a22 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -67,6 +67,7 @@ struct sco_pinfo {
 	__u32		flags;
 	__u16		setting;
 	__u8		cmsg_mask;
+	struct bt_codec codec;
 	struct sco_conn	*conn;
 };
 
@@ -438,6 +439,7 @@ static void __sco_sock_close(struct sock *sk)
 		sock_set_flag(sk, SOCK_ZAPPED);
 		break;
 	}
+
 }
 
 /* Must be called on unlocked socket. */
@@ -499,6 +501,10 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_state    = BT_OPEN;
 
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
+	sco_pi(sk)->codec.id = CODING_FORMAT_CVSD;
+	sco_pi(sk)->codec.cid = 0xffff;
+	sco_pi(sk)->codec.vid = 0xffff;
+	sco_pi(sk)->codec.data_path = 0x00;
 
 	timer_setup(&sk->sk_timer, sco_sock_timeout, 0);
 
@@ -808,6 +814,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	int len, err = 0;
 	struct bt_voice voice;
+	struct bt_codecs *codecs;
+	struct hci_dev *hdev;
+	__u8 buffer[255];
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -870,6 +879,56 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			sco_pi(sk)->cmsg_mask &= SCO_CMSG_PKT_STATUS;
 		break;
 
+	case BT_CODEC:
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src, BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+
+		if (!hdev->set_data_path) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+
+		if (optlen < sizeof(struct bt_codecs) || optlen > 255) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (copy_from_sockptr(buffer, optval, optlen)) {
+			err = -EFAULT;
+			break;
+		}
+
+		codecs = (void *)buffer;
+
+		if (codecs->num_codecs > 1) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (codecs->codecs[0].data_path) {
+			err = hdev->set_data_path(hdev, SCO_LINK,
+						  codecs->codecs);
+			if (err < 0)
+				break;
+
+			if (codecs->codecs[0].id == 0xff) {
+				sco_pi(sk)->codec.cid = codecs->codecs[0].cid;
+				sco_pi(sk)->codec.vid = codecs->codecs[0].vid;
+			}
+		}
+		sco_pi(sk)->codec.id = codecs->codecs[0].id;
+		sco_pi(sk)->codec.data_path = codecs->codecs[0].data_path;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.17.1

