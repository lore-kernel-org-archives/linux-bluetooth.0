Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B806FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0EF610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbhHMMUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhHMMUb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:31 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643EC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:05 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id bo13-20020a05621414adb029035561c68664so6918804qvb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QaLclhB85/cauEIPsHpq5YPbMmoQlX3Cg2QfR0Ui6yc=;
        b=t8VC0g+m//6pk7vxpv20EkQuR2iPT3XG4p1jE84aA8vW/A3Gbru+YLT6+hque/pgcR
         uzecx0XHyz0Wx5RHMbLsXQz71jH3v3W0iGAtylgmqM+3O/FQXlUZr4Y+RVaThVD42Vod
         AbHCFTXyNaM5wPz2dpgLk5rIAKDzLEbqfqJ1wIZyCRoW/o6sTh1H7cBCkqP4squ8OmwQ
         73+9jx0G+Cd4a0ZP0j/gVzHzk2lb/ZzDtqwN1AmxbUMt+7b88hifeCe1IwH7RH1Joom5
         gusPMmbONtxzYxLa/eE6jBjs8f7GOkgjcs/ip7scvinFVIzAMvimHMhnoymE2qMunR1L
         HqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QaLclhB85/cauEIPsHpq5YPbMmoQlX3Cg2QfR0Ui6yc=;
        b=cjmtsYeKT75OuNEMFSfGaU9peDpZxx3cFiD+M2aQ55nLukuErdcS4HWq+GG2DNbF03
         s1+MuRXIjym8Ys0Hk9/JSD55Qcc5wVKmSlAzInTFRYuy2dTwszMt/Mb7T5nAVnXAPSx7
         leFzSD8/xz87m9FZbYLp3nqwJJxy4DJW5PtpUxpRyQnVm3atwYjWGeoxIH/NUcGjFOxG
         +VsoXYxZhVmaUMXUxovEB2BlLOIjwZc2W8mp0839WSknJ3cgKIQ9Vw5ZJIpKqG1TrL4a
         G2+35+Pr5IETFBIrAY8z7+YmgR31FdCuteN5JX5AhLOiAxx5jZ2XXtFP2gqEukx5ZBPc
         1BLg==
X-Gm-Message-State: AOAM532H2lgN9x4urAsYN37ILaDkHbOsowRetLUE2FMXD6ULdZz5d8Ra
        tPOwkEbhJbboskjqLpsQ4c0GTe5NspZsMpTlXPFqUtO46W99Ax/NonCD4dw+11TP5TBKKOjpjh2
        YCD5Lt+posdxgmdiUhmSztI6EH9ViJ6/o2aE/WbAJhy36tjgJLAgtlMaJDmByzXUj1W7QC+f2Yn
        QK
X-Google-Smtp-Source: ABdhPJyxN6H6icnw4YWucR6CUXWBZ80xIeVIUr5wibieFqhzuqkoxk/lSZjljlr1QwD5Pw4lsbEKUiasMyj4
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a0c:c250:: with SMTP id
 w16mr2428319qvh.10.1628857204219; Fri, 13 Aug 2021 05:20:04 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:53 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.8.I4df08516dd5129d4e9d2cf963121074f500201d9@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 08/62] doc/mgmt: Inclusive language update
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

Update the docs to reflect the changes in lib/mgmt.c.
---

 doc/mgmt-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb00..97d33e30a1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -855,7 +855,7 @@ Load Long Term Keys Command
 					Address (6 Octets)
 					Address_Type (1 Octet)
 					Key_Type (1 Octet)
-					Master (1 Octet)
+					Central (1 Octet)
 					Encryption_Size (1 Octet)
 					Encryption_Diversifier (2 Octets)
 					Random_Number (8 Octets)
@@ -4019,7 +4019,7 @@ New Long Term Key Event
 					Address (6 Octets)
 					Address_Type (1 Octet)
 					Key_Type (1 Octet)
-					Master (1 Octet)
+					Central (1 Octet)
 					Encryption Size (1 Octet)
 					Enc. Diversifier (2 Octets)
 					Random Number (8 Octets)
@@ -4459,7 +4459,7 @@ New Signature Resolving Key Event
 				}
 
 	This event indicates that a new signature resolving key has been
-	generated for either the master or slave device.
+	generated for either the central or peripheral device.
 
 	The Store_Hint parameter indicates whether the host is expected
 	to store the key persistently or not.
-- 
2.33.0.rc1.237.g0d66db33f3-goog

