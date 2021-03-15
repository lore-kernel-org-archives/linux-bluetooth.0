Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8FDC43333
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E2F64F07
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhCORk2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhCORkM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:40:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1399FC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u18so15643329plc.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3tA1Um38m4hYMnv9CGiuJA7SkPRldGIsASeqovUw/Yg=;
        b=jzT+YBKsUay8L5SDP0XQUBdWreFn28NylOlYDWrayB0iCmB9QOU7SUV/jCPCShfLYh
         3NpU6topG2+y10SsIChZQro66gpS5bMqGd/1gqUNyD5qVzAy4YVBil1xS+YYJFMNVM2m
         xyZr9sMzBgGXYZY/NE/sW0suNPbyHHeyPLTrgFZNGCy/+trf8Zj3HJcr7gEoDaZYl5XK
         FshmfBra3xmcjnv78XOoOE0PT5TQJWnw9JzrvpzBqO8iWQzjbxzLeNtEAQ2UETNnSM3f
         8eT2HMVmhkP9auwVsi3EtVmIc3oeO+6eV+m8OnO7gt3evUQKjUoiCulSR2CJtbDSNVF6
         09fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tA1Um38m4hYMnv9CGiuJA7SkPRldGIsASeqovUw/Yg=;
        b=SMC2Fyd8LQI1CRli283+/QI9hWnu9hOs9Q3ebZca/U5nsG6Qwev1/oAsoRbdy6Ejgm
         j/y2jJnLLBHtqYALtjTK+/qEVqtB77Pqs/SzFWirdFljbGSYrycvwreClGnQM+OHwabB
         z6k93FLcHgXJ6U/ye5RdK74XBPK7SnGyr3cPCrHtyXxu17ERaU6G+8pul77AZT8ycuQ6
         oip/S3wTlOCpqAWEYOsU9DE1Re0oJ+/EHlQ53UjvYbE3HK5+10WByvLbaegh38i0nK9f
         emH2fMfePEi/tnq21QCDTE/k4CVb/f50OWKHIR8Ki+osassgB4Wx/vyR7LtHdwR6m2m3
         bzWg==
X-Gm-Message-State: AOAM5316ksvN5RyvCm9FX7Epi8GiiwauWM9hE9iZCap3OKUTRdeWa80Z
        Fw1kQ1vztK9e0aIwGyp382aE/hrK8q2TZw==
X-Google-Smtp-Source: ABdhPJwXUP0XaWV+ZusyYRVUQnPvPIkCgrBHa8v1+apkIz1Ygw49ZAktFYsadw2U+BeoP8Oe+vM1WA==
X-Received: by 2002:a17:902:8303:b029:e6:4ef3:4f17 with SMTP id bd3-20020a1709028303b02900e64ef34f17mr12428168plb.22.1615830011345;
        Mon, 15 Mar 2021 10:40:11 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fa21sm246914pjb.25.2021.03.15.10.40.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:40:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 9/9] Bluetooth: btintel: Skip reading firmware file version while in bootloader mode
Date:   Mon, 15 Mar 2021 10:40:02 -0700
Message-Id: <20210315174002.1778447-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315174002.1778447-1-luiz.dentz@gmail.com>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Lokendra Singh <lokendra.singh@intel.com>

This skips parsing the firmware version information from the firmware
file while controller is in bootloader mode. As in bootloader mode,
we are supposed to patch unconditionally.

Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
---
 drivers/bluetooth/btintel.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 6442acba76d1..e44b6993cf91 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1031,6 +1031,10 @@ int btintel_download_firmware(struct hci_dev *hdev,
 		/* Skip version checking */
 		break;
 	default:
+		/* Skip reading firmware file version in bootloader mode */
+		if (ver->fw_variant == 0x06)
+			break;
+
 		/* Skip download if firmware has the same version */
 		if (btintel_firmware_version(hdev, ver->fw_build_num,
 					     ver->fw_build_ww, ver->fw_build_yy,
@@ -1070,15 +1074,19 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 	int err;
 	u32 css_header_ver;
 
-	/* Skip download if firmware has the same version */
-	if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
-				     ver->min_fw_build_cw, ver->min_fw_build_yy,
-				     fw, boot_param)) {
-		bt_dev_info(hdev, "Firmware already loaded");
-		/* Return -EALREADY to indicate that firmware has already been
-		 * loaded.
-		 */
-		return -EALREADY;
+	/* Skip reading firmware file version in bootloader mode */
+	if (ver->img_type != 0x01) {
+		/* Skip download if firmware has the same version */
+		if (btintel_firmware_version(hdev, ver->min_fw_build_nn,
+					     ver->min_fw_build_cw,
+					     ver->min_fw_build_yy,
+					     fw, boot_param)) {
+			bt_dev_info(hdev, "Firmware already loaded");
+			/* Return -EALREADY to indicate that firmware has
+			 * already been loaded.
+			 */
+			return -EALREADY;
+		}
 	}
 
 	/* The firmware variant determines if the device is in bootloader
-- 
2.30.2

