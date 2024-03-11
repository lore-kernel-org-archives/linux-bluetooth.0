Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B443ADB
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167831; cv=none; b=Gg6WoyzrRN23CNWIMrXhc64BHdR7OkuW9FzxJ780Go6bPZVqDNtdh2ZUd4LhquSnPh5mR/V7IPi6d8r94yA5RdFHbpNGRbq+6HCframFMgDBv/nwb0+09b/sCBgCkX8dAB/xSvnEAlL03qkOm8BUQhN79TKuC2avQbsMWwGuYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167831; c=relaxed/simple;
	bh=cVLJiPQTPO0O4ljQt7XSpoE5yVR3IJva05k2B60bzO4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BulPsus6N2BydiKVzS1hVq+Hsoj5+jSxDSdDabJQavh9Tfrxm+XPV3iGngtXVrlPdzxDuAhAi7mZxPXsfalWUMEcDsvzD7+4r/B5uOntrFrrMQlB2pNARsWY7i3MmQWhpDBL4e5tiiy93S+xYfhhOn2G5aZPyM58uv0p0Iqhpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZmkkFwF; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZmkkFwF"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7dbc1373c8eso1086102241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710167827; x=1710772627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqGRkaukFE25pycIxZUm4xLGnq9v4ehvKlzusYh4/4A=;
        b=fZmkkFwF9ZhHmsEoc/vMDKN++pTkceQEKvwdLV+vyknCL9Tfyetb3nQckY6DfDc/zz
         +2rRl0V9249rbE+RmCT07JYMLpTzee0mhyipgD87z/qrG7wujugS8V7Ij4YYxzQJq2AK
         YFxMgbVkSdtO61gWP2Yssi7tmgmfO7G8kEYBK4QKl2F4jG5pkUvI67+KTHh6BZxuwucX
         v3NHlI82qBYwzFAdPMxKcdst31vfUlEmmls1OIeID5cHeHW39uo8ACarPpoY35dWO2+S
         y+fkOcDQYoQjyIAKa69Yl+QZanXXjlDDARND4gxRVTxIZzHbmj0OSnrdOewGGhez0Kza
         geBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167827; x=1710772627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqGRkaukFE25pycIxZUm4xLGnq9v4ehvKlzusYh4/4A=;
        b=wnQDhCWMuMPal75FZiUCOtHWUdD+T7AtPOAHTf4fiiVM7jNLLwOcgLCXAdZwWmKjQ5
         wEGvkokq63VcGlO5molPjnYcE6Q0JSdsAmuQ9p9y5sjD3dCcDMy7aynTYsidM5Uc7DPI
         afQEPUrLYIrvfo7Ov3VX7bBIrTuimvGfmHh2BGhzB+orQUVFw04yXhaiiS93hG5GuGtu
         p6tlTtiWmBPMj7uT2iv+XF3pI5y7RK98JAF85lVqNQxXZsiYcz6fGcwY61zeeWV3di+/
         ZsovBPhCPTcrLkv1VmoOX9YtRS0YXHZmbXv/3ZrK4QHaG3cpzIxQOqpo10zQXBwlXn52
         5Drw==
X-Gm-Message-State: AOJu0Yzjt7vnZ0KDBUy8NmdUq5E83QiGmtq347l0q417gm+DieH0zU6g
	nlecZY9J1BAWiZrbjtCfbaSNU8gj9KZZmni79XW2vfC2wIM45XsiYGPBwUH8
X-Google-Smtp-Source: AGHT+IGTbvrO6A2raqIFEaDi1Tgbnk7ITqoJzB9ZX0WbSkbDnHzgs7l/aHpCfLuIWADnuV+lu0Ltig==
X-Received: by 2002:a05:6102:1244:b0:473:21ee:1c73 with SMTP id p4-20020a056102124400b0047321ee1c73mr3545938vsg.22.1710167827216;
        Mon, 11 Mar 2024 07:37:07 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 75-20020a9f23d1000000b007db07367c49sm880687uao.40.2024.03.11.07.37.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:37:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btintel: Use proper prefixes
Date: Mon, 11 Mar 2024 10:37:03 -0400
Message-ID: <20240311143703.751323-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Properly prefix symbols with BTINTEL coming from btintel.h otherwire we
may run into symbol clashes and it just make it easier to identify which
header the symbol comes from.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 152 ++++++++++++++++++------------------
 drivers/bluetooth/btintel.h | 118 ++++++++++++++--------------
 drivers/bluetooth/btusb.c   |  14 ++--
 3 files changed, 144 insertions(+), 140 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd95..37caa316530a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -237,7 +237,7 @@ static int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
 	 *
 	 * This flag is set after reading the Intel version.
 	 */
-	if (btintel_test_flag(hdev, INTEL_ROM_LEGACY))
+	if (btintel_test_flag(hdev, BTINTEL_ROM_LEGACY))
 		ret = btintel_set_diag_mfg(hdev, enable);
 	else
 		ret = btintel_set_diag(hdev, enable);
@@ -463,9 +463,9 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
-	if (INTEL_HW_PLATFORM(version->cnvi_bt) != 0x37) {
+	if (BTINTEL_HW_PLATFORM(version->cnvi_bt) != 0x37) {
 		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
-			   INTEL_HW_PLATFORM(version->cnvi_bt));
+			   BTINTEL_HW_PLATFORM(version->cnvi_bt));
 		return -EINVAL;
 	}
 
@@ -475,7 +475,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	 * This check has been put in place to ensure correct forward
 	 * compatibility options when newer hardware variants come along.
 	 */
-	switch (INTEL_HW_VARIANT(version->cnvi_bt)) {
+	switch (BTINTEL_HW_VARIANT(version->cnvi_bt)) {
 	case 0x17:	/* TyP */
 	case 0x18:	/* Slr */
 	case 0x19:	/* Slr-F */
@@ -484,7 +484,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
-			   INTEL_HW_VARIANT(version->cnvi_bt));
+			   BTINTEL_HW_VARIANT(version->cnvi_bt));
 		return -EINVAL;
 	}
 
@@ -532,7 +532,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	coredump_info.hw_variant = INTEL_HW_VARIANT(version->cnvi_bt);
+	coredump_info.hw_variant = BTINTEL_HW_VARIANT(version->cnvi_bt);
 	coredump_info.fw_build_num = version->build_num;
 
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
@@ -570,25 +570,25 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 			return -EINVAL;
 
 		switch (tlv->type) {
-		case INTEL_TLV_CNVI_TOP:
+		case BTINTEL_TLV_CNVI_TOP:
 			version->cnvi_top = get_unaligned_le32(tlv->val);
 			break;
-		case INTEL_TLV_CNVR_TOP:
+		case BTINTEL_TLV_CNVR_TOP:
 			version->cnvr_top = get_unaligned_le32(tlv->val);
 			break;
-		case INTEL_TLV_CNVI_BT:
+		case BTINTEL_TLV_CNVI_BT:
 			version->cnvi_bt = get_unaligned_le32(tlv->val);
 			break;
-		case INTEL_TLV_CNVR_BT:
+		case BTINTEL_TLV_CNVR_BT:
 			version->cnvr_bt = get_unaligned_le32(tlv->val);
 			break;
-		case INTEL_TLV_DEV_REV_ID:
+		case BTINTEL_TLV_DEV_REV_ID:
 			version->dev_rev_id = get_unaligned_le16(tlv->val);
 			break;
-		case INTEL_TLV_IMAGE_TYPE:
+		case BTINTEL_TLV_IMAGE_TYPE:
 			version->img_type = tlv->val[0];
 			break;
-		case INTEL_TLV_TIME_STAMP:
+		case BTINTEL_TLV_TIME_STAMP:
 			/* If image type is Operational firmware (0x03), then
 			 * running FW Calendar Week and Year information can
 			 * be extracted from Timestamp information
@@ -597,10 +597,10 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 			version->min_fw_build_yy = tlv->val[1];
 			version->timestamp = get_unaligned_le16(tlv->val);
 			break;
-		case INTEL_TLV_BUILD_TYPE:
+		case BTINTEL_TLV_BUILD_TYPE:
 			version->build_type = tlv->val[0];
 			break;
-		case INTEL_TLV_BUILD_NUM:
+		case BTINTEL_TLV_BUILD_NUM:
 			/* If image type is Operational firmware (0x03), then
 			 * running FW build number can be extracted from the
 			 * Build information
@@ -608,34 +608,34 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 			version->min_fw_build_nn = tlv->val[0];
 			version->build_num = get_unaligned_le32(tlv->val);
 			break;
-		case INTEL_TLV_SECURE_BOOT:
+		case BTINTEL_TLV_SECURE_BOOT:
 			version->secure_boot = tlv->val[0];
 			break;
-		case INTEL_TLV_OTP_LOCK:
+		case BTINTEL_TLV_OTP_LOCK:
 			version->otp_lock = tlv->val[0];
 			break;
-		case INTEL_TLV_API_LOCK:
+		case BTINTEL_TLV_API_LOCK:
 			version->api_lock = tlv->val[0];
 			break;
-		case INTEL_TLV_DEBUG_LOCK:
+		case BTINTEL_TLV_DEBUG_LOCK:
 			version->debug_lock = tlv->val[0];
 			break;
-		case INTEL_TLV_MIN_FW:
+		case BTINTEL_TLV_MIN_FW:
 			version->min_fw_build_nn = tlv->val[0];
 			version->min_fw_build_cw = tlv->val[1];
 			version->min_fw_build_yy = tlv->val[2];
 			break;
-		case INTEL_TLV_LIMITED_CCE:
+		case BTINTEL_TLV_LIMITED_CCE:
 			version->limited_cce = tlv->val[0];
 			break;
-		case INTEL_TLV_SBE_TYPE:
+		case BTINTEL_TLV_SBE_TYPE:
 			version->sbe_type = tlv->val[0];
 			break;
-		case INTEL_TLV_OTP_BDADDR:
+		case BTINTEL_TLV_OTP_BDADDR:
 			memcpy(&version->otp_bd_addr, tlv->val,
 							sizeof(bdaddr_t));
 			break;
-		case INTEL_TLV_GIT_SHA1:
+		case BTINTEL_TLV_GIT_SHA1:
 			version->git_sha1 = get_unaligned_le32(tlv->val);
 			break;
 		default:
@@ -1837,11 +1837,11 @@ static int btintel_download_wait(struct hci_dev *hdev, ktime_t calltime, int mse
 	unsigned long long duration;
 	int err;
 
-	btintel_set_flag(hdev, INTEL_FIRMWARE_LOADED);
+	btintel_set_flag(hdev, BTINTEL_FIRMWARE_LOADED);
 
 	bt_dev_info(hdev, "Waiting for firmware download to complete");
 
-	err = btintel_wait_on_flag_timeout(hdev, INTEL_DOWNLOADING,
+	err = btintel_wait_on_flag_timeout(hdev, BTINTEL_DOWNLOADING,
 					   TASK_INTERRUPTIBLE,
 					   msecs_to_jiffies(msec));
 	if (err == -EINTR) {
@@ -1854,7 +1854,7 @@ static int btintel_download_wait(struct hci_dev *hdev, ktime_t calltime, int mse
 		return -ETIMEDOUT;
 	}
 
-	if (btintel_test_flag(hdev, INTEL_FIRMWARE_FAILED)) {
+	if (btintel_test_flag(hdev, BTINTEL_FIRMWARE_FAILED)) {
 		bt_dev_err(hdev, "Firmware loading failed");
 		return -ENOEXEC;
 	}
@@ -1876,7 +1876,7 @@ static int btintel_boot_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
 
 	bt_dev_info(hdev, "Waiting for device to boot");
 
-	err = btintel_wait_on_flag_timeout(hdev, INTEL_BOOTING,
+	err = btintel_wait_on_flag_timeout(hdev, BTINTEL_BOOTING,
 					   TASK_INTERRUPTIBLE,
 					   msecs_to_jiffies(msec));
 	if (err == -EINTR) {
@@ -1905,7 +1905,7 @@ static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
 
 	calltime = ktime_get();
 
-	btintel_set_flag(hdev, INTEL_BOOTING);
+	btintel_set_flag(hdev, BTINTEL_BOOTING);
 
 	err = btintel_send_intel_reset(hdev, boot_addr);
 	if (err) {
@@ -1985,7 +1985,7 @@ static int btintel_download_fw(struct hci_dev *hdev,
 	 * case since that command is only available in bootloader mode.
 	 */
 	if (ver->fw_variant == 0x23) {
-		btintel_clear_flag(hdev, INTEL_BOOTLOADER);
+		btintel_clear_flag(hdev, BTINTEL_BOOTLOADER);
 		btintel_check_bdaddr(hdev);
 
 		/* SfP and WsP don't seem to update the firmware version on file
@@ -2050,9 +2050,9 @@ static int btintel_download_fw(struct hci_dev *hdev,
 	 */
 	err = btintel_get_fw_name(ver, params, fwname, sizeof(fwname), "sfi");
 	if (err < 0) {
-		if (!btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+		if (!btintel_test_flag(hdev, BTINTEL_BOOTLOADER)) {
 			/* Firmware has already been loaded */
-			btintel_set_flag(hdev, INTEL_FIRMWARE_LOADED);
+			btintel_set_flag(hdev, BTINTEL_FIRMWARE_LOADED);
 			return 0;
 		}
 
@@ -2062,9 +2062,9 @@ static int btintel_download_fw(struct hci_dev *hdev,
 
 	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
-		if (!btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+		if (!btintel_test_flag(hdev, BTINTEL_BOOTLOADER)) {
 			/* Firmware has already been loaded */
-			btintel_set_flag(hdev, INTEL_FIRMWARE_LOADED);
+			btintel_set_flag(hdev, BTINTEL_FIRMWARE_LOADED);
 			return 0;
 		}
 
@@ -2084,14 +2084,14 @@ static int btintel_download_fw(struct hci_dev *hdev,
 
 	calltime = ktime_get();
 
-	btintel_set_flag(hdev, INTEL_DOWNLOADING);
+	btintel_set_flag(hdev, BTINTEL_DOWNLOADING);
 
 	/* Start firmware downloading and get boot parameter */
 	err = btintel_download_firmware(hdev, ver, fw, boot_param);
 	if (err < 0) {
 		if (err == -EALREADY) {
 			/* Firmware has already been loaded */
-			btintel_set_flag(hdev, INTEL_FIRMWARE_LOADED);
+			btintel_set_flag(hdev, BTINTEL_FIRMWARE_LOADED);
 			err = 0;
 			goto done;
 		}
@@ -2108,7 +2108,7 @@ static int btintel_download_fw(struct hci_dev *hdev,
 	 * that all fragments have been successfully received.
 	 *
 	 * When the event processing receives the notification, then the
-	 * INTEL_DOWNLOADING flag will be cleared.
+	 * BTINTEL_DOWNLOADING flag will be cleared.
 	 *
 	 * The firmware loading should not take longer than 5 seconds
 	 * and thus just timeout if that happens and fail the setup
@@ -2140,7 +2140,7 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 	 */
 	boot_param = 0x00000000;
 
-	btintel_set_flag(hdev, INTEL_BOOTLOADER);
+	btintel_set_flag(hdev, BTINTEL_BOOTLOADER);
 
 	err = btintel_download_fw(hdev, ver, &params, &boot_param);
 	if (err)
@@ -2154,7 +2154,7 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 	if (err)
 		return err;
 
-	btintel_clear_flag(hdev, INTEL_BOOTLOADER);
+	btintel_clear_flag(hdev, BTINTEL_BOOTLOADER);
 
 	err = btintel_get_fw_name(ver, &params, ddcname,
 						sizeof(ddcname), "ddc");
@@ -2217,10 +2217,8 @@ static void btintel_get_fw_name_tlv(const struct intel_version_tlv *ver,
 	}
 
 	snprintf(fw_name, len, format,
-		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
-					  INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
-		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
-					  INTEL_CNVX_TOP_STEP(ver->cnvr_top)),
+		 BTINTEL_CNVX_TOP_PACK_SWAB(ver->cnvi_top),
+		 BTINTEL_CNVX_TOP_PACK_SWAB(ver->cnvr_top),
 		 suffix);
 }
 
@@ -2250,7 +2248,7 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	 * case since that command is only available in bootloader mode.
 	 */
 	if (ver->img_type == BTINTEL_IMG_OP) {
-		btintel_clear_flag(hdev, INTEL_BOOTLOADER);
+		btintel_clear_flag(hdev, BTINTEL_BOOTLOADER);
 		btintel_check_bdaddr(hdev);
 	} else {
 		/*
@@ -2267,9 +2265,9 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
 	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
-		if (!btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+		if (!btintel_test_flag(hdev, BTINTEL_BOOTLOADER)) {
 			/* Firmware has already been loaded */
-			btintel_set_flag(hdev, INTEL_FIRMWARE_LOADED);
+			btintel_set_flag(hdev, BTINTEL_FIRMWARE_LOADED);
 			return 0;
 		}
 
@@ -2290,16 +2288,16 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 
 	calltime = ktime_get();
 
-	btintel_set_flag(hdev, INTEL_DOWNLOADING);
+	btintel_set_flag(hdev, BTINTEL_DOWNLOADING);
 
 	/* Start firmware downloading and get boot parameter */
 	err = btintel_download_fw_tlv(hdev, ver, fw, boot_param,
-					       INTEL_HW_VARIANT(ver->cnvi_bt),
+					       BTINTEL_HW_VARIANT(ver->cnvi_bt),
 					       ver->sbe_type);
 	if (err < 0) {
 		if (err == -EALREADY) {
 			/* Firmware has already been loaded */
-			btintel_set_flag(hdev, INTEL_FIRMWARE_LOADED);
+			btintel_set_flag(hdev, BTINTEL_FIRMWARE_LOADED);
 			err = 0;
 			goto done;
 		}
@@ -2477,9 +2475,11 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 
 	ppag_cmd.ppag_enable_flags = cpu_to_le32(ppag.mode);
 
-	skb = __hci_cmd_sync(hdev, INTEL_OP_PPAG_CMD, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, BTINTEL_OP_PPAG_CMD, sizeof(ppag_cmd),
+			     &ppag_cmd, HCI_CMD_TIMEOUT);
 	if (IS_ERR(skb)) {
-		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));
+		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)",
+			    PTR_ERR(skb));
 		return;
 	}
 	bt_dev_info(hdev, "PPAG-BT: Enabled (Mode %d)", ppag.mode);
@@ -2612,7 +2612,7 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	 */
 	boot_param = 0x00000000;
 
-	btintel_set_flag(hdev, INTEL_BOOTLOADER);
+	btintel_set_flag(hdev, BTINTEL_BOOTLOADER);
 
 	err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
 	if (err)
@@ -2643,7 +2643,7 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 			return err;
 	}
 
-	btintel_clear_flag(hdev, INTEL_BOOTLOADER);
+	btintel_clear_flag(hdev, BTINTEL_BOOTLOADER);
 
 	btintel_get_fw_name_tlv(ver, ddcname, sizeof(ddcname), "ddc");
 	/* Once the device is running in operational mode, it needs to
@@ -2837,14 +2837,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * number of completed commands and allow normal command processing
 	 * from now on.
 	 *
-	 * Regarding the INTEL_BROKEN_SHUTDOWN_LED flag, these devices maybe
+	 * Regarding the BTINTEL_BROKEN_SHUTDOWN_LED flag, these devices maybe
 	 * in the SW_RFKILL ON state as a workaround of fixing LED issue during
 	 * the shutdown() procedure, and once the device is in SW_RFKILL ON
 	 * state, the only way to exit out of it is sending the HCI_Reset
 	 * command.
 	 */
-	if (btintel_test_flag(hdev, INTEL_BROKEN_INITIAL_NCMD) ||
-	    btintel_test_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED)) {
+	if (btintel_test_flag(hdev, BTINTEL_BROKEN_INITIAL_NCMD) ||
+	    btintel_test_flag(hdev, BTINTEL_BROKEN_SHUTDOWN_LED)) {
 		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
 				     HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
@@ -2905,7 +2905,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x07:	/* WP */
 		case 0x08:	/* StP */
 			/* Legacy ROM product */
-			btintel_set_flag(hdev, INTEL_ROM_LEGACY);
+			btintel_set_flag(hdev, BTINTEL_ROM_LEGACY);
 
 			/* Apply the device specific HCI quirks
 			 *
@@ -2917,7 +2917,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			 * (idProduct)
 			 */
 			if (!btintel_test_flag(hdev,
-					       INTEL_ROM_LEGACY_NO_WBS_SUPPORT))
+					       BTINTEL_ROM_LEGACY_NO_WBS_SUPPORT))
 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 					&hdev->quirks);
 			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
@@ -2970,9 +2970,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		goto exit_error;
 	}
 
-	if (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt) != 0x37) {
+	if (BTINTEL_HW_PLATFORM(ver_tlv.cnvi_bt) != 0x37) {
 		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
-			   INTEL_HW_PLATFORM(ver_tlv.cnvi_bt));
+			   BTINTEL_HW_PLATFORM(ver_tlv.cnvi_bt));
 		err = -EINVAL;
 		goto exit_error;
 	}
@@ -2984,7 +2984,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	 * compatibility options when newer hardware variants come
 	 * along.
 	 */
-	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
+	switch (BTINTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x11:      /* JfP */
 	case 0x12:      /* ThP */
 	case 0x13:      /* HrP */
@@ -3046,7 +3046,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
-					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+					BTINTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 		btintel_set_dsm_reset_method(hdev, &ver_tlv);
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
@@ -3055,7 +3055,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
-			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
+			   BTINTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 		err = -EINVAL;
 		break;
 	}
@@ -3088,7 +3088,7 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 	 * goes off. As a workaround, sends HCI_Intel_SW_RFKILL to put the
 	 * device in the RFKILL ON state which turns off the BT LED immediately.
 	 */
-	if (btintel_test_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED)) {
+	if (btintel_test_flag(hdev, BTINTEL_BROKEN_SHUTDOWN_LED)) {
 		skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
 		if (IS_ERR(skb)) {
 			ret = PTR_ERR(skb);
@@ -3121,14 +3121,14 @@ static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 	struct intel_tlv *tlv = (void *)&skb->data[5];
 
 	/* The first event is always an event type TLV */
-	if (tlv->type != INTEL_TLV_TYPE_ID)
+	if (tlv->type != BTINTEL_TLV_TYPE_ID)
 		goto recv_frame;
 
 	switch (tlv->val[0]) {
-	case INTEL_TLV_SYSTEM_EXCEPTION:
-	case INTEL_TLV_FATAL_EXCEPTION:
-	case INTEL_TLV_DEBUG_EXCEPTION:
-	case INTEL_TLV_TEST_EXCEPTION:
+	case BTINTEL_TLV_SYSTEM_EXCEPTION:
+	case BTINTEL_TLV_FATAL_EXCEPTION:
+	case BTINTEL_TLV_DEBUG_EXCEPTION:
+	case BTINTEL_TLV_TEST_EXCEPTION:
 		/* Generate devcoredump from exception */
 		if (!hci_devcd_init(hdev, skb->len)) {
 			hci_devcd_append(hdev, skb);
@@ -3156,7 +3156,7 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
 		unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
 
-		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+		if (btintel_test_flag(hdev, BTINTEL_BOOTLOADER)) {
 			switch (skb->data[2]) {
 			case 0x02:
 				/* When switching to the operational firmware
@@ -3197,8 +3197,8 @@ void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len)
 	if (len != sizeof(*evt))
 		return;
 
-	if (btintel_test_and_clear_flag(hdev, INTEL_BOOTING))
-		btintel_wake_up_flag(hdev, INTEL_BOOTING);
+	if (btintel_test_and_clear_flag(hdev, BTINTEL_BOOTING))
+		btintel_wake_up_flag(hdev, BTINTEL_BOOTING);
 }
 EXPORT_SYMBOL_GPL(btintel_bootup);
 
@@ -3211,11 +3211,11 @@ void btintel_secure_send_result(struct hci_dev *hdev,
 		return;
 
 	if (evt->result)
-		btintel_set_flag(hdev, INTEL_FIRMWARE_FAILED);
+		btintel_set_flag(hdev, BTINTEL_FIRMWARE_FAILED);
 
-	if (btintel_test_and_clear_flag(hdev, INTEL_DOWNLOADING) &&
-	    btintel_test_flag(hdev, INTEL_FIRMWARE_LOADED))
-		btintel_wake_up_flag(hdev, INTEL_DOWNLOADING);
+	if (btintel_test_and_clear_flag(hdev, BTINTEL_DOWNLOADING) &&
+	    btintel_test_flag(hdev, BTINTEL_FIRMWARE_LOADED))
+		btintel_wake_up_flag(hdev, BTINTEL_DOWNLOADING);
 }
 EXPORT_SYMBOL_GPL(btintel_secure_send_result);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 64ab5a2860ab..2b416e3e7dc9 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -8,41 +8,41 @@
 
 /* List of tlv type */
 enum {
-	INTEL_TLV_CNVI_TOP = 0x10,
-	INTEL_TLV_CNVR_TOP,
-	INTEL_TLV_CNVI_BT,
-	INTEL_TLV_CNVR_BT,
-	INTEL_TLV_CNVI_OTP,
-	INTEL_TLV_CNVR_OTP,
-	INTEL_TLV_DEV_REV_ID,
-	INTEL_TLV_USB_VENDOR_ID,
-	INTEL_TLV_USB_PRODUCT_ID,
-	INTEL_TLV_PCIE_VENDOR_ID,
-	INTEL_TLV_PCIE_DEVICE_ID,
-	INTEL_TLV_PCIE_SUBSYSTEM_ID,
-	INTEL_TLV_IMAGE_TYPE,
-	INTEL_TLV_TIME_STAMP,
-	INTEL_TLV_BUILD_TYPE,
-	INTEL_TLV_BUILD_NUM,
-	INTEL_TLV_FW_BUILD_PRODUCT,
-	INTEL_TLV_FW_BUILD_HW,
-	INTEL_TLV_FW_STEP,
-	INTEL_TLV_BT_SPEC,
-	INTEL_TLV_MFG_NAME,
-	INTEL_TLV_HCI_REV,
-	INTEL_TLV_LMP_SUBVER,
-	INTEL_TLV_OTP_PATCH_VER,
-	INTEL_TLV_SECURE_BOOT,
-	INTEL_TLV_KEY_FROM_HDR,
-	INTEL_TLV_OTP_LOCK,
-	INTEL_TLV_API_LOCK,
-	INTEL_TLV_DEBUG_LOCK,
-	INTEL_TLV_MIN_FW,
-	INTEL_TLV_LIMITED_CCE,
-	INTEL_TLV_SBE_TYPE,
-	INTEL_TLV_OTP_BDADDR,
-	INTEL_TLV_UNLOCKED_STATE,
-	INTEL_TLV_GIT_SHA1
+	BTINTEL_TLV_CNVI_TOP = 0x10,
+	BTINTEL_TLV_CNVR_TOP,
+	BTINTEL_TLV_CNVI_BT,
+	BTINTEL_TLV_CNVR_BT,
+	BTINTEL_TLV_CNVI_OTP,
+	BTINTEL_TLV_CNVR_OTP,
+	BTINTEL_TLV_DEV_REV_ID,
+	BTINTEL_TLV_USB_VENDOR_ID,
+	BTINTEL_TLV_USB_PRODUCT_ID,
+	BTINTEL_TLV_PCIE_VENDOR_ID,
+	BTINTEL_TLV_PCIE_DEVICE_ID,
+	BTINTEL_TLV_PCIE_SUBSYSTEM_ID,
+	BTINTEL_TLV_IMAGE_TYPE,
+	BTINTEL_TLV_TIME_STAMP,
+	BTINTEL_TLV_BUILD_TYPE,
+	BTINTEL_TLV_BUILD_NUM,
+	BTINTEL_TLV_FW_BUILD_PRODUCT,
+	BTINTEL_TLV_FW_BUILD_HW,
+	BTINTEL_TLV_FW_STEP,
+	BTINTEL_TLV_BT_SPEC,
+	BTINTEL_TLV_MFG_NAME,
+	BTINTEL_TLV_HCI_REV,
+	BTINTEL_TLV_LMP_SUBVER,
+	BTINTEL_TLV_OTP_PATCH_VER,
+	BTINTEL_TLV_SECURE_BOOT,
+	BTINTEL_TLV_KEY_FROM_HDR,
+	BTINTEL_TLV_OTP_LOCK,
+	BTINTEL_TLV_API_LOCK,
+	BTINTEL_TLV_DEBUG_LOCK,
+	BTINTEL_TLV_MIN_FW,
+	BTINTEL_TLV_LIMITED_CCE,
+	BTINTEL_TLV_SBE_TYPE,
+	BTINTEL_TLV_OTP_BDADDR,
+	BTINTEL_TLV_UNLOCKED_STATE,
+	BTINTEL_TLV_GIT_SHA1
 };
 
 struct intel_tlv {
@@ -145,41 +145,43 @@ struct intel_offload_use_cases {
 	__u8	preset[8];
 } __packed;
 
-#define INTEL_OP_PPAG_CMD		0xFE0B
+#define BTINTEL_OP_PPAG_CMD		0xFE0B
 struct hci_ppag_enable_cmd {
 	__le32	ppag_enable_flags;
 } __packed;
 
-#define INTEL_TLV_TYPE_ID		0x01
+#define BTINTEL_TLV_TYPE_ID		0x01
 
-#define INTEL_TLV_SYSTEM_EXCEPTION	0x00
-#define INTEL_TLV_FATAL_EXCEPTION	0x01
-#define INTEL_TLV_DEBUG_EXCEPTION	0x02
-#define INTEL_TLV_TEST_EXCEPTION	0xDE
+#define BTINTEL_TLV_SYSTEM_EXCEPTION	0x00
+#define BTINTEL_TLV_FATAL_EXCEPTION	0x01
+#define BTINTEL_TLV_DEBUG_EXCEPTION	0x02
+#define BTINTEL_TLV_TEST_EXCEPTION	0xDE
 
-#define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
-#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
-#define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
-#define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
-#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
+#define BTINTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
+#define BTINTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
+#define BTINTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
+#define BTINTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
+#define BTINTEL_CNVX_TOP_PACK_SWAB(t) \
+	__swab16((__u16)(((BTINTEL_CNVX_TOP_TYPE(t)) << 4) | \
+		(BTINTEL_CNVX_TOP_STEP(t))))
 
 enum {
-	INTEL_BOOTLOADER,
-	INTEL_DOWNLOADING,
-	INTEL_FIRMWARE_LOADED,
-	INTEL_FIRMWARE_FAILED,
-	INTEL_BOOTING,
-	INTEL_BROKEN_INITIAL_NCMD,
-	INTEL_BROKEN_SHUTDOWN_LED,
-	INTEL_ROM_LEGACY,
-	INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
-	INTEL_ACPI_RESET_ACTIVE,
+	BTINTEL_BOOTLOADER,
+	BTINTEL_DOWNLOADING,
+	BTINTEL_FIRMWARE_LOADED,
+	BTINTEL_FIRMWARE_FAILED,
+	BTINTEL_BOOTING,
+	BTINTEL_BROKEN_INITIAL_NCMD,
+	BTINTEL_BROKEN_SHUTDOWN_LED,
+	BTINTEL_ROM_LEGACY,
+	BTINTEL_ROM_LEGACY_NO_WBS_SUPPORT,
+	BTINTEL_ACPI_RESET_ACTIVE,
 
-	__INTEL_NUM_FLAGS,
+	__BTINTEL_NUM_FLAGS,
 };
 
 struct btintel_data {
-	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
+	DECLARE_BITMAP(flags, __BTINTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
 };
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 06e915b57283..8b977470ce2e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -900,7 +900,8 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 		return;
 
 	if (intel_data->acpi_reset_method) {
-		if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_data->flags)) {
+		if (test_and_set_bit(BTINTEL_ACPI_RESET_ACTIVE,
+				     intel_data->flags)) {
 			bt_dev_err(hdev, "acpi: last reset failed ? Not resetting again");
 			return;
 		}
@@ -2504,7 +2505,7 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	 * events via the bulk endpoint. These events are treated the
 	 * same way as the ones received from the interrupt endpoint.
 	 */
-	if (btintel_test_flag(hdev, INTEL_BOOTLOADER))
+	if (btintel_test_flag(hdev, BTINTEL_BOOTLOADER))
 		return btusb_recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
@@ -2518,7 +2519,7 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
-		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
+		if (btintel_test_flag(hdev, BTINTEL_BOOTLOADER)) {
 			struct hci_command_hdr *cmd = (void *)skb->data;
 			__u16 opcode = le16_to_cpu(cmd->opcode);
 
@@ -4408,13 +4409,14 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 
 		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
-			btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_SUPPORT);
+			btintel_set_flag(hdev,
+					 BTINTEL_ROM_LEGACY_NO_WBS_SUPPORT);
 
 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
-			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
+			btintel_set_flag(hdev, BTINTEL_BROKEN_INITIAL_NCMD);
 
 		if (id->driver_info & BTUSB_INTEL_BROKEN_SHUTDOWN_LED)
-			btintel_set_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED);
+			btintel_set_flag(hdev, BTINTEL_BROKEN_SHUTDOWN_LED);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.43.0

