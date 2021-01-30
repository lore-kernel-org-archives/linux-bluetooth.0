Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0750C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A419164DBD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhA3AQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 19:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA3AQD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 19:16:03 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D67C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:15:22 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t25so7751992pga.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6/n/kDFNvXS/tHMjAJSeRSwBculpBFUsG3zli0vKkYI=;
        b=jj4dz3tx6eJhQxgI5MzJiTBVEmH1WgZdiUwe9WrQekkLMGrUulKT7JzZUrFqfQT83E
         4/ArsB0Kzc6VFugioaEU8Bjl6veaXvIm5Z10Z//FWGSGoqel2fsEZJsxqx7iVSLYAyAj
         jBjIZLGljq47JmbRIU9kWonLsbaNtunwI85AxBWwmsGH+YoQoyNL+KrxYMp7cH2qC1Xk
         sGfcMR3HOZ0j8V9GQILL9Dz6cD6my+A3L5G/zF89IxaUx+zgi4KC5NxWTuMFe4BZ/JhR
         y5zgbtXOGnJ0LB5eVMhwboZZ01LfXNaKDl2OHeNKvmy/2/SMQ1YhtFIr0rreae7D+AKd
         EIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/n/kDFNvXS/tHMjAJSeRSwBculpBFUsG3zli0vKkYI=;
        b=MCnmExjnZhFbXv9O6/T8CR+lm4/x+/SGRPXMa9SlcsnhnPpt5il1wDAKKHLzPA5pxK
         mXpzC8S+N7k8i/uReeyCtBDQOlEfSJoQ3PRcBzUyaUoVHBkCq4ftOCCZmN9Tam8wijFX
         KQ6HGR10sOgKyrJe5F8+XtGlqEIsmgdz4arravUohQ18ayK9D/FiHyGExIqIt7Rhui2i
         J9U/pZOPW1Se8TI9MDQyBo9AD5QjRvl1ZEgTiqv23a4YfTjv2o3mUBGm7Vpo3uZpEmci
         TgLahrkpGuLTFU4vp0b6GRt5R0LKO65Vs2HhEKbmF+qc3l7JkgtpWB16D7yQ/GW44rC1
         0P4A==
X-Gm-Message-State: AOAM531Ug7GZ7a3SkERSSHRvTjy1MQZ6gbY0qGJYwUWPvCJPxh8L6MGu
        bePMwlJ5x1NGZkijnkjmqBVXN/mVmZr6UQ==
X-Google-Smtp-Source: ABdhPJxi0mlsxQ4AYf7+Uv81IfQooDiPX+CvJLQdvWiwSNXG6yWBNwAoLcjRAbiU4ErbnCQxH8BH2g==
X-Received: by 2002:a63:6e0f:: with SMTP id j15mr7174636pgc.21.1611965721491;
        Fri, 29 Jan 2021 16:15:21 -0800 (PST)
Received: from han1-XPS-13-9350.hsd1.or.comcast.net ([2601:1c0:6a01:30d0:c047:f587:7300:6549])
        by smtp.gmail.com with ESMTPSA id v9sm8619432pju.33.2021.01.29.16.15.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 16:15:20 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/2] tools/bluemoon: Add support for checking other firmware file types
Date:   Fri, 29 Jan 2021 16:15:19 -0800
Message-Id: <20210130001519.91190-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130001519.91190-1-hj.tedd.an@gmail.com>
References: <20210130001519.91190-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

There are more firmware files for Intel devices like .ddc, and .bseq.
This patch checks the file extension and analyze the firmware file.
---
 tools/bluemoon.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 912f4f2a9..2651721a3 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -127,6 +127,8 @@ struct cmd_trigger_exception {
 	uint8_t  type;
 } __attribute__ ((packed));
 
+#define CMD_DDC_CONFIG_WRITE	0xfc8b
+
 #define CMD_MEMORY_WRITE	0xfc8e
 
 static struct bt_hci *hci_dev;
@@ -608,7 +610,10 @@ static const struct {
 	{ 0x0a, "iBT 2.1 (AG620)"	},
 	{ 0x0b, "iBT 3.0 (LnP)"		},
 	{ 0x0c, "iBT 3.0 (WsP)"		},
+	{ 0x11, "iBT 3.5 (JfP)"		},
 	{ 0x12, "iBT 3.5 (ThP)"		},
+	{ 0x13, "iBT 3.5 (HrP)"		},
+	{ 0x14, "iBT 3.5 (CcP)"		},
 	{ }
 };
 
@@ -657,6 +662,16 @@ static void read_version_complete(const void *data, uint8_t size,
 	}
 
 	if (load_firmware) {
+		/* This option is only supported for the legacy ROM produce,
+		 * which can be identified by the fw_variant == 0x01
+		 */
+		if (rsp->fw_variant != 0x01) {
+			printf("FW Variant: 0x%02x\n", rsp->fw_variant);
+			fprintf(stderr, "This device is not supported\n");
+			mainloop_quit();
+			return;
+		}
+
 		if (load_firmware_value) {
 			printf("Firmware: %s\n", load_firmware_value);
 			request_firmware(load_firmware_value);
@@ -735,6 +750,95 @@ static void read_version_complete(const void *data, uint8_t size,
 	mainloop_quit();
 }
 
+struct ddc {
+	uint8_t  size;
+	uint16_t id;
+	uint8_t  value[0];
+} __attribute__ ((packed));
+
+static unsigned int analyze_ddc(uint8_t *data, ssize_t len)
+{
+	unsigned int ddc_num;
+	ssize_t offset;
+	struct ddc *ddc;
+
+	ddc_num = 0;
+	offset = 0;
+
+	while (offset < len) {
+		ddc = (void *)&data[offset];
+		offset += ddc->size + 1;
+		ddc_num++;
+	}
+
+	return ddc_num;
+}
+
+static void analyze_firmware_bseq(uint8_t *data, ssize_t len)
+{
+	struct cmd_write_bd_data *bddata = NULL;
+	unsigned int cmd_num;
+	unsigned int evt_num;
+	unsigned int ddc_num;
+	ssize_t offset;
+
+	offset = 0;
+	cmd_num = 0;
+	evt_num = 0;
+	ddc_num = 0;
+
+	while (offset < len) {
+		uint8_t type;
+		struct bt_hci_cmd_hdr *cmd_hdr;
+		struct bt_hci_evt_hdr *evt_hdr;
+
+		type = data[offset];
+		offset += 1;
+
+		/* Command */
+		if (type == 0x01) {
+			cmd_hdr = (void *)&data[offset];
+
+			if (cmd_hdr->opcode == CMD_WRITE_BD_DATA)
+				bddata = (void *)&data[offset + 3];
+
+			if (cmd_hdr->opcode == CMD_DDC_CONFIG_WRITE)
+				ddc_num = analyze_ddc((void *)&data[offset + 3],
+						      cmd_hdr->plen);
+
+			offset += cmd_hdr->plen + sizeof(*cmd_hdr);
+			cmd_num++;
+
+		} else if (type == 0x02) {
+			evt_hdr = (void *)&data[offset];
+			offset += evt_hdr->plen + sizeof(*evt_hdr);
+			evt_num++;
+		} else {
+			fprintf(stderr, "Unknown type: 0x%02x\n", type);
+			return;
+		}
+
+	}
+
+	printf("Command count:\t%d\n", cmd_num);
+	printf("Event count:\t%d\n", evt_num);
+
+	if (bddata) {
+		printf("\n");
+		printf("BD Data Configuration\n");
+		printf("Features:\t%02X%02X %02X%02X %02X%02X %02X%02X\n",
+		       bddata->features[7], bddata->features[6],
+		       bddata->features[5], bddata->features[4],
+		       bddata->features[3], bddata->features[2],
+		       bddata->features[1], bddata->features[0]);
+		printf("LE Features:\t%02x\n", bddata->le_features);
+		printf("LMP Version:\t0x%02x\n", bddata->lmp_version);
+	}
+
+	if (ddc_num)
+		printf("Total DDC:\t%d\n", ddc_num);
+}
+
 struct css_hdr {
 	uint32_t module_type;
 	uint32_t header_len;
@@ -753,6 +857,7 @@ static void analyze_firmware(const char *path)
 {
 	unsigned int cmd_num = 0;
 	struct css_hdr *css;
+	const char *ext;
 	struct stat st;
 	ssize_t len;
 	int fd;
@@ -790,6 +895,32 @@ static void analyze_firmware(const char *path)
 		goto done;
 	}
 
+	/* Check the file extension for file type */
+	ext = strrchr(path, '.');
+	if (!ext) {
+		fprintf(stderr, "Unable to get the file extension from path\n");
+		goto done;
+	}
+
+	if (!strncmp(ext, ".ddc", 4)) {
+		printf("Firmware file type: DDC file\n\n");
+		cmd_num = analyze_ddc(firmware_data, len);
+		printf("Total DDC:\t%d\n", cmd_num);
+		goto done;
+
+	} else if (!strncmp(ext, ".bseq", 5)) {
+		printf("Firmware file type: BSEQ file\n\n");
+		analyze_firmware_bseq(firmware_data, len);
+		goto done;
+
+	} else if (!strncmp(ext, ".sfi", 4))
+		printf("Firmware file type: SFI file\n\n");
+
+	else {
+		fprintf(stderr, "Unknown file extension: %s\n", ext);
+		goto done;
+	}
+
 	if ((size_t) len < sizeof(*css)) {
 		fprintf(stderr, "Firmware file is too short\n");
 		goto done;
-- 
2.25.1

