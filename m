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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3B7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3656F61179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhIOIe6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbhIOIe5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B072C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 83-20020a251956000000b0059948f541cbso2693404ybz.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VqIR0WxkDkAwvgcPdijbeLpyDzbOjTuB1XgaDlGuRfI=;
        b=RMG/v/DjYngNGw9JIgE3vmSqghc+484kxRNbOt8/YAClllnu2FdzzwEKmimScEi3EQ
         AuYVF4NjQVMRjBbja7mQ1vWVpe9yj/ixrlHCUEIw42Gop5msmJ/3DEy1lAyKMf4x+Dcu
         K55Hf/CXEGKKo9nTk5oUKmPCsrWIaVsCQtxPQFRm4cOlZbm5NTj738jFVRn4h5p9NRGZ
         EZLn2yvWvuRmFNtf+iIAlyTK+YjT5y3cZ5aFpJad+dPSlkyewc9aRUOZ4GJhAdX9jKQi
         5CvL4gfI+5dGZu1jwTUt2TfmROkl6CFIQhMCLKHZSOoU06ZZTdXinnmf9750o+H7hrcX
         vcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VqIR0WxkDkAwvgcPdijbeLpyDzbOjTuB1XgaDlGuRfI=;
        b=Ul93PX0YbzEHiMcjfOFrWfnlaGuBfuYVEMdtUb7SJ9i20Au96wkfUCQpfquW0DCBEK
         y8HQ+WkovNqdC4rENUoil4/Tf7n+Ue8uafWbBgHrmTEUq/9pJJ6/Etv1ztfNfb6Amrsf
         SdWg0qcMAUJwohOWcEct8Wq5gXOm1c/4PrBEX4b+rh46N07dYywvPWHGNlE0hyVCECRf
         CQips1wsXqG1TkepdZ5DEFqbPsY7Wl8CLYBYB+KRD2Z2agjCSpQeAHO6SlN5BS+BbmJi
         +4JW4QqmdNw4wVn3mp7MeXmseLY4Pzb1M5OqBjZqCmt5d5Yth7USqIxgS9bd2zV3n4Sy
         plBw==
X-Gm-Message-State: AOAM532Xbi8SAZKBcyzBFW2evQIanq0fu3yfsa7Zi9eveCgKLoHvwAeC
        8SjzGg0Daux9K5dYiNqezgyVQMlGAlZHcPpA9Fv9yLSQV+ew6/WfS886EjwpBO1C9eeCXESyEUF
        78mu3nxlfr+f92GPQg3Cm2O+SRobYhu/YTot8JYeBAh6Wt4wxumiU9pxqMoYCFm1uIVR+270WnZ
        ZR
X-Google-Smtp-Source: ABdhPJyx8lTN9uEsHT2wdCphpSIZhQRmXwnjQ6ddHizyrn6OKTbx1S1QBJBAYIpYAFj4qLivQ7J0nq8OYyOR
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a25:9b03:: with SMTP id
 y3mr4743280ybn.264.1631694817558; Wed, 15 Sep 2021 01:33:37 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:32:08 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.12.I864344f9ee91b9c051ae4212c9f5a236bdd49632@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 12/13] unit/mesh: Inclusive language changes
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
2.33.0.464.g1972c5931b-goog

