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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9264C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9956361221
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 18:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbhDLSk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbhDLSk4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 14:40:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C8C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 11:40:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14so2278927pjl.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Apr 2021 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uq2AbQRzRKbo1fXWbQj4G5cuhsfQXMYrbmYBMQQOT2k=;
        b=CFeVir3NMJDAKGJFOWWlp9iee1dFSP5W37MXz8Ha4esP0l6dMmunnp/dtBvnKaTn7V
         Kkh7wHrSXU/lcQZ+9cSWldWRRjKh+yu+CQSuivjs5M4Tc83XI8P0G6z59sDXxjtgGXFC
         sVP2uAm5zxsvu+i1Y0pvdqQsEx+DaJ9oPketOOnnPA4X+AABEuVWpJ78srC8vgfwkeFC
         gq+bEsU6tqP0j7hCPO1SIXmKiNrEUxpifb8K44/QZ4zN1+J3UNawBcAIOESwhRvOuqj/
         ro6MtOxUTeZpsSQX6+28KoOwyRmiq/jg4fXpS472jSzHQDVnh1e5L361bovjGOnIo+vi
         5mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uq2AbQRzRKbo1fXWbQj4G5cuhsfQXMYrbmYBMQQOT2k=;
        b=bnd5gKC8Bzf9uLnUpsX/lyr/g+Ej9Mybe9792YCyysHTz/npF7vTgiGGoAzfZmjfe0
         x0n54XcnnP551nx8ENfl7AOJT9qmYIfHQWO5GzRp/eao22CVeaycV3+TdZVobCFv5TOH
         zt/aMUpTq4fPr8Hx+WJUcJmcqzPgpHMoRmzVKCqNJA//62TGu6hykGOuBlNQRaNn6k77
         7fg53x6B5f0AbiBmtF6kBqz4BclbzuQBRQe/o2W3EpnSGuJI1a/W6XJiF0jKyPwxrZU3
         y26eDSzN912roAf0pw/Yd0ryJ/JWpC8noZWIqJs93eLeKzvGVGBdiHPO7+ERqefbMuKJ
         WNvQ==
X-Gm-Message-State: AOAM532RkC6E/dqjdRGHVAQHYXe9T2qVkLJsNyxDtvWCHtrr+9ZH9SC6
        BOtZB7HWEiChP/d1HRG+OoK0q7+E2daafw==
X-Google-Smtp-Source: ABdhPJzXQO0AOu+T0Uj9a6+L48y08tbvTefFknQ3tlLvJYj1Lp9Mn4UclasjgL5TP/oqPDe8pDtCVg==
X-Received: by 2002:a17:90a:d701:: with SMTP id y1mr594261pju.1.1618252836476;
        Mon, 12 Apr 2021 11:40:36 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v13sm9773551pfu.54.2021.04.12.11.40.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 11:40:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: Introduce bt_skb_pull
Date:   Mon, 12 Apr 2021 11:40:32 -0700
Message-Id: <20210412184033.2504931-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_skb_pull which will be used to parse events, it checks
the skb contains the given length and then use skb_pull to advance in
data which avoid having to rely on another variable to track the
position in the buffer.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..449bc8e112f9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -420,6 +420,18 @@ static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
 	return NULL;
 }
 
+static inline void *bt_skb_pull(struct sk_buff *skb, size_t len)
+{
+	void *data = skb->data;
+
+	if (skb->len < len)
+		return NULL;
+
+	skb_pull(skb, len);
+
+	return data;
+}
+
 int bt_to_errno(u16 code);
 
 void hci_sock_set_flag(struct sock *sk, int nr);
-- 
2.30.2

