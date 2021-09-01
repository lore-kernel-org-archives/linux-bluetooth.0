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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFFDC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388CC6102A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 00:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbhIAA1U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 20:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhIAA1T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 20:27:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F077C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:26:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so963961pgh.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aCRHB/ssiwjKRr5Y83BliYp7RmTBRWH6WSIPulVy6og=;
        b=guPz0kEPpXMb22FucYINhDnnZWTX7ruXm+jkAdxoBxnSxzHhqTUCGWZfoikyOnsbDJ
         xlKABaIQHuRVl3Jf1TmJyWzUwHIXAUdjxoeOEZrX30sRiONUP1EqypOgrGREtB0rFT5U
         ftXPOOVP5mHEpoif5It2n/QNUuy6QK03hRfeLQIYDAlXcFmzLnzWg4uV70lFh8vO+7q7
         09qTfS3m+j1Sx+96pjlij+iZhN73g5lQ249jhS+zXgwIEmCuP05pxeHcQTXsGnsFKCF4
         CrCtUkr2a+MNNbBUW8mRzPxBUofsk1qgufdPf5RHKadKiAUBSRD/kmgGUlt9U/f3enGE
         UyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCRHB/ssiwjKRr5Y83BliYp7RmTBRWH6WSIPulVy6og=;
        b=P+RvQyGkrKOUOhOcnUJyhvdqoBMPxDYP+ddusPMNJvbkeWF2LN7usdBwcauxlT3+eb
         /FwoILMP10orb3WH7PZ9VoHPSNZ4mVEfnkIi9MTrpN+/B+wUYpRYaj5vMRPDx7OG63KJ
         dDL0j2nzGfvQneRoTysHNtw0tTsxsT7qjwQoDdWr6K+pjlvQO0lpuzyFqy2AlhqqGQEY
         FwXt3dk5fS6aj0RPvyde0C6qQcJoeGKf8R2uim3jjwEDPnb/n3GF6pAcvIuxgNVGJqsm
         pT2WOBo/zPrkswOfLKsIaqFmV6ArzCs69cR4ADGel2ctOwClgOKAhnVZAND8NV+K7rF9
         0X2A==
X-Gm-Message-State: AOAM533tgnOQRzsiyGaQv4NJxB0L5JTryFX+2LLEknjkuEHSebFNJnvK
        81NpjnLRxW3EhZhHf2CGkBJMk1WgwVs=
X-Google-Smtp-Source: ABdhPJxrDDFlR9Y4cvNeK0kvZRWsshSiFPfwUXx5o0JaPIuZqq0JSpMrmw53tfrS+phb21z7NZuX0A==
X-Received: by 2002:a62:d104:0:b0:3ee:46b:d4ed with SMTP id z4-20020a62d104000000b003ee046bd4edmr30595255pfg.38.1630455982813;
        Tue, 31 Aug 2021 17:26:22 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gm5sm4054655pjb.32.2021.08.31.17.26.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 17:26:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Add bt_skb_sendmmsg helper
Date:   Tue, 31 Aug 2021 17:26:19 -0700
Message-Id: <20210901002621.414016-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901002621.414016-1-luiz.dentz@gmail.com>
References: <20210901002621.414016-1-luiz.dentz@gmail.com>
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
index f858efcf9f40..96743e6e7a0a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -446,6 +446,41 @@ static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
 	return skb;
 }
 
+/* Similar to bt_skb_sendmsg but can split the msg into multiple fragments
+ * accourding to the MTU.
+ */
+static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
+					      struct msghdr *msg,
+					      size_t len, size_t mtu,
+					      size_t header, size_t footer)
+{
+	struct sk_buff *skb, **frag;
+	size_t size = min_t(size_t, len, mtu);
+
+	skb = bt_skb_sendmsg(sk, msg, size, header, footer);
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
+		*frag = bt_skb_sendmsg(sk, msg, size, header, footer);
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

