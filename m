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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B146C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 23:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C4564DFB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 23:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhA2Xwr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhA2Xwm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 18:52:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C296AC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 15:52:01 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y205so7213129pfc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 15:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=VCv21ZA/gs03bLm6rjA+A8dgzWyq0af7VtQI/aPKlVhUNJRRT+fMULUQc0nPCNok6F
         N/TlymzOvzewAKfHP2pTXMHHdkGdL9SbNVHFNkd54iCEeuJI3F4aHSkbw5lKjA6HLLaA
         W4R68teo/BNsv9LqbC8Z81I0FjLMMqqtOIvzmkW/K0QI0fiHgwRMvABNXNCYFRLbZmdi
         dXCwzXmlrnT35Ltn8bnWoHoFLEHjhhGcV34H8dGZwPbX85r22MDvICJfmK/xrEROoJM3
         GHUCXhLhULPY5ABJie/qfn4aQKQUKhh0IXbyVBkrUETaFWvbnvbI6r5uX+Pp5eQBloa4
         sS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=ZUKtGbDnjQdbdHKJnqWylJ/I1KdqK/dD2oYjzSyT0S0CVlkk6BrvMjNifBtqT+tfpK
         3Duz3oU0MhOUXPOuJU8qTjBjdONUaNJzmXMd5bbmHuXMy/EWazMD23V7lLpsaDziDBZd
         obAM4wSVNxi4iQmpINk9e15RwHbscQv84i60zd+pHeXYIQrYQa8dy9qzAHL522/h9fZV
         P5/zDq4B94IbVBtd1ySp4Hh/0a66zSlZicW5YF38NBxiDCDmWQNd37a2BqO7fv/zV4zW
         g1VPunVT1b6CInZWZyf6Ij/RCR5XZsqP3f19cIuvpmpuKtd2qBPlA/ATesi6Os8IubwB
         f7yQ==
X-Gm-Message-State: AOAM531j7uh3I/flisjJ6wnacdy70XZ6Znv7GrPgmOWf485j65m7VQTH
        AnMUIjTPiQJ51CRZ2q7ylRbF3aWNsfQzEA==
X-Google-Smtp-Source: ABdhPJzk5YL+w0PeaYd/fKXsagDp8d5Ojnaq97gRDKrOzvMzeNgll7qVNpFCLb+rp0Jacq/c2/4yJA==
X-Received: by 2002:a62:ddd1:0:b029:1b7:5651:f6ea with SMTP id w200-20020a62ddd10000b02901b75651f6eamr6736632pff.62.1611964321167;
        Fri, 29 Jan 2021 15:52:01 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:c047:f587:7300:6549])
        by smtp.gmail.com with ESMTPSA id z11sm8963190pjn.5.2021.01.29.15.52.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 15:52:00 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] tools/bluemoon: Display FW version of firmware file
Date:   Fri, 29 Jan 2021 15:51:58 -0800
Message-Id: <20210129235159.90017-1-hj.tedd.an@gmail.com>
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

