Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6441CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbhLAS6j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbhLAS6a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4866AC061748
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x7so18744088pjn.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9G4nN6adFXZs7o7sbkseSehA9CiImKOItvL2sjo4178=;
        b=oarEs9uBgDkvv6egljVtCJvsYWMIllP4GsQgwrcOLBi7vhU78bQqYi9KOaJrfcrTCN
         0xN2T8Kbi7k8I0B74XINJ1mq8KE+JR63PpVP1MQaiRkZ+qja04yQkzppvrxb61gXV7Qg
         ScwiloxJ5NIt/THNe7jwV/ZPfl/jpC+UAG5jgF6Y9DXjEh670H2VLnjJ9DpFiYUZRyVW
         /DnFkvvT/FpYXlcNLyyPfMEPy1jU5YbV+zf3sWZPVNaGKEieH5PMnenQYydn0z7GrCnH
         njpt7bvR4DNgW8Gv6Cz357QfoBqfg5zcUGjncFiSql5bVcewAqQwKijOY8ypiqhpI3iu
         y4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9G4nN6adFXZs7o7sbkseSehA9CiImKOItvL2sjo4178=;
        b=8N4gjcvVBYEIZatbl/bH2gU2ABmjsjEhVExuVx/PXPBMoh4L77B0B9npfsLFW09ZWV
         FDcFJ6S78x/XMyvGBhtotOL2MbC02gjN3MbWE0TLeWk4KIRf6n0+P8ILhMHSsfBRal/q
         qcwJB8QzMzcsVG3Vq3VzSNZtfhKh6itEZ7gOVUdVOxysT73uXigi5e9J2ZMWHtqUX0SQ
         MjdJg4qPbZeNoviQa9qjPlFo0mcrEGg0dak7+b2KTrpc0iB5/nB0uvgcUI805YmyDxYp
         RBiHaDNRU9uOzOVOZeOML+DPjy6n6WToRx0x8K5Vz3HSMOQ1/6DZd/ZbuewRn3kEfr8O
         nS6A==
X-Gm-Message-State: AOAM5315cdI9Mabr9sg7LveL63F8ANTLTtnxJWAFHKjvjx6mdQdMNCyi
        FOreTY5tMkX/JAM6weR8+rumfgi0swA=
X-Google-Smtp-Source: ABdhPJzZ7LNZD7jVZKlytk+taWta0zVW4NZHPOn++zzd8PLPRVaU3mtlp5y05fkE7TPHA2+lHlVI1w==
X-Received: by 2002:a17:90b:33c2:: with SMTP id lk2mr36133pjb.19.1638384908543;
        Wed, 01 Dec 2021 10:55:08 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:08 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/15] skbuff: introduce skb_pull_data
Date:   Wed,  1 Dec 2021 10:54:52 -0800
Message-Id: <20211201185506.1421186-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211201185506.1421186-1-luiz.dentz@gmail.com>
References: <20211201185506.1421186-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Like skb_pull but returns the original data pointer before pulling the
data after performing a check against sbk->len.

This allows to change code that does "struct foo *p = (void *)skb->data;"
which is hard to audit and error prone, to:

        p = skb_pull_data(skb, sizeof(*p));
        if (!p)
                return;

Which is both safer and cleaner.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/skbuff.c      | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index eba256af64a5..877dda38684a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2373,6 +2373,8 @@ static inline void *skb_pull_inline(struct sk_buff *skb, unsigned int len)
 	return unlikely(len > skb->len) ? NULL : __skb_pull(skb, len);
 }
 
+void *skb_pull_data(struct sk_buff *skb, size_t len);
+
 void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 
 static inline void *__pskb_pull(struct sk_buff *skb, unsigned int len)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a33247fdb8f5..0b19833ffbce 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2023,6 +2023,29 @@ void *skb_pull(struct sk_buff *skb, unsigned int len)
 }
 EXPORT_SYMBOL(skb_pull);
 
+/**
+ *	skb_pull_data - remove data from the start of a buffer returning its
+ *	original position.
+ *	@skb: buffer to use
+ *	@len: amount of data to remove
+ *
+ *	This function removes data from the start of a buffer, returning
+ *	the memory to the headroom. A pointer to the original data in the buffer
+ *	is returned after checking if there is enough data to pull. Once the
+ *	data has been pulled future pushes will overwrite the old data.
+ */
+void *skb_pull_data(struct sk_buff *skb, size_t len)
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
 /**
  *	skb_trim - remove end from a buffer
  *	@skb: buffer to alter
-- 
2.33.1

