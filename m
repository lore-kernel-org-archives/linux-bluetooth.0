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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D47C433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 19:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F257E619A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 19:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhCWS7r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhCWS7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1821C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y5so15284624pfn.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3tA1Um38m4hYMnv9CGiuJA7SkPRldGIsASeqovUw/Yg=;
        b=mSKNtZdNfji0zKO7l1792ESPrDU4DC1YWkrMTD0KG48LmeMATsSrDV31c+U41NAeKE
         GWW66LGL8r4I+ibqTjbuhjRFTRLy6sceenNKvi2pQIO1BeA/Tz32boxT/8kd4xVgfz4m
         mh6OjcKEo3VSQlawRjhQUF64FG8wQYs8eQVg2VeZgW0ptNT5OdPRgImIaibkEiOeVrbQ
         sX8COcQAQ3+1Kptv7E6RKEHKb8ZZPII7K7MqKKFCzJNYttGiMy52WB1L9uobcdbm8XVW
         /ByHKXvbf33rEh02/+QyDEoOhYznApPZYthnseLFHd6X6xFDDTquwhuQ4yWhZR191TXN
         A0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tA1Um38m4hYMnv9CGiuJA7SkPRldGIsASeqovUw/Yg=;
        b=MZtXwUINdUE/CoJ/U88kQEht5KV05W7WMEG2OjLUBPK+VFmYKCQ/kW9lRZR0CSZNRC
         wFlOOEwn1kXq2HZ9mkg8V4BCu3vcZqBAuKH7GJppv+HtvFRhgW9QGnJ0CrTZ2Cgxrkia
         OHfczeP3EOofVvP8nKimYAEZNBYWxgX1+W7QaYBnOY1wvdQQmqnqVtTQucMWvGIr/tRr
         QpEnsnJ2zs2VdSIpzN3rZJycmK/9Ti24g4g0m+p5h+sXd+YVVPh94FIUD5ml35rRneLA
         GSGTNC9w79750KY9uU9E9Aopt/f2APIrOiBA+0hfhtY2Z+/mIWlwWeFWNFv410jEM5Ky
         tqlg==
X-Gm-Message-State: AOAM531XqO1o7nE0r6Lvk+gl36eQFecZ45mIblSzvVMGqvdoC59PuSot
        pp0f0vrk4bnBplXrpz+Ys5ktF9vom0sTsg==
X-Google-Smtp-Source: ABdhPJz4BzKh2KvlmnRdYfQrYEH/bGMA8JP0QUPIXocfOuthO+Z/yTHxx/9PO7Pq46DPrNANJibbfQ==
X-Received: by 2002:a65:6107:: with SMTP id z7mr5322160pgu.435.1616525952852;
        Tue, 23 Mar 2021 11:59:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 9/9] Bluetooth: btintel: Skip reading firmware file version while in bootloader mode
Date:   Tue, 23 Mar 2021 11:59:04 -0700
Message-Id: <20210323185904.3372987-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
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

