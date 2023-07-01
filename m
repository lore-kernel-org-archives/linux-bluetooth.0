Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C531EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Jul 2023 04:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGAENF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Jul 2023 00:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAEND (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Jul 2023 00:13:03 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFD92
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 21:13:01 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bd6446528dcso2551901276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 21:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1688184780; x=1690776780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rq0+wc8el5OWiq5aP4AyS7h40iIrwF8fTq8KKhQSqSE=;
        b=UFB/L3Nzx6FGdGPK9+fvSp4WeBy3T41aLcp9NA+j1L21e9t4zXHNelgJ6OSrDz1Fi2
         jb3yYJrKGgkQ/0rXnBwO9zdopLxwjrtFBj+KfKAFL5r900r4Y2054f9OCC+YvyM2ZFza
         UY1koomMUf8b9JKmUw/uinJijk5eOKSjRKHZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688184780; x=1690776780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rq0+wc8el5OWiq5aP4AyS7h40iIrwF8fTq8KKhQSqSE=;
        b=FJDVqxEChlKOEXVMsMzR3ERCnTkK/GMLBTxvCNg8KCwq52jKFLwNSIsOCRTc979R4Z
         nNvePsEHjabJm8gcA+7O9vGM65ZMfoRR3pkAmeueJlkBNEOGn9XwUf3TbUISsa+UcdZl
         X5j50kDkulgk94OjSnr3uzKlre+z5iZvlsmzLnnDV1FRJejf/H7xVRtl/2lzsqnoS6nw
         Vft9By1w/ueUzfCQJhXgl28XWTLbeSJaqBEHUnqOySkgc2+pVek9mDC6P/Mgl7t0cg85
         kKp9t3yiezi3vsbWQT0y2sQSjcN+FpT1W6XDN1BGzHvkuQRAYoD1Z1qzjX6RdGWnNelo
         NvUA==
X-Gm-Message-State: ABy/qLYsxjQlAVKaQHM9PSG2i1Qz09qe5xByHK6/QBu2zjANAawJzCvM
        AMYenlBxmuLGgZa4sWdI2UkymjQ1E+0Iz0q/kUgjwshx
X-Google-Smtp-Source: APBJJlE/zVZCMWi+UzBIjUGC3cSnTJNAOjjd5vudqwT89E3gOu1xynCaPK0n7suR69Cr2LQbJHiLeA==
X-Received: by 2002:a25:f808:0:b0:bc7:afaf:539b with SMTP id u8-20020a25f808000000b00bc7afaf539bmr4883826ybd.43.1688184780226;
        Fri, 30 Jun 2023 21:13:00 -0700 (PDT)
Received: from 6a33e4bd7b5d.heitbaum.com ([122.199.31.3])
        by smtp.googlemail.com with ESMTPSA id r4-20020a632b04000000b00553ebb05d28sm11285290pgr.41.2023.06.30.21.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 21:12:59 -0700 (PDT)
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH] configure: Fix check ell path for cross compiling
Date:   Sat,  1 Jul 2023 04:12:52 +0000
Message-Id: <20230701041252.139338-1-rudi@heitbaum.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use of AC_CHECK_FILE prevents cross compilation.
Instead use test to support cross compiling.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 configure.ac | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index eff297960..bc7edfcd3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -298,9 +298,10 @@ if (test "${enable_external_ell}" = "yes"); then
 	AC_SUBST(ELL_LIBS)
 fi
 if (test "${enable_external_ell}" != "yes"); then
-	AC_CHECK_FILE(${srcdir}/ell/ell.h, dummy=yes,
-			AC_CHECK_FILE(${srcdir}/../ell/ell/ell.h, dummy=yes,
-				AC_MSG_ERROR(ELL source is required or use --enable-external-ell)))
+	if (test ! -f ${srcdir}/ell/ell.h) &&
+			(test ! -f ${srcdir}/../ell/ell/ell.h); then
+				AC_MSG_ERROR(ELL source is required or use --enable-external-ell)
+	fi
 fi
 AM_CONDITIONAL(EXTERNAL_ELL, test "${enable_external_ell}" = "yes" ||
 				(test "${enable_btpclient}" != "yes" &&
-- 
2.34.1

