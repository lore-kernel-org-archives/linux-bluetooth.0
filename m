Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9513EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 21:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378510AbiEDVNn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378505AbiEDVNl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 17:13:41 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D8651E47
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:10:03 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cw22-20020a056a00451600b0050e09a0c53aso803779pfb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b7WsrvbnTgwzAHR5EeEDX6HG+quOXPNtvadvNCGL1M4=;
        b=Vdme2JIRo1IaQfIdB1wxmyDU9rYtEB/+Uq7pJE+Nr2QDO+PCd882/vZ5PWVl2QpPw0
         c5W9ze6swmLRmlB3DPe5H+AKxAGb6mBWULP1NKvb2cq8BAe3MXDI2hOVYirnt9yrOVZr
         zz3KURqwx2zLgBfjYyTp4lMUXMKI3Yr7PqRPE1HI0UWLqdHO1mbqMSRAUpRbqQaoneq4
         wz/3Ly4qSTOow4Cb89Mpac9in3CnODNhvhKYjfiUzJ1y8yTbTx8utvH5AZcdP+bSXab+
         l2IqbvUVMC4VsDGXeRbgKPogaWfTCx7/zwVJaWC3k3vI4hLreJORGJuzK/WM5LUvXOSH
         ACYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b7WsrvbnTgwzAHR5EeEDX6HG+quOXPNtvadvNCGL1M4=;
        b=2rDbAB/0GWoeAo9qA/BX8Pbu6Kvrr5KiYGEESVoUknxt7wGpYTwYTh2Ot243jYahIP
         U9FnSZe00HzjM36h/2jUqHafRErEYlSoESN66L3m/VZKuQfxOvMgkzs6aJwi3P5riyyE
         WGseJ2g9fHThIb/geZKSJVyLXh4aAGhguA1yCJCBo5fdkGAwblEsXL860Mm6tDTmTh32
         xQz2EjesbPzRShqSsXleF/Bjivxa8SEoPH6A3oxeG98AkBlKCEW5gcwA8/mIY6WE2NPx
         /oeoFhyFXi6vAStbCeq0fbBEVWzfjIEGn1hfq2QAYBjqpE6zAIhlLalFnw9OVdXhakUg
         4U7g==
X-Gm-Message-State: AOAM5316Tkp9UkJMIk8Myrt7vBljSdx/IQ8V9qxOVWmjmLvTKeMwjxrp
        KSVUSQTHNjkmEk8gqAlP0DL4te4LcrXN2KiUqiG1A2PtBAZ82xNMxlXxcBP6lPvTYl3YbERVg6C
        FCosksjGmRGJj5CGJtxWlK80/fPh5MceNue9zjrqksbsCnz/xV1vXryE/DF4iOazqLaGee6EZUK
        vK
X-Google-Smtp-Source: ABdhPJzc9c7oomeKgqVfkCZs42g1vfTcNp5HeO48OFn9auFCGgF8C5ABLeubEVCOISsbOSsyU+3gXAAC8J23
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:c986:b0:1d9:56e7:4e83 with SMTP id
 w6-20020a17090ac98600b001d956e74e83mr108697pjt.1.1651698602842; Wed, 04 May
 2022 14:10:02 -0700 (PDT)
Date:   Wed,  4 May 2022 14:09:47 -0700
In-Reply-To: <20220504210948.2968827-1-jiangzp@google.com>
Message-Id: <20220504140940.Bluez.v3.2.I52f3efc7576fd0048437f1419dd2e1e687f7ac65@changeid>
Mime-Version: 1.0
References: <20220504210948.2968827-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [Bluez PATCH v3 2/3] doc: add "Bonded" flag to dbus property
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bonded flag is used to indicate the link key or ltk of the remote
device has been stored.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v3:
- Move documentation update to a separate patch
- Add description to bonded and paired

 doc/device-api.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 1e8590b27d58..c7e217c07526 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -246,7 +246,17 @@ Properties	string Address [readonly]
 
 		boolean Paired [readonly]
 
-			Indicates if the remote device is paired.
+			Indicates if the remote device is paired. Pairing is
+			the process where devices exchange the information to
+			establish an encrypted connection.
+
+		boolean Bonded [readonly]
+
+			Indicates if the remote device is bonded. Bonded means
+			the link key or the ltk from the pairing process has
+			been stored.
+			A PropertiesChanged signal indicate changes to this
+			status.
 
 		boolean Connected [readonly]
 
-- 
2.36.0.464.gb9c8b46e94-goog

