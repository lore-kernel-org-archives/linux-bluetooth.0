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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C7C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D73610A1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhICW2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhICW2i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 18:28:38 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6B1C061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 15:27:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mj9-20020a17090b368900b001965618d019so458597pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bUG5RFoU/MlbNuIj3tMKfHg8hf0P6016JQmHbmqnbzw=;
        b=nCIHcKI1aUHii/T75cabONlKCoCS8f2CKkSsdyOUfH5KiIcc/d6apTnqS3MzJ7+xJb
         rm6KqOHLz5L+sV1IFdyfSwSKN1GyRgWX6R6RKz+GuNqRFgW/O8GTuMC3UjYDgwB6vKgM
         X4uGq8bu536VUuERsKRwJ2xsZn0KvxdLddVFz4F9RfSoKwfZgjFrrQpAL9bmhH7O0DLL
         NEvYyMkIGV5ZDxkGN9pMDUZ0zk7qyeOpZLRM0DoAZrkiMn3s13RdsI8u/DpZlpIDh4Bf
         hbvT7gjccLCrmLPBTjHLbvcNhbmwRraO9TqXrAstJFV1s/G+T2sVCoNfNZHfGlU9MTUv
         2lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUG5RFoU/MlbNuIj3tMKfHg8hf0P6016JQmHbmqnbzw=;
        b=tYeFaQhEsNZvck8yMYSUCmf/jnzl5ayMBMmnFi0B2l0dPQMi0c36YxPAnr8RUop7/L
         Df71l15kqN9OvUROTz/JriT4bKellxsT27ty+q5k8LUKhWsSC/Un/4H0TtoqZuRk+WsZ
         kUlzdxHHcZbLnfwaUfb+z5N8NS2mmoeiXL5CKY7bLMYCDR5wVzgmm5HUcu4JdjRVHDxJ
         OPumv2WVnQ2IhxTjTtKnZfRDJQ+fWAfvlr9xGPdZQoNdadDJRlEboKhesPfMFT63DH5k
         RNIGOtJZMI20PP4sMonk/V5gITLUkF4VapkvWNO9L5Czg0XOo3xLYGICgFKT+ZoaeWj3
         piwA==
X-Gm-Message-State: AOAM5309mKALSHrVJBf+Vw2p8gUwh3qdJNdNdYgaYJXr/UAgSacaIyzo
        97WOE9tbKO/n5ev7MvXzGWOp6PEvc/0=
X-Google-Smtp-Source: ABdhPJxCrl3vBIaK7HmyVY6qkxZb0gU0GltTOH+Etx0fgtPR4DQyBaYteyuriPv8duEomHRuBsjDaQ==
X-Received: by 2002:a17:902:e0c3:b0:134:fde4:63c2 with SMTP id e3-20020a170902e0c300b00134fde463c2mr913440pla.43.1630708056960;
        Fri, 03 Sep 2021 15:27:36 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x4sm225796pjq.20.2021.09.03.15.27.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 15:27:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg
Date:   Fri,  3 Sep 2021 15:27:31 -0700
Message-Id: <20210903222732.1472560-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903222732.1472560-1-luiz.dentz@gmail.com>
References: <20210903222732.1472560-1-luiz.dentz@gmail.com>
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
index b62c91c627e2..901097c1f484 100644
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
+	skb = bt_skb_sendmsg(sk, msg, len, len, 0, 0);
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

