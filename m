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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A2C4743C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5E761289
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFVBDs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 21:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBDs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 21:03:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32808C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 21so121470pfp.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeeLQxuj66jGVpXa6UNilbd/H4ckQmm68Ab/6lrUDk0=;
        b=azXB+rqjSFGI9o+PX/k4DGNLkl/hXPSiMEeX/tjgkIYEYZeqJlrWU8zMzwUE9dePki
         bd3uUXTs3SCffIZbdwVnYiPzpnjzgHId5EiGwBh5l6Qwl5r07fBJYoRyuk11HSFAFqB8
         QSdFmSWgnr2O+QerP/eWQnq370LbgVEMwApJUcc95lOHwIeVwM/b/zthdWhtleQV+gSN
         W0IiSBgsjXzLBkDdmOU9e5YiumvFLnw8dCmz5zFJ4iN2P1oUXjRgQJPq+rDJ2XS1GrRE
         fwQ40sSYMM9BwRYq1OujsFhbDnTf6hSHvj4wKUQybuYLL9k6XY92ZuidzZ8kdVeLJ/mH
         +f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeeLQxuj66jGVpXa6UNilbd/H4ckQmm68Ab/6lrUDk0=;
        b=nO+1GA57vvk9ZqKakxJT6cNxx7qOtmlF7D5k2qGJCj52CjuR7c1uoCSHd+hZK0nCcR
         lCXul83ba5enTvBxJehErDTcLvvTwzmNHkSyALhSzdatbtEgfRvxcQCSicD0yVvYV2k+
         UZxuMXaueaLV6pTarRgWsMmxOcIEta7b31Z1QChquvyx9bzOgaNNvF+UIr8vSvlIKxcs
         Hai6WpVHTYOLTATVTwPtPrJjnHh3lpYZNr8UI/gFPJmLKMrHn+PEb38qQidY7W4+/N2h
         Tplzeg2OphvfR609PQFoqskIIm0mlNhffjaxJ6NYd5QOD32B37XX6q9q3tqgzup6eDNW
         SoyQ==
X-Gm-Message-State: AOAM530qCGS9P3DMRkXpqDMOR11yETlyq3PtS1uKggfyu3XVoJDdB9NM
        QbivQPuNe5zVWYl8EPgm4dBI4lCe+QU=
X-Google-Smtp-Source: ABdhPJzITqb06Ig/dNbsDJn76ZF3poW3wepi6tukMBZwuXiH7sIPEbGLLTO9c6pv76xLkwmeT5IThg==
X-Received: by 2002:a05:6a00:be4:b029:300:effd:431f with SMTP id x36-20020a056a000be4b0290300effd431fmr904692pfu.69.1624323692452;
        Mon, 21 Jun 2021 18:01:32 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id f28sm17970120pgb.12.2021.06.21.18.01.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 18:01:31 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/5] tools/mgmt-tester: Enable High-Speed(HS) test cases
Date:   Mon, 21 Jun 2021 18:01:27 -0700
Message-Id: <20210622010131.427059-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch enables the BT High-Speed(HS) test cases by enabling the HS
in the kernel config.
---
 doc/tester.config   |  1 +
 tools/mgmt-tester.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/tester.config b/doc/tester.config
index 661d7a0b0..850fb6a38 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -29,6 +29,7 @@ CONFIG_BT_RFCOMM=y
 CONFIG_BT_BNEP=y
 CONFIG_BT_HIDP=y
 CONFIG_BT_LE=y
+CONFIG_BT_HS=y
 
 CONFIG_BT_HCIVHCI=y
 
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index fcce699d3..8cae376f4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5315,7 +5315,7 @@ static const char ext_ctrl_info1[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x00, 0x00, 0x00, /* current settings */
 	0x09, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5360,7 +5360,7 @@ static const char ext_ctrl_info2[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x0D, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5391,7 +5391,7 @@ static const char ext_ctrl_info3[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x16, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5426,7 +5426,7 @@ static const char ext_ctrl_info4[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x80, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir length */
 	0x04, /* dev class length */
@@ -5485,7 +5485,7 @@ static const char ext_ctrl_info5[] = {
 	0x00, 0x00, 0x00, 0x01, 0xaa, 0x00, /* btaddr */
 	0x09, /* version */
 	0x3f, 0x00, /* manufacturer */
-	0xff, 0xbe, 0x01, 0x00, /* supported settings */
+	0xff, 0xbf, 0x01, 0x00, /* supported settings */
 	0x81, 0x02, 0x00, 0x00, /* current settings */
 	0x1a, 0x00, /* eir len */
 	0x04, /* dev class len */
-- 
2.26.3

