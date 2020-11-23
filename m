Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D77C5519F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF0A20738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 00:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqdE02Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgKWACv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 19:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgKWACv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 19:02:51 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19A72078D
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 00:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606089770;
        bh=X8osNqF4IGVV8yXK++K/JebfF32+qRFYWO/A3kWzsoo=;
        h=From:To:Subject:Date:From;
        b=NqdE02Lp0RtxZTKaOua0raQ0mZvQgvadamVYkhd8MfJeJrWbIiDMI68/ceRSQ4+gM
         2YYCcrC6E9lCgW609GglmABsHywVPyTTaI4AiUzlYYomsdbvGX9Ua5bs0RbQ1bMgRC
         EhfZUhb90lm0/x4yqDjdYb4QAxbc2ghHJiW2RKGE=
Received: by pali.im (Postfix)
        id 1D8DA798; Mon, 23 Nov 2020 01:02:48 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] sbc: Add sbc_reinit_msbc
Date:   Mon, 23 Nov 2020 01:01:57 +0100
Message-Id: <20201123000157.13003-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new API function sbc_reinit_msbc. Like sbc_reinit or
sbc_reinit_a2dp but for msbc.
---
 Makefile.am |  6 +++---
 sbc/sbc.c   | 18 ++++++++++++++++++
 sbc/sbc.h   |  1 +
 sbc/sbc.sym |  5 +++++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 7ff0c7d..8a58b59 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -6,9 +6,9 @@ AM_MAKEFLAGS = --no-print-directory
 # Interfaces added:		CURRENT++ REVISION=0 AGE++
 # Interfaces removed:		CURRENT++ REVISION=0 AGE=0
 
-SBC_CURRENT = 3
-SBC_REVISION = 2
-SBC_AGE = 2
+SBC_CURRENT = 4
+SBC_REVISION = 0
+SBC_AGE = 3
 
 sbc_headers = sbc/sbc.h
 
diff --git a/sbc/sbc.c b/sbc/sbc.c
index edbe332..d059906 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1087,6 +1087,24 @@ SBC_EXPORT int sbc_init_msbc(sbc_t *sbc, unsigned long flags)
 	return 0;
 }
 
+SBC_EXPORT int sbc_reinit_msbc(sbc_t *sbc, unsigned long flags)
+{
+	int err;
+
+	err = sbc_reinit(sbc, flags);
+	if (err < 0)
+		return err;
+
+	sbc->frequency = SBC_FREQ_16000;
+	sbc->blocks = MSBC_BLOCKS;
+	sbc->subbands = SBC_SB_8;
+	sbc->mode = SBC_MODE_MONO;
+	sbc->allocation = SBC_AM_LOUDNESS;
+	sbc->bitpool = 26;
+
+	return 0;
+}
+
 static int sbc_set_a2dp(sbc_t *sbc, unsigned long flags,
 					const void *conf, size_t conf_len)
 {
diff --git a/sbc/sbc.h b/sbc/sbc.h
index 835460a..65d5ef3 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -85,6 +85,7 @@ typedef struct sbc_struct sbc_t;
 int sbc_init(sbc_t *sbc, unsigned long flags);
 int sbc_reinit(sbc_t *sbc, unsigned long flags);
 int sbc_init_msbc(sbc_t *sbc, unsigned long flags);
+int sbc_reinit_msbc(sbc_t *sbc, unsigned long flags);
 int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
 					const void *conf, size_t conf_len);
 int sbc_reinit_a2dp(sbc_t *sbc, unsigned long flags,
diff --git a/sbc/sbc.sym b/sbc/sbc.sym
index c1f6919..938301a 100644
--- a/sbc/sbc.sym
+++ b/sbc/sbc.sym
@@ -26,3 +26,8 @@ global:
 	sbc_init_a2dp;
 	sbc_reinit_a2dp;
 } SBC_1.1;
+
+SBC_1.3 {
+global:
+	sbc_reinit_msbc;
+} SBC_1.2;
-- 
2.20.1

