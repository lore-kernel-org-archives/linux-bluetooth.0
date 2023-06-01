Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD4C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 23:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjFAXjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFAXjG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 19:39:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0892136
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 16:39:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so1714967b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685662743; x=1688254743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=whbmuO7ngTJhvFRPJg6Rdytc7gTUnaCIJab2ljA7PeA=;
        b=ZqIuGMtnkGRftcR+/I6ZkgR6bQcxnget/0FASDypH8zLYPMNtWDLKh+jTWSOUcDF6c
         z7UsA+vWtdKF1hWslP6VyXteZ80p6r7zY1+PvxvdNcKlZJ4WIdsFd/QWjbQu0z5gmLi7
         Cvue4Qgmgtp7dTsN/KcLib/5KDYiweI8IqDeJLNzNjp8VAl+SChaop/Z+7nTbnQMgpkA
         LRxScWtSscw93W1WgAR/O0MVitamVHUpQr9T326A20h4Hv/ccdA6A1JrqTpJEQS/wMXz
         GZvU1DzajGYYalq8pCy/qA2cttnsp07MJ37dBuZl99aL1nrmRjbP4Dpsb2tnkTiL3MSw
         qwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662743; x=1688254743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whbmuO7ngTJhvFRPJg6Rdytc7gTUnaCIJab2ljA7PeA=;
        b=lrM5MLRxT0oVVvOYvxx8qUGhoHoHVOHv0yUoenfFcDS9aoHa3RgRix3rBgU6QPdEQh
         8CZXPQieh6PA5BQxsP5/At6wiRYIcqsbtXV3VdwmjSJrxnFs1eBgfRrevUE3RepSYTFz
         TPyyWKqIihkZ+LermtbTY8JVlPnMIVOCfkKnfwihX9ZG0dgduTe7Oo4tq0wo0KuFQn19
         oo21UzGS2KeGcwE2w05XFboqjqr4kGNwgAKTGFBwosewGAlpYQ5A9TN8Rhs32cKHliII
         hBe1DPMJhFwO3fCKQ86HHr9JwG859V25lr6o+vxkvahDfoUYQq2sfAhz93hrffczwJXE
         77Gg==
X-Gm-Message-State: AC+VfDwj1klqn28Wy9PtkGjjOfOKw/oLZz9t7y5FwXTs0AGynbyZggon
        5teTjpameIORQFWyNm8+xLMFcGzNlPw=
X-Google-Smtp-Source: ACHHUZ5/GR+mCuAuv4ccvfDDRQ5g5z0BQfsuikD8b+VpWIjovi7FhXMN6PWK840yH8W4wAjvZp3D/Q==
X-Received: by 2002:a05:6a00:c82:b0:649:dd0d:69d1 with SMTP id a2-20020a056a000c8200b00649dd0d69d1mr13312533pfv.31.1685662743457;
        Thu, 01 Jun 2023 16:39:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b00652f5bd894esm78459pfa.177.2023.06.01.16.39.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:39:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Consolidate code around sk_alloc into a helper function
Date:   Thu,  1 Jun 2023 16:38:59 -0700
Message-Id: <20230601233901.1448729-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This consolidates code around sk_alloc into bt_sock_alloc which does
take care of common initialization.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/af_bluetooth.c      | 21 +++++++++++++++++++++
 net/bluetooth/bnep/sock.c         | 10 +---------
 net/bluetooth/hci_sock.c          | 10 ++--------
 net/bluetooth/iso.c               | 10 +---------
 net/bluetooth/l2cap_sock.c        | 10 +---------
 net/bluetooth/rfcomm/sock.c       | 13 +++----------
 net/bluetooth/sco.c               | 10 +---------
 8 files changed, 32 insertions(+), 54 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1b4230cd42a3..b518e5379045 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -400,6 +400,8 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 1c3c7ff5c3c6..6035422e13da 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -140,6 +140,27 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
 	return err;
 }
 
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern)
+{
+	struct sock *sk;
+
+	sk = sk_alloc(net, PF_BLUETOOTH, prio, prot, kern);
+	if (!sk)
+		return NULL;
+
+	sock_init_data(sock, sk);
+	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+
+	sock_reset_flag(sk, SOCK_ZAPPED);
+
+	sk->sk_protocol = proto;
+	sk->sk_state    = BT_OPEN;
+
+	return sk;
+}
+EXPORT_SYMBOL(bt_sock_alloc);
+
 void bt_sock_link(struct bt_sock_list *l, struct sock *sk)
 {
 	write_lock(&l->lock);
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 57d509d77cb4..00d47bcf4d7d 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -205,21 +205,13 @@ static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &bnep_proto, kern);
+	sk = bt_sock_alloc(net, sock, &bnep_proto, protocol, GFP_ATOMIC, kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
 	sock->ops = &bnep_sock_ops;
-
 	sock->state = SS_UNCONNECTED;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-	sk->sk_state	= BT_OPEN;
-
 	bt_sock_link(&bnep_sk_list, sk);
 	return 0;
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1d249d839819..9c45586f5818 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2143,18 +2143,12 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &hci_sock_ops;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hci_sk_proto, kern);
+	sk = bt_sock_alloc(net, sock, &hci_sk_proto, protocol, GFP_ATOMIC,
+			   kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-
 	sock->state = SS_UNCONNECTED;
-	sk->sk_state = BT_OPEN;
 	sk->sk_destruct = hci_sock_destruct;
 
 	bt_sock_link(&hci_sk_list, sk);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 485348fcc030..9c9f3f704c7f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -739,21 +739,13 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &iso_proto, kern);
+	sk = bt_sock_alloc(net, sock, &iso_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = iso_sock_destruct;
 	sk->sk_sndtimeo = ISO_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	/* Set address type as public as default src address is BDADDR_ANY */
 	iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 947ca580bb9a..9ef936f27a6a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1858,21 +1858,13 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	struct sock *sk;
 	struct l2cap_chan *chan;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &l2cap_proto, kern);
+	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state = BT_OPEN;
-
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 4397e14ff560..b54e8a530f55 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -268,18 +268,16 @@ static struct proto rfcomm_proto = {
 	.obj_size	= sizeof(struct rfcomm_pinfo)
 };
 
-static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio, int kern)
+static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
+				      int proto, gfp_t prio, int kern)
 {
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &rfcomm_proto, kern);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	d = rfcomm_dlc_alloc(prio);
 	if (!d) {
 		sk_free(sk);
@@ -298,11 +296,6 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int
 	sk->sk_sndbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 	sk->sk_rcvbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	bt_sock_link(&rfcomm_sk_list, sk);
 
 	BT_DBG("sk %p", sk);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index cd1a27ac555d..bbf7072f5e80 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -503,21 +503,13 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &sco_proto, kern);
+	sk = bt_sock_alloc(net, sock, &sco_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = sco_sock_destruct;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
 	sco_pi(sk)->codec.id = BT_CODEC_CVSD;
 	sco_pi(sk)->codec.cid = 0xffff;
-- 
2.40.1

