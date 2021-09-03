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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F25C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DF260C51
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhICW2j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 18:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhICW2j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 18:28:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922AC061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 15:27:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso455699pjh.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cLcSl8nMUeEmOer03hxjSfU3oPUHGSQDxIvzfp/OHI0=;
        b=jc59hr3Z8Eif/3ubpcV+GLSd+Vi/XpmV7vL/8X7XFil8tzQIGnVZWFj3BeybSakOsF
         QtyYUYSwRCfTSYyuV/61oC+9Q41PoSL1xQL+XaDNNJe89B89ycDr81QMkYlzI997r+Ri
         dwPhaV0vGA27xbdYDUi42XN+LrOhYSzZp2dDitCFaS6Zdnfad22Na0OZMTFtIthpneaa
         8RLp0eI5pqknfUEd/0apMfajtjSFyqesN+jitgGkayRsHwkz+/lxEVWWiJ2i3U8VfaVk
         3Xjwn/atYvur8MvM16epSkCzggGQvrtBZ6J12+XDfVtA/m/4EUtGd3J0qeui+OzsCVx3
         ZtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLcSl8nMUeEmOer03hxjSfU3oPUHGSQDxIvzfp/OHI0=;
        b=JbfCvyZthpW00E+97l8qWAAdUQbTsyiv5gMawzOEGAGtKeO5ae0lF/13jcN7EiHecU
         xND4LmikJ2Gk2CE6RSl5V+nt2q4bCI0XW5EboTYmkeBTd6lcKEFu8HdjpzvU5ccATNGX
         jE8fwdYgeuYZ+lgNYXGdWH1S+FW/VDG+zbIL4yZ5VEOsuFvpeH0+Gd548DOsVEJ6uvyV
         Aud7wMcC/D9cs90Dga5+jl6VE+5yOnmrcDcTUNVGys++opi/w5pC+Px642/yQe5QH+1B
         km8AWX4o2f2FK3EvZeX/3fGN49eOLNvdtAKiv5zozBtteEUA6H1GhWq87lF9wnmKJGYF
         VW7A==
X-Gm-Message-State: AOAM533ZUg1kYMo3SZWR8ExyQSCgP/prEwcmXVg4PUJIlel3+7yLO9gA
        0x7v91JX4iIAKig7n7YYYGjZj2RX3jE=
X-Google-Smtp-Source: ABdhPJxHk3cT1Aj9Z7b7dTbQkr/0UH7CkQJTdNHl3IyWBVcWM6y+iye1Eq64N56/raB1nCqsxj45nQ==
X-Received: by 2002:a17:90a:ce8e:: with SMTP id g14mr1108561pju.241.1630708058019;
        Fri, 03 Sep 2021 15:27:38 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x4sm225796pjq.20.2021.09.03.15.27.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 15:27:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg
Date:   Fri,  3 Sep 2021 15:27:32 -0700
Message-Id: <20210903222732.1472560-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903222732.1472560-1-luiz.dentz@gmail.com>
References: <20210903222732.1472560-1-luiz.dentz@gmail.com>
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
 net/bluetooth/rfcomm/core.c | 50 +++++++++++++++++++++++++++++++------
 net/bluetooth/rfcomm/sock.c | 46 ++++++++--------------------------
 2 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f2bacb464ccf..7324764384b6 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -549,22 +549,58 @@ struct rfcomm_dlc *rfcomm_dlc_exists(bdaddr_t *src, bdaddr_t *dst, u8 channel)
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
+	unsigned long flags;
+	struct sk_buff *frag, *next;
+	int len;
 
 	if (d->state != BT_CONNECTED)
 		return -ENOTCONN;
 
-	BT_DBG("dlc %p mtu %d len %d", d, d->mtu, len);
+	frag = skb_shinfo(skb)->frag_list;
+	skb_shinfo(skb)->frag_list = NULL;
 
-	if (len > d->mtu)
-		return -EINVAL;
+	/* Queue all fragments atomically. */
+	spin_lock_irqsave(&d->tx_queue.lock, flags);
 
-	rfcomm_make_uih(skb, d->addr);
-	skb_queue_tail(&d->tx_queue, skb);
+	len = rfcomm_dlc_send_frag(d, skb);
+	if (len < 0 || !frag)
+		goto unlock;
+
+	for (; frag; frag = next) {
+		int ret;
+
+		next = frag->next;
+
+		ret = rfcomm_dlc_send_frag(d, frag);
+		if (ret < 0) {
+			kfree_skb(frag);
+			goto unlock;
+		}
+
+		len += ret;
+	}
+
+unlock:
+	spin_unlock_irqrestore(&d->tx_queue.lock, flags);
 
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

