Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68052C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Jun 2023 00:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbjFCAQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbjFCAQe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 20:16:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69517E43
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 17:16:33 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33d22754450so9865735ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Jun 2023 17:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685751392; x=1688343392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2h5Uz9y2Au1IFITBAReRPzwRwVGLLKM+YfA341gnQI=;
        b=sI2VzeTpr6Juposfy3AJ00NwXaQ+OJeAU4YyTdJBoUKHbSezvFUDnflpq9vEuueflX
         o0HLpJzTAA1XU9J5KyE9qsD7kzRzk7NYo2XoJyYwQp90ZuXvP+j3Q8PdtpQCRts5446b
         KHJMLfjNM5KiktaIs2+I8l5rWeu1JcZCHppiTlwKn7tL29YDa24EmDNt5GJrlLu3NN33
         gbAZZqa91JmHaSGpoJVO0r/atdkYiarbH6b3muDwjbvAFbRWSfOygPJje0+j5KrxEdYM
         5qoYuSV8zQhLXMeIA5iiyD7sIVL7I+GxsxljUnY4VYZIGCEOiKw57WFNXRRREJaCVRwr
         VTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685751392; x=1688343392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2h5Uz9y2Au1IFITBAReRPzwRwVGLLKM+YfA341gnQI=;
        b=e+zvb0vdI2lG++WgIjmDxZm/L5vHTVPZ7cYW5Z0DmwzMrvBWLfzXYWMhNeGXmtK8Nl
         suHccihmFb9rXQ6bulHtBhCAK4MPjmLPnlQdhP0n5Ina1k6o7ZSsmRMwJaQGw8Hixomt
         YRqydBMBElnJSIvhQfaqZv/1dQDcUiSoOyTOQMj0AvGjUU+N2cdMA+th3Vq0wzTSS5g3
         AnqtG8yj2n8g5RGuQRd69o1suesAumqE+lS/Mr/z3Pom0W74+6liXthB8LStliAj8H4z
         c02GKCJUm7MGeuVQpNqXYWaXUjKYoG8LTVjWMLZlD253aX189IWyhXvsHbMBpdzEk7Id
         wPSQ==
X-Gm-Message-State: AC+VfDyDDaA0DGHf3QPHyQwEG21SjKTwgEtRjRRQ7unHcpmo9tJNOnkP
        twPa8xXg3BylRL7KOL3dBgSiBU5SRZQ=
X-Google-Smtp-Source: ACHHUZ7fyOICW1ahs6yT1GAdEH06YPBvsS0AkKKLvDarZaipzZALX5Tdm0bnaqno8j/wMVm9p+vdtg==
X-Received: by 2002:a92:d34a:0:b0:33b:5fb3:6070 with SMTP id a10-20020a92d34a000000b0033b5fb36070mr10836713ilh.5.1685751391734;
        Fri, 02 Jun 2023 17:16:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78e13000000b0064fde7ae1ffsm1496267pfr.38.2023.06.02.17.16.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 17:16:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: Init sk_peer_* on bt_sock_alloc
Date:   Fri,  2 Jun 2023 17:16:27 -0700
Message-Id: <20230603001628.1886596-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603001628.1886596-1-luiz.dentz@gmail.com>
References: <20230603001628.1886596-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure peer information is always available via sock when using
bt_sock_alloc.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/af_bluetooth.c | 24 ++++++++++++++++++++++++
 net/bluetooth/hidp/sock.c    | 10 +---------
 net/bluetooth/l2cap_sock.c   | 19 -------------------
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 6035422e13da..647afb187147 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -157,6 +157,14 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	/* Init peer information so it can be properly monitored */
+	if (!kern) {
+		spin_lock(&sk->sk_peer_lock);
+		sk->sk_peer_pid  = get_pid(task_tgid(current));
+		sk->sk_peer_cred = get_current_cred();
+		spin_unlock(&sk->sk_peer_lock);
+	}
+
 	return sk;
 }
 EXPORT_SYMBOL(bt_sock_alloc);
@@ -179,6 +187,9 @@ EXPORT_SYMBOL(bt_sock_unlink);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
+	const struct cred *old_cred;
+	struct pid *old_pid;
+
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
@@ -191,6 +202,19 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
 
+	/* Copy credentials from parent since for incoming connections the
+	 * socket is allocated by the kernel.
+	 */
+	spin_lock(&sk->sk_peer_lock);
+	old_pid = sk->sk_peer_pid;
+	old_cred = sk->sk_peer_cred;
+	sk->sk_peer_pid = get_pid(parent->sk_peer_pid);
+	sk->sk_peer_cred = get_cred(parent->sk_peer_cred);
+	spin_unlock(&sk->sk_peer_lock);
+
+	put_pid(old_pid);
+	put_cred(old_cred);
+
 	if (bh)
 		bh_unlock_sock(sk);
 	else
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 369ed92dac99..c93aaeb3a3fa 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -256,21 +256,13 @@ static int hidp_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hidp_proto, kern);
+	sk = bt_sock_alloc(net, sock, &hidp_proto, protocol, GFP_ATOMIC, kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
 	sock->ops = &hidp_sock_ops;
-
 	sock->state = SS_UNCONNECTED;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-	sk->sk_state	= BT_OPEN;
-
 	bt_sock_link(&hidp_sk_list, sk);
 
 	return 0;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9ef936f27a6a..3bdfc3f1e73d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -178,21 +178,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	return err;
 }
 
-static void l2cap_sock_init_pid(struct sock *sk)
-{
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-
-	/* Only L2CAP_MODE_EXT_FLOWCTL ever need to access the PID in order to
-	 * group the channels being requested.
-	 */
-	if (chan->mode != L2CAP_MODE_EXT_FLOWCTL)
-		return;
-
-	spin_lock(&sk->sk_peer_lock);
-	sk->sk_peer_pid = get_pid(task_tgid(current));
-	spin_unlock(&sk->sk_peer_lock);
-}
-
 static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 			      int alen, int flags)
 {
@@ -268,8 +253,6 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
-	l2cap_sock_init_pid(sk);
-
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
@@ -325,8 +308,6 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	l2cap_sock_init_pid(sk);
-
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 
-- 
2.40.1

