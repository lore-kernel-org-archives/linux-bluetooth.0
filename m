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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD9AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D6661185
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhIOXCc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhIOXCb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:02:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B893C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:01:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k24so4281117pgh.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qX2dfn2x26WX07e7xdzg2ywb6Njzmd8j8daHrFRGUlY=;
        b=LzPLtqx1kXUavKGjmwI8dvuthushIcZFI9LXn1wHkGrMvbomgkjhYrBESNKqCcpsx8
         3k+uCvo+RTB4M35f/vmYPgIY5wmC9OSgf/rdDyxquSKSYqGW8ThcQoJqQJhhDnbsy3tO
         mmYaHUJ5eZ/YyB3rQqS5NyGimc7ZbpmAgsLG/aKB3pE/Om8PmHzJmkrN4+liv0lpqXTs
         Gtp86HqRJ4ky4KyAEfuU5dmXS2POLGmuBs0ssT/IjyI956MH92oH4TXlflrFWzGpLcRU
         WzNsUKh0cRut3w4ncRILSPI8CqnXBTUHCGBCm+jGb2tpyrBRe9b/LA6pqKoh/10AS4Ar
         DxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qX2dfn2x26WX07e7xdzg2ywb6Njzmd8j8daHrFRGUlY=;
        b=nrTRieSPUsbGJBVshk9sbwE6a4csplUGwQkPvqYHkReraNsx0rEDDsT+6ZKUQpZmXc
         PxXLOKDbtETM6ipG10vjZfSBs2Ryx45uFhuY1uuYyRLXoh2NOoEsmDgDA0iEcBZaqpOM
         5jGYJ1whP64j3tmdpvMWxsaMSFNhGx6jS0cXpI9fqX2+cC33PDm7ljDw3csWox5ncuuE
         cK3jMqalhNbWwCZgPVtg3H7TbXutL/nFC+856OLSpDxczOtS13DsXGOK+7dzE+HifyLN
         c5PZXdwm4JVJLpwHvL0AtKvtrobp+rMbM+Y8HgebpH9oG2b9o9RrGJPbad7/5YOL3Em+
         9/Bg==
X-Gm-Message-State: AOAM531c6E+wsGliTWsbAOaJgZGof6WytNjCTu/vEpDEWP2XeSmz4Z/W
        nZpSWEtdzf3UGiUZ6ZsiAVRcsdHZYEA=
X-Google-Smtp-Source: ABdhPJyDpX1cwZDZFiE5DAj7El03Z4SRxtmFSj0ysWnoupr5GKg/e4HXWkW1Cd19MbgtEKsfGrbwnQ==
X-Received: by 2002:a05:6a00:2189:b0:414:22ae:eab9 with SMTP id h9-20020a056a00218900b0041422aeeab9mr2018918pfi.65.1631746871523;
        Wed, 15 Sep 2021 16:01:11 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d3sm5742226pjc.49.2021.09.15.16.01.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:01:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: Fix passing NULL to PTR_ERR
Date:   Wed, 15 Sep 2021 16:01:08 -0700
Message-Id: <20210915230109.4107111-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915230109.4107111-1-luiz.dentz@gmail.com>
References: <20210915230109.4107111-1-luiz.dentz@gmail.com>
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

