Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1848720789
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314129AbhAZW66 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbhAZVYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 16:24:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CDC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 13:24:03 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t25so92869pga.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=tJjfVjKYsM8vmWfPUwu9KpX/84PdyOgBOqS0Bq6crUf8D9XrxCj9a3UFugttTWp+X/
         72sE8VSY2Hi6gWcNnkeSQQz4Zgnzak8Nv0o3uVOScUJLzQjdPMNQPFdZ+3WZBfWSd43x
         La72hDqrmUkm/VTlk06QZajnoG5lRg9X5nC68igfgWHJiH3tEfSWtF5DRD5G5eNsG4Je
         YRm577s0yNFlrje3kRKEx49TjCuZMgpX9IsZXp3YedIfnLolx8j7JwTtCHB74f62BmyI
         diazoN0pqxfmR2GOQqFVniZJsYrXNfYUnpCC6z3VI3qIhI2rdEJVAgXEqH681OF8pSeF
         fHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=1VPUesuAg4eJfWzK3lH54NswLymedCxjr1zvsNN7POo=;
        b=PXseQ8aOgV9KAKJuO4Z4oIaVcRPfxPakHaJkbZmveC2PzpA8sxxRjpi4v4AFdm4Jo+
         UWth83A+2nm3zGiB1PFTWdEzftEFmZhwWaQzmy0m7ckBNeRVhKu8pJH9OjjOTmDnReoh
         P1TxaiM8H+dwJdT14LZjgHifv6jKxGplQu7+jYUqedqSCzp8ANtY8BsbwrwyFr14O9B4
         3Xm2nEHILIbgj3BUsm3vFbmpTPWkTxZGOwB9GQ56BZoweOZ4I4Kd1r/fQC16rJGh8RXV
         EPi+CVkpfChX+CFVN2hn3/l4ECWFlDfgqhsCfseiakiUn0INyg9lO5smxto9gi8L0lXV
         MV7Q==
X-Gm-Message-State: AOAM530PT3WmpfDqMxnUW97tw0SonMQW/uS2BaL3wDM7X4M7XQXWAwzB
        RWvUq5LvSNk331ILHGp/+qgvGgYpRyNpzPGy
X-Google-Smtp-Source: ABdhPJwNRcYEijUpM/Rw44hjKb7y28D9+MYWX9puiQYVRnFU3XKdeimLmUxaM7oBUSQmYaEhoHhIRA==
X-Received: by 2002:a65:5884:: with SMTP id d4mr7507244pgu.303.1611696242467;
        Tue, 26 Jan 2021 13:24:02 -0800 (PST)
Received: from han1-XPS-13-9350 ([2601:1c0:6a01:30d0:3127:d904:e93e:f6b7])
        by smtp.gmail.com with ESMTPSA id q126sm48333pfb.111.2021.01.26.13.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:01 -0800 (PST)
Message-ID: <0abc1bb90aa6426c6030c06e8a95beff5e521707.camel@gmail.com>
Subject: [PATCH BlueZ v3] tools/bluemoon: Display FW version of firmware file
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Linux Bluetooth Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     tedd.an@intel.com
Date:   Tue, 26 Jan 2021 13:24:01 -0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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


