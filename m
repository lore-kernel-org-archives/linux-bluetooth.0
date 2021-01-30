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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FBBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC5764E13
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhA3AQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 19:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhA3AQC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 19:16:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BFC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:15:21 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u67so7249857pfb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=mGcQqLb7I9Na0HX3TKrcWD7aOik0PxqPi1NGJ+eDfKN2ywTCjW0RPrjCH+ZaSh1R+e
         iD3WzVQk0FlsdHowvU5SnAIgHcPqdLR4MmLFI+l+LJAYTV9ixUkoo6Ed6/Gkpaf0fMcM
         J8nuxJR/s/5AFCQjHkjnyMPIT1i678SPvWv97XinMDyhNYfBCmQIm1+kLOFqMbJRRjB5
         S0x2QEv2FoJszwjvwUV8F4oXp+FBVaR0lPqthWVcNzDYSrOXJYFnmYFCAiQ7V5er1iUA
         zVXzUrDz8a7aK0zsTkkaUGZaswf5jtySBBQapDlEbkmAs5jA4XLTXYmFuRPDDLBQgLDy
         onrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=osmYbxB3vN+JEzZZunvnZ9tz3AB+mzAKnGMMLLmUtR6Xu76aMzHHD+Quh8MdhJbadV
         ipn2e1RYPhd/Ls9e8lOdwOpn/6HwLbUlL3RsQpsJHjsK6v2TJj0ZS1dbZSdlc5svKOuJ
         DJeH1d3o7eS6XREHKUAgUd6Ef1mcVSq6JSZRiLm14QfEPPhGa68h6bNMkcVAVK+NAeTZ
         Hp14qlHjkEPM1hjmB657RwJNJXu9y4ba9cdvCf6BCox7+Wc0LehaPs13j7DDb6hjLG8u
         Hz34xBIcr9yfV0F/Ob+Vtr3edb8ceA4a7X+woFf3VkPce8R+o9iOCx11H0DiTOsa3RZj
         YhLA==
X-Gm-Message-State: AOAM532Cow+hwxmvmfP9qS69YtR4pjpJKpzIPBpku4UvcFuXghEX/p1x
        aP04g8DKRIZK4WTjpJzmvyG1kwtJdSjE9g==
X-Google-Smtp-Source: ABdhPJyX63nnhgyytCmQi2wXxfnKjd7/4Ztxyikyls6321fmNC/LByMMvwoQqImpKfced/zSnNnk0g==
X-Received: by 2002:a65:6152:: with SMTP id o18mr6922939pgv.392.1611965720686;
        Fri, 29 Jan 2021 16:15:20 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:c047:f587:7300:6549])
        by smtp.gmail.com with ESMTPSA id v9sm8619432pju.33.2021.01.29.16.15.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 16:15:20 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/2] tools/bluemoon: Display FW version of firmware file
Date:   Fri, 29 Jan 2021 16:15:18 -0800
Message-Id: <20210130001519.91190-1-hj.tedd.an@gmail.com>
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

