Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45325C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 22:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbhLHWnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbhLHWnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Dec 2021 17:43:02 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840CFC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Dec 2021 14:39:29 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l64so3311814pgl.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Dec 2021 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UhCunFf+J/qZtJa1OVsLdNGjKAIj7Nbn9jacChrEnYw=;
        b=Jm4zOI91mbtEBn3iuHWKofCwty7dIm0sjZfTRBILLmH59hYYq8g7wBbm1f2c+2WwGc
         Y5zPup2ZYUL4qzVvBDnoieUs8AJ6djphIgJWbODQzh48z7v52cfoXSXkkCQh/IadBM4J
         bMeJhbBLD6WMHaHzX6VwWEvdHOlqtN1gJDn454xo2HYf9ACQVO1eCpYsR3w44FYzuwW+
         4XdEX6jJQ9D1aHfJ8wyynS6m9EkYt/Z41ugK/ics4L74ck8X8fhFEGROEm2M7BsYR2h3
         HO5wKCDYflpqPF9h0aJaJKkKRc36PIGZk6mc1Sj/cpVaf4eEDkhmxScyXegE+MUFJHCE
         +5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhCunFf+J/qZtJa1OVsLdNGjKAIj7Nbn9jacChrEnYw=;
        b=bXPWjwSF78aNCIuLKQjevkfsPwO3ZZtjMwToQw2ukT7+6ftgogcYYpuVSz5W3EBk0y
         Xa4QMoj8Qf8epQ7fvWvedFxWXjeLtb1HOWO+TszXUJtCee53T1jvEJs1X/HMNrRw8NwR
         K2fZuBa06Zo0MwpnqvqUMnT5IO3eEePrIBXypqEDMblKXKFZgmvHerVsdibHbsb+t/fR
         c0uEycWPbP7p6Jtk3aAM3gQEp2zlzLBS/pdCZ6GMqvFfFv1vadcC5UTqOHVdSG0EID0l
         1thS4ri/6QtXBOJ0RVVHupOZ9xX5/LPBkcdXR799DkO8DTGcMz/FHwc+iVcmzN5B7v1Q
         TVlg==
X-Gm-Message-State: AOAM533TQ1iohDxsqpvNX+EDw9rxtJ4Chx/laNZ+z74a/3w/NWukqfBj
        VW+s9hL2qbrgiEk3sFB+NK+ShilK1YE=
X-Google-Smtp-Source: ABdhPJwkfJEPuc3PEuiI80bQ5l2OEM0LBeUGKumEDU4ZOAGzs3qcEZRNxQJMUaCYU+CW3Q3ckh+H5Q==
X-Received: by 2002:a05:6a00:ad0:b0:4ac:3d49:d8d with SMTP id c16-20020a056a000ad000b004ac3d490d8dmr8193646pfl.25.1639003168752;
        Wed, 08 Dec 2021 14:39:28 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e9a:66a9:f3af:51f3])
        by smtp.gmail.com with ESMTPSA id n16sm3757948pja.46.2021.12.08.14.39.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:39:28 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ V2 PATCH 3/5] tools/btgatt-server: Replace random number generation function
Date:   Wed,  8 Dec 2021 14:39:21 -0800
Message-Id: <20211208223923.519664-4-hj.tedd.an@gmail.com>
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
 tools/btgatt-server.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 000145a3d..15d49a464 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -20,6 +20,7 @@
 #include <getopt.h>
 #include <unistd.h>
 #include <errno.h>
+#include <sys/random.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -284,9 +285,13 @@ static bool hr_msrmt_cb(void *user_data)
 	uint16_t len = 2;
 	uint8_t pdu[4];
 	uint32_t cur_ee;
+	uint32_t val;
+
+	if (getrandom(&val, sizeof(val), 0) < 0)
+		return false;
 
 	pdu[0] = 0x06;
-	pdu[1] = 90 + (rand() % 40);
+	pdu[1] = 90 + (val % 40);
 
 	if (expended_present) {
 		pdu[0] |= 0x08;
-- 
2.25.1

