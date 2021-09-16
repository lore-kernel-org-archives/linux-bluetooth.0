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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3A6C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 18:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029A461212
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbhIPS4j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344157AbhIPS4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 14:56:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABAC043087
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:03:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so1630075pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rpv1FaQ9oQ4VD4XcDBX4LDce+ctNlKY97mbkm3KNwuc=;
        b=p/432OUWAjBhfesC4L7qSyIH9zUxLxfdlG3xIzYBlp5Z0r672ksQyrqGSgkc27r4Zo
         gojjvuheC7jFXtUZyUcxFabeFxHnU+Mx36zByciTsm2of6ZHmN1Z/3ZExnR0PTcvd7i9
         5z0aROXqW3uBS2/GAsBK1WhAAURkhpIX0Aio3i11XcMXoRKm4onO7wrJ2VGhIMzHZCo1
         1bR0pe2tZlkBln0NdLZ4Vr98ftBxHKxomEdRmPJb63jkMGQH0lMdqZ6Ot8arDqPPUFWX
         DUWLFSn16pi3RxNm8BF+uyVKmAftclz3zG1TjdkxkTn5pBfJmGKSUsTkO2GJpkq8egEi
         o9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpv1FaQ9oQ4VD4XcDBX4LDce+ctNlKY97mbkm3KNwuc=;
        b=1G3xI2N7DCAcZjWHpbLuPuh/+exp1d3DUVx4xAlUdHbavXs/Xl3N0Ka/iWdAKtHtZK
         Gftbk0yk7zjST1GWjcmy/Fs1JfW+M4Fm3pEhhBAI9pwNJ417oHyzLzQljdHKEzFm4aHI
         PVOPHsGsIqRaLZRvxMUEZMwquK6Q5yg8XYpeMKPdEhmyojMowBMp1b6Az//4cZI0OBoF
         m8CfULMpU+dv9tSqwknaX7E7OJKQGqJrPHRcdEFP+ISKVrs/i3blnR5DyXITQNmI8Mix
         mL4CHyVEhFxVjALzlXqMuD2OCa10Si72NmWYiS6v1aqmuLmrvgjZs0bFSG6S0hbX/bWt
         Xcmg==
X-Gm-Message-State: AOAM5323An/sBLbI3jN31ogyq2pjRAJusx9RXt6vmsqwSyGyYkGOUBil
        dapsNY57ohZu3nQ6yRnDADN81JDcJ0I=
X-Google-Smtp-Source: ABdhPJwhZ0MHDj9aPwl5B2Q9KPwVYSC4aPXQB8M/i9EULcA1V5bcKvlDFgee9wjQJTbOOq1CbPa/Ww==
X-Received: by 2002:a17:902:784c:b0:138:f4e5:9df8 with SMTP id e12-20020a170902784c00b00138f4e59df8mr5870357pln.14.1631815417772;
        Thu, 16 Sep 2021 11:03:37 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p24sm3580432pfh.136.2021.09.16.11.03.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:03:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/4] Bluetooth: Fix passing NULL to PTR_ERR
Date:   Thu, 16 Sep 2021 11:03:34 -0700
Message-Id: <20210916180335.75976-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916180335.75976-1-luiz.dentz@gmail.com>
References: <20210916180335.75976-1-luiz.dentz@gmail.com>
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

