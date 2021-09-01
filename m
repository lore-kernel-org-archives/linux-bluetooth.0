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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF45C4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD45B60F6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbhIAA1U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhIAA1T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 20:27:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6DC061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:26:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x16so700892pfh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV91TlQ/uyvI2F8HVAFusfi8G+Q5pnpGFBPBrBkciLA=;
        b=mZJY/ocaN6AjdA65d6pe50IWkT7WSpv6+//ptgBwH1ImMCTUwQI7rkrsNs/qcPHN03
         /1GjAUv5HR3+QHWJgycHtW7Fu8AFYfs040FpFE/9U5ieoEySafctP2e4c8YSQP6cajZz
         z0cd6+40fmIhJrC/RCLTWxsISRx509G/JZQDGbywMFUP9aDM0hisrBQva0xzU3RXAXOi
         RWdr2a2KkpZOJicFdVK5BupulPkvADDmrmfUSMjAwM3BBwMc7GLAy4L+9hXnka7vLREg
         0bxYGQdWdbGR30xM2oAJWZELy7R7r1d67CDNRHLQR1piYqfSaPbTlRbGf7q4kPXo7ycl
         SaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oV91TlQ/uyvI2F8HVAFusfi8G+Q5pnpGFBPBrBkciLA=;
        b=mxMNQQs+FgklpXi+l6ZzTmENpxgty3dFy9ZkZOhD/W/+GRdoZkKhvanjPYVPWnNKQI
         Sm6GvpSuDHniQVJigjKta3FvRoQinnASkh9TrcKV4Ex58ctg86nGz3hvNoGtrxb//YqH
         +lkgkNbnbFNb590AOslfzNxdhbWP02U0nwwNLvAjw51kA+BeeLkZNdzY213ZItF3s6Dp
         11OYANPKWmJbCQDPwyXETjBaSPGqxAjzI5i+AuxpuCURWUeiqszHO4o+TUancebM0w+a
         0ObjXHmekXPomp+zlQvF4J86vIj1HZFLi5Cgn1+x0MWflriFxgWHOI5MjqNh8XlcUmLT
         5bmQ==
X-Gm-Message-State: AOAM531Fziu39YcLXiZD+udd7BEL7aDy0pP4ggAnuKkCgXLzp8VPsY9O
        2NLY3p43qiPUvGtb/+kooOamyhaZYeQ=
X-Google-Smtp-Source: ABdhPJyRRAAM2nPMR+M03bYmQ/1vLnWW5vUPK1BgP6v8pgnoQycoSKentTK/CZfvPrcl4RqioQHDjA==
X-Received: by 2002:a62:cf86:0:b029:3e0:7cef:9e03 with SMTP id b128-20020a62cf860000b02903e07cef9e03mr31566411pfg.0.1630455982143;
        Tue, 31 Aug 2021 17:26:22 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gm5sm4054655pjb.32.2021.08.31.17.26.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 17:26:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add bt_skb_sendmsg helper
Date:   Tue, 31 Aug 2021 17:26:18 -0700
Message-Id: <20210901002621.414016-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/bluetooth.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..f858efcf9f40 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -420,6 +420,32 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
 	return NULL;
 }
 
+/* Shall not be called with lock_sock held */
+static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
+					     struct msghdr *msg,
+					     size_t len, size_t header,
+					     size_t footer)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = bt_skb_send_alloc(sk, len + header + footer,
+				msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
+		return ERR_PTR(err);
+
+	skb_reserve(skb, header);
+
+	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
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

