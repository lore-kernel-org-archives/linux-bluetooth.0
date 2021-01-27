Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE5CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 04:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EA7205CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 04:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhA0E2T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 23:28:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:17986 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403887AbhA0ARc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 19:17:32 -0500
IronPort-SDR: djyi1vQajMxpB91RSPRAUIFxeCdxEuuEaBSgfFdlu98vYBOeX5Vb+qmPlq9UqN4Lb3zxPiFSFh
 x8Ru8p7bBFpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="179211498"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="179211498"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 16:15:43 -0800
IronPort-SDR: hwSXtC0KdproYtL656VkJA9TweRH5w5yLV7aoy4PN5rmjf/cHvdJC2t7q71/m0g5O1/4/tXgVW
 /YcTsz0nfUhw==
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="472938005"
Received: from rkfoote-mobl1.amr.corp.intel.com ([10.251.7.251])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 16:15:43 -0800
Message-ID: <7ce3b84389e123d1d09dc110377ec369cf7825d7.camel@linux.intel.com>
Subject: [PATCH BlueZ] tools/bluemoon: Display FW version of firmware file
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd An <tedd.an@intel.com>
Cc:     hj.tedd.an@gmail.com, Luiz Von Dentz <luiz.von.dentz@intel.com>
Date:   Tue, 26 Jan 2021 16:15:41 -0800
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
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
2.26.2


