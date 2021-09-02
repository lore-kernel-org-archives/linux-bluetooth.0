Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE2C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD0F60EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhIBEJZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbhIBEJR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:09:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B33C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:08:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o22-20020ac872d60000b029029817302575so442768qtp.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+chwaZbbMAUDVjk5/HeDGz0egFmhkV86cNDd2nRvrXU=;
        b=Iw4+t7dyWc1w83HaO0bNT5ojih9jfEtlNn3w88/4LXml0vFEZbJQ9ew1bKM1Io4PZa
         2eTagJjM9VUrWIhFEfNM/+jrc3n7UuQB8XZ7OtTxC24tcLqKzqP2qzwXnrNb9BsaFuqS
         7zUMKq/y7GR+W2n1Be2nFpRkOu0xQ8WYsxqk05AQGQl6ejNK7XVt/I7rl8gDvywyP8xS
         od1md86/mam6aTU4GmEHHKe1QcDWYv0pteEO1Cc9Kw4i5dOgI+JvBMFdPbODx2U3pj3c
         upSphe75qWbSx3+Bh2KMo1QuehzJq9qjDe4KbHczWvYoXAPeCOiGKODDbCFHYXzOAkkC
         V5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+chwaZbbMAUDVjk5/HeDGz0egFmhkV86cNDd2nRvrXU=;
        b=Lx+DtfYU3YVo30nZXDECRfZfesvbpo7PegVGIXInAIwcxo5ajEbADmZbDdcZD3nP02
         uGHsKBOM/M6nzByuvfYuvwAEK/GOygAML4m9Jl7epAoFqvwHZ2m9ZKKTwMOEc+F8ADdZ
         pw3ydIu02/ypdaTo51RQG/GLX97eSfkE1000P9Y2g5ouzICuNnvtgFvgn91ywyEeT7OZ
         yWgHzZZB1EP8XWMAre05IRyU7y3hLFhjE1XheaVMc9UFxxgJdzziTjOL0gc7ECIeSkUH
         vdN7qds1+zXHy4d7rwfMtHEmzKRIpeeoSglLFfeQKPG43MhNMKnOgRi490a75P6y2vMq
         P9WQ==
X-Gm-Message-State: AOAM531w28YaDwPLj09ZV9FU3NP9adkOxI3W47PSDf2u0+h7v6xYE3zu
        74fVcVjkNZDDKsZOj9jn4Dq9wLZe1Mi1GyCfO1GUVSeW/A/RdCQ6IPrULJmmw4ngq6E4xF3bL9O
        p2Kp+x2J86OFx6aintsonpeEQtc/7T/eqcBYF8Ns/0Vk8LZz+hgQXQEb+Yd6SzqJCCWsqzCgsxo
        q7
X-Google-Smtp-Source: ABdhPJxDMAMNZ0+LTKVAzz9btGsCRC1iWkWLe6QbaTHqfbt+Jis7KXG/eiU9a0V3Av0kJ8vW7C8+m0oP/Rut
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:21cc:: with SMTP id
 d12mr1071781qvh.22.1630555698852; Wed, 01 Sep 2021 21:08:18 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:09 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.11.I864344f9ee91b9c051ae4212c9f5a236bdd49632@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 11/13] unit/mesh: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
"flooding" is the preferred term.
---

(no changes since v1)

 unit/test-mesh-crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 12709dace0..f9b7d81da7 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -111,7 +111,7 @@ static const struct mesh_crypto_test s8_1_2 = {
 };
 
 static const struct mesh_crypto_test s8_1_3 = {
-	.name		= "8.1.3 k2 function (master)",
+	.name		= "8.1.3 k2 function (flooding)",
 	.net_key	= "f7a2a44f8e8a8029064f173ddc1e2b00",
 	.p		= "00",
 	.nid		= "7f",
@@ -159,7 +159,7 @@ static const struct mesh_crypto_test s8_2_1 = {
 };
 
 static const struct mesh_crypto_test s8_2_2 = {
-	.name		= "8.2.2 Encryption and privacy keys (Master)",
+	.name		= "8.2.2 Encryption and privacy keys (flooding)",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
 	.p		= "00",
 	.nid		= "68",
-- 
2.33.0.259.gc128427fd7-goog

