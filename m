Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57ECC433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9325C20771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313772AbhAZW6I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393413AbhAZRt5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 12:49:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1DC061788
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 09:49:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lw17so1618489pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2aZKfq5FCs/M0zy6bHJijugjpc9A2MRnegy9e+obYM=;
        b=p4G0a2rmaquFE6Ms20pgOeOOQM4kxs/T8wphU4G0tuj0T+CFN1+782LaoFbNFcskty
         ILDJbLMuFWd1Bok0VCaWoSwhwtwcSQKe/Jiw4C2hCq9MEwo8aBUgfeuX7cNdghLRGdEx
         TZzMxILjabS35etvPP/kaIEaWe5lYYbi/GOONABHVYsNB/moixBHpZOfuF9j3Fx2ZUYm
         BndYUUrpw2mizHpFMJyyLWnfq2RKKAdMyBcWJzU8KNh1VqVaCBBU1IZMNd3Dr9EWh8cS
         jLTfC3FeyBnPwD4kWMkLjNRqkftIU47Hagtz0ERayU5QqN5qroEuDL329h6l8Ls8SHr9
         KRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2aZKfq5FCs/M0zy6bHJijugjpc9A2MRnegy9e+obYM=;
        b=qj8tqt+9LdFMT82InTKLJ81IX0IS3AFAy9A5ToW7X7+UhA8laOkXzE8J987BO0+QBU
         y8Ln/LY1Nm5r+5Fag9eT3fgsPz75q3hGzfG/KGhpnSZ9eieOjwPbfylBl1GOFLyLr0Nk
         /I/uzcz/dSvwT7sGV7O8v8Ug9Rh/JaQZMTXesJYcHGrgZb19QA0tiC6hDSl7R6J6jynA
         SI6FilUSP7aU3fhMtBEbZK45pbQeTWPk7QFsdRkoEkmUDhU32OX0yNq4mzX+Ws2ZK3W5
         5+tEpI+ZSWz0fRt0HbrMib7NyYnSQ9OjIVJvbhL67auY/36kxRCkdaeadsQl1xjXQ5T8
         6NUw==
X-Gm-Message-State: AOAM533Npx5KVgtfbIc+gFxOzEHYNyLSd7Tvv7MLDIqm0lUtkp5Ot32J
        9M4VAIEP2ZpC8sKDjQgWGZ40IifsFuQ5Dw==
X-Google-Smtp-Source: ABdhPJwhPkOJSizEogr3CiVc8ZQsdZTW2h0xCMF/6oGlrl7m5JKI5nUqfJrniZpDUDGaHzgE/H1Fxw==
X-Received: by 2002:a17:902:c14d:b029:de:3a7f:2c08 with SMTP id 13-20020a170902c14db02900de3a7f2c08mr7022176plj.7.1611683354586;
        Tue, 26 Jan 2021 09:49:14 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:3127:d904:e93e:f6b7])
        by smtp.gmail.com with ESMTPSA id e17sm2901765pjh.39.2021.01.26.09.49.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 09:49:13 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] tools/bluemoon: Display FW version of firmware file
Date:   Tue, 26 Jan 2021 09:49:12 -0800
Message-Id: <20210126174912.83822-1-tedd.an@intel.com>
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

