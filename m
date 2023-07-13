Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69DFC0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 22:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGMWmr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGMWmq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 18:42:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5479270B
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:42:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8b2b60731so6754675ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689288164; x=1691880164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxBuN4Ft9W6aCNwbYG0UsmsWSI5cvIZDCXH4Gx6Wi5U=;
        b=cVecnTybfgRhD2ABWcJb9DY5hEyK1kOMJHo8dNcwlH86I4uzmWg54RzNSwKJhI8Ctz
         NsS2NUnVajGuBZjKPqQ+SivbYEHZnXkvEs3L390fC/TJeFuNCf+LCVNufj5bonnd9IS9
         Mbu3IFTMAXu+FNSW0TjWaLYQEgeytr+AypFPpD7JBIh+J9ux7khkYtzXh89/piYPofsE
         hQ/l0mfBpKapQcNBKys5ywaWxTabU9U9EGu63fLNAGvScsyMpTqNuV0t3JK7CVy630HM
         wcgF9NWuX0vENV5AJuCohiNHWvGwiG/G2H66FPxfQiC5xOsrVeecDfhXOUQKtkm7n6b8
         OKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689288164; x=1691880164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxBuN4Ft9W6aCNwbYG0UsmsWSI5cvIZDCXH4Gx6Wi5U=;
        b=S3O+DUIGgNJ1e6797DjiOOVaBNOmDnI573jh2Lrfyx+6N9lLezrjn/Go6PGYNC6p3N
         QwXoHKD2quV9QcPeXwK4Ltc/Tux7mvi/DS3ikF71avIxKbbSsWCFyFM3KEKE9RUooFhu
         /pMu7ZPQj3wBnl5lR+FUs2lzV+aJfqBHBEh0K4lG7xPyzZ5BWLbCC+4Qv5sdrefAXcbG
         bYfK7f6X7WRGncNKZOgDIY/d/nQfsuRTfhSy0LJPdf+KIrZjSkYtvS/+P+E1lWiDhMYu
         nOYR5pHWHd9KFSzHbOERqTDhpXKuwqFoJqrGE7s8iRyjdvrEQypHGn0ouWhq0dGR9pv+
         YaCg==
X-Gm-Message-State: ABy/qLbf5bPdumGaIXG7Z/UfNeA7kbJblUMi+ySOJmsRrMy59KI35+6k
        kV28tH4NdBrEBFVZNC8HqeL7jS2abMs=
X-Google-Smtp-Source: APBJJlFMc0oEb1P5G7RRIoXchWW2JtI3H+WILh32gL1D8bGzc2lx3DEq0n0bOo30gX7tsSaJNuH4IQ==
X-Received: by 2002:a17:902:d34d:b0:1b2:a63:9587 with SMTP id l13-20020a170902d34d00b001b20a639587mr2281674plk.36.1689288163755;
        Thu, 13 Jul 2023 15:42:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b8b4730355sm6373762plb.287.2023.07.13.15.42.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:42:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: af_bluetooth: Make BT_PKT_STATUS generic
Date:   Thu, 13 Jul 2023 15:42:38 -0700
Message-Id: <20230713224239.2286549-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the handling of BT_PKT_STATUS more generic so it can be
reused by sockets other than SCO like BT_DEFER_SETUP, etc.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  8 +++-----
 include/net/bluetooth/sco.h       |  2 --
 net/bluetooth/af_bluetooth.c      |  8 ++++++--
 net/bluetooth/hci_core.c          |  2 +-
 net/bluetooth/sco.c               | 22 ++++------------------
 5 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 34998ae8ed78..aa90adc3b2a4 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -386,6 +386,7 @@ struct bt_sock {
 enum {
 	BT_SK_DEFER_SETUP,
 	BT_SK_SUSPEND,
+	BT_SK_PKT_STATUS
 };
 
 struct bt_sock_list {
@@ -432,10 +433,6 @@ struct l2cap_ctrl {
 	struct l2cap_chan *chan;
 };
 
-struct sco_ctrl {
-	u8	pkt_status;
-};
-
 struct hci_dev;
 
 typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
@@ -466,9 +463,9 @@ struct bt_skb_cb {
 	u8 force_active;
 	u16 expect;
 	u8 incoming:1;
+	u8 pkt_status:2;
 	union {
 		struct l2cap_ctrl l2cap;
-		struct sco_ctrl sco;
 		struct hci_ctrl hci;
 		struct mgmt_ctrl mgmt;
 		struct scm_creds creds;
@@ -477,6 +474,7 @@ struct bt_skb_cb {
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
 #define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
+#define hci_skb_pkt_status(skb) bt_cb((skb))->pkt_status
 #define hci_skb_expect(skb) bt_cb((skb))->expect
 #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
 #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1aa2e14b6c94..f40ddb4264fc 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -46,6 +46,4 @@ struct sco_conninfo {
 	__u8  dev_class[3];
 };
 
-#define SCO_CMSG_PKT_STATUS	0x01
-
 #endif /* __SCO_H */
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 647afb187147..336a76165454 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -333,8 +333,12 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
 						&msg->msg_namelen);
 
-		if (bt_sk(sk)->skb_put_cmsg)
-			bt_sk(sk)->skb_put_cmsg(skb, msg, sk);
+		if (test_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags)) {
+			u8 pkt_status = hci_skb_pkt_status(skb);
+
+			put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
+				 sizeof(pkt_status), &pkt_status);
+		}
 	}
 
 	skb_free_datagram(sk, skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bd90caad4804..0fefa6788911 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3895,7 +3895,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (conn) {
 		/* Send to upper protocol */
-		bt_cb(skb)->sco.pkt_status = flags & 0x03;
+		hci_skb_pkt_status(skb) = flags & 0x03;
 		sco_recv_scodata(conn, skb);
 		return;
 	} else {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ec6dce488a40..50ad5935ae47 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -68,7 +68,6 @@ struct sco_pinfo {
 	bdaddr_t	dst;
 	__u32		flags;
 	__u16		setting;
-	__u8		cmsg_mask;
 	struct bt_codec codec;
 	struct sco_conn	*conn;
 };
@@ -471,15 +470,6 @@ static void sco_sock_close(struct sock *sk)
 	release_sock(sk);
 }
 
-static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
-			     struct sock *sk)
-{
-	if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
-		put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
-			 sizeof(bt_cb(skb)->sco.pkt_status),
-			 &bt_cb(skb)->sco.pkt_status);
-}
-
 static void sco_sock_init(struct sock *sk, struct sock *parent)
 {
 	BT_DBG("sk %p", sk);
@@ -488,8 +478,6 @@ static void sco_sock_init(struct sock *sk, struct sock *parent)
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->flags = bt_sk(parent)->flags;
 		security_sk_clone(parent, sk);
-	} else {
-		bt_sk(sk)->skb_put_cmsg = sco_skb_put_cmsg;
 	}
 }
 
@@ -907,9 +895,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		if (opt)
-			sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
+			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
 		else
-			sco_pi(sk)->cmsg_mask &= SCO_CMSG_PKT_STATUS;
+			clear_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
 		break;
 
 	case BT_CODEC:
@@ -1040,7 +1028,6 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	int len, err = 0;
 	struct bt_voice voice;
 	u32 phys;
-	int pkt_status;
 	int buf_len;
 	struct codec_list *c;
 	u8 num_codecs, i, __user *ptr;
@@ -1094,9 +1081,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		pkt_status = (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS);
-
-		if (put_user(pkt_status, (int __user *)optval))
+		if (put_user(test_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags),
+			     (int __user *)optval))
 			err = -EFAULT;
 		break;
 
-- 
2.40.1

