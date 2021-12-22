Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDBBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 23:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbhLVXmK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242243AbhLVXmI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 18:42:08 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26F8C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:08 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so7228833pja.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9ihzvmfL1JKR63zuErQK+qR+qt0qyup6+/MlQjMaiNo=;
        b=P1QlfCSX5AcBXjtTliZSJB8ctd1GrYz+lKTkTttkXwC0br+td/TD14+9s2clZfP7oZ
         lPDboM+L41TeKOCLLpcBPSTZjAiIMLjrP5ydBtiMd8TWBhhJghlgbYeehJIqfSXEUe9v
         LtP81YwLw4eb3IWYWbRd+r+VIpkI6GI9BZm/jt9bCwaaUkKmUafPyxs689fUp1eODb51
         fZK/wrUBM3PuGCngIUId3WedP9mUpgxFDA6dRIWNX3JGAp/NbVp/HgAE/LaHHqeadinJ
         /kDvs7YcOp7kHDfnPjucVB0PjeJhpvV3l1ZNF80+V2+4UKxubuKjPSGy6TCvq6Vrwqvm
         Ow7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ihzvmfL1JKR63zuErQK+qR+qt0qyup6+/MlQjMaiNo=;
        b=1dLgdUVOHu+FhsXS1OmIY4GLAxuMnjA0SErtIQClQragxjNSECNLqxJo+eiwd6bHN5
         h2+RO9CbYi5fbTTuz22Oi+/as4AJx2YCipaDjerAdCLSp78XfyiA9eUwj5l/bXWpZbY6
         3EzOakMCDgfPDKMjq27h6yDyea7IVPyA8z10jyumASgz3pLoR1hP0J1eDHut6LzKK5pt
         oD+HZzuBjm5EOZnTWQSmlS00cRfAtv+GzkK71h0/O+cGFCGLaFmQ0Q3LjHbiy+Y8gou7
         VKHBYtu9hOW7CjZ6XRKyWwbZdkB6iDEiXLEHgrN6xBqixB2kUdsLe99LK7oQJvp+gXt2
         ZOtA==
X-Gm-Message-State: AOAM533ElxKz6Iz5FeeRiIIv2qNmBgpGEL50qD+b1BlhLPFth/JW8OTR
        THU8JJp5hgCu4+VX0XcgjTMB1PkfLgU=
X-Google-Smtp-Source: ABdhPJz2fhrKyVQLM7++COhvMBC+Hjdd0fujoJ2qLn8yjvU9i2jCs13V1IUgV/hxDkEwLl0EqvLFUQ==
X-Received: by 2002:a17:90a:eb08:: with SMTP id j8mr157167pjz.68.1640216528033;
        Wed, 22 Dec 2021 15:42:08 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r10sm3563666pff.120.2021.12.22.15.42.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:42:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] gattrib: Fix passing NULL to memcpy
Date:   Wed, 22 Dec 2021 15:42:04 -0800
Message-Id: <20211222234204.1455901-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222234204.1455901-1-luiz.dentz@gmail.com>
References: <20211222234204.1455901-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following runtime error:

  attrib/gattrib.c:198:2: runtime error: null pointer passed as
  argument 2, which is declared to never be null
---
 attrib/gattrib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 270a37ebe..041b9d289 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -195,7 +195,9 @@ static uint8_t *construct_full_pdu(uint8_t opcode, const void *pdu,
 		return NULL;
 
 	buf[0] = opcode;
-	memcpy(buf + 1, pdu, length);
+
+	if (pdu && length)
+		memcpy(buf + 1, pdu, length);
 
 	return buf;
 }
-- 
2.33.1

