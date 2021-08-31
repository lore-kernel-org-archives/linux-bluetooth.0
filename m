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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CBFC4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 01:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAE46103C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 01:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhHaBQ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 21:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbhHaBQ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 21:16:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF78C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 18:15:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q21so9621726plq.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 18:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8LQ0W8o/Cd47UkUjFVIl5AJg9GhqnaY0ikl8hrCuAqc=;
        b=f8JE2OQvSgOnXb35wjP4q//QYuedNsLc26DcvqE8zoCPzosLhlXHIN7myO+3hITE87
         jgz2Hg3WvuocpwyzmRWpQLrVmp7pI+fMb/KShKuIdSTfCWJSESmSAb4mFdVGPm9QbJtD
         aVIPXhbLeKX4hIWViQNOL7CkwCrbs7r9Gd7UuPbi5zVBjmCSUdXSF3vERTv+XHgkYGTv
         V34nfxpruxT3qIzui/RBZT5ndIGAr546OX1KWpYVLKmrV/aq/wjMbsqljUzUwzURChxB
         2+OFqE/k4lr/FrNoJ7gTVdl+mYKJvLGKFvh385rZdxZ4g/jhZVnAtedtihqiILkIYRWs
         aINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LQ0W8o/Cd47UkUjFVIl5AJg9GhqnaY0ikl8hrCuAqc=;
        b=LqSAHSm51hyq64n+RJNX3w0gZL6hDvVCLTV3MAPYK+jwaBimulF+WSuN+Kr5ZC4JcX
         lO5H2gJYB3MZb9FeOeIQtGU0Cyq+xzEdmoIx9aABCAlovYbF6DBCBLdaMxm8Luw0rqeI
         6H7FkPOQuTvbr06GehWm4In859+/P3Z39slQlsvVzz52gXQufUCv0hzYhH5zL4vUJOPu
         wDrFvKdMYrlooWZQ30odCQpGst9DrC1ixHQgqlKh1OJcwG6H+bo+8+tdytdlWNKbzEUF
         DApJv1OB+x/EygggXzzidrAzWpWJsMdzRxurj+4679fUBkg0qh/NK2iTngNJ7TxEPa0e
         PA0w==
X-Gm-Message-State: AOAM5302hqMWKbUgfdeLtM3LRTy2DOPCzTEOpZhUxXRiWxwNtlXNuDhn
        //nzI/9mOs9Xpb3qsSfX3k8O29dkJkk=
X-Google-Smtp-Source: ABdhPJxcCBgWwT3bHNzanUYC4k06pRzMF2KpzthvCpdosqow/FF4Jyp8ICDj+eZhebw4MWerMjkTIQ==
X-Received: by 2002:a17:90a:43c2:: with SMTP id r60mr2247918pjg.52.1630372532283;
        Mon, 30 Aug 2021 18:15:32 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g18sm5020750pge.33.2021.08.30.18.15.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 18:15:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 4/4] Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg
Date:   Mon, 30 Aug 2021 18:15:28 -0700
Message-Id: <20210831011528.225877-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831011528.225877-1-luiz.dentz@gmail.com>
References: <20210831011528.225877-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_skb_sendmmsg instead using memcpy_from_msg which
is not considered safe to be used when lock_sock is held.

Also make rfcomm_dlc_send handle skb with fragments and queue them all
atomically.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/core.c | 44 ++++++++++++++++++++++++++++------
 net/bluetooth/rfcomm/sock.c | 48 ++++++++++---------------------------
 2 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f2bacb464ccf..361a60b4a670 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -549,22 +549,52 @@ struct rfcomm_dlc *rfcomm_dlc_exists(bdaddr_t *src, bdaddr_t *dst, u8 channel)
 	return dlc;
 }
 
+static int rfcomm_dlc_send_frag(struct rfcomm_dlc *d, struct sk_buff *frag)
+{
+	int len = frag->len;
+
+	BT_DBG("dlc %p mtu %d len %d", d, d->mtu, len);
+
+	if (len > d->mtu)
+		return -EINVAL;
+
+	rfcomm_make_uih(frag, d->addr);
+	__skb_queue_tail(&d->tx_queue, frag);
+
+	return len;
+}
+
 int rfcomm_dlc_send(struct rfcomm_dlc *d, struct sk_buff *skb)
 {
-	int len = skb->len;
+	struct sk_buff *frag;
+	int len;
 
 	if (d->state != BT_CONNECTED)
 		return -ENOTCONN;
 
-	BT_DBG("dlc %p mtu %d len %d", d, d->mtu, len);
+	/* Queue all fragments atomically. */
+	spin_lock_bh(&d->tx_queue.lock);
 
-	if (len > d->mtu)
-		return -EINVAL;
+	len = rfcomm_dlc_send_frag(d, skb);
+	if (len < 0)
+		goto unlock;
 
-	rfcomm_make_uih(skb, d->addr);
-	skb_queue_tail(&d->tx_queue, skb);
+	skb_walk_frags(skb, frag) {
+		int ret;
+
+		ret = rfcomm_dlc_send_frag(d, frag);
+		if (ret < 0)
+			break;
+
+		len += ret;
+	}
+
+	skb_shinfo(skb)->frag_list = NULL;
+
+unlock:
+	spin_unlock_bh(&d->tx_queue.lock);
 
-	if (!test_bit(RFCOMM_TX_THROTTLED, &d->flags))
+	if (len > 0 && !test_bit(RFCOMM_TX_THROTTLED, &d->flags))
 		rfcomm_schedule();
 	return len;
 }
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 2c95bb58f901..9dec2ff510be 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -558,6 +558,7 @@ static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 {
 	struct sock *sk = sock->sk;
 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
+	size_t size;
 	struct sk_buff *skb;
 	int sent;
 
@@ -574,47 +575,22 @@ static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
-	sent = bt_sock_wait_ready(sk, msg->msg_flags);
-	if (sent)
-		goto done;
+	size = min_t(size_t, len, d->mtu);
 
-	while (len) {
-		size_t size = min_t(size_t, len, d->mtu);
-		int err;
-
-		skb = sock_alloc_send_skb(sk, size + RFCOMM_SKB_RESERVE,
-				msg->msg_flags & MSG_DONTWAIT, &err);
-		if (!skb) {
-			if (sent == 0)
-				sent = err;
-			break;
-		}
-		skb_reserve(skb, RFCOMM_SKB_HEAD_RESERVE);
-
-		err = memcpy_from_msg(skb_put(skb, size), msg, size);
-		if (err) {
-			kfree_skb(skb);
-			if (sent == 0)
-				sent = err;
-			break;
-		}
+	sent = bt_sock_wait_ready(sk, msg->msg_flags);
 
-		skb->priority = sk->sk_priority;
+	release_sock(sk);
 
-		err = rfcomm_dlc_send(d, skb);
-		if (err < 0) {
-			kfree_skb(skb);
-			if (sent == 0)
-				sent = err;
-			break;
-		}
+	if (sent)
+		return sent;
 
-		sent += size;
-		len  -= size;
-	}
+	skb = bt_skb_sendmmsg(sk, msg, len, d->mtu, RFCOMM_SKB_RESERVE);
+	if (IS_ERR_OR_NULL(skb))
+		return PTR_ERR(skb);
 
-done:
-	release_sock(sk);
+	sent = rfcomm_dlc_send(d, skb);
+	if (sent < 0)
+		kfree_skb(skb);
 
 	return sent;
 }
-- 
2.31.1

