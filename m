Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B518CC433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AE164E54
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhBJATI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbhBIXey (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 18:34:54 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70566C06178A
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 15:34:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q20so57110pfu.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 15:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qYWGxf7E1iSC2NR4fEKZZ8OFY++f6Wsdk4TWwc68iY0=;
        b=gvELQOsLkbkfW2xcky2SxBgWTO/NEhxrZ1/O4K2Vl75h3G8R9YwSJ42YVvA6Wl32kS
         2UFa3A8BF69e2NQSeu3F9V3qLCiVLtPyg4AhZSyyhLNMHgmaN8GBvBlx9RA/wRVzA2Tx
         V4vtIZHIXpKGedJm8ac3TV7Qw4jX14qhrjFiYSh4chPdugemUMQfzPKOzzWtYEkQDwx8
         4Wfwr+84oWCvod0Lv2Oun5Wz1sE/u6P1xItNdcVWk6adF/ZOvkvlTBnHUap1jRIXsmOF
         q52PHK7/vlD6uho0pBf7vUy6W/cepYbUyckdSYCRwNA40shc7/z0608ojoafvkXhW8Tc
         d6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYWGxf7E1iSC2NR4fEKZZ8OFY++f6Wsdk4TWwc68iY0=;
        b=hOdWbQpPLX1YYovT9JHTIdr8j79n7cyM2fmz+rB2ks+zdhFKJJbYgDv568tYbnq6Dd
         QFhIL8u6m9TtmrvQxgZGmVTdcjbS8vIYgFXMhKQuOZOEWhS6UShK/7W3mbhmKvB16HTh
         oFp+yN1mPT1CxAJDCwF3EzIztaxpZeJu9FJJdOWa8e+14+G//DpDrrLIB1/SB6irHfN6
         msvnhUO0vozr4ysBKlPGl4F30et2KQarfyPllz/F59JNRnTZymCKnAV75ddO9ELc3ltU
         +qhMZBwvNjq7363d7AsXvGcJq2wwGxBVTTUMX1vBqJpY8nFx4d8VJAVZ1AZRdlMYNdo/
         DQSA==
X-Gm-Message-State: AOAM530nCbhu64rCcyeqIQB0WZaVfvkM3SK2pJAXSlBIqPVhqc0D26ES
        9aKW8hN88BlrruXQGG+3gn+yPNuJfMqIAg==
X-Google-Smtp-Source: ABdhPJzJ5JtMxprbxP+YO7mlTzLPy++VHiQxNaQdYwTMULyxIwxEoNH0znElHDT83SHqSzeDHOuxRQ==
X-Received: by 2002:a63:fd01:: with SMTP id d1mr312537pgh.319.1612913647652;
        Tue, 09 Feb 2021 15:34:07 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s18sm141943pjr.14.2021.02.09.15.34.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:34:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] Bluetooth: btintel: Consolidate intel_version parsing
Date:   Tue,  9 Feb 2021 15:34:02 -0800
Message-Id: <20210209233404.2121960-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209233404.2121960-1-luiz.dentz@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves checks version checks of intel_version to
btintel_version_info.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  2 +-
 drivers/bluetooth/btusb.c   | 12 ++++--------
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index ce4b9ef2015f..17f5e3d0dad9 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -216,10 +216,39 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 {
 	const char *variant;
 
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
+			   ver->hw_platform);
+		return -EINVAL;
+	}
+
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
+	switch (ver->hw_variant) {
+	case 0x0b:      /* SfP */
+	case 0x0c:      /* WsP */
+	case 0x11:      /* JfP */
+	case 0x12:      /* ThP */
+	case 0x13:      /* HrP */
+	case 0x14:      /* CcP */
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
+			   ver->hw_variant);
+		return -EINVAL;
+	}
+
 	switch (ver->fw_variant) {
 	case 0x06:
 		variant = "Bootloader";
@@ -228,13 +257,16 @@ void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		variant = "Firmware";
 		break;
 	default:
-		return;
+		bt_dev_err(hdev, "Unsupported firmware variant(%02x)", ver->fw_variant);
+		return -EINVAL;
 	}
 
 	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
 		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
 		    ver->fw_build_num, ver->fw_build_ww,
 		    2000 + ver->fw_build_yy);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_version_info);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 94a63e898826..7163170410a8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -148,7 +148,7 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable);
 int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
+int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
 int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 895950a79400..c1f8d61ced65 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2474,12 +2474,6 @@ static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 					     char *fw_name, size_t len,
 					     const char *suffix)
 {
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (ver->hw_platform != 0x37)
-		return -EINVAL;
-
 	switch (ver->hw_variant) {
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
@@ -2657,8 +2651,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (!ver || !params)
 		return -EINVAL;
 
-	btintel_version_info(hdev, ver);
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -2845,6 +2837,10 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return err;
 	}
 
+	err = btintel_version_info(hdev, &ver);
+	if (err)
+		return err;
+
 	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
 	if (err)
 		return err;
-- 
2.26.2

