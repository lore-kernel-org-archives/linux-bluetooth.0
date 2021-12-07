Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BBFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 01:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378901AbhLGBDn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 20:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347991AbhLGBDn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 20:03:43 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E60C061746
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 17:00:13 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so1263965pjq.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Dec 2021 17:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aR60ZJ2BmhTstAkBblZAqdelun2/RuFtmoBMZI1VMI=;
        b=qiZJo6VfFXASRmTe93C+jbiaTnqFUbvwQqotACucsZ8jxsfeCw965lDYDQ0J123CeH
         KfyZMcQRzW2zJWrH102rsCpxk+0T2W2YEi3fFtFhVzUe+Dz5pvEeROT0tIGqRZerKJsu
         gTI3/GNhXnY545q2OTUx9Nr8Xvz6lF8z35ccNoTsUzPM2AsO407aPlAFQlFkx/qJfdlT
         yMLDSHgxH/RwA5cVryD1tYpMJmBdJO+9HwpETpmltGt7EUAXpzVHMyScSbyz8INu1eE2
         FQaYfB2husFxDIzSA2WzQt5IJK63MVOkzuNBa0Ut0Dej6Tjxc2YzKiy67nJVl6nbTm48
         USgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aR60ZJ2BmhTstAkBblZAqdelun2/RuFtmoBMZI1VMI=;
        b=R+Baesplps0tjqY1SgIoq8ObkPUqHyXvMd3A9jLB+1tA9AIZNN2vgwogMyjYXhftQs
         yxHu2LKQhkcuJ48Urnm/CKzoU0WyOB+QmwbtzA1PfssAFKSuIEj+wkza40GYeW9rFv2g
         sesm1CmFlW326k9TKy+PwSl/reCLl4wKT5S74KNf0X8gepDnHn4PO4gRZPUIKH/oCBxg
         u8wub+rnwKJOIQdvDaDWRX0/4KHgOaXTmgMo+MOvrAWdiwANBBv6XtbmHP3jgMw1OWZc
         vkLipwsxaovgQQEgCFryF2GaOvpUilewBThjU3sXHuVOQsbRve7k5rAEKYXuFbeD8oFZ
         5sRQ==
X-Gm-Message-State: AOAM530oiY37pGqlQYly030z0eda4D6u+3ttHumlN1+LqNX82qmNIBVj
        TN8j049NaEp14zKUVrG2USyhedR+0Ck=
X-Google-Smtp-Source: ABdhPJyHl7GouBf3wwL5ePJ5csfNTDexY8p92UytsXGKKGPBCI24ctZesCUe+JePx16bK+aiqc75Ow==
X-Received: by 2002:a17:90a:7e0d:: with SMTP id i13mr2563838pjl.171.1638838812934;
        Mon, 06 Dec 2021 17:00:12 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x16sm13043944pfo.165.2021.12.06.17.00.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 17:00:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] skbuff: Fix missing EXPORT_SYMBOL for skb_pull_data
Date:   Mon,  6 Dec 2021 17:00:11 -0800
Message-Id: <20211207010011.3619889-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing EXPORT_SYMBOL(skb_pull_data).

Fixes: 54dda1e8cf3c ("skbuff: introduce skb_pull_data")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0b19833ffbce..dd3ef966efdb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2045,6 +2045,7 @@ void *skb_pull_data(struct sk_buff *skb, size_t len)
 
 	return data;
 }
+EXPORT_SYMBOL(skb_pull_data);
 
 /**
  *	skb_trim - remove end from a buffer
-- 
2.33.1

