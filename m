Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F77FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 22:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58EB61003
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 22:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhD1W5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD1W5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 18:57:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F3C06138B
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Apr 2021 15:56:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h20so33708275plr.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Apr 2021 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8ARMZ2uMHOWbPdG61OT7xuZzLhO5lhIGY9vkuOKkso=;
        b=anfZm2yXe2iPrqSa6zBqc9ETsrXSguPxFlmpFbZat1XtDi0jc4kJDtPQgtGnM7VuHJ
         FLf+C4QPYZrfDGdVqNchDBcmRBSX70DSlN5LcXXf4MF/yulUnskjdOKUQRsdwyK9FFB+
         FKYIpbbRm9ok3JEYlJBgC8JuHNWwOAvaztAEbgRzQcDyVh+AQHTCVdl2vhPYisWqDKiv
         dFd9jA7m5I3QKmh18khSdTC+6V3cpidoltTsERMas25OuY/1x6ARXgOBoobjGOp79ihv
         WLAfHwZhc+DktaLLUiE3hkJQCe2OcjF2qfYEFHAI9AebjtE+bEa2oOxJDc63CJjAogfO
         uVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8ARMZ2uMHOWbPdG61OT7xuZzLhO5lhIGY9vkuOKkso=;
        b=QEl5ZgaI30uouCy3yAD/mumh/Qej7Y7qFLn25TqEdD0kapxKmZiAjn3QATf2SwcJNs
         N6ZcArwJuCRzTI+pARmwA1fQOVFc7dz4cL8xq9ME7y9HOI6pfACaYVgm2Zd2ZWM7fKb2
         tL1IAiKz0qdMFGY8gE/vv0MQd/AZSAse6PxxxCUH2oZaePbAiXMmJDcyaNr9+RiulPxe
         JuWr9cR8ZPc0p9iI6FSqT7tr0G1260xVHA1C23mZ47JcW3dXu796JMt6l8n46CFeNf+J
         XNAVzHAX+7RFY1Oa3V5YuosynDpGTQcNwu9UzKZDBaWt9Im1Co9un4bioCs2Pc50o/vp
         0TnQ==
X-Gm-Message-State: AOAM532kYG8CbLgsjd1x8cH+0Kq0xuznubudGsslwxXVj0jwaJpIlFcj
        9ImVreA9EGSy7LVRtlauPCiuZgp1Aew=
X-Google-Smtp-Source: ABdhPJz9iiP0IxdPoM6cZCAZUg6EHfqeMqNtaY2S1zOEyDbcGwWoNHo6XR1XgIfwBT3fOm3F1tRD9w==
X-Received: by 2002:a17:90b:14c5:: with SMTP id jz5mr34292380pjb.195.1619650612421;
        Wed, 28 Apr 2021 15:56:52 -0700 (PDT)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:d830:298:3c1c:1e5c:c7d7])
        by smtp.gmail.com with ESMTPSA id h11sm440542pjs.52.2021.04.28.15.56.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:56:51 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ] Build: Add missing ELL headers and sources
Date:   Wed, 28 Apr 2021 15:56:50 -0700
Message-Id: <20210428225650.372450-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

The recent change in ELL included the header file tls.h which didn't
included in the BlueZ. This patch adds a series of missing ELL headers
and sources to align with the change in ELL.
---
 Makefile.am | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f98243f72..94f30a435 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -140,7 +140,12 @@ ell_headers = ell/util.h \
 			ell/uuid.h \
 			ell/useful.h \
 			ell/main-private.h \
-			ell/tester.h
+			ell/tester.h \
+			ell/tls.h \
+			ell/tls-private.h \
+			ell/ecc.h \
+			ell/ecc-private.h \
+			ell/ecdh.h
 
 ell_sources = ell/private.h ell/missing.h \
 			ell/util.c \
@@ -178,7 +183,14 @@ ell_sources = ell/private.h ell/missing.h \
 			ell/siphash-private.h \
 			ell/siphash.c \
 			ell/uuid.c \
-			ell/tester.c
+			ell/tester.c \
+			ell/tls.c \
+			ell/tls-extensions.c \
+			ell/tls-suites.c \
+			ell/tls-record.c \
+			ell/ecc.c \
+			ell/ecc-external.c \
+			ell/ecdh.c
 
 ell_shared = ell/useful.h
 
-- 
2.25.1

