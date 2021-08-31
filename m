Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CFBC4320E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 01:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF5B60FD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 01:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhHaBQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhHaBQZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 21:16:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49100C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 18:15:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e16so13213115pfc.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 18:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=292hCsqMTFWIpO3XqBPxXoXEvsaaCmeMmmKu1ZdkBFY=;
        b=iqVNozcOvU+5Jg94snf7ITU92je/hSxpCWOeQJh5pOmhxq8tfJml0L6XtYGLx8BWwv
         dFYNqvfqy4CDhaEuhrT/Zq9WKpGXwKaMPdj6IpnLaEud9u6XmmtdS45qKYYtrCxAbXwL
         I3OT22KE4O/5M6+Cd0ACfiaMlMQwkZ7x+XqKAzf9C7iCqgRbYe/8lgqfFh7sMNyQyN/U
         fKSyMLrD2EgDPha+ZOOiSOHOVdMcFCwq2jVGeTBAZZqVS/CdXQ7jT5HiCwTgdHwE+VDK
         2Tu9hue+MFmYVDje19oSkwDr0UyfEzd3uU7AwEAXr9W5PhSptQalbVPAqE307iYdxCjI
         MfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=292hCsqMTFWIpO3XqBPxXoXEvsaaCmeMmmKu1ZdkBFY=;
        b=KqzY+Et24r/TnLBQ6JzO1/leVq2BbyNyuHKitG6P23DgYcNpO4/UuswpTHUFRn2T2I
         PTTBDpG51vxycemVUJ7FRfxph3641v/n/+MiX5W1/5a1qKTzU6I09A7X5RtfV/ZTy6WB
         vlTZZiwO0JoiAjYWkRVTBC5ZkZmAY6giEV6o6gXr9ZsZGP6YpSn3a5Cv18y3utb/HLWd
         xnjk6r7JUn+yLzbcrQK15ZYuy7jpMcxF+J8azRqCRoP3BgiD5NAw5aJyp6kOIRjkyLKh
         jnLkxHSDm65aILvD1Xkfui69Ka/eK5hPu8gu2ZP1AJNiUBOjIKW7/Il1TjNEwM9qyHWD
         poBQ==
X-Gm-Message-State: AOAM530Mt7KUV47ZSpKBhU2XYD9+gEca7S7EAuPBRQ0qIgu0MLFHNPyr
        Lawr5jYDk+vKWMTi3kmtuaovf8TUvQk=
X-Google-Smtp-Source: ABdhPJwkOPLTI/LzpsWZUb0vjYbKKCq/ikf9WKpE1rwjnGUVGpJVyxTTBIdMOVp+RJq/3mVZKQJD7A==
X-Received: by 2002:a05:6a00:a01:b0:3eb:2fbc:1abb with SMTP id p1-20020a056a000a0100b003eb2fbc1abbmr26432203pfh.20.1630372530593;
        Mon, 30 Aug 2021 18:15:30 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g18sm5020750pge.33.2021.08.30.18.15.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 18:15:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/4] Bluetooth: Add bt_skb_sendmmsg helper
Date:   Mon, 30 Aug 2021 18:15:26 -0700
Message-Id: <20210831011528.225877-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831011528.225877-1-luiz.dentz@gmail.com>
References: <20210831011528.225877-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/bluetooth.h | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1bfb5d3d24dd..1d66bccdf539 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -443,6 +443,41 @@ static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
 	return skb;
 }
 
+/* Similar to bt_skb_sendmsg but can split the msg into multiple fragments
+ * accourding to the MTU.
+ */
+static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
+					      struct msghdr *msg,
+					      size_t len, size_t mtu,
+					      int reserve)
+{
+	struct sk_buff *skb, **frag;
+	size_t size = min_t(size_t, len, mtu);
+
+	skb = bt_skb_sendmsg(sk, msg, size, reserve);
+	if (IS_ERR_OR_NULL(skb))
+		return skb;
+
+	len -= size;
+	if (!len)
+		return skb;
+
+	/* Add remaining data over MTU as continuation fragments */
+	frag = &skb_shinfo(skb)->frag_list;
+	while (len) {
+		*frag = bt_skb_sendmsg(sk, msg, size, reserve);
+		if (IS_ERR_OR_NULL(*frag)) {
+			kfree_skb(skb);
+			return *frag;
+		}
+
+		len -= (*frag)->len;
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

