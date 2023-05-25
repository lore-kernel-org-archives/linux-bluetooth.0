Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E9C7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 23:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbjEYXqv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbjEYXqt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 19:46:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435E13D
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 16:46:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d3fdcadb8so242563b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685058407; x=1687650407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCrwrwcO2rqGVk4TdW0IJTTdQ3wW4X9hR3opm81SZgQ=;
        b=WbjWXHbswZlnJ53jCzWBDJCT9jmzakpMq0ekshVWIzpRbY82B7xzwgs13Dzihjr9kM
         M88JFNJyjPvnTJQgJK2h2oZ1LUM9RjsfJLcNRap5eYotx/9MDTXJnzAIMoIZGMmcrSu+
         tQbPSU0xORo+IaAqVrNLf60vs+SrParyH2/l2byUWwX5WzoNUdxowOlB28527VbUZ5Lz
         Mb1B/VRkCoah0Zive5hphj9vKsPQYeXHJqUgPR3x3hpnsszDntKF7BZoDWm12acdD8Jd
         LAoUyZD4eCEN8Eu+W48T/sGCxubdszIGH1LS9npthdh4JjRYmbqOe8bGEHISBTrpuJHJ
         yJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685058407; x=1687650407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCrwrwcO2rqGVk4TdW0IJTTdQ3wW4X9hR3opm81SZgQ=;
        b=QnTKuQFVZZguLwk58JpU8ZSisIN9dl/IODM35xrY44TjyYPyRvz1L50h4L/19gNsSH
         lv9x3r6jo+0ylEvJp+pi/6ipYKrwyncYVqCOy1J3+Mx7S4FJOw4bhSagULaMA46wSweU
         Hpn0YbUTSMpND4auD+H2mKaaR/Nc9MCe9tDF+YBo7iEYUY5Bs1+mFgfAs8rJNEKnsT/h
         LGkJsIErdaTRSf7xUywQ+UIMb0M9TA91RmP2Pt7p+hhC4FKzuLoM8rtLM65vQFd93o0n
         AE3HNOaHHaGFtoKs5W3JWA7QAlVTkHTXUp8AXn1wT2ZqdqoHVqkETCvPZ1lLDVwQZlwN
         4wJQ==
X-Gm-Message-State: AC+VfDxnYLN4waG7QSA/bxeysM3NzjU7Ef1YMwZqW8FlInKaslj/JXJT
        HnFuXdOSPWBjPLghZlsOufYJCuKoaFY=
X-Google-Smtp-Source: ACHHUZ6qST7NsiT8m6Jj6MW2gePjYxLSlG6TVMKGd8YqOngI5MZ7iqXaZC/wDJIUZWNz7VPJBHu8Xw==
X-Received: by 2002:a05:6a00:1a12:b0:64d:742f:f590 with SMTP id g18-20020a056a001a1200b0064d742ff590mr665861pfv.8.1685058406768;
        Thu, 25 May 2023 16:46:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n23-20020aa79057000000b0064867dc8719sm1626930pfo.118.2023.05.25.16.46.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 16:46:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Init sk_peer_* on bt_sock_alloc
Date:   Thu, 25 May 2023 16:46:42 -0700
Message-Id: <20230525234643.3597907-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525234643.3597907-1-luiz.dentz@gmail.com>
References: <20230525234643.3597907-1-luiz.dentz@gmail.com>
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
 net/bluetooth/af_bluetooth.c |  8 ++++++++
 net/bluetooth/hidp/sock.c    | 10 +---------
 net/bluetooth/l2cap_sock.c   | 19 -------------------
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 6035422e13da..ba1d01d82f1c 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -157,6 +157,14 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
+	if (!kern) {
+		/* Init peer information so it can be properly monitored */
+		spin_lock(&sk->sk_peer_lock);
+		sk->sk_peer_pid  = get_pid(task_tgid(current));
+		sk->sk_peer_cred = get_current_cred();
+		spin_unlock(&sk->sk_peer_lock);
+	}
+
 	return sk;
 }
 EXPORT_SYMBOL(bt_sock_alloc);
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
index d3de79b9a70b..f419e95fdcfc 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -177,21 +177,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
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
@@ -267,8 +252,6 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
-	l2cap_sock_init_pid(sk);
-
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
@@ -324,8 +307,6 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	l2cap_sock_init_pid(sk);
-
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 
-- 
2.40.1

