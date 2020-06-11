Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B722078D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PhEkMbQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFKN2K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgFKN2K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 09:28:10 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B9C03E96F
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 06:28:10 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z47so2086134uad.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nS+TDLihjg0mf4/EFDDec+3kbAwkozLu02FpGibKD+M=;
        b=PhEkMbQncYUKy3Si/U1yd8QvV9n3yvTPqdZUY27X95P9XAquyH0R6aVFHzTs+YANic
         rqawhLUmtK3rzDcSTNBOj1hm75vKEAUVtjFpk15aBvLkgOs98pNX6LMHCIo03jguANRg
         4Wtjn4JufO2RTW8Ib5xkqu3ggxZJZ0pHksFso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nS+TDLihjg0mf4/EFDDec+3kbAwkozLu02FpGibKD+M=;
        b=a8QpISlmgzHk7OAq1S1uh5UWMIVWxYM6p4sUg8A0WDAx+wRPFOjBpqtHqjDLWpsnXk
         ylfTz/0GGd1M6YZApMv4kU5A/ku7TrYXM+w/k4l80n87lpbjTLYbsA5VezkqbM/6s+cO
         OFM8AHsBFay3XSp0vhZPe+M08xxh/xBQBDU12va30vgTO9QuywTEiT0ER4dDM3GKudi1
         BnqL1nUfc+gXbNOwqzkmBjgoYcH+u7v0rLCCbEOMMIYHuXbQof22Vx0TIxPZnpVRtjAV
         b0WbKp7SGXWJR7qK8MJatWbIMwYXV4o8XrOQyHQJhzLAt6MPJw58bp638tB4C6de6r8m
         FMFQ==
X-Gm-Message-State: AOAM531+w6My31qYb8w+AgBd2d+lM0yGLj1m7X/0bhAQcPMunuX7npwZ
        pSilC/EeAepUm+5myKUx3EV44ATVAhY=
X-Google-Smtp-Source: ABdhPJwv4fRkanu6SMxkim2CFH6HMrtXpaO279Yb5AV4od9ubfmDwZg3oeiRtadHwr42y0ArLdS/hg==
X-Received: by 2002:ab0:5f95:: with SMTP id b21mr6338465uaj.122.1591882088686;
        Thu, 11 Jun 2020 06:28:08 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id d1sm438898vke.18.2020.06.11.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 06:28:08 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v5] sco:Add support for BT_PKT_STATUS CMSG data
Date:   Thu, 11 Jun 2020 13:28:05 +0000
Message-Id: <20200611132805.139622-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
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
Hsin-yu Chao.

Signed-off-by: Alain Michaud <alainm@chromium.org>

---

Changes in v5:
- reducing cmsg_mask to 8 bit
- clarifying the public symbol usage versus internal CMSG flags.

Changes in v4:
- Addressing feedback from Marcel

 include/net/bluetooth/bluetooth.h | 10 ++++++++++
 include/net/bluetooth/sco.h       |  2 ++
 net/bluetooth/af_bluetooth.c      |  3 +++
 net/bluetooth/hci_core.c          |  1 +
 net/bluetooth/sco.c               | 33 +++++++++++++++++++++++++++++++
 5 files changed, 49 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 3fa7b1e3c5d9..4044c6a1ffd0 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -147,6 +147,10 @@ struct bt_voice {
 #define BT_MODE_LE_FLOWCTL	0x03
 #define BT_MODE_EXT_FLOWCTL	0x04
 
+#define BT_PKT_STATUS          16
+
+#define BT_SCM_PKT_STATUS	0x03
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
@@ -275,6 +279,7 @@ struct bt_sock {
 	struct sock *parent;
 	unsigned long flags;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
+	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
 };
 
 enum {
@@ -324,6 +329,10 @@ struct l2cap_ctrl {
 	struct l2cap_chan *chan;
 };
 
+struct sco_ctrl {
+	u8	pkt_status;
+};
+
 struct hci_dev;
 
 typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
@@ -350,6 +359,7 @@ struct bt_skb_cb {
 	u8 incoming:1;
 	union {
 		struct l2cap_ctrl l2cap;
+		struct sco_ctrl sco;
 		struct hci_ctrl hci;
 	};
 };
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index f40ddb4264fc..1aa2e14b6c94 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -46,4 +46,6 @@ struct sco_conninfo {
 	__u8  dev_class[3];
 };
 
+#define SCO_CMSG_PKT_STATUS	0x01
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
index c8c3d38cdc7b..012a1579c260 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -66,6 +66,7 @@ struct sco_pinfo {
 	bdaddr_t	dst;
 	__u32		flags;
 	__u16		setting;
+	__u8		cmsg_mask;
 	struct sco_conn	*conn;
 };
 
@@ -449,6 +450,15 @@ static void sco_sock_close(struct sock *sk)
 	sco_sock_kill(sk);
 }
 
+static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
+			     struct sock *sk)
+{
+	if (test_bit(SCO_CMSG_PKT_STATUS, &sco_pi(sk)->cmsg_mask))
+		put_cmsg(msg, SOL_BLUETOOTH, BT_SCM_PKT_STATUS,
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
+			set_bit(SCO_CMSG_PKT_STATUS, &sco_pi(sk)->cmsg_mask);
+		else
+			clear_bit(SCO_CMSG_PKT_STATUS, &sco_pi(sk)->cmsg_mask);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -923,6 +947,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 	int len, err = 0;
 	struct bt_voice voice;
 	u32 phys;
+	int pkt_status;
 
 	BT_DBG("sk %p", sk);
 
@@ -969,6 +994,14 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_PKT_STATUS:
+		pkt_status = test_bit(SCO_CMSG_PKT_STATUS,
+				      &(sco_pi(sk)->cmsg_mask));
+
+		if (put_user(pkt_status, (int __user *)optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.27.0.290.gba653c62da-goog

