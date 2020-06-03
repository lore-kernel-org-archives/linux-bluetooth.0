Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B8AC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4974B20823
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LoneoR49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCOv3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgFCOv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 10:51:28 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BEBC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 07:51:28 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c15so930187uar.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtvKh6dBFh8QiSwUYYrfuKjbdVtIFde99aNkmrj9iHk=;
        b=LoneoR49oi8004/I3jrSvTf2vLnI1YhD2Io9DZW4lmvkYSfThafpDQnu7prf3Qerj5
         3XI3i9RTCxxCj0ZuZ4a8Wria5zRlu9FeSlkk3xgigkqzpxpi837RF5UywY0SGp2UU7Aa
         e/AWYcyt+dTRAS/Slv3tQD4Zkl1WsEkDckBWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtvKh6dBFh8QiSwUYYrfuKjbdVtIFde99aNkmrj9iHk=;
        b=nn3KDk0uoIToXkdR4hq5ZBoOF69hy1TU03rtFZKLVpNu0SoorV7Q2VJvSg1EO9tFUP
         00ENOmdbhWNcKgpeVfn+dOOS+oB/UVIPBiOyQHILx+XOXuSKW+7Qdkv6i/vvLwPtFOPt
         zBJS3ijUY2UBb2+0OLP2K1YNJE5VFr3YL36AQjt5pjvjdtKXKawMq1BsRirwvPPySR3X
         rzyrdcbamTF0T+uX0P8tLvHI8VJDwuMt5M9g8fWCMSl3kXMoWHJ3LPlGp5WigZNqPRgw
         rhrvNjBuKuhWYVvFisJ1C7pQ5RIvi4MX8hCuL3ab9WgybAqf5D1mN9thB+HtoqTznHpM
         QqDg==
X-Gm-Message-State: AOAM532uvouAW+GxYXX/SffzWWSxsqIBVqOWeBRKUgDb7AVLjRQBWFBq
        qB4iuA9QsJ1w3IqOtu86hJw3bb0gQss=
X-Google-Smtp-Source: ABdhPJwt8E1bvboFMOI7idE2Zjkb3qouhj19jT8e5ZLewV6iE9V0Hp0CU6OJ0DBwDBnKSns73xTVDA==
X-Received: by 2002:a9f:2068:: with SMTP id 95mr238964uam.134.1591195886837;
        Wed, 03 Jun 2020 07:51:26 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r128sm314669vkf.48.2020.06.03.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 07:51:25 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] sco:Add support for BT_PKT_STATUS CMSG data
Date:   Wed,  3 Jun 2020 14:51:21 +0000
Message-Id: <20200603145121.124842-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds support for reporting the BT_PKT_STATUS to the socket
CMSG data to allow the implementation of a packet loss correction on
erronous data received on the SCO socket.

The patch was partially developed by Marcel Holtmann and validated by
Hsin-yu Chao

Signed-off-by: Alain Michaud <alainm@chromium.org>

---

 include/net/bluetooth/bluetooth.h |  8 +++++++
 include/net/bluetooth/sco.h       |  3 +++
 net/bluetooth/af_bluetooth.c      |  3 +++
 net/bluetooth/hci_core.c          |  1 +
 net/bluetooth/sco.c               | 35 +++++++++++++++++++++++++++++++
 5 files changed, 50 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 3fa7b1e3c5d9..85e6c5754448 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -147,6 +147,8 @@ struct bt_voice {
 #define BT_MODE_LE_FLOWCTL	0x03
 #define BT_MODE_EXT_FLOWCTL	0x04
 
+#define BT_PKT_STATUS          16
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
@@ -275,6 +277,7 @@ struct bt_sock {
 	struct sock *parent;
 	unsigned long flags;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
+	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
 };
 
 enum {
@@ -324,6 +327,10 @@ struct l2cap_ctrl {
 	struct l2cap_chan *chan;
 };
 
+struct sco_ctrl {
+	u8	pkt_status;
+};
+
 struct hci_dev;
 
 typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
@@ -350,6 +357,7 @@ struct bt_skb_cb {
 	u8 incoming:1;
 	union {
 		struct l2cap_ctrl l2cap;
+		struct sco_ctrl sco;
 		struct hci_ctrl hci;
 	};
 };
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index f40ddb4264fc..7f0d7bdc53f6 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -46,4 +46,7 @@ struct sco_conninfo {
 	__u8  dev_class[3];
 };
 
+/* CMSG flags */
+#define SCO_CMSG_PKT_STATUS	0x0001
+
 #endif /* __SCO_H */
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 3fd124927d4d..d0abea8d08cc 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -286,6 +286,9 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		if (msg->msg_name && bt_sk(sk)->skb_msg_name)
 			bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
 						&msg->msg_namelen);
+
+		if (bt_sk(sk)->skb_put_cmsg)
+			bt_sk(sk)->skb_put_cmsg(skb, msg, sk);
 	}
 
 	skb_free_datagram(sk, skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 51d399273276..7b5e46198d99 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4549,6 +4549,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (conn) {
 		/* Send to upper protocol */
+		bt_cb(skb)->sco.pkt_status = flags & 0x03;
 		sco_recv_scodata(conn, skb);
 		return;
 	} else {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c8c3d38cdc7b..f6b54853e547 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -66,6 +66,7 @@ struct sco_pinfo {
 	bdaddr_t	dst;
 	__u32		flags;
 	__u16		setting;
+	__u32           cmsg_mask;
 	struct sco_conn	*conn;
 };
 
@@ -449,6 +450,15 @@ static void sco_sock_close(struct sock *sk)
 	sco_sock_kill(sk);
 }
 
+static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
+			     struct sock *sk)
+{
+	if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
+		put_cmsg(msg, SOL_BLUETOOTH, BT_PKT_STATUS,
+			 sizeof(bt_cb(skb)->sco.pkt_status),
+			 &bt_cb(skb)->sco.pkt_status);
+}
+
 static void sco_sock_init(struct sock *sk, struct sock *parent)
 {
 	BT_DBG("sk %p", sk);
@@ -457,6 +467,8 @@ static void sco_sock_init(struct sock *sk, struct sock *parent)
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->flags = bt_sk(parent)->flags;
 		security_sk_clone(parent, sk);
+	} else {
+		bt_sk(sk)->skb_put_cmsg = sco_skb_put_cmsg;
 	}
 }
 
@@ -846,6 +858,18 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		sco_pi(sk)->setting = voice.setting;
 		break;
 
+	case BT_PKT_STATUS:
+		if (get_user(opt, (u32 __user *)optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt)
+			sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
+		else
+			sco_pi(sk)->cmsg_mask &= ~SCO_CMSG_PKT_STATUS;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -923,6 +947,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	int len, err = 0;
 	struct bt_voice voice;
 	u32 phys;
+	u32 pkt_status;
 
 	BT_DBG("sk %p", sk);
 
@@ -969,6 +994,16 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_PKT_STATUS:
+		if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
+			pkt_status = 1;
+		else
+			pkt_status = 0;
+
+		if (put_user(pkt_status, (u32 __user *)optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.27.0.rc2.251.g90737beb825-goog

