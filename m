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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D6CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C084660C51
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhICW2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhICW2h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 18:28:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF262C061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 15:27:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so370955plp.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5IpJP9B7ZdVTX0IhB74qBI/8P/SQ3SVQ67PrRn8dkQE=;
        b=p10hlOr6qEjmH0FU7i/A4ISvelnl7CFXhq6omjySab7b5A5U8vI9cpI82kS7xrmEhH
         PF6E7PClUB2d1Np6dWh794fHz2f6Hwqxra3eIv8xz2RLdDb7PbGxsXol0qV8APOs0MBV
         4JQDl0nID1GyoTpW2S9mcPSiaE9reelufJmSZVvowSjvUIMkKRMvXBiXsM7SaQKAOBng
         MXM2YrdyTQyiAVv4ET5Geb5KePAdUGVDHmEQ4XjMjO8u3WVh2i1q7BunXldMTLpe6fCC
         gb6qTsjOMMW387Na0P60Nv+EBV2xcMfGC0/p7F8fJVWUzkVslQbANJ0D5lRWY7rDuDxa
         JPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5IpJP9B7ZdVTX0IhB74qBI/8P/SQ3SVQ67PrRn8dkQE=;
        b=VvC5eP6+3NutzI+TEO99LkX2oICwihyX9Gz9vfPcXnOqveTSfyaGyyX+XDlSLyMr46
         Fc3CntCJL0ZXIXZSDX8Cju1bVqNIAFEAYm26g1Qx7GIPtqkfbXJ2uTC6HY+UFmbAtWvV
         Kh3hMwjiXFHzEYhTC3wzUvDp2rKQBDoEKismUG6vXleTVAHKTkUgdDN/gN2fglJFAUBP
         WllCfvO7OGZJopSrJWiL8kNWZGZWwegTNyDlxje3s850unCwHztDFqHdnr9zfNbdruk9
         sscuOtenp4diyYcW4J4A9aWS2owQ9W7CGRGDeLrnt4tvSptRJWg7wGvKeK3Fy1zeI5Jh
         w2Wg==
X-Gm-Message-State: AOAM530aqQU98zBe/0SuTz8CSga3qGxSw6qAQ7OqmXt6PrU5e+9XvZiP
        1qqMTPXhWywyuhWk1w34fKTPgVBYXuk=
X-Google-Smtp-Source: ABdhPJzB9hC4t+bglI5xsSFnqyz1b3nOSV3bsgBHl3hmyJiI0RSGMdcHbo+uIjFPcjTZBx9rxXpSNQ==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr1064579pjb.53.1630708055597;
        Fri, 03 Sep 2021 15:27:35 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x4sm225796pjq.20.2021.09.03.15.27.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 15:27:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/4] Bluetooth: Add bt_skb_sendmsg helper
Date:   Fri,  3 Sep 2021 15:27:29 -0700
Message-Id: <20210903222732.1472560-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_skb_sendmsg helps takes care of allocation the skb and copying the
the contents of msg over to the skb while checking for possible errors
so it should be safe to call it without holding lock_sock.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..aa6f8fe897ce 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -420,6 +420,34 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
 	return NULL;
 }
 
+/* Shall not be called with lock_sock held */
+static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
+					     struct msghdr *msg,
+					     size_t len, size_t mtu,
+					     size_t headroom, size_t tailroom)
+{
+	struct sk_buff *skb;
+	size_t size = min_t(size_t, len, mtu);
+	int err;
+
+	skb = bt_skb_send_alloc(sk, size + headroom + tailroom,
+				msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
+		return ERR_PTR(err);
+
+	skb_reserve(skb, headroom);
+	skb_tailroom_reserve(skb, mtu, tailroom);
+
+	if (!copy_from_iter_full(skb_put(skb, size), size, &msg->msg_iter)) {
+		kfree_skb(skb);
+		return ERR_PTR(-EFAULT);
+	}
+
+	skb->priority = sk->sk_priority;
+
+	return skb;
+}
+
 int bt_to_errno(u16 code);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
-- 
2.31.1

