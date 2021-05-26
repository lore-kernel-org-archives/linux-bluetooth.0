Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB10C4707F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63656140F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 00:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhEZAV6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhEZAV5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 20:21:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881FC061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:20:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x188so24895762pfd.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 17:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H2zwyia3p7d2uxe0ZBO4miRasBmJH8+968BsSYNruX4=;
        b=s/5qdEWP22e4gj/VUTNg34dzJKmTThSZ7TzvYxhi6PPL952yOpWnIvWW9EP4KmvVGP
         QC6bdmH38hisY4cL97WyB3JmGpQYgZZa681n4g85iF5A5GgeWzceHVanfvDzWafgHwky
         sCxH8eROwM3i0RdEIxJ02qQAzLebIdZUj4aP7FqcJWaXWULizoyTOY0svulYKQGKI8Nz
         Pd62bxciJgarc5R8h33wE/kX4oaFVfnaiGz3ZYpHdrztj4BF+EZ1AiU03N7DqXEd0NNE
         vMAdn+FA/Bi9EFIl1yQ0+owMj4ZaictAhDlYC+jUJeajjs12NTT1EZQj746rBZ1arkYd
         X9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2zwyia3p7d2uxe0ZBO4miRasBmJH8+968BsSYNruX4=;
        b=qnAxfjo8DwnjE1H8AbiSw3HUf0rili6f7MBMGu6e0PSEyaPtW8M3D27dvyrBI+MjZr
         yQMaxCaUiI/Mk5o8huE7CdtE9EaVqRpfY+DQ6zYWtx/XNUmZZt5OBHVpl+39yPDkkGaV
         2DOvrrPTKvKFBKOhlJxi/v9H4mc0BkfTVcV//yx3wIZkbANI7cwP/D6BWQ65iWGFDdQu
         Hm5+7g4zA49j8LX8omV2rHzDb2/11domKTW/vc1zvm28pe9hxAj1sRCvHyxoyZqAGsQu
         UY/y2Vp6RzlOtJmBxunvacWU/xo3Q/k5qHlFj5JjaaGV0Zv77R0i60pM1Kgs2LLBfnq9
         HpNg==
X-Gm-Message-State: AOAM531PRe2JCMXXqyk5CrulzqTaiJn3fUWC+QUMLRUn0Cg6JkBAHGdM
        2ytd23GMJ9QAVd/v457oy9THFjZZ2jfCTA==
X-Google-Smtp-Source: ABdhPJwVedJunCKLH0g9GcDyWJPOvEvYemWSBFGdsXhc8mIwpnSJ/m+BwBpe2RydKPpe3OLHGUKjuQ==
X-Received: by 2002:a62:1796:0:b029:2d5:91b4:642d with SMTP id 144-20020a6217960000b02902d591b4642dmr32069304pfx.7.1621988425923;
        Tue, 25 May 2021 17:20:25 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::e853])
        by smtp.gmail.com with ESMTPSA id t19sm14305726pfq.116.2021.05.25.17.20.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 17:20:25 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/4] lib: Align mgmt header with document
Date:   Tue, 25 May 2021 17:20:22 -0700
Message-Id: <20210526002024.412237-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210526002024.412237-1-hj.tedd.an@gmail.com>
References: <20210526002024.412237-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the mgmt header to align with the mgmt api document
(doc/mgmt-api.txt)
---
 lib/mgmt.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a85f891c5..0a6349321 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1087,11 +1087,13 @@ static const char *mgmt_op[] = {
 	"Set PHY Configuration",
 	"Set Blocked Keys",
 	"Set Wideband Speech",
-	"Read Security Information",			/* 0x0048 */
+	"Read Controller Capabilities Information",	/* 0x0048 */
 	"Read Experimental Features Information",
 	"Set Experimental Feature",
 	"Read Default System Configuration",
 	"Set Default System Configuration",
+	"Read Default Runtime Configuration",
+	"Set Default Runtime Configuration",
 	"Get Device Flags",
 	"Set Device Flags",				/* 0x0050 */
 	"Read Advertisement Monitor Features",
@@ -1143,6 +1145,8 @@ static const char *mgmt_ev[] = {
 	"Extended Controller Information Changed",
 	"PHY Configuration Changed",
 	"Experimental Feature Changed",
+	"Default System Configuration Changed",		/* 0x0028 */
+	"Default Runtime Configuration Changed",
 	"Device Flags Changed",
 	"Advertisement Monitor Added",			/* 0x002b */
 	"Advertisement Monitor Removed",
@@ -1172,6 +1176,7 @@ static const char *mgmt_status[] = {
 	"Blocked through rfkill",
 	"Already Paired",
 	"Permission Denied",
+	"Connection Not Established",
 };
 
 #ifndef NELEM
-- 
2.26.3

