Return-Path: <SRS0=GU2S=7H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BAEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 18:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5492071C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ki/gLAEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbgEYSnt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 May 2020 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389656AbgEYSnt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 May 2020 14:43:49 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2328CC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2020 11:43:49 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i89so6423759uad.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2020 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gNqoIgcCiWnixZI/ZH2DHwbXhBVZFocOGZufBL0W/g=;
        b=Ki/gLAEVeElJrPtr3UB5vMKyZrXjqPQDlNoG6USeCs2JIBvhAUfM271cqLFylr6zR2
         M5cynlSbsg16w5efjKF6k6vApdvK40xr3pXKGvtAgU+HgFtfs9UwFfYjee/DmeNs9zEt
         7DIth9TBaqDPt9GCb4wlcNfmfRhC0EMQK60UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/gNqoIgcCiWnixZI/ZH2DHwbXhBVZFocOGZufBL0W/g=;
        b=T15dC4Oc90d+0rLXfc1EGqZNPV+aIqMzzlVmT6viblcfXXhdQknH181yoErL0tS254
         8XMiJDv6Mem68jssa7c1WjaZmgLZsZNvNRcDXMJNCL65hwcKeDRgBp0d5UBoskT2inux
         P6mCnGRv1/ZdLUUGuwnjDiCTfyn4SxdtYdZsQt2PdYTetkWxf40Dsb2xfJik+yNAVyQI
         6ghidDP5IbDt6B5kiI88sPw+dWObmZihWcDS56fY3BrthGEH5q1HaoE68HloYPuGGgqn
         5ZR84LWrNZ/Pp5n98EEJhxyumllipk59FIhdXm1ZW/hPV6/NiEr62rkzvucwCGzRzVeu
         kjjw==
X-Gm-Message-State: AOAM5332uEMmi2jhFjS/mEwMtEAojUR0BNAeIYqbAPAB4Z6d+OgM/Xyy
        C+OJVsfXTL9FcQyQO23S8aZRzlGQyyk=
X-Google-Smtp-Source: ABdhPJzUC/pgkQjrhmeqZC5aiektuhj7g3ZsjAfqBOM5L5zb5DaK0KndsvRVvK9D6lvVAxtA9I0roA==
X-Received: by 2002:ab0:6ed0:: with SMTP id c16mr23111273uav.62.1590432227841;
        Mon, 25 May 2020 11:43:47 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id 203sm1969382vka.51.2020.05.25.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 11:43:47 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] sco:Add support for BT_PKT_STATUS CMSG data
Date:   Mon, 25 May 2020 18:43:43 +0000
Message-Id: <20200525184343.8532-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
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

 include/net/bluetooth/bluetooth.h |  8 ++++++++
 include/net/bluetooth/sco.h       |  3 +++
 net/bluetooth/af_bluetooth.c      |  3 +++
 net/bluetooth/hci_core.c          |  1 +
 net/bluetooth/sco.c               | 28 ++++++++++++++++++++++++++++
 5 files changed, 43 insertions(+)

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
index c8c3d38cdc7b..3d7b973e5b7b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -66,6 +66,7 @@ struct sco_pinfo {
 	bdaddr_t	dst;
 	__u32		flags;
 	__u16		setting;
+	__u32           cmsg_mask;
 	struct sco_conn	*conn;
 };
 
@@ -449,6 +450,19 @@ static void sco_sock_close(struct sock *sk)
 	sco_sock_kill(sk);
 }
 
+static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
+			     struct sock *sk)
+{
+	__u32 mask = sco_pi(sk)->cmsg_mask;
+
+	if (mask & SCO_CMSG_PKT_STATUS) {
+		int pkt_status = bt_cb(skb)->sco.pkt_status;
+
+		put_cmsg(msg, SOL_BLUETOOTH, BT_PKT_STATUS, sizeof(pkt_status),
+			 &pkt_status);
+	}
+}
+
 static void sco_sock_init(struct sock *sk, struct sock *parent)
 {
 	BT_DBG("sk %p", sk);
@@ -457,6 +471,8 @@ static void sco_sock_init(struct sock *sk, struct sock *parent)
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->flags = bt_sk(parent)->flags;
 		security_sk_clone(parent, sk);
+	} else {
+		bt_sk(sk)->skb_put_cmsg = sco_skb_put_cmsg;
 	}
 }
 
@@ -846,6 +862,18 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		sco_pi(sk)->setting = voice.setting;
 		break;
 
+	case BT_PKT_STATUS:
+		if (get_user(opt, (int __user *)optval)) {
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
-- 
2.27.0.rc0.183.gde8f92d652-goog

