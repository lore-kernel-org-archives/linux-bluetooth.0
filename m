Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45251C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C7861212
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhIPUMP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbhIPUMN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 16:12:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E1BC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:10:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k24so7264322pgh.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rpv1FaQ9oQ4VD4XcDBX4LDce+ctNlKY97mbkm3KNwuc=;
        b=f1Q8Ci3o5vkHflWM42UBXmfek31N0CGnRhSD3BZJO6I/1LQKviI/9cPLMFMm9j3Bu5
         8yBX6lBHzuqp0Q/swEut978gbZZH43qOKAnT+0jPQ9y4BW5zKeyMgRU2X0C461eCI6r5
         AOsa2OxgbONDNExEHqAJZi5+bx1hN3eC6kqlDl6M4frjmDqQw+rWDPM2Y+dE7VszTVX4
         Du3q8iMRKWWQ1g0ZIUgc4tfYlRFe2nBi+TeimItv33ePgZv1s3LJuT2Zr4dpsPiUciB+
         iT5atLeKQI6NkBFjK8QsYxp8Vz8VKf3ccPoEFrthq5JtvV0fCrIPktd452a01M/UNJBK
         VKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpv1FaQ9oQ4VD4XcDBX4LDce+ctNlKY97mbkm3KNwuc=;
        b=glyXKqStwC3QYl6HsYI9/wP2eEwAJ/EwejVY/0Wqvb7zCH1BXd2sxRuUBRlWTIDBVa
         /M30MJn9BopbL7ZyHrqHoXw5rELBjJFBvCqgZwQ88HBCDnhq0vZMC58dCMADbeuj/aCu
         2Vk+0tKNPwZLxWBuHY1Se6AKXz9O4INLwbKB1wSjJDWvo+eVZ8Y9HSVdP25hVjsYIbQJ
         AqTCHsHYlN7jTps7CxfYkwx3sENKSPcPTpBVfN57bclHZ7z4Zz7pgF5QxIFHABXljk1R
         /AlFEss3DqIup9r/YMuAUa+5yjkm/HFaaMieLpP4720GnIsuwI22y1jtpJBMr8RYa/YX
         xf7w==
X-Gm-Message-State: AOAM530QAVTZCMHAD+Rm1O8mewQphsKcLqwqP5RctLktCL//JnqwN3bu
        nznQb8G+Odbc8hdygcjWTqyi13tUcng=
X-Google-Smtp-Source: ABdhPJxLwFP6AsZ28y1JJGjdD99aguXeWpB+ncKisnltw/Dp1P2w5ml7dzSb7ujVOtTbLSxOAArxcQ==
X-Received: by 2002:a65:624b:: with SMTP id q11mr6496429pgv.232.1631823051869;
        Thu, 16 Sep 2021 13:10:51 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x128sm2500445pfd.203.2021.09.16.13.10.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:10:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 3/4] Bluetooth: Fix passing NULL to PTR_ERR
Date:   Thu, 16 Sep 2021 13:10:48 -0700
Message-Id: <20210916201049.114392-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916201049.114392-1-luiz.dentz@gmail.com>
References: <20210916201049.114392-1-luiz.dentz@gmail.com>
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
Tested-by: Tedd Ho-Jeong An <tedd.an@intel.com>
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

