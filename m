Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08B4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 19:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350173AbhLWTuH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 14:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350170AbhLWTuG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 14:50:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C38C061401
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 11:50:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j13so5133866plx.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Dec 2021 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=J2lS0iRw5GOOkYspCEPwL67WJGoMMJgZHxHo5YI4B40OVQ8x0JVrF5X7snviYiRxBm
         6Mj9UigBFR+mcFKAdpMhRQRGAI5TkwMx30Pw9z8kRUsy/0tk/SkRrGdBh8YDLlEUtarK
         5Wf+xvDhCHGb1gWxDOO6JrlcrILFYbbD5I8aJHEcknoHNadtkShay1Uh9B9CkUYqi/fR
         6ErAjh1NOj4Wi44OAIkmWi0Djpzbx7KuFtLwmXiQTRjYYx/6P8fScVt7lSmC6CNrUxME
         HvV9rn9nlcZKHeWbaWD+Ms50k7R8i+miOm9ypPFlV6ZcaC8tKmOGWer0AGIDpRson0k5
         LtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=VkjHwYucSEC9lwaM0L6MbmTE9pVOdN0Q/GSr4NR0KHNlr6Tj0tM7tnnBkU6YgREBuA
         KIReBI1p5qVNCn3x74N50N47VK+pI2MaZHXLk3xmtg2duvbGT0eeCvzLGhGR0V8fbyQl
         thrMumh6jlN3KAK1rRT2eCCrCT3zmtgkcQHzJJ+Ch3HVm9BKXrauGPXqmkXNRiMyI05N
         /3Z+yk7A/e8FAaexDIRFduiOQ1t4tqymz1Ve3sBWOd0h/RcriLuZjNdmp1DgWhDnhWch
         AQQJmV6iQ4oieI6RgdQfhN7H9ANgEG0fI9iwLQYLM3yQzlIiYWWW6kn10o44xDk/eDZZ
         n55w==
X-Gm-Message-State: AOAM530jFQk+hVCnm1tARvzAbanIqz+MeHSG1OnRyQli5gWEvVqx9pI4
        w1uJffGZ3RSGB91kwXi8p1QOwDe3as4=
X-Google-Smtp-Source: ABdhPJz6j0EmrEFzEXlo/H0D0gyJNlEAKSbauzgiquuqffrES3L57HllHBUI+1sc00vOAYbGGs4xKg==
X-Received: by 2002:a17:90a:aa95:: with SMTP id l21mr4171312pjq.215.1640289006014;
        Thu, 23 Dec 2021 11:50:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mu2sm6631894pjb.43.2021.12.23.11.50.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 11:50:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/4] bootstrap-configure: Enable sanitizer options
Date:   Thu, 23 Dec 2021 11:50:02 -0800
Message-Id: <20211223195003.1647434-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223195003.1647434-1-luiz.dentz@gmail.com>
References: <20211223195003.1647434-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bootstrap-configure enables all sanitizers.
---
 bootstrap-configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index a34be8320..8172840d5 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -28,6 +28,9 @@ fi
 		--enable-btpclient \
 		--enable-logger \
 		--enable-pie \
+		--enable-asan \
+		--enable-lsan \
+		--enable-ubsan \
 		--enable-cups \
 		--enable-library \
 		--enable-admin \
-- 
2.33.1

