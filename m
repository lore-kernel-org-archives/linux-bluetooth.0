Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7E7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 18:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014036115C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Oct 2021 18:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbhJPSCx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbhJPSCv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 Oct 2021 14:02:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F8C061765
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Oct 2021 11:00:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 66so11755615pgc.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 Oct 2021 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M085LcD41LDDIK8Rg13RjGP6BPFnmb74fCHiD2WUIlI=;
        b=HllmaOadpV7PuhG1PxpnlIyM9Umf15yDGIJ+DMtKtfx9HqwJBYyDURzJHy8PmwjNYq
         CbpG136paxsCdiNjto46fDZrhKhjMFhPjGXQXqVixaCuNf0XOoBAtpGlsVEMJ728hy/C
         sU+XSVx+j7ek4wbf8wXiOuucwBwSo/yucRv7iczoHf9pPxDbUDRmU1wC7u3P5LcRP8YV
         apREmUi0TySsYUM+1gA7WxYxkNkTgk51USW1MKfolgC3V8a52Gnvz63yyHrVCZdkOANx
         ElB27nqb1PoUeQSCS+fl6NZ35wUo2ALL2jKY1BfA9LtvYe2xe9tZUdTv85QVo4VnN+Hi
         F8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M085LcD41LDDIK8Rg13RjGP6BPFnmb74fCHiD2WUIlI=;
        b=GBDklOQH1A72N7dcugmpjnmJWy/Gs1M1U432QK722y081k4OnB9tcLx/dUTL+uhm7T
         F6L2V0EHTGp344BO2fB4pzloq0WSVqie9GKrKdPZ9kfYtHM+qavKSGF106f0B1KCnZyG
         r7ZiJriplg40kiUnijJplh7DS3fEHW6agtQBCxq73+jing0ZYVZUFbagqddWgyK2nsJD
         v1y6El+jmP5pJAj3bXJiCFu1LF0OtrpCJZ64WGFKp77Dh/51GmfYMU1pitTV2dXsP5fD
         K8huQFJtXyJHTP8+pmbBpQ4etrZlizhIdBx/pC8XP+JbmlK1imWr28Zw6QRrkB0sma1h
         iFLA==
X-Gm-Message-State: AOAM533J0k0aCn+nGONC84tSjRMPjqVi9XQWHvx6KkxoLduDpvPZHD6O
        nAUsdmr5eDYcJA4LCuFNbHbRRJ0+hEAIeQ==
X-Google-Smtp-Source: ABdhPJwUo0YdMn2ZeDqfIKmUbf88ByJMXs47+UZyEynUexIYLa+c9kRPggX0prSr2Jy7YZmvzOio5Q==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr14740824pgb.39.1634407242780;
        Sat, 16 Oct 2021 11:00:42 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:7cf0:730:2c83:c489])
        by smtp.gmail.com with ESMTPSA id o14sm8321470pfh.84.2021.10.16.11.00.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 11:00:42 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] build: Fix build error with ell/cleanup.h
Date:   Sat, 16 Oct 2021 11:00:41 -0700
Message-Id: <20211016180041.477315-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the build error due to missing ell/cleanup.h.

./ell/util.h:33:10: fatal error: ell/cleanup.h: No such file or directory
   33 | #include <ell/cleanup.h>
      |          ^~~~~~~~~~~~~~~
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 268c797cb..a9439588a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -145,6 +145,7 @@ ell_headers = ell/util.h \
 			ell/tls-private.h \
 			ell/ecc.h \
 			ell/ecc-private.h \
+			ell/cleanup.h \
 			ell/ecdh.h
 
 ell_sources = ell/private.h ell/missing.h \
-- 
2.25.1

