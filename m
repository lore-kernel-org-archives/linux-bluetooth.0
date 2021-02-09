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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BAC4332B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E2964E4E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 00:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhBJAS5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 19:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhBIXey (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 18:34:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2FC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Feb 2021 15:34:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j11so160144plt.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Feb 2021 15:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lNTiFxZ49BbRIPPeXko9qZ28Ra9Ps3hbsvOdvHpWtCw=;
        b=Ll0KzgX0XD1UyBDt7T7amgmEkxUK/8IPqFWLzUPYwgVlrIwHUZMEnkPID1oP8Wq9cE
         QO9oBQY2SyJVb6agBesRtxCGXO/pYbqRWK9o3dDUSEoGPBjAQJ0H8TG/M1/VVPk+gpa4
         xDofIHBun5Opl9jMk155YSdCu9ePmVaiKIEd7Xaqe/yBdwHfsDtpXiKpC0tRwmt09lIr
         NKO3/TZsb4qxMJS9IO68ylbxqJ2Ar7wkTp/bpawl7T9UwlskyDO7OMGfsLv7OI40Gp0E
         Cj5JDJhxeOjyxfo4j5CWFMyziNahM258Jt3A9bfXxlksXtUZZc9QVFLhvamfccYrL+3f
         sMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNTiFxZ49BbRIPPeXko9qZ28Ra9Ps3hbsvOdvHpWtCw=;
        b=TLIBYWiXpCGMd+C3Vbkza4IcAAk1UbJo3id+5vexIJEw2ZvIpnmNzd1sPx3AYQNWf5
         fRt9mgNyWZVmm9xi0lJtmHeDvBddOD8ZfCarhsq6Kiv+vzhvd7XBQZbsHF/oYFnb/WOX
         k3TNUoX0o6n85sy94CSj1rhHgb8D5L/y/uXZWqcxB+xgAtZ4E0xWQjpFnbzaOQuVkNwY
         GqlBkFfdP9rLFmves6y5cCMWSdkVEMTvife+LeDWzeutghDczc1RVCdCB6LmzsXKgxGd
         cxlGJ4PxCbekU23v+vV8Ce1iyl0c8RchxKEV/f0qPPmYYovY5AmhXbsLU75AxwMvlhMM
         wm9g==
X-Gm-Message-State: AOAM532espwN2QMwJD95EEJ6JKfiYUy7r1aIYslhsDLNWnfAQI8E0SNn
        oknT9k3GZHV/QmihaahqbDE3XNWvMNwf3w==
X-Google-Smtp-Source: ABdhPJxTU7Q9Ggeo6RcDF07uZ4HxZ/74uLlgmxB/rF8PYj6YJBRtEoiZD645Ndub4JotJydQz1gd4w==
X-Received: by 2002:a17:90a:ba87:: with SMTP id t7mr275074pjr.184.1612913646289;
        Tue, 09 Feb 2021 15:34:06 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s18sm141943pjr.14.2021.02.09.15.34.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:34:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/6] Bluetooth: btintel: Move operational checks after version check
Date:   Tue,  9 Feb 2021 15:34:00 -0800
Message-Id: <20210209233404.2121960-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209233404.2121960-1-luiz.dentz@gmail.com>
References: <20210209233404.2121960-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to allow new firmware to be loaded it first needs to check if
the firmware version on file matches the one loaded if it doesn't then
it needs to revert to boorloader mode in order to load the new firmware.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 22 +++++++++++
 drivers/bluetooth/btusb.c   | 74 +++++++++++++++----------------------
 2 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 153989bd8d5f..ccab05f67df9 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -948,6 +948,17 @@ int btintel_download_firmware(struct hci_dev *hdev,
 		return -EALREADY;
 	}
 
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x06 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * If the firmware version has changed that means it needs to be reset
+	 * to bootloader when operational so the new firmware can be loaded.
+	 */
+	if (ver->fw_variant == 0x23)
+		return -EINVAL;
+
 	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
 	if (err)
 		return err;
@@ -974,6 +985,17 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 		return -EALREADY;
 	}
 
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x03 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * If the firmware version has changed that means it needs to be reset
+	 * to bootloader when operational so the new firmware can be loaded.
+	 */
+	if (ver->img_type == 0x03)
+		return -EINVAL;
+
 	/* iBT hardware variants 0x0b, 0x0c, 0x11, 0x12, 0x13, 0x14 support
 	 * only RSA secure boot engine. Hence, the corresponding sfi file will
 	 * have RSA header of 644 bytes followed by Command Buffer.
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e896c6702d60..113ff780232f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2469,14 +2469,30 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
+static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 					     struct intel_boot_params *params,
 					     char *fw_name, size_t len,
 					     const char *suffix)
 {
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37)
+		return -EINVAL;
+
 	switch (ver->hw_variant) {
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
+		/* The firmware variant determines if the device is in
+		 * bootloader mode or is running operational firmware.
+		 *
+		 * Version checking cannot be performed in these models since
+		 * the firmware versioning depends on the firmware being in
+		 * bootloader mode.
+		 */
+		if (ver->fw_variant == 0x23)
+			return -EALREADY;
+
 		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
 			le16_to_cpu(ver->hw_variant),
 			le16_to_cpu(params->dev_revid),
@@ -2493,9 +2509,10 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 			suffix);
 		break;
 	default:
-		return false;
+		return -EINVAL;
 	}
-	return true;
+
+	return 0;
 }
 
 static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
@@ -2550,7 +2567,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	if (ver->img_type == 0x03) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-		return 0;
 	}
 
 	/* Check for supported iBT hardware variants of this firmware
@@ -2693,35 +2709,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (!ver || !params)
 		return -EINVAL;
 
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (ver->hw_platform != 0x37) {
-		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
-			   ver->hw_platform);
-		return -EINVAL;
-	}
-
-	/* Check for supported iBT hardware variants of this firmware
-	 * loading method.
-	 *
-	 * This check has been put in place to ensure correct forward
-	 * compatibility options when newer hardware variants come along.
-	 */
-	switch (ver->hw_variant) {
-	case 0x0b:	/* SfP */
-	case 0x0c:	/* WsP */
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* CcP */
-		break;
-	default:
-		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-			   ver->hw_variant);
-		return -EINVAL;
-	}
-
 	btintel_version_info(hdev, ver);
 
 	/* The firmware variant determines if the device is in bootloader
@@ -2740,16 +2727,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (ver->fw_variant == 0x23) {
 		clear_bit(BTUSB_BOOTLOADER, &data->flags);
 		btintel_check_bdaddr(hdev);
-		return 0;
-	}
-
-	/* If the device is not in bootloader mode, then the only possible
-	 * choice is to return an error and abort the device initialization.
-	 */
-	if (ver->fw_variant != 0x06) {
-		bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
-			   ver->fw_variant);
-		return -ENODEV;
+		/* Proceed to download to check if the version matches */
+		goto download;
 	}
 
 	/* Read the secure boot parameters to identify the operating
@@ -2777,6 +2756,7 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
 	}
 
+download:
 	/* With this Intel bootloader only the hardware variant and device
 	 * revision information are used to select the right firmware for SfP
 	 * and WsP.
@@ -2800,7 +2780,13 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	 */
 	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
 						sizeof(fwname), "sfi");
-	if (!err) {
+	if (err < 0) {
+		if (err == -EALREADY) {
+			/* Firmware has already been loaded */
+			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+			goto done;
+		}
+
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
 	}
-- 
2.26.2

