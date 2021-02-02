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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ADBC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 03:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDF664ED4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 03:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBBDkt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBBDks (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Feb 2021 22:40:48 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A653C061573
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Feb 2021 19:40:08 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y205so13426456pfc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Feb 2021 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQM9RrRWsegAJXIpcJlxvRsaMrV7eMAfLscLjtTdlcU=;
        b=b5C6w3t4gTA0TxonlwM91rNQCiIbfupPx5ofUKZewYXaWbDKWpeKStJeoU3ulrLzlL
         a8FEqOAQ5zRUNJ1Ee3GzSw43TLUxDN2wOE+hiFEcrwyTy2Hi80SzpO4rp7KRZdkenKtx
         Eh6kU/b79xXXzKTNFmYSEyXZ+raQ4HOK8x5v8jFB+Xnk05zjxTH5gOQssWK4d0eLdpUE
         a2Arl2ZLKOpvwskUD3o2dc87v5fcVVb96iTE0LH/Tn/zZh6GD2/5OGhIX4D5LHbu0Bq0
         kpw3ritaFWDUVz75Ff9AGykrGsOFHbc/39oQKCyAATaG/ziJkKYTb2aWaMTUUcFi38A5
         3T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQM9RrRWsegAJXIpcJlxvRsaMrV7eMAfLscLjtTdlcU=;
        b=aAMG09i9unxTQVnZy5315mLflVAfO3h3XrGL9uC4rz0NY4rnEDthJFiRlLulUo6okz
         JL4Gn5fRgj97a9t8cBBFZgg1bVhL4KQK42lyqCk7PHPlFJ6COI5I8KS7FBQr/hHDbY1s
         pZf34L0oUIfYnpH/QZ9VUfLkf0ci9vHsT4opwEOnoGJXMnZLrBC4eSxEzW6tmTvZmnRA
         ra8fZv1PYYzKctJ+w/zgaGZoRbN3WwCa0zV6D1c1cjVmoX9njZrahaSCDSaVj8c8BN+m
         z0MNAK9XSjVPjFca73pLx69AGkEuVXT5LUan1l1Gp6uFrfdnR2c5PEeI4B461STq+mHh
         S4cA==
X-Gm-Message-State: AOAM531FwPHRc3uLI3OazSYHwl4nCcsjUH+xtvJOX+/SI+TylBniaD64
        xpbudKhA+pTBEKTVhWuf0n42aVYNe/9fBg==
X-Google-Smtp-Source: ABdhPJxnEHbgxUxPBLQx+FDWugKd6avEbMz3m/n5utNNiu8XYq/eDZq/Ta0eSXeSbfbR69GhN+ah6w==
X-Received: by 2002:a63:6c85:: with SMTP id h127mr19984316pgc.158.1612237207756;
        Mon, 01 Feb 2021 19:40:07 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:2ff9:d5db:6a4d:60be])
        by smtp.gmail.com with ESMTPSA id l190sm19689568pfl.205.2021.02.01.19.40.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:40:06 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/2] tools/bluemoon: Display FW version of firmware file
Date:   Mon,  1 Feb 2021 19:40:04 -0800
Message-Id: <20210202034005.27697-1-hj.tedd.an@gmail.com>
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
 tools/bluemoon.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 8b62b1e7b..382c76c69 100644
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
@@ -840,13 +842,23 @@ static void analyze_firmware(const char *path)
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
+			printf("Firmware build:\t%u-%u.%u\n",
+					params->fw_build_nn,
+					params->fw_build_cw,
+					2000 + params->fw_build_yy);
+			printf("\n");
+		case CMD_NO_OPERATION:
 		case CMD_MEMORY_WRITE:
 			break;
 		default:
-- 
2.25.1

