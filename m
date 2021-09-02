Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A2C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8024860698
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbhIBKwV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245589AbhIBKwG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:52:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DCC0617AF
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:50:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j11-20020a0cf9cb000000b00375f0642d2dso1212802qvo.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+chwaZbbMAUDVjk5/HeDGz0egFmhkV86cNDd2nRvrXU=;
        b=F5H4Tm8X7ZHK2VRpN7X1/01T5QzW0QUC7lX6mI0JGF/PfhD73GOyA/FG9eVqs/xYO5
         bE2at3dJs24FBxKcgmrZF1BdrfW9GFZ9blJ6mkDV7DPm5Fhj8Pcs2FFHXrFZnDCPJq5H
         TpV7A0nIGit43VQ1Nh4waYkm91nUKD71DmE1BtXW8eCdrbWhncCFaShX/wkmZYLTjxzL
         SkF91mgIicxRgRuBKPFqROY5KOQUOBALUGjAT1p4cusejc38ug4y4DF9RVdqPmDQa98O
         cNuVHi91CobK87oUutmIX94sHdmM6edh4NfVZDb/S2YJsenaK4Px4EKxmjcAHb02ttND
         tPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+chwaZbbMAUDVjk5/HeDGz0egFmhkV86cNDd2nRvrXU=;
        b=KVgyRBlH02Zcbl9Epw22C6qFflUd8VxgnHUl412mlsB2I8LHAwnMIZS31IeaF2AbKy
         C0Qmm8O/HrqdEY2LVyJPgwQxU9tIPGLqbVEhdzTv6cae06P7uRZEcCRbpnZPm9PQTm5I
         v6sucrECpFczq6E8rM/kjyLeGEoTt6ryrlu73m8rnfGkKFoU901/jda2KvGnqsmjp+kU
         4HCsUzE7+euf37xpCPTlgLu80wERedftfYHY0qQeV9VczBkhMemM6m3epAidwFcP+HFd
         9rcSS4iCVkn97s8/4jeUJL1RNcMqcCggRmFToxT/pkXNIbSrip4TLDslGVDbUZV9xeYi
         K39g==
X-Gm-Message-State: AOAM533apGYS8yyoQ7Dij50LfTI6nA8gsK1aMXmHnkX6GtoSQubwnxJP
        TWKh8HNk7Jl4nv1XVErb36MtKQKP2FX6+dPtWLV0F1Li5vL2M/9YrG2EiLUR2yTmdFbvl6hw1qi
        3Ub70CpRJV4dpPRRYBHyHghEHFIVNHXJcQvJU3OIzSwS822aSKi0EEJu6OWmsvMUHn/gmIJj5cR
        w9
X-Google-Smtp-Source: ABdhPJxTSzLSl5YhhQPOWCx5bFSlM8h0KDzCtEm/vvAXDeP54vnPyu4lOFaudSYvQt5wys5/DWJx5fMWMU9/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a0c:f901:: with SMTP id
 v1mr2166083qvn.45.1630579833988; Thu, 02 Sep 2021 03:50:33 -0700 (PDT)
Date:   Thu,  2 Sep 2021 18:49:37 +0800
In-Reply-To: <20210902104938.824737-1-apusaka@google.com>
Message-Id: <20210902184744.Bluez.v3.11.I864344f9ee91b9c051ae4212c9f5a236bdd49632@changeid>
Mime-Version: 1.0
References: <20210902104938.824737-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v3 11/12] unit/mesh: Inclusive language changes
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

