Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F6C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 01:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DFA60FD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 01:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhHaBQ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 21:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbhHaBQ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 21:16:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C640C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 18:15:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id r13so13234637pff.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BP8RayrDpeexAEqETs3zixs0Rar9P3UtLvTZ9Wt8oyU=;
        b=CaqCD/4urLQk73oFHbh6NlqLdw007yaFQON2RcuxIp/8OJn+B3dFzALhXYyUSrDmMD
         Swl1AAxSqLsqHIqJxotPN2liXxYy8/9zNx+XM3GlSVCzF+xCDM4U9fFQOeOu+78u+B2L
         hsMDB77PqNP9fwAtGaG9THlxEVK4h3gVX51r/H+QRoI9+nefu/N6DWOnHZhyv0OWdJR/
         QbAEd5hoBruZVajyCELlAu/5W+gfj+IVqi5vNyFh5j4Z+46SziEpbOQPT6iDosC3Y/8V
         mX7WTSEooboZl+XMa+gVkWUmrucg9MEbQB3jN9/GhY2xndqIT8KhmvXQShC3AWKPYDlX
         6l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BP8RayrDpeexAEqETs3zixs0Rar9P3UtLvTZ9Wt8oyU=;
        b=hHzBAZbdoSDwWfLwyzN5WPy/ffjJ3a6uDE6VPZUBbSp3Jnfa+GXN4t4i6ns97DvvEE
         iQpz91xTvzdevQE8uauZLqNMTnAQuqyFjMnF3iCs9C9CNI0MGGcp+vuk54KiS3GeiVCk
         RWNqrlMpSv0H2tnrskb/K7qM0xkdctUGDh+wcEXmNvJpCJJk8oiJLL3Eb978Yb74hFeQ
         NOXgkN8mpqd8i0h+TawwpTV/jDMdERgS310rK+RhdZyGf9tyPd/a8vN7E2MD0sWP9IKC
         oLYjKYXNg+uwqyRytBkJ5PkrkP6gkXPzWWq+bFjRYH6vtN8v9gdukDr8BsovZ1JgCwKQ
         lYzw==
X-Gm-Message-State: AOAM531P/Tomds3d7KXpAFvNIEUW34elf6tk+joBNDXaPW4p0J1YsFOO
        pPCUJ3iNP3FQBlCPQbvRtzPyN4Wp0Wc=
X-Google-Smtp-Source: ABdhPJy+q2P5W6DmI0sjpvtRbfT9nJIdDtq4vifPEGI+MBXqt6unNc9P3/BwxxxlNZ6Ldbm5nwaoqg==
X-Received: by 2002:a05:6a00:ac8:b029:320:a6bb:880d with SMTP id c8-20020a056a000ac8b0290320a6bb880dmr26031103pfl.41.1630372531280;
        Mon, 30 Aug 2021 18:15:31 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g18sm5020750pge.33.2021.08.30.18.15.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 18:15:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 3/4] Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg
Date:   Mon, 30 Aug 2021 18:15:27 -0700
Message-Id: <20210831011528.225877-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831011528.225877-1-luiz.dentz@gmail.com>
References: <20210831011528.225877-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_skb_sendmsg instead of allocating a different
buffer to be used with memcpy_from_msg which cause one extra copy.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b62c91c627e2..8a262fbc8aa8 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -280,27 +280,19 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 	return err;
 }
 
-static int sco_send_frame(struct sock *sk, void *buf, int len,
-			  unsigned int msg_flags)
+static int sco_send_frame(struct sock *sk, struct sk_buff *skb)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
-	struct sk_buff *skb;
-	int err;
 
 	/* Check outgoing MTU */
-	if (len > conn->mtu)
+	if (skb->len > conn->mtu)
 		return -EINVAL;
 
-	BT_DBG("sk %p len %d", sk, len);
+	BT_DBG("sk %p len %d", sk, skb->len);
 
-	skb = bt_skb_send_alloc(sk, len, msg_flags & MSG_DONTWAIT, &err);
-	if (!skb)
-		return err;
-
-	memcpy(skb_put(skb, len), buf, len);
 	hci_send_sco(conn->hcon, skb);
 
-	return len;
+	return skb->len;
 }
 
 static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
@@ -722,7 +714,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
 	struct sock *sk = sock->sk;
-	void *buf;
+	struct sk_buff *skb;
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -734,24 +726,20 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (memcpy_from_msg(buf, msg, len)) {
-		kfree(buf);
-		return -EFAULT;
-	}
+	skb = bt_skb_sendmsg(sk, msg, len, 0);
+	if (IS_ERR_OR_NULL(skb))
+		return PTR_ERR(skb);
 
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECTED)
-		err = sco_send_frame(sk, buf, len, msg->msg_flags);
+		err = sco_send_frame(sk, skb);
 	else
 		err = -ENOTCONN;
 
 	release_sock(sk);
-	kfree(buf);
+	if (err)
+		kfree_skb(skb);
 	return err;
 }
 
-- 
2.31.1

