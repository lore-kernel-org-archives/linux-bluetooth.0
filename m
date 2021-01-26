Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C0EC4332B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D470920771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313821AbhAZW6O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389694AbhAZSZM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 13:25:12 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52122C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 10:24:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v19so11966647pgj.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=j6suntPk+Xw2jn8dfKm0j36ZhOhMyJI+nJXsIBrmjNDSDoP7AmsozNySCodr6UVHGE
         nyR41RRe1yPDwb12gcwzO+7Ny2vYFPor56uZg2iJmdwWrUl2bl6vosu5iameRo4CZrV9
         GaIR7xHCXu3mUcUCVemXYxkPznNxz0MIXNepV27dfXBU0izjyJ20iJl/2kxD9fybkFy0
         d0YjI4mVejrEj+N9CJEIDiqNmBeGTbFZKGENZ1Gd+tMG10pUYmm/y99WCnQjgOYzrWOp
         7XdyVW3zFokgCQPofrMqx1vtiJBG2AWJrhdMsfK4gzH/U5w3ngJ1HuNulffHBGLKqpqX
         sxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=AVr4zOCF9CkOIW8p13pCYiGF7qHuSwHVuk3j1iTJCUD3MOOvXQomGEvIbJ+UY4TFIx
         WM+/6BAYJl9Gjp0aYYyCzpZLVg0VwniwCHdYwghdyRmYDDyP/CR+5DZbNsyo+6wosneb
         PrWTCvUi9mzAro77FCyul6y0LxwyNeDFDpnKp+a4s8xHPmG9V7uxDRMzzD2FKfTsoRrD
         CgZSZ8YU9suQ8873F9mHDBt8gq6x3R0Nqq28hwl9EJwlbZRo3u1bBSItjAL7mkWXREaU
         VRa5HUFnnrOCeSUrvRIgtVjauUykbG8jKUAZgoRC5fz7i2e+fLtQutB5FadL7v5EndGk
         G+UQ==
X-Gm-Message-State: AOAM532q1hoiuGPXtKOfIzRndl5FQKRvOANXJJaWhijmqzwcaw3IImUg
        8WQBl85ogU8FpqkSgVKP+0/rwiKuPkTgOQ==
X-Google-Smtp-Source: ABdhPJw1acqq5H5vJJXs9fohJkWmxVKLYLrqk6c1aksTvsBl5dE5xUsWJdkRjQBUHGssQCQXlFcZqA==
X-Received: by 2002:a63:e210:: with SMTP id q16mr6805489pgh.249.1611685471583;
        Tue, 26 Jan 2021 10:24:31 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:3127:d904:e93e:f6b7])
        by smtp.gmail.com with ESMTPSA id q12sm19689649pgj.24.2021.01.26.10.24.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:24:31 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3] tools/bluemoon: Display FW version of firmware file
Date:   Tue, 26 Jan 2021 10:24:30 -0800
Message-Id: <20210126182430.84718-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch displays a FW version after parsing the WRITE_BOOT_PARAMS
command in the firmeare file. It also change the display type for
Module vendor and Date in the CSS header to hex for easy read.
---
 tools/bluemoon.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 8b62b1e7b..912f4f2a9 100644
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
+					le32_to_cpu(params->boot_addr));
+			printf("FW Version(yy):\t%d (0x%02X)\n",
+					params->fw_build_yy + 2000,
+					params->fw_build_yy);
+			printf("FW Version(cw):\t%d (0x%02X)\n",
+					params->fw_build_cw,
+					params->fw_build_cw);
+			printf("FW Version(nn):\t%d (0x%02X)\n",
+					params->fw_build_nn,
+					params->fw_build_nn);
+
+			printf("\n");
+		case CMD_NO_OPERATION:
 		case CMD_MEMORY_WRITE:
 			break;
 		default:
-- 
2.25.1

