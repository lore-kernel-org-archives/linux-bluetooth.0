Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDAC4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CC423B83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLRTHo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:07:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgLRTHn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 14:07:43 -0500
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dave.jones@canonical.com>)
        id 1kqL5h-0004Gf-CC
        for linux-bluetooth@vger.kernel.org; Fri, 18 Dec 2020 19:07:01 +0000
Received: by mail-ej1-f72.google.com with SMTP id g18so1206599eje.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqcqvDi+qPxdzPKlcNaeMUK7kqd1L6r1MewrVt1IVxM=;
        b=gtRBCOcH3W2Zz+zkNyPgGUGOOhYBlZYhFjkuJbchmJzCW5d/sGoeNZSVluFmPJU2Zu
         LCeyZ22Cq7yanyTqf71b5p7ZpD6MtEQIk0CTPf+Wy3im75D07M4TI13SuhViwg3/1pwY
         qO2ZuFmxXcsgr5nbynLovyU9CON95OPPykm+iZDPycwmU7YYpfDE8QF/8ANYNUdiJ5Hq
         LGadTHxZZSh3fUOizCZWsCCT5CNvuaEqx23DXO3owfq4ICnLLfIxRgSIXAHfXoD/kuW3
         ahMlWqL0KHCSn15TpxoOvlGb0/RhZnU/w318NR8smuk43Q9VMz0V3crgt8ZJOWp+Hcwq
         4jLw==
X-Gm-Message-State: AOAM530IUm1biGNpab8qe03x1oVo6B4++asGjvz7rTnRtrUtGrCiaVJy
        AkZ9kFmRJ7FX0OLlngU+pNYmMhUsxTbrFHCizo0Tin7dJWNVSgYELtIu3DIkZmNNtY7rURmJIUO
        NM40ltnAYG4KTraAG7fwpgAbUhb/j9yhTJ4HItPEdXGWBNg==
X-Received: by 2002:a17:906:b082:: with SMTP id x2mr3622450ejy.100.1608318420720;
        Fri, 18 Dec 2020 11:07:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEnld/MxtusJ6fOsaH1FZ8gPdInwNC82ZuYIjQFTVuo80djpG0Ewx0WZz9UlU85oFVftaruQ==
X-Received: by 2002:a17:906:b082:: with SMTP id x2mr3622432ejy.100.1608318420538;
        Fri, 18 Dec 2020 11:07:00 -0800 (PST)
Received: from localhost (waveform.plus.com. [80.229.34.140])
        by smtp.gmail.com with ESMTPSA id ga11sm5884782ejb.34.2020.12.18.11.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:06:59 -0800 (PST)
From:   Dave Jones <dave.jones@canonical.com>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Dave Jones <dave.jones@canonical.com>
Subject: [PATCH v1 3/3] hciattach: Enable loading BCM43xx firmware on RPi
Date:   Fri, 18 Dec 2020 19:06:09 +0000
Message-Id: <20201218190609.107898-4-dave.jones@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201218190609.107898-1-dave.jones@canonical.com>
References: <20201218190609.107898-1-dave.jones@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Corrects the location of the firmware from /etc/firmware to
/lib/firmware, and disables setting the UART interface speed prior to
loading the firmware. An already existing later call to
bcm43xx_set_speed still sets the speed of the interface as requested.

For certain bluetooth devices, in particular that on the Raspberry Pi
400, setting the UART speed prior to loading the firmware causes the
firmware load to fail.

Signed-off-by: Dave Jones <dave.jones@canonical.com>
---
 tools/hciattach_bcm43xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index dbb5a3fe3..ddf9b4037 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -31,7 +31,7 @@
 #include "hciattach.h"
 
 #ifndef FIRMWARE_DIR
-#define FIRMWARE_DIR "/etc/firmware"
+#define FIRMWARE_DIR "/lib/firmware"
 #endif
 
 #define FW_EXT ".hcd"
@@ -356,9 +356,6 @@ int bcm43xx_init(int fd, int def_speed, int speed, struct termios *ti,
 	if (bcm43xx_locate_patch(FIRMWARE_DIR, chip_name, fw_path)) {
 		fprintf(stderr, "Patch not found, continue anyway\n");
 	} else {
-		if (bcm43xx_set_speed(fd, ti, speed))
-			return -1;
-
 		if (bcm43xx_load_firmware(fd, fw_path))
 			return -1;
 
-- 
2.27.0

