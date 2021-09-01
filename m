Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0CC43216
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA4B61041
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241448AbhIAA1V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhIAA1V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 20:27:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F51C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:26:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u6so733907pfi.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e+JOgnu5aYfmjmTYg8pc1RJeuZkSzP18EUONRnYx5AM=;
        b=PEOeSwSggZvIC93e1GatwXAwzW9IwQfF7+4eNzlkjQYiQj5BMKOC3oM/rqHCkJukAX
         49CbZzK5g94+jXqY7ocvGJzI3Pk0sPq0f22imTIOokxG83I0BAG1FH5wJIoPlcweHtJN
         bEJSCxEALVPdfwOio43B0ZplsF0pySalyyoBq5NwRZzWcZX301vRezhHPrdcCNmgcPeD
         2Uq9GyU9WaJIraCD/nRpQ11h+HMGZjRY9Fs9e4gSOaTn32BRNur/6kgtXLmwV5pzMPWK
         HIiqKqKq7s71Dn+NFutGs81I+4XvyLe23vPpVKgGJiEQtuBnJ06EpND4e0wFJD0YA4Pw
         0S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+JOgnu5aYfmjmTYg8pc1RJeuZkSzP18EUONRnYx5AM=;
        b=OJrgaSXtRsK3pZOYElq8DrWvKN8LWwvhKXI1+guY0cETtazNlPSawGil4D0nU1VbXK
         QerguynWoHJVGCEVmtM+8uHle7Qsqlum7zEHhpcXQZ4mXbZ5ULS80xtNQukWRF758r4K
         uRmBvOIP461DfR/lnaZQh93b4qcDOhGgUvHn/NvWQ06/87PxtZNEG66h3D/ZajOVaZcC
         NxMSckqth/8MlICgbzWv3TgmnTpiB+JNHY2dEGYbvTsjkCBqxictoo3p6iQMSXlvtuUi
         /9fGJHGgOdauO91926usaf/PYwt6Iv3mf7nuJ+JrhuPcmYQhIWGf7bvGIlLaxQHVIPsW
         e7Cg==
X-Gm-Message-State: AOAM532yUONBKnL1u+vliCDODi5hkY9lAe9jl14ceeCKgsG5oBlavs2y
        3OtzgJqqXsJ1K6wsRopEWIEXp5obkls=
X-Google-Smtp-Source: ABdhPJzDdC5iom0Dn2rEXLov7Cd0fnPGPq432pCDWuL5i31YX2lTwAbw9Asb8IixHPIUX9yVe3iaAA==
X-Received: by 2002:aa7:83d8:0:b0:3ef:990f:5525 with SMTP id j24-20020aa783d8000000b003ef990f5525mr31053819pfn.29.1630455984451;
        Tue, 31 Aug 2021 17:26:24 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gm5sm4054655pjb.32.2021.08.31.17.26.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 17:26:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg
Date:   Tue, 31 Aug 2021 17:26:21 -0700
Message-Id: <20210901002621.414016-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901002621.414016-1-luiz.dentz@gmail.com>
References: <20210901002621.414016-1-luiz.dentz@gmail.com>
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
 net/bluetooth/rfcomm/core.c | 44 +++++++++++++++++++++++++++++------
 net/bluetooth/rfcomm/sock.c | 46 ++++++++-----------------------------
 2 files changed, 47 insertions(+), 43 deletions(-)

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
index 2c95bb58f901..5938af3e9936 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -575,46 +575,20 @@ static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	lock_sock(sk);
 
 	sent = bt_sock_wait_ready(sk, msg->msg_flags);
-	if (sent)
-		goto done;
-
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
+	skb = bt_skb_sendmmsg(sk, msg, len, d->mtu, RFCOMM_SKB_HEAD_RESERVE,
+			      RFCOMM_SKB_TAIL_RESERVE);
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

