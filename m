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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3906660C51
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 22:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhICW2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhICW2h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 18:28:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A69C061575
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Sep 2021 15:27:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c17so487378pgc.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Sep 2021 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mljDYYlLDcj/0CkTyYH9Brnr1HPRQ48Nwhm/HTTbv9s=;
        b=UoFPSQVSt5FfCbDjJxMQXcwsfN0aZbp++dQcOOp9PcRNmoMm/CBVH+h8kBiNh0IiBA
         VmLt88993ZWffJdM+QnpmqER1oS+gqaCyGJYjn+sdFACIkNHZSJwnaLuVCVBHG71tbEu
         ThabQ7HzrxP/2cC8NVx7AsDeblTbp4IlJN34LzUEmMNrB1SCjptGYOIGWHQRntFNe6UK
         bcAl9vYn0coxikEBiY3Bg9PnRXnOzbgQYrCK+aa+FH6JOdfgPmhRitZjJTCbWdtArnij
         DSG7wF9yvdIzU+RI8M45omKnWM44rHaMTCZQdFC8S/u0jBgOp6OJDq5jKwalb6RQ+H3c
         KPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mljDYYlLDcj/0CkTyYH9Brnr1HPRQ48Nwhm/HTTbv9s=;
        b=JhrvUmwTyLy/WQdplnWJyiWHvvTDHUN/cJTCZjRtH1lW1AP4KcoMtFOm670C6Bmgyl
         MNFtuNmsb1yF82MO7gFQU7l0lAU01A67kFVfHo86i9QhBibkx0Xdh1KUWd/7/wRlm5za
         PU20fNE4TqGicLYhtAz/tf2heQ6cAe0WT7nwMxigfkO3f5OU2y3qjAArxwTW9Am9I+y0
         /ocur+ge90C3+6ZdsHO8YBKPNDw/v40evdAQLF7CSGHBavX9griB70LYrLz7/BcSyUgD
         qTHscZjsVodxngBp3uHQNN5239AjTHjCKSYJ3L7uyLj5WeUB5O9qnYXVTcrHta600iJl
         XYSQ==
X-Gm-Message-State: AOAM531zwE39K4D5QW644QJX3J4wvfFdiZX60+GNYZ27zdqKz8wIqJ14
        FjrZ+ySZGMjOOZ4ln7YdXjib34L3fa0=
X-Google-Smtp-Source: ABdhPJwnzRsO6gY1qtDMVRA0x6ma3WbMXnIJh6SrXqgsk5dIp7PqTZ7aRv1ouvJFtCKXnFQTyMzyRw==
X-Received: by 2002:a63:a55a:: with SMTP id r26mr1034150pgu.13.1630708056180;
        Fri, 03 Sep 2021 15:27:36 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x4sm225796pjq.20.2021.09.03.15.27.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 15:27:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/4] Bluetooth: Add bt_skb_sendmmsg helper
Date:   Fri,  3 Sep 2021 15:27:30 -0700
Message-Id: <20210903222732.1472560-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903222732.1472560-1-luiz.dentz@gmail.com>
References: <20210903222732.1472560-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This works similarly to bt_skb_sendmsg but can split the msg into
multiple skb fragments which is useful for stream sockets.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index aa6f8fe897ce..82a83b3b77b8 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -448,6 +448,44 @@ static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
 	return skb;
 }
 
+/* Similar to bt_skb_sendmsg but can split the msg into multiple fragments
+ * accourding to the MTU.
+ */
+static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
+					      struct msghdr *msg,
+					      size_t len, size_t mtu,
+					      size_t headroom, size_t tailroom)
+{
+	struct sk_buff *skb, **frag;
+
+	skb = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
+	if (IS_ERR_OR_NULL(skb))
+		return skb;
+
+	len -= skb->len;
+	if (!len)
+		return skb;
+
+	/* Add remaining data over MTU as continuation fragments */
+	frag = &skb_shinfo(skb)->frag_list;
+	while (len) {
+		struct sk_buff *tmp;
+
+		tmp = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
+		if (IS_ERR_OR_NULL(tmp)) {
+			kfree_skb(skb);
+			return tmp;
+		}
+
+		len -= tmp->len;
+
+		*frag = tmp;
+		frag = &(*frag)->next;
+	}
+
+	return skb;
+}
+
 int bt_to_errno(u16 code);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
-- 
2.31.1

