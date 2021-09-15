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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26ACC61242
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhIOXhZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhIOXhY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:37:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA35C061766
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j6so4209872pfa.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qX2dfn2x26WX07e7xdzg2ywb6Njzmd8j8daHrFRGUlY=;
        b=S9hxECxPlRtRHDWSMhtmv5c+YaspcIfsWlDNnJsV1ys9XFGvSfmWqH+atQf4YaaiCC
         NVRqzvo2929RZt/poJT3+qT5eGsbME3yvCe2xq810FFFag3SCkVZgRJ/5yiktkYvSEMl
         9KlrKdCp4P333wkju5p3QsKxgQaJ7GibScOIAPu+QD6cH7st8fUB6p56f1qhN+DZOUQ3
         pB8m9aE0p/k9nm/qKgv5Rh55lwojhJ0bVo7SneOeqWRHC7IWIfHrPttGc0g12UogAF40
         dJLtasREcpWs8SoNMq8JjTW068URZq6VEreMp61gBWGVR31EyJiUWFp7aZcnHwESQfNR
         yJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qX2dfn2x26WX07e7xdzg2ywb6Njzmd8j8daHrFRGUlY=;
        b=TcFsiJqxE62jy4khtFt2o8qGVrztnEwN10ss1lkQ/GAnMzm6T3DvKVp+kD/BtY8rdp
         Vjd+a0LPS0midE0ncYKmMTR/w57rk67c8umDZo2LHCLZdHKnVi8vElf92g/jbALdGAB3
         o1u3OiBrjvZ63EN2mTzXq3obT6tweTQ1SAhauEVB5mVzSl7MzfJMLDIBY4ae3IYsroyy
         X43e/K/9uu2qYdNs7HMOoawckRpQm+ZHwHxP19/Ec9xOQXLnS+lc4SKFOauwCwnzVVHL
         XOUa1woyvnk35ykvadm7nvZG6u1uJH9q2IQIL+JsbKz4ofwdhL52tR3UxdI5100BnEYZ
         RrJg==
X-Gm-Message-State: AOAM531bspo//C/v8KV3k6JbiYHPUUziwlS+YeOOUtcZAyRVlDAnqlCR
        i+kRZiLc3S6OX1oHGRtesR1MO1kuKik=
X-Google-Smtp-Source: ABdhPJxmrPbDD8k4DjxXRCWW623mF/wEAde8pPq5L9qqFD7bUr+VocNDYFYz1AiuKHO8O+rJ5Iem6g==
X-Received: by 2002:a62:4e0f:0:b0:3ee:668d:b841 with SMTP id c15-20020a624e0f000000b003ee668db841mr2424880pfb.48.1631748963876;
        Wed, 15 Sep 2021 16:36:03 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x13sm890980pff.70.2021.09.15.16.36.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:36:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: Fix passing NULL to PTR_ERR
Date:   Wed, 15 Sep 2021 16:35:59 -0700
Message-Id: <20210915233600.4129808-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915233600.4129808-1-luiz.dentz@gmail.com>
References: <20210915233600.4129808-1-luiz.dentz@gmail.com>
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

