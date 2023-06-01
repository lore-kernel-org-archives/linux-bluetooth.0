Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A423FC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 23:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjFAXjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFAXjI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 19:39:08 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D3180
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 16:39:06 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6af78ce91b1so1390418a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685662745; x=1688254745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9VVfw7kJjQhzYFof6Iy1rBMmvCHqJISZhgceoymPQI=;
        b=LdtRPd8GGAhkr/c75HXYfHv+kHoLGewq8Nbl0qCqKMUvQPJyJ5OmZOfjIezIM8VXx9
         h39nctWlT+taC+XQw+VC8n8j1ZhULCvFkPucKO7tREXAjZFMUmF9oBDVmlVc9sApC6eZ
         iDWkwv2tMcjE4NCdmXR6YpLhQSW/FVQ0QsDzL3YrUKxBLh3U+Hm1FRBAMmCYcbVLEeOz
         soITRMXvOvNY7MwP9YlCrzn4BJ/oMoIn2Wfj8hrbsTtyLcOkGqqj6wYdtNqijvIVj6nk
         seERzdEmr3sqZkRlbGEJcpi/55SVu7tQmya3vcxTYwhR0qh0jZsQ/wofNbeumkjWl8YS
         yMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662745; x=1688254745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9VVfw7kJjQhzYFof6Iy1rBMmvCHqJISZhgceoymPQI=;
        b=lw7w7PrcJeZ7ehxXCGb0e6zO3mjEpa+ilNpQ3sERnJMir+aizClKcyg7YI7MSJIVBf
         GKF6MVxbVcjdYXdyyd5zbhRUpwtopUqVHLecN9Uy608Iy4tS5ZDs1OW9fqHjbSsR5ZXw
         M/bvK2yy6JMszuNXKqZitkn52cU3q90D/r/r6Mx7DblBSQPU4aXJZ5jG3J/zg3s/mzLQ
         aPmXoNZbT4ovPLFAkCKISGE14vb+P0r9t1EhPXoHC461vzgF9yi3d70xZyic6mPDr4gC
         uLKJ0Rf/SKHDwlpWAR1zgX8agl4MlZTPevjL/pRlchgK2dJZlaJpCBmmOYWS11VM+dPt
         2ZUg==
X-Gm-Message-State: AC+VfDw2FgvklF/ZWmXa+RdzX5fEk1bkaHv/gLIjZqB3IbWvJYQ4umxp
        2ZvdUS2Rf2Brng4zyTf2qISeuzuMzcE=
X-Google-Smtp-Source: ACHHUZ5rQHJxDV8k4Cd+jm5boYrrZXDtP2pU/4J9izQKIH+24CQj0SxN5xEf9dYBxzmCOj6pX0SKwA==
X-Received: by 2002:a05:6830:154e:b0:6af:6f25:48c with SMTP id l14-20020a056830154e00b006af6f25048cmr972870otp.3.1685662745258;
        Thu, 01 Jun 2023 16:39:05 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b00652f5bd894esm78459pfa.177.2023.06.01.16.39.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:39:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Init sk_peer_* on bt_sock_alloc
Date:   Thu,  1 Jun 2023 16:39:00 -0700
Message-Id: <20230601233901.1448729-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601233901.1448729-1-luiz.dentz@gmail.com>
References: <20230601233901.1448729-1-luiz.dentz@gmail.com>
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
 net/bluetooth/af_bluetooth.c | 14 ++++++++++++++
 net/bluetooth/hidp/sock.c    | 10 +---------
 net/bluetooth/l2cap_sock.c   | 19 -------------------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 6035422e13da..eae346045a23 100644
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
@@ -191,6 +199,12 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
 
+	/* Copy credentials from parent since for incoming connections the
+	 * socket is allocated by the kernel.
+	 */
+	sk->sk_peer_pid = parent->sk_peer_pid;
+	sk->sk_peer_cred = parent->sk_peer_cred;
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

