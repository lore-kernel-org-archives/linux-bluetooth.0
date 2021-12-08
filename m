Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31CFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 22:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhLHWnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhLHWnB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 17:43:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8994C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 14:39:28 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n8so2526574plf.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 14:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xcCXtWkaR8CL9aA+N6B44g2JofUYA1pHfR8xX2mn584=;
        b=Pp3NBHoCiKnl+AuWfG5PsdFnH/3mxPfUxjZ5lz3Gcwyg/ybvLzRPNG5bOQ2G3PV6oR
         yggyQIVpRK7JltnRVhDaFk/sg4r089ZdsGenLH7dWvAL6D2OOsJEGqoeTstABIJEK9rJ
         K4SzZvrgBpOnEmXhx7YEaa8saTXWdndkzMvyjeO7KDONZYKyGogzgPRbk2qI8x9MFlJr
         9LAu6KL3Blk1ocWYIR+f9yVq8d8NlqWRTkJtmo3emAg77xka24RiRMY/cm7bpWSEOMaJ
         MP+gMLMm/+5xy0D8mVyYdzi2/3iYz3f/28yu9vUBuaIoRwn+K0XQ1SlUL2AK2k3HPMFR
         PO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcCXtWkaR8CL9aA+N6B44g2JofUYA1pHfR8xX2mn584=;
        b=2omqxgCcvDZLwQOSaRSHxRfugHH0SFdpZfAAuusuo0jxJ4DQgEHwmtUURmnWS4hwBA
         fQkW/LmGag88aiZFl+bA39fsZ6yFJExPbzGFm3dEnTmxsSj6GW945R8F+j3m3603zKCR
         M95WIPw5MuKX1b0SOktwoJjNq4NnrmlJWYOISpYSnonefSzkTrHsVrD3zPk4XawB8BXF
         A/Np25sZjn9YHv8gtKbqsP1aBzKd2bvXaDL3w89zcBopRXteSMQgxtr29B6R9Xo7SVcZ
         2VyrAKNAkmdQNXT36k0K3SbRcPIWKOEx4tR2wRtFNGgYYIOrxEuxJTRbGKwpNkcr8GkS
         H2AA==
X-Gm-Message-State: AOAM531uij9jWGwRIuIZMN+KnkQCY66WvCJP+V+Y77w4+P95mTZ+p9h5
        PhsAaXl0v6Q9bQhAv6CYvK9PwYp2nbs=
X-Google-Smtp-Source: ABdhPJzNtqWkwnuu+qqRfxSMD7brSft0nWZhyAvdusCWczyiLWsSmv/WJLUm70JaHMnifkUt/J+XfQ==
X-Received: by 2002:a17:90b:1293:: with SMTP id fw19mr10839001pjb.155.1639003168063;
        Wed, 08 Dec 2021 14:39:28 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e9a:66a9:f3af:51f3])
        by smtp.gmail.com with ESMTPSA id n16sm3757948pja.46.2021.12.08.14.39.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:39:27 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ V2 PATCH 2/5] peripheral: Replace random number generation function
Date:   Wed,  8 Dec 2021 14:39:20 -0800
Message-Id: <20211208223923.519664-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208223923.519664-1-hj.tedd.an@gmail.com>
References: <20211208223923.519664-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the getrandom() syscall.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 peripheral/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/peripheral/main.c b/peripheral/main.c
index 86b52236e..0f5210403 100644
--- a/peripheral/main.c
+++ b/peripheral/main.c
@@ -25,6 +25,7 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/mount.h>
+#include <sys/random.h>
 
 #ifndef WAIT_ANY
 #define WAIT_ANY (-1)
@@ -191,11 +192,11 @@ int main(int argc, char *argv[])
 							addr, 6) < 0) {
 			printf("Generating new persistent static address\n");
 
-			addr[0] = rand();
-			addr[1] = rand();
-			addr[2] = rand();
-			addr[3] = 0x34;
-			addr[4] = 0x12;
+			if (getrandom(addr, sizeof(addr), 0) < 0) {
+				perror("Failed to get random static address");
+				return EXIT_FAILURE;
+			}
+			/* Overwrite the MSB to make it a static address */
 			addr[5] = 0xc0;
 
 			efivars_write("BluetoothStaticAddress",
-- 
2.25.1

