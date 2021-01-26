Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88952C4332E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F18820771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313260AbhAZW5r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388743AbhAZFpz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 00:45:55 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0EC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 21:45:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q131so9840281pfq.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 21:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODUGC4hdJeRdlEleX5VDVkve51htproVIDZ5AyPYN1o=;
        b=uI5tCJmhdcCS+tZs2j813/EZ1bZJOIrGWjILaTQRcZPpCBgFtKmGJRYqqx/wdTumMG
         4Gmg7HH1HWdkQ7sC2bnbgdlhluKeRmpQSFadmzjJ0TFSHNwAH7YB0G+1He4WIc1T8A+V
         3EDWBgSvfrgYSakESsiWf88gL3SYIS9bHptQ7dWII2cidpyi+wAqPy/GGTYuclKcR3Lj
         ihefRUYUDhOxVmGZaNrkDVfklfbEzNvwR9XhKfG3XkrswL3cHHCzW9uNm1tUepNnAh/R
         ZesZXmRq0Nwbo2oOOkYyKa0e3Ffw6ukDS3UizYX11auerMwYUOwo4GNZ85WqeKQkvRgo
         J11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODUGC4hdJeRdlEleX5VDVkve51htproVIDZ5AyPYN1o=;
        b=ausLsgw2qkwghjjHhttMMI5zXX/3A0a1oufHQou7vLamcY7VpzO8wd1ex9otcvOPjr
         iNJQuMV0DfjG0AIa3a5HRPzOPlC+CtakpLpRxozZeKabAxgCTrN8Fkj2o7VuuVSBwF4l
         UzrHuKI/EGSQpbDA7Dwz2eiUX/DdFgArb11+TCnMjrI1Y4gbzy0Z0xyVVY72qXtXJda8
         SClEgEe/gEGbEpIKirZ9rSpHVr79WdVoWUw0IVhpwZ5ODyMlBVamF5G4OiDVYqi8DTq/
         V5hbYYjnQsrvyZm6QKYHNismR+HCPQthHQAst/veoQ6nBSTTgxStRX4cQGmnNxYnlAGO
         fgZQ==
X-Gm-Message-State: AOAM530YQgGz+oZ/G6+LufWA19GTUdo7FOsVF3m4I9pJaKZq5c5RKdJ/
        d+ukh0YuMjxbG7/2Z4qw074gOdawkc3oLcdR
X-Google-Smtp-Source: ABdhPJzCTdzbv97W5FaHBreNKUlLXiBb8kYujtHOYAVSksIFBuMDmzMA7QNqbVk5Z9eCgikD01Ct4A==
X-Received: by 2002:a63:7402:: with SMTP id p2mr4125705pgc.101.1611639914876;
        Mon, 25 Jan 2021 21:45:14 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:3127:d904:e93e:f6b7])
        by smtp.gmail.com with ESMTPSA id v1sm19037213pga.63.2021.01.25.21.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:45:14 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     tedd.an@intel.com
Subject: [PATCH] tools/bluemoon: Display FW version of firmware file
Date:   Mon, 25 Jan 2021 21:45:12 -0800
Message-Id: <20210126054512.76870-1-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch displays a FW version after parsing the WRITE_BOOT_PARAMS
command in the firmeare file. It also change the display type for
Module vendor and Date in the CSS header to hex for easy read.
---
 tools/bluemoon.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 8b62b1e7b..773e891cf 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -805,8 +805,10 @@ static void analyze_firmware(const char *path)
 				le32_to_cpu(css->header_version) >> 16,
 				le32_to_cpu(css->header_version) & 0xffff);
 	printf("Module ID:\t%u\n", le32_to_cpu(css->module_id));
-	printf("Module vendor:\t%u\n", le32_to_cpu(css->module_vendor));
-	printf("Date:\t\t%u\n", le32_to_cpu(css->date));
+	printf("Module vendor:\t0x%x\n", le32_to_cpu(css->module_vendor));
+	printf("Date:\t\t%04x-%02x-%02x\n", le32_to_cpu(css->date) >> 16,
+				le32_to_cpu(css->date) >> 8 & 0xff,
+				le32_to_cpu(css->date) & 0xff);
 	printf("Size:\t\t%u DWORDs / %u bytes\n", le32_to_cpu(css->size),
 						le32_to_cpu(css->size) * 4);
 	printf("Key size:\t%u DWORDs / %u bytes\n",
@@ -840,13 +842,29 @@ static void analyze_firmware(const char *path)
 	while (firmware_offset < firmware_size) {
 		uint16_t opcode;
 		uint8_t dlen;
+		struct cmd_write_boot_params *params;
 
 		opcode = get_le16(firmware_data + firmware_offset);
 		dlen = firmware_data[firmware_offset + 2];
 
 		switch (opcode) {
-		case CMD_NO_OPERATION:
 		case CMD_WRITE_BOOT_PARAMS:
+			params = (void *)&firmware_data[firmware_offset + 3];
+			printf("Boot Parameters\n");
+			printf("Boot Address:\t0x%08x\n",
+						le32_to_cpu(params->boot_addr));
+			printf("FW Version(YY):\t%d (0x%02X)\n",
+						params->fw_build_yy + 2000,
+						params->fw_build_yy);
+			printf("FW Version(WW):\t%d (0x%02X)\n",
+						params->fw_build_cw,
+						params->fw_build_cw);
+			printf("FW Version(NN):\t%d (0x%02X)\n",
+						params->fw_build_nn,
+						params->fw_build_nn);
+
+			printf("\n");
+		case CMD_NO_OPERATION:
 		case CMD_MEMORY_WRITE:
 			break;
 		default:
-- 
2.25.1

