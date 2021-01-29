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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48604C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 23:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136E064DF1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 23:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhA2XvC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA2Xu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 18:50:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3AC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 15:50:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id kx7so6598225pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=Ja9mwjlOAK27LERV1ehIHhht/yYelNZ+FWK3qDFr89l4/dUK3ZomzuPDPFaqAELGr9
         V8kk1vL7fTMmJHvvhST4j26i7lUU5wETQG6D4Rxl5m0Qo/AwfsbyFAxDqTDFtissL8Jh
         ztx97CH7g2PTCapBKnmgmoEN6ODuUlxcCVeeuP5We0X5jMCDjRUOVawmLDQF/nL4ijMM
         cqquk2NcRbJ6ER9AdO/HbnYNIBiNhaZp5a6lvJ8Aa1nuULcQtsouC4zSjsrA8k8gsj52
         YniSxDGTTYmNxv2qXhETQGgbbzN1IvCBR5r415Dy4u7ctfKmIWBtpdOdqt6NeHKwbX5m
         xAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=tzvw9/+zvbLSuvdmvMyvFFz4kA7bTDgJzU02TXYQ0LkMphK/YqNZAr6jcI+360r1lL
         SsN04EurI5s7dx517u9KA3N/Qh/tDeLmV3w5bB1uktCy33RYP/StZik7OPsxml4gYVYf
         kfw0WJFf1M9Av3XGzQyZgG+PN1iO2qRRK4z9llbOIXoKWGXcQN9MYw3hyx7RX5IZtoOn
         LJ0b9WnCAo7vTBaUpy2DtUYl7ciLAI07LC4vF1aNMX1iiYQBrY18NaTWLPZbh9djrD3e
         Lfd1ywxm+o+Ciav6kHLqwtfd3kHL7BAhBJjYfrp3Yv6IVzPTuyekaFGfUzpYlCCXQilG
         CWig==
X-Gm-Message-State: AOAM533wsqfVi2LDr7Ot/pbWgHwumhvdl0A/8oUfPnFj++S17TRmqDxm
        02GetVLDyISgZx9oTG16m5W3L+LNYPX/Xg==
X-Google-Smtp-Source: ABdhPJzkTYzMRDtEOIVnrO923N4kjfCpUUlgwF+lCQsR2K7f+h83sfw7S2bfifsnqLZjBhACNCzZjw==
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr6497208pjb.41.1611964218915;
        Fri, 29 Jan 2021 15:50:18 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:c047:f587:7300:6549])
        by smtp.gmail.com with ESMTPSA id w4sm9698495pfi.191.2021.01.29.15.50.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 15:50:18 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] tools/bluemoon: Display FW version of firmware file
Date:   Fri, 29 Jan 2021 15:50:16 -0800
Message-Id: <20210129235017.89788-1-hj.tedd.an@gmail.com>
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

