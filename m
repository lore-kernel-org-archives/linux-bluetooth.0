Return-Path: <SRS0=8P1K=QT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F62C282CA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82C82075C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="WyMYHKf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfBLPPY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:15:24 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43917 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbfBLPPW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Feb 2019 10:15:22 -0500
Received: by mail-lj1-f178.google.com with SMTP id o1-v6so2510658ljc.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Feb 2019 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBFE/qJkwx0r3PCdtI1ax/QbsYySMr8iYKVWk7orY3g=;
        b=WyMYHKf4J/TjmwOHkcOezwO/N7g4Nf8RBl6Ucn6jCx4lRudVE+mCw2LYbtdr2HjR1I
         monPlnwbTuEXGT0cRoHSOjTkZzWls84hJ/d/zQrf0y5wpiiAiFe6sE7TS1TCf8gnqWc0
         STqtn5HsdcMEWReXLsZDyld3M/l1HahRgDCodsa64gv2pxn0XW3CsN0zpfkY0/1ahkVU
         wjP8JhU13Sgil97RN3dSBKN/NJ7vFdfTcRgDoUeqQ9Eek2a7QD5PR0GZgSt5ZjG9dAFc
         6jFyss/i3fMMT/bbjoVuHKx9EPc7po4kzOhfP+V/i1misxmHy1dCA4Zz5BC/4t4Q3Mve
         dWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBFE/qJkwx0r3PCdtI1ax/QbsYySMr8iYKVWk7orY3g=;
        b=kEIrEacnVpsJrPK4Sb2QI5Gh/yfZDsfkxOs9dW6ndciEE+OdeLKjksyaZN7GUMbIcX
         I1JvVzDRBsUrm0NgO6VB3FKeE5GjeoTNyLCegwbBQh4PWEIADTwmIFMq3ZgLupuxvWXC
         WklN5O5x+14QqoI3yL9tNfSp4rhs5AqiY39zKwdcwsU2dS4D1qUx8fr6xBk8oQ1A2pxC
         JQYYFzMS4Nte+Z7IKmmVOWTDFq7XEexa+1ISJe/FKbStWeXxrsxlfWVh2cVuABzuQEID
         cg3fbDRPQau9Hkc39yQNCLwVad/IQlQODzRXutOH+8Jc50P+KbxA5FmUvS3Y/vdlcLqV
         fIJQ==
X-Gm-Message-State: AHQUAubBRiGPaaaDrWqTUXc/vgu3S2qGEYs5VkX4wuy+m+2YUSxGjmjk
        FmKsE2+Z7ma2pvfVlvNCHoJzQuTiVEs=
X-Google-Smtp-Source: AHgI3Ia3wUqrIPKgvf6Sp7JVyK838tD2vlf7uk8L6Kh4vWYsmYaD0ksiPABBBCkrbpIFrzFKp/AfpQ==
X-Received: by 2002:a2e:834a:: with SMTP id l10-v6mr2829668ljh.42.1549984519947;
        Tue, 12 Feb 2019 07:15:19 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id u11sm2996636lfb.85.2019.02.12.07.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 07:15:19 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/2] build: Fix missing dependency for btpclient
Date:   Tue, 12 Feb 2019 16:15:14 +0100
Message-Id: <20190212151515.13436-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

prog_DEPENDENCIES is computed by automake only if not supplied so we
must provide all dependencies if provided manually.

This resulted in random build failures:

libtool:   error: cannot find the library 'lib/libbluetooth-internal.la'
    or unhandled argument 'lib/libbluetooth-internal.la'
make[1]: *** [Makefile:5436: tools/btpclient] Error 1
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 1f8271542..0f94bbbe7 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -471,5 +471,5 @@ noinst_PROGRAMS += tools/btpclient
 tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
 tools_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
-tools_btpclient_DEPENDENCIES = $(ell_dependencies)
+tools_btpclient_DEPENDENCIES = lib/libbluetooth-internal.la $(ell_dependencies)
 endif
-- 
2.20.1

