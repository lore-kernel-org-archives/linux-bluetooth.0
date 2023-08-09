Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A35C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 19:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjHITqZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjHITqY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 15:46:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD010DC
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 12:46:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc63ef9959so2136115ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691610382; x=1692215182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EG5RAg0g2ru7BjKxksjGel0KA2xEoxS3HbUDxCS9Mtc=;
        b=KCymxo1GcuvsC4ph0v6yylOZqSDxGsJ6WbHA9CvDlZjeLE8Ep16aI/F409iVn4ZE2V
         geSsaP+aL4LS7H8PGBO2+ReMDD+GWmQAd7/IPuNwlWJzWngc+x1lsbfSm3Sxw2y7u1XH
         +DyXXWo+sSNP9Z0Z1Ap8YVfaKHPcD4u1MzgeH7XmA7ocTqwgrK/fbTq33uphI+y/ZCj0
         3ZWw+fxCVIO9WszVDphR/DXcivUFya09GABWnQwTXc9p5HsTIFtKvFv5SxOIs449Kytl
         nGj87b6Z+PYmeppOmsQAM7SHkaWtUtHZ5ERjRTIAU51fNCLFwYAG8DCKpUmXmUeIqkLn
         I/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691610382; x=1692215182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EG5RAg0g2ru7BjKxksjGel0KA2xEoxS3HbUDxCS9Mtc=;
        b=QlwUiKPEMWPpB7+RJLw/2liL+rMj2lEl4n90tt5z8exNkJE5/Tj2Eqn9Rk2D3V3jd4
         RplcdPka2udwMfZYolVN0g1f79G8+97QeB1ijL+lkd9GDB9Y7kNL44H+xWCkzVgFQkiB
         /b0bHl3oC8cr3Gq7S1O9e9Zz26ZDlSp8YjY+iEYXG+kPgD5E6KhjilR/XkeztAI1/EE9
         nfqFluCHd2lSNKf3BdpzxVFntazeOUMtJkb10htaWoijXC2ck0L0SuW/PvaE+W2qNb1r
         /mOVG+ngGcWbcKTckHJn42Ji6+lthHjoFHm3UWqjkJcO5zxu2iBCRQYWOCl9XDbpkczT
         iyrQ==
X-Gm-Message-State: AOJu0YzekmPkZWYdZtFaJN5noTuL+egUn+3o8LDNURx/O4gFNYQTOAkl
        hApSUvi3Zslv3qGircxA3LBJm8T8854=
X-Google-Smtp-Source: AGHT+IG8RfjWUEhX2DSitIQet7I/XmLpC/CRg939+xY87pohe5bu9FgEYUvAwgYXnB3lFWJpuu/Kfg==
X-Received: by 2002:a17:903:32d2:b0:1b8:2c6f:3248 with SMTP id i18-20020a17090332d200b001b82c6f3248mr121497plr.39.1691610382330;
        Wed, 09 Aug 2023 12:46:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001b8b4730355sm11545274plh.287.2023.08.09.12.46.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:46:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix not probing drivers at startup
Date:   Wed,  9 Aug 2023 12:46:20 -0700
Message-ID: <20230809194620.1595792-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Patch 67a26abe53bf ("profile: Add probe_on_discover flag") introduced a
regression which prevents drivers to be properly loaded at startup since
at that point they are not connected when code shall testing if
the devide is temporary instead.
---
 src/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 19ae03f7d98a..ecd385cf813a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3933,10 +3933,10 @@ static bool device_match_profile(struct btd_device *device,
 	if (profile->remote_uuid == NULL)
 		return false;
 
-	/* Don't match if device was just discovered (not connected) and the
+	/* Don't match if device was just discovered, is temporary, and the
 	 * profile don't have probe_on_discover flag set.
 	 */
-	if (!btd_device_is_connected(device) && !profile->probe_on_discover)
+	if (device->temporary && !profile->probe_on_discover)
 		return false;
 
 	if (g_slist_find_custom(uuids, profile->remote_uuid,
-- 
2.41.0

