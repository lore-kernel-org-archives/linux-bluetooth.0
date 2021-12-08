Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 00:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhLHA6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhLHA6Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 19:58:25 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622ACC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 16:54:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l64so591465pgl.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 16:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BvGlbsHSaHYZ89GwHQfqmVwCe+aASVO9YDzeX3gwlbw=;
        b=WXkaz60IXYyYj5HQodAkU679DJR1a8ddPx3bL++psMWQQqohN+sCBSqoDf3QM/chKH
         O6fD9Hb3b0MuzdA/+sscPa2M3zmWnITiyauVK5kQz2/yh1cdz1eiAy54y/enI3LwZe3A
         bQPxkLD5CeS/qBGhi9QLzWjouk03NAK7OkII0pYwhTrUFiYL96vBl06OXjG6WWl1E99T
         WsTUDM9nURbsdSQbmyXWY4zn2JfA/5IJZjAeHWF678iY2ROvOq67SC/INiQyxzMWLVJI
         5jzq+lsiw7vK0+Ff7RlVjWSRK7g84eRi1pf/D28aMVLmJjN4kMeTjXfpBNEpjV+ua/uh
         8e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvGlbsHSaHYZ89GwHQfqmVwCe+aASVO9YDzeX3gwlbw=;
        b=dS+3BZsNQOecslW+r8ELryq6WIua1LPowIKJUpWT2GKrUAkhuNv3uVCR2WDJLYmX8Y
         d2Ncqejpk7UjBIwZ7NC0Pdux5ZLcwwKOVXt41kAazzvqjtKFcBrqV2FA1Bx/XI9at+X8
         hD3nokes+ONFWqAf8njFY0L36wNswEMWsP4TzF6nWLKZogtAA8Tta0F2WFlTGeK3e4gO
         OHga1U+n8TQu9eLWzPOMzsQPrFMMNl6XFHL//mVmMOnusGy73zRfU86S/lrFHx1LCoWS
         nZDjvvzLRjOB/m22X5WtGV4ctZwjZkIRmFEUHqeFH7DwNi0HPaPUk6RaOt4qEFPppPsr
         Umlw==
X-Gm-Message-State: AOAM532ZbR/NqKootXMR5nRonlQL2WeWlfFpkixYPKhaqttSRXfUqroA
        78Ddc+7gRosD8ipLynFXf1CoHU+Hk50=
X-Google-Smtp-Source: ABdhPJyGaEHxQi6aLtOod9A24hyf/SgZuVyV/LM92uxeZtmMgyCeiMm/XTuLycZCsxKPFCGLMCYwuw==
X-Received: by 2002:a63:c042:: with SMTP id z2mr20958765pgi.491.1638924893653;
        Tue, 07 Dec 2021 16:54:53 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:52cb:f76a:51b5:e541])
        by smtp.gmail.com with ESMTPSA id d195sm604191pga.41.2021.12.07.16.54.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:54:53 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/5] peripheral: Replace random number generation function
Date:   Tue,  7 Dec 2021 16:54:43 -0800
Message-Id: <20211208005446.196637-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208005446.196637-1-hj.tedd.an@gmail.com>
References: <20211208005446.196637-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the l_getrandom() from ELL,
which uses the getrandom() system call.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 Makefile.tools    | 3 ++-
 peripheral/main.c | 8 +++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 8312d4d27..63b52c386 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -109,7 +109,8 @@ peripheral_btsensor_SOURCES = peripheral/main.c \
 				peripheral/gap.h peripheral/gap.c \
 				peripheral/gatt.h peripheral/gatt.c
 peripheral_btsensor_LDADD = src/libshared-mainloop.la \
-				lib/libbluetooth-internal.la
+				lib/libbluetooth-internal.la \
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_3dsp_SOURCES = tools/3dsp.c monitor/bt.h
 tools_3dsp_LDADD = src/libshared-mainloop.la
diff --git a/peripheral/main.c b/peripheral/main.c
index 86b52236e..f7ac043a0 100644
--- a/peripheral/main.c
+++ b/peripheral/main.c
@@ -25,6 +25,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/mount.h>
+#include <ell/ell.h>
 
 #ifndef WAIT_ANY
 #define WAIT_ANY (-1)
@@ -191,11 +192,8 @@ int main(int argc, char *argv[])
 							addr, 6) < 0) {
 			printf("Generating new persistent static address\n");
 
-			addr[0] = rand();
-			addr[1] = rand();
-			addr[2] = rand();
-			addr[3] = 0x34;
-			addr[4] = 0x12;
+			l_getrandom(addr, 6);
+			/* Update the MSB to make it a static address */
 			addr[5] = 0xc0;
 
 			efivars_write("BluetoothStaticAddress",
-- 
2.25.1

