Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41D6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 22:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhLHWnD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbhLHWnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 17:43:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3936AC0617A1
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 14:39:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u17so2509022plg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 14:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MrWtMuKZpMCN25LN/8i3Rj+4vnCyRyifo7BdIBg+8Ys=;
        b=G4wOsBmvtACCPUiJxqHWgrXDeqlz/nRU6NDbQ222pvwT4epOMiOCrmYuJjQmTPib79
         Cw/OXmpuC8BiFpfXG6xYsV1LWNL3IIRM5H6MlsQW8pCaCO3kf2JeirEjtbYl0aWmssoD
         qbOVi8sDX9SgB+hVEWhRl0oJ6uxvKl1UsEEvF9zkCQiL4a13mm786C413VsJxcuTVlih
         12Fz5kqUZ+ifH1DAZ2pH13DxUc4mwDpbWlqBMk4Wwwb8Z8NpWEGIRYKoTTfFA1wTVnQc
         ATpbhRtH7D+BiRFtWlGb20/TmAthN6sN4ZmsYPIKNI7nE4+se0NhpUNiKoQme/rH2d2p
         6vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MrWtMuKZpMCN25LN/8i3Rj+4vnCyRyifo7BdIBg+8Ys=;
        b=sROjlwWCfzmFKYme91pDVvh5g/P8UsQfqgnY2/j2GZWFnAcnfFeAUp4sRF7gPbS1gQ
         GX/oh66EqBLqZ3ucpVVKt8OZWKABEVp06zE8HENVXnKCjlICJmdt4eBFI6lYLGTEZhNA
         WMLTH5x0hPXckFlV6KrY9t1wbNwFjUSoDb5eCurNv2m8iDgdcGJvdH8JMjreIk4oiuva
         vGoMyCYp3ogad+j1LupW9SI6++s7lIury2hS7Z2eAqCOHnPmWt4ahG9EFxhy3Jmr0wZ/
         AgKqSoXObasPkZUpvJFYRbk0v4BggJpLR+6Msg3jB2vggW/y/9rWx4Aq4R7ldfRJa8da
         iP8Q==
X-Gm-Message-State: AOAM53334uDk7OzTQeTw2ikKyI4O45UxyKQuedR03moaKhEtdfTPNGY/
        KLCIUWL0yHUxiVQtCcgxpCKzo04BVLE=
X-Google-Smtp-Source: ABdhPJz+wNfGqowas+VWj38Npm7b801O2jmshPc8uXnW8ZXPRcsgY1csNnMpa4nxou9oy/oAyBzODQ==
X-Received: by 2002:a17:90b:4d0e:: with SMTP id mw14mr10674564pjb.43.1639003169534;
        Wed, 08 Dec 2021 14:39:29 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e9a:66a9:f3af:51f3])
        by smtp.gmail.com with ESMTPSA id n16sm3757948pja.46.2021.12.08.14.39.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:39:29 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ V2 PATCH 4/5] plugins: Replace random number generation function
Date:   Wed,  8 Dec 2021 14:39:22 -0800
Message-Id: <20211208223923.519664-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208223923.519664-1-hj.tedd.an@gmail.com>
References: <20211208223923.519664-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the getrandom() syscall.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 plugins/autopair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 665a4f4a6..a75ecebe4 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -17,6 +17,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#include <sys/random.h>
 
 #include <glib.h>
 
@@ -49,6 +50,7 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 	char pinstr[7];
 	char name[25];
 	uint32_t class;
+	uint32_t val;
 
 	ba2str(device_get_address(device), addr);
 
@@ -129,8 +131,12 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 			if (attempt >= 4)
 				return 0;
 
+			if (getrandom(&val, sizeof(val), 0) < 0) {
+				error("Failed to get a random pincode");
+				return 0;
+			}
 			snprintf(pinstr, sizeof(pinstr), "%06u",
-						rand() % 1000000);
+						val % 1000000);
 			*display = true;
 			memcpy(pinbuf, pinstr, 6);
 			return 6;
-- 
2.25.1

