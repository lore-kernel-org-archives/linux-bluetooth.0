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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1445161029
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 20:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhIOUaS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhIOUaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 16:30:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D78C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 13:28:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so3876798pgr.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qX2dfn2x26WX07e7xdzg2ywb6Njzmd8j8daHrFRGUlY=;
        b=Wqf/PXxge+TVMeKGeS6LAGz2Atvv7G1RmscnrMtm9WaXOieGs3+hGQ1AfY5NDKhIkg
         Lcd1uIExQuoATVvR4SJuCWcuLqQnGt6JMIzJSy6+8GgAmHpFtalAemC2LSlkJ2ah8TrN
         Nbydl+BylgnhBJjHeKQ+MUSEokldiyKwswMsanYuZPRAHcW+/iOMcXwZMckWDLoR/BLt
         z8LTSrOg3ACdhiM1ZTMvGx07/oigBWK1WWd8aNIhUWzWfOUhLE8TLMYhuBKUHXNCxeZL
         1iYZ67ui0rl7mnJ+M496MlIw4hSP3mGhPqK8FLJRIJsPYHKx3wOcb/j6S8439VZJW232
         bgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qX2dfn2x26WX07e7xdzg2ywb6Njzmd8j8daHrFRGUlY=;
        b=WWKE8D37+r4ercnl+MXltlgToO5YZoBT6ZcrTngo1Wx9mDhnzRGxWxxR9G4f/t9kdo
         2ag0llMUNQDp09vWM/z6JzDLZkSqzq2CAJRo9YGZbC4mQuMhufd1iw9kD9ZPzoNxsi8d
         4/feTKl8s6ktdFFc54M/uVnP2LPkhiBZ6CczJYuYZ84j62zp5415EmntpWyqkZt8KbN7
         Sb186+Y2bCn5wNgzDx9Cl9PYrPGIQlDrp22ad0Z37PbaSZ07dtVztwNez/EWvqJWLez3
         IWM2/I9BFZR8KxZH4k35sFTvbp7IIEaQzAN9+R69yAazkLsA/Dn/Ive5YxNfsMhetmx1
         m3Og==
X-Gm-Message-State: AOAM532nF963FiHzTYfazB9W5a5hl7bPSFaQXWxy1VwjDenuPapfLiMn
        M9c+13Na938EqXfoL+4l+I67sv7D3Pg=
X-Google-Smtp-Source: ABdhPJzDNjC33h4H4/jaej3ymFTIXn0t1boUsQ2T7gGw9dNhOqDZO3TAP4EOrWm2xcVEDNDOwdi8Sg==
X-Received: by 2002:a63:bf07:: with SMTP id v7mr1413576pgf.475.1631737738087;
        Wed, 15 Sep 2021 13:28:58 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 141sm799312pgf.46.2021.09.15.13.28.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:28:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix passing NULL to PTR_ERR
Date:   Wed, 15 Sep 2021 13:28:56 -0700
Message-Id: <20210915202856.4030398-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915202856.4030398-1-luiz.dentz@gmail.com>
References: <20210915202856.4030398-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Passing NULL to PTR_ERR will result in 0 (success), also since the likes of
bt_skb_sendmsg does never return NULL it is safe to replace the instances of
IS_ERR_OR_NULL with IS_ERR when checking its return.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 2 +-
 net/bluetooth/rfcomm/sock.c       | 2 +-
 net/bluetooth/sco.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index aa221c1a27c6..3271870fd85e 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -496,7 +496,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 		struct sk_buff *tmp;
 
 		tmp = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
-		if (IS_ERR_OR_NULL(tmp)) {
+		if (IS_ERR(tmp)) {
 			kfree_skb(skb);
 			return tmp;
 		}
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 5938af3e9936..4bf4ea6cbb5e 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -583,7 +583,7 @@ static int rfcomm_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	skb = bt_skb_sendmmsg(sk, msg, len, d->mtu, RFCOMM_SKB_HEAD_RESERVE,
 			      RFCOMM_SKB_TAIL_RESERVE);
-	if (IS_ERR_OR_NULL(skb))
+	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	sent = rfcomm_dlc_send(d, skb);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 446f871f11ed..f51399d1b9cb 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -733,7 +733,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		return -EOPNOTSUPP;
 
 	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
-	if (IS_ERR_OR_NULL(skb))
+	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	lock_sock(sk);
-- 
2.31.1

