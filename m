Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6391CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D496044F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbhIFIGo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbhIFIGo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:06:44 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC9C06175F
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:05:39 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id i7-20020a056214030700b0036b565ee6c0so10560355qvu.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JdUla9Ab9VCr1GVWOVLpNdEFxkhBxHC0jS6cKjr+lO4=;
        b=ZAymSi8rUDZCUir0AcQmbd9H9akRftSjKl1DAq3BibgaEEYlhfB1SHXragC6nOCpYg
         wXPmhRRJsobXnskGI9rKUYCUKShM0XeQk128clwnZoA09tayvgllYRyg9w0bOb10btQ6
         Xzy7nm+xkgyyO5a5lL7+0DesbPkMmyTmXVAiTOYMz1KjU6m6+iPyBICIGg6lZTYJz1FA
         GHp2c+MgZHQY5/7gw+wjhBsHW6v8K8XGtWISL+LMo/Yj699lZJPQwEM091bBKjlcDUzF
         uvV4nKCE4bmWd3hNGpxb6U1pL6zCw2Y1L5fSNOkQzFkw9cU+QPhZz0FaZaejW4xzr0AR
         rE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JdUla9Ab9VCr1GVWOVLpNdEFxkhBxHC0jS6cKjr+lO4=;
        b=D613J6lnO0dl5rIkp24Sn9waRynWO61mYmIpnMVcRwWwA0e5Aq69vb0eEGN0Fs6c6X
         rn5d5DUxaHQIA3chmKeQpucZwyRf8irZhHViiaok+YDPpq/rCzYtXRBQwRaDETSt3Qpx
         m3AgKMU+p4ifyeGE36DpSDfDA+WKDln4JfIYpkKwJB8WsYs8U+37+9T5S6rbU+uNcNwX
         1xPaObR6gqkgea/4apnLqoufR4G5bdWiD0Oxz+6a08uttwTXSzBbu2NH7PGR4vLPX/Rm
         uU6a6QmlT70L1Z3qoTshbLdytCjhYtkMqHm8EC5GMzuMl7wZAA4BqmvAkCm5T0c9fS5V
         aBnA==
X-Gm-Message-State: AOAM532g2GncEtSbDOQbUG+nn3BVycP2tDiaR2PYM42/2vTxKnI+K+/U
        xl7GUqQnSUh4IGorqzu3FWe9RMRtiC4THVJVKGN9rLv9o3oDLX4X83bRWmJ5xL6UXOp+TsZn4Qg
        nPR3/0IZhOSSn8Ju8GCPE1dMQLqYd9qDCFTUOBUNzQzuM4KTLAJ6DWHGCIib83ogYsEpJ0Yxmb8
        rF
X-Google-Smtp-Source: ABdhPJyo6CvEqAf3sWBoOJUk2o4zehMi8oI4fY559FkdKldeSYczcQJDWy90S4tPdyS9OjQgNNmuzDytjy6t
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3b13:95ba:12e5:7134])
 (user=apusaka job=sendgmr) by 2002:a05:6214:1142:: with SMTP id
 b2mr11045135qvt.0.1630915538929; Mon, 06 Sep 2021 01:05:38 -0700 (PDT)
Date:   Mon,  6 Sep 2021 16:04:49 +0800
In-Reply-To: <20210906080450.1771211-1-apusaka@google.com>
Message-Id: <20210906160340.Bluez.v4.11.I864344f9ee91b9c051ae4212c9f5a236bdd49632@changeid>
Mime-Version: 1.0
References: <20210906080450.1771211-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v4 11/12] unit/mesh: Inclusive language changes
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
2.33.0.153.gba50c8fa24-goog

