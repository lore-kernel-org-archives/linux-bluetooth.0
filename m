Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AECC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AB76023B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhG2SgR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhG2SgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33198C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso17081261pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTupyKJc0gL4L5tPiGm/YAUOXI6vvZ8zL0LyjT3HW1M=;
        b=mLajjoK2UVFRoxZ2oNjQzReSQno+uGV4k11omnhkEhjT5XcSHumpWDijRqi2u1EnSH
         k3/jEl1tgLlAwL3q+rXtnG+Oeix1yH4iGu3sUeIn/Q5E1sKXjiZHVp72JKPtrLrrgD9/
         dLxiF7pvc4WHJkxaqsY5hbLgf3tS/jblwU0/k4dRa0N1Xju8aMy70kEh3YNbweeU1gzd
         gXl1wKnRpTpRioyWKWTSoqP4x/M2bsqoyfOGgih30/207tWjLSdtUNMxRbpgz1TdXl63
         bicnYPBKa6eGQ25QNmi+H8UDNd5FIdkTOw4G7XidR96psyKZxUo3YteGOn7CEBUdgw/t
         CNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTupyKJc0gL4L5tPiGm/YAUOXI6vvZ8zL0LyjT3HW1M=;
        b=XQPC0ba1RWf3rJFfX6ttds6xIqryb+SEMDx5b9WJrQ+m4d0nWvimcafMx9HkcrX20k
         Doc2wxD+7/CFbhUMqc3Zh1Rw4bsZzN1h3OnfdV+hzKYpvfr1ApFz9UYClKKBimYX2OpQ
         27BtUpfHXYIlGOKeTJvN2/mLtex2rUEPukppb7Geu7OLuOlrr5aL0X7ZanerJvFGGy5p
         C6SKJ+HUzn2otqJ1Li3bxmrS4cJpD4AsMiCiHyVrNrVSbx6tvJ9cdizaJ2CO4chO8gBV
         yeA0OQcrxX+sko3ovSzUCnAT6vBi7QOFMs9BT9Vh9eNo1v8m2zza8ti6hARuaj5pTx/e
         GXFQ==
X-Gm-Message-State: AOAM532e5QZEzCZYfC1UqQFqmAAC4ddj4UR/g83O8tbO7FA7d7/saE5v
        6vpniM80uQ48AVnjHpD1t6HzEpKMvmY=
X-Google-Smtp-Source: ABdhPJwUI2Ax9NhY/K3JJPda01oMNvK0+jhyXhX0Qrs8nTEOIQRVSLbOETp3wJf6A8xK2jIQvwPBow==
X-Received: by 2002:aa7:998d:0:b029:356:315b:e4f4 with SMTP id k13-20020aa7998d0000b0290356315be4f4mr6337831pfh.65.1627583772308;
        Thu, 29 Jul 2021 11:36:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:11 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 09/11] Bluetooth: btintel: Refactoring setup routine for TLV based booloader
Date:   Thu, 29 Jul 2021 11:35:58 -0700
Message-Id: <20210729183600.281586-10-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch refactors the setup routines for the TLV based bootloader
devices into combined setup, and move the related functions from btubs
to btintel.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 289 +++++++++++++++++--------
 drivers/bluetooth/btintel.h |  13 --
 drivers/bluetooth/btusb.c   | 413 +-----------------------------------
 3 files changed, 204 insertions(+), 511 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 944203cae8e0..dc5e2b255605 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -623,90 +623,7 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 		return -EIO;
 	}
 
-	/* Consume Command Complete Status field */
-	skb_pull(skb, 1);
-
-	/* Event parameters contatin multiple TLVs. Read each of them
-	 * and only keep the required data. Also, it use existing legacy
-	 * version field like hw_platform, hw_variant, and fw_variant
-	 * to keep the existing setup flow
-	 */
-	while (skb->len) {
-		struct intel_tlv *tlv;
-
-		tlv = (struct intel_tlv *)skb->data;
-		switch (tlv->type) {
-		case INTEL_TLV_CNVI_TOP:
-			version->cnvi_top = get_unaligned_le32(tlv->val);
-			break;
-		case INTEL_TLV_CNVR_TOP:
-			version->cnvr_top = get_unaligned_le32(tlv->val);
-			break;
-		case INTEL_TLV_CNVI_BT:
-			version->cnvi_bt = get_unaligned_le32(tlv->val);
-			break;
-		case INTEL_TLV_CNVR_BT:
-			version->cnvr_bt = get_unaligned_le32(tlv->val);
-			break;
-		case INTEL_TLV_DEV_REV_ID:
-			version->dev_rev_id = get_unaligned_le16(tlv->val);
-			break;
-		case INTEL_TLV_IMAGE_TYPE:
-			version->img_type = tlv->val[0];
-			break;
-		case INTEL_TLV_TIME_STAMP:
-			/* If image type is Operational firmware (0x03), then
-			 * running FW Calendar Week and Year information can
-			 * be extracted from Timestamp information
-			 */
-			version->min_fw_build_cw = tlv->val[0];
-			version->min_fw_build_yy = tlv->val[1];
-			version->timestamp = get_unaligned_le16(tlv->val);
-			break;
-		case INTEL_TLV_BUILD_TYPE:
-			version->build_type = tlv->val[0];
-			break;
-		case INTEL_TLV_BUILD_NUM:
-			/* If image type is Operational firmware (0x03), then
-			 * running FW build number can be extracted from the
-			 * Build information
-			 */
-			version->min_fw_build_nn = tlv->val[0];
-			version->build_num = get_unaligned_le32(tlv->val);
-			break;
-		case INTEL_TLV_SECURE_BOOT:
-			version->secure_boot = tlv->val[0];
-			break;
-		case INTEL_TLV_OTP_LOCK:
-			version->otp_lock = tlv->val[0];
-			break;
-		case INTEL_TLV_API_LOCK:
-			version->api_lock = tlv->val[0];
-			break;
-		case INTEL_TLV_DEBUG_LOCK:
-			version->debug_lock = tlv->val[0];
-			break;
-		case INTEL_TLV_MIN_FW:
-			version->min_fw_build_nn = tlv->val[0];
-			version->min_fw_build_cw = tlv->val[1];
-			version->min_fw_build_yy = tlv->val[2];
-			break;
-		case INTEL_TLV_LIMITED_CCE:
-			version->limited_cce = tlv->val[0];
-			break;
-		case INTEL_TLV_SBE_TYPE:
-			version->sbe_type = tlv->val[0];
-			break;
-		case INTEL_TLV_OTP_BDADDR:
-			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
-			break;
-		default:
-			/* Ignore rest of information */
-			break;
-		}
-		/* consume the current tlv and move to next*/
-		skb_pull(skb, tlv->len + sizeof(*tlv));
-	}
+	btintel_parse_version_tlv(hdev, version, skb);
 
 	kfree_skb(skb);
 	return 0;
@@ -1184,10 +1101,10 @@ int btintel_download_firmware(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btintel_download_firmware);
 
-int btintel_download_firmware_newgen(struct hci_dev *hdev,
-				     struct intel_version_tlv *ver,
-				     const struct firmware *fw, u32 *boot_param,
-				     u8 hw_variant, u8 sbe_type)
+static int btintel_download_fw_tlv(struct hci_dev *hdev,
+				   struct intel_version_tlv *ver,
+				   const struct firmware *fw, u32 *boot_param,
+				   u8 hw_variant, u8 sbe_type)
 {
 	int err;
 	u32 css_header_ver;
@@ -1284,7 +1201,6 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_download_firmware_newgen);
 
 void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
@@ -2061,6 +1977,199 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 	return 0;
 }
 
+static void btintel_get_fw_name_tlv(const struct intel_version_tlv *ver,
+				    char *fw_name, size_t len,
+				    const char *suffix)
+{
+	/* The firmware file name for new generation controllers will be
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 */
+	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
+					  INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
+					  INTEL_CNVX_TOP_STEP(ver->cnvr_top)),
+		 suffix);
+}
+
+static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
+					   struct intel_version_tlv *ver,
+					   u32 *boot_param)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	const struct firmware *fw;
+	char fwname[64];
+	int err;
+	ktime_t calltime;
+
+	if (!ver || !boot_param)
+		return -EINVAL;
+
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x03 identifies
+	 * the bootloader and the value 0x23 identifies the operational
+	 * firmware.
+	 *
+	 * When the operational firmware is already present, then only
+	 * the check for valid Bluetooth device address is needed. This
+	 * determines if the device will be added as configured or
+	 * unconfigured controller.
+	 *
+	 * It is not possible to use the Secure Boot Parameters in this
+	 * case since that command is only available in bootloader mode.
+	 */
+	if (ver->img_type == 0x03) {
+		clear_bit(INTEL_BOOTLOADER, &intel->flags);
+		btintel_check_bdaddr(hdev);
+	}
+
+	/* If the OTP has no valid Bluetooth device address, then there will
+	 * also be no valid address for the operational firmware.
+	 */
+	if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
+		bt_dev_info(hdev, "No device address configured");
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+	btintel_get_fw_name_tlv(ver, fwname, sizeof(fwname), "sfi");
+	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		if (!test_bit(INTEL_BOOTLOADER, &intel->flags)) {
+			/* Firmware has already been loaded */
+			set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
+			return 0;
+		}
+
+		bt_dev_err(hdev, "Failed to load Intel firmware file %s (%d)",
+			   fwname, err);
+
+		return err;
+	}
+
+	bt_dev_info(hdev, "Found device firmware: %s", fwname);
+
+	if (fw->size < 644) {
+		bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
+			   fw->size);
+		err = -EBADF;
+		goto done;
+	}
+
+	calltime = ktime_get();
+
+	set_bit(INTEL_DOWNLOADING, &intel->flags);
+
+	/* Start firmware downloading and get boot parameter */
+	err = btintel_download_fw_tlv(hdev, ver, fw, boot_param,
+					       INTEL_HW_VARIANT(ver->cnvi_bt),
+					       ver->sbe_type);
+	if (err < 0) {
+		if (err == -EALREADY) {
+			/* Firmware has already been loaded */
+			set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
+			err = 0;
+			goto done;
+		}
+
+		/* When FW download fails, send Intel Reset to retry
+		 * FW download.
+		 */
+		btintel_reset_to_bootloader(hdev);
+		goto done;
+	}
+
+	/* Before switching the device into operational mode and with that
+	 * booting the loaded firmware, wait for the bootloader notification
+	 * that all fragments have been successfully received.
+	 *
+	 * When the event processing receives the notification, then the
+	 * BTUSB_DOWNLOADING flag will be cleared.
+	 *
+	 * The firmware loading should not take longer than 5 seconds
+	 * and thus just timeout if that happens and fail the setup
+	 * of this device.
+	 */
+	err = btintel_download_wait(hdev, calltime, 5000);
+	if (err == -ETIMEDOUT)
+		btintel_reset_to_bootloader(hdev);
+
+done:
+	release_firmware(fw);
+	return err;
+}
+
+static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
+					struct intel_version_tlv *ver)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	u32 boot_param;
+	char ddcname[64];
+	int err;
+	struct intel_debug_features features;
+	struct intel_version_tlv new_ver;
+
+	bt_dev_dbg(hdev, "");
+
+	/* Set the default boot parameter to 0x0 and it is updated to
+	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
+	 * command while downloading the firmware.
+	 */
+	boot_param = 0x00000000;
+
+	set_bit(INTEL_BOOTLOADER, &intel->flags);
+
+	err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
+	if (err)
+		return err;
+
+	/* check if controller is already having an operational firmware */
+	if (ver->img_type == 0x03)
+		goto finish;
+
+	err = btintel_boot(hdev, boot_param);
+	if (err)
+		return err;
+
+	clear_bit(INTEL_BOOTLOADER, &intel->flags);
+
+	btintel_get_fw_name_tlv(ver, ddcname, sizeof(ddcname), "ddc");
+	/* Once the device is running in operational mode, it needs to
+	 * apply the device configuration (DDC) parameters.
+	 *
+	 * The device can work without DDC parameters, so even if it
+	 * fails to load the file, no need to fail the setup.
+	 */
+	btintel_load_ddc_config(hdev, ddcname);
+
+	/* Read the Intel supported features and if new exception formats
+	 * supported, need to load the additional DDC config to enable.
+	 */
+	err = btintel_read_debug_features(hdev, &features);
+	if (!err) {
+		/* Set DDC mask for available debug features */
+		btintel_set_debug_features(hdev, &features);
+	}
+
+	/* Read the Intel version information after loading the FW  */
+	err = btintel_read_version_tlv(hdev, &new_ver);
+	if (err)
+		return err;
+
+	btintel_version_info_tlv(hdev, &new_ver);
+
+finish:
+	/* Set the event mask for Intel specific vendor events. This enables
+	 * a few extra events that are useful during general operation. It
+	 * does not enable any debugging related events.
+	 *
+	 * The device will function correctly without these events enabled
+	 * and thus no need to fail the setup.
+	 */
+	btintel_set_event_mask(hdev, false);
+
+	return 0;
+}
+
 int btintel_setup_combined(struct hci_dev *hdev)
 {
 	struct btintel_data *intel = hci_get_priv(hdev);
@@ -2154,7 +2263,7 @@ int btintel_setup_combined(struct hci_dev *hdev)
 	btintel_version_info_tlv(hdev, &ver_tlv);
 
 	/* TODO: Need to filter the device for new generation */
-	/* TODO: call setup routine for tlv based bootloader product */
+	err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
 
 	return err;
 }
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index f02ccd7e76fb..696656fd7e99 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -181,11 +181,6 @@ int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 int btintel_setup_combined(struct hci_dev *hdev);
 int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_set_flags(struct hci_dev *hdev, unsigned int flag);
-int btintel_download_firmware_newgen(struct hci_dev *hdev,
-				     struct intel_version_tlv *ver,
-				     const struct firmware *fw,
-				     u32 *boot_param, u8 hw_variant,
-				     u8 sbe_type);
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
 int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
@@ -316,14 +311,6 @@ static inline void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
 {
 }
 
-static inline int btintel_download_firmware_newgen(struct hci_dev *hdev,
-						   const struct firmware *fw,
-						   u32 *boot_param,
-						   u8 hw_variant, u8 sbe_type)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4b1e6504f187..1e82fbad162d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -372,9 +372,9 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
+	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH},
-	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_NEWGEN |
+	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
@@ -2005,74 +2005,16 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	 * events via the bulk endpoint. These events are treated the
 	 * same way as the ones received from the interrupt endpoint.
 	 */
-	if (test_bit(BTUSB_BOOTLOADER, &data->flags) ||
-				test_bit(INTEL_BOOTLOADER, &intel->flags))
+	if (test_bit(INTEL_BOOTLOADER, &intel->flags))
 		return btusb_recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
 }
 
-static void btusb_intel_bootup(struct btusb_data *data, const void *ptr,
-			       unsigned int len)
-{
-	const struct intel_bootup *evt = ptr;
-
-	if (len != sizeof(*evt))
-		return;
-
-	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags))
-		wake_up_bit(&data->flags, BTUSB_BOOTING);
-}
-
-static void btusb_intel_secure_send_result(struct btusb_data *data,
-					   const void *ptr, unsigned int len)
-{
-	const struct intel_secure_send_result *evt = ptr;
-
-	if (len != sizeof(*evt))
-		return;
-
-	if (evt->result)
-		set_bit(BTUSB_FIRMWARE_FAILED, &data->flags);
-
-	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
-	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
-		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
-}
-
 static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct btintel_data *intel = hci_get_priv(hdev);
 
-	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
-		struct hci_event_hdr *hdr = (void *)skb->data;
-
-		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
-		    hdr->plen > 0) {
-			const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
-			unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
-
-			switch (skb->data[2]) {
-			case 0x02:
-				/* When switching to the operational firmware
-				 * the device sends a vendor specific event
-				 * indicating that the bootup completed.
-				 */
-				btusb_intel_bootup(data, ptr, len);
-				break;
-			case 0x06:
-				/* When the firmware loading completes the
-				 * device sends out a vendor specific event
-				 * indicating the result of the firmware
-				 * loading.
-				 */
-				btusb_intel_secure_send_result(data, ptr, len);
-				break;
-			}
-		}
-	}
-
 	if (test_bit(INTEL_BOOTLOADER, &intel->flags)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
 
@@ -2106,7 +2048,6 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct btintel_data *intel = hci_get_priv(hdev);
 	struct urb *urb;
 
@@ -2114,8 +2055,7 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
-		if (test_bit(BTUSB_BOOTLOADER, &data->flags) ||
-				test_bit(INTEL_BOOTLOADER, &intel->flags)) {
+		if (test_bit(INTEL_BOOTLOADER, &intel->flags)) {
 			struct hci_command_hdr *cmd = (void *)skb->data;
 			__u16 opcode = le16_to_cpu(cmd->opcode);
 
@@ -2167,330 +2107,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
-						 char *fw_name, size_t len,
-						 const char *suffix)
-{
-	/* The firmware file name for new generation controllers will be
-	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
-	 */
-	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
-		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvi_top),
-					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvi_top)),
-		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvr_top),
-					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvr_top)),
-		 suffix);
-}
-
-static int btusb_download_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	ktime_t delta, rettime;
-	unsigned long long duration;
-	int err;
-
-	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-	bt_dev_info(hdev, "Waiting for firmware download to complete");
-
-	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(msec));
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Firmware loading interrupted");
-		return err;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Firmware loading timeout");
-		return -ETIMEDOUT;
-	}
-
-	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
-		bt_dev_err(hdev, "Firmware loading failed");
-		return -ENOEXEC;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
-
-	return 0;
-}
-
-static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
-						struct intel_version_tlv *ver,
-						u32 *boot_param)
-{
-	const struct firmware *fw;
-	char fwname[64];
-	int err;
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	ktime_t calltime;
-
-	if (!ver || !boot_param)
-		return -EINVAL;
-
-	/* The firmware variant determines if the device is in bootloader
-	 * mode or is running operational firmware. The value 0x03 identifies
-	 * the bootloader and the value 0x23 identifies the operational
-	 * firmware.
-	 *
-	 * When the operational firmware is already present, then only
-	 * the check for valid Bluetooth device address is needed. This
-	 * determines if the device will be added as configured or
-	 * unconfigured controller.
-	 *
-	 * It is not possible to use the Secure Boot Parameters in this
-	 * case since that command is only available in bootloader mode.
-	 */
-	if (ver->img_type == 0x03) {
-		clear_bit(BTUSB_BOOTLOADER, &data->flags);
-		btintel_check_bdaddr(hdev);
-	}
-
-	/* If the OTP has no valid Bluetooth device address, then there will
-	 * also be no valid address for the operational firmware.
-	 */
-	if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
-		bt_dev_info(hdev, "No device address configured");
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-	}
-
-	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
-	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
-	if (err < 0) {
-		if (!test_bit(BTUSB_BOOTLOADER, &data->flags)) {
-			/* Firmware has already been loaded */
-			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-			return 0;
-		}
-
-		bt_dev_err(hdev, "Failed to load Intel firmware file %s (%d)",
-			   fwname, err);
-
-		return err;
-	}
-
-	bt_dev_info(hdev, "Found device firmware: %s", fwname);
-
-	if (fw->size < 644) {
-		bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
-			   fw->size);
-		err = -EBADF;
-		goto done;
-	}
-
-	calltime = ktime_get();
-
-	set_bit(BTUSB_DOWNLOADING, &data->flags);
-
-	/* Start firmware downloading and get boot parameter */
-	err = btintel_download_firmware_newgen(hdev, ver, fw, boot_param,
-					       INTEL_HW_VARIANT(ver->cnvi_bt),
-					       ver->sbe_type);
-	if (err < 0) {
-		if (err == -EALREADY) {
-			/* Firmware has already been loaded */
-			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-			err = 0;
-			goto done;
-		}
-
-		/* When FW download fails, send Intel Reset to retry
-		 * FW download.
-		 */
-		btintel_reset_to_bootloader(hdev);
-		goto done;
-	}
-
-	/* Before switching the device into operational mode and with that
-	 * booting the loaded firmware, wait for the bootloader notification
-	 * that all fragments have been successfully received.
-	 *
-	 * When the event processing receives the notification, then the
-	 * BTUSB_DOWNLOADING flag will be cleared.
-	 *
-	 * The firmware loading should not take longer than 5 seconds
-	 * and thus just timeout if that happens and fail the setup
-	 * of this device.
-	 */
-	err = btusb_download_wait(hdev, calltime, 5000);
-	if (err == -ETIMEDOUT)
-		btintel_reset_to_bootloader(hdev);
-
-done:
-	release_firmware(fw);
-	return err;
-}
-
-static int btusb_boot_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	ktime_t delta, rettime;
-	unsigned long long duration;
-	int err;
-
-	bt_dev_info(hdev, "Waiting for device to boot");
-
-	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(msec));
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Device boot interrupted");
-		return -EINTR;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Device boot timeout");
-		return -ETIMEDOUT;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
-
-	return 0;
-}
-
-static int btusb_intel_boot(struct hci_dev *hdev, u32 boot_addr)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	ktime_t calltime;
-	int err;
-
-	calltime = ktime_get();
-
-	set_bit(BTUSB_BOOTING, &data->flags);
-
-	err = btintel_send_intel_reset(hdev, boot_addr);
-	if (err) {
-		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
-		return err;
-	}
-
-	/* The bootloader will not indicate when the device is ready. This
-	 * is done by the operational firmware sending bootup notification.
-	 *
-	 * Booting into operational firmware should not take longer than
-	 * 1 second. However if that happens, then just fail the setup
-	 * since something went wrong.
-	 */
-	err = btusb_boot_wait(hdev, calltime, 1000);
-	if (err == -ETIMEDOUT)
-		btintel_reset_to_bootloader(hdev);
-
-	return err;
-}
-
-static int btusb_setup_intel_newgen(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u32 boot_param;
-	char ddcname[64];
-	int err;
-	struct intel_debug_features features;
-	struct intel_version_tlv version;
-
-	bt_dev_dbg(hdev, "");
-
-	/* Set the default boot parameter to 0x0 and it is updated to
-	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
-	 * command while downloading the firmware.
-	 */
-	boot_param = 0x00000000;
-
-	/* Read the Intel version information to determine if the device
-	 * is in bootloader mode or if it already has operational firmware
-	 * loaded.
-	 */
-	err = btintel_read_version_tlv(hdev, &version);
-	if (err) {
-		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
-		return err;
-	}
-
-	err = btintel_version_info_tlv(hdev, &version);
-	if (err)
-		return err;
-
-	err = btusb_intel_download_firmware_newgen(hdev, &version, &boot_param);
-	if (err)
-		return err;
-
-	/* check if controller is already having an operational firmware */
-	if (version.img_type == 0x03)
-		goto finish;
-
-	err = btusb_intel_boot(hdev, boot_param);
-	if (err)
-		return err;
-
-	clear_bit(BTUSB_BOOTLOADER, &data->flags);
-
-	btusb_setup_intel_newgen_get_fw_name(&version, ddcname, sizeof(ddcname),
-					     "ddc");
-	/* Once the device is running in operational mode, it needs to
-	 * apply the device configuration (DDC) parameters.
-	 *
-	 * The device can work without DDC parameters, so even if it
-	 * fails to load the file, no need to fail the setup.
-	 */
-	btintel_load_ddc_config(hdev, ddcname);
-
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	err = btintel_read_debug_features(hdev, &features);
-	if (!err) {
-		/* Set DDC mask for available debug features */
-		btintel_set_debug_features(hdev, &features);
-	}
-
-	/* Read the Intel version information after loading the FW  */
-	err = btintel_read_version_tlv(hdev, &version);
-	if (err)
-		return err;
-
-	btintel_version_info_tlv(hdev, &version);
-
-finish:
-	/* Set the event mask for Intel specific vendor events. This enables
-	 * a few extra events that are useful during general operation. It
-	 * does not enable any debugging related events.
-	 *
-	 * The device will function correctly without these events enabled
-	 * and thus no need to fail the setup.
-	 */
-	btintel_set_event_mask(hdev, false);
-
-	return 0;
-}
-
-static int btusb_shutdown_intel_new(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-
-	/* Send HCI Reset to the controller to stop any BT activity which
-	 * were triggered. This will help to save power and maintain the
-	 * sync b/w Host and controller
-	 */
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "HCI reset during shutdown failed");
-		return PTR_ERR(skb);
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
-
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 
@@ -3966,8 +3582,7 @@ static int btusb_probe(struct usb_interface *intf,
 	data->recv_event = hci_recv_frame;
 	data->recv_bulk = btusb_recv_bulk;
 
-	if (id->driver_info & BTUSB_INTEL_COMBINED ||
-				id->driver_info & BTUSB_INTEL_NEW) {
+	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		/* Allocate extra space for Intel device */
 		priv_size += sizeof(struct btintel_data);
 
@@ -4071,24 +3686,6 @@ static int btusb_probe(struct usb_interface *intf,
 			btintel_set_flags(hdev, INTEL_BROKEN_LED);
 	}
 
-	if (id->driver_info & BTUSB_INTEL_NEWGEN) {
-		hdev->manufacturer = 2;
-		hdev->send = btusb_send_frame_intel;
-		hdev->setup = btusb_setup_intel_newgen;
-		hdev->shutdown = btusb_shutdown_intel_new;
-		hdev->hw_error = btintel_hw_error;
-		hdev->set_diag = btintel_set_diag;
-		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-
-		data->recv_event = btusb_recv_event_intel;
-		data->recv_bulk = btusb_recv_bulk_intel;
-		set_bit(BTUSB_BOOTLOADER, &data->flags);
-	}
-
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-- 
2.25.1

