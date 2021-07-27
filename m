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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1685EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F022260F93
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhG0Xvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0Xvs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D13FC061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j1so2396339pjv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiU4qkKTxqLRQZua0UpbtywphpRbroeK8KZoUoUZELg=;
        b=nUcT6FOWrwnSO10l8Ib61NR9iWAnuGO9O2SLn1wE6Y4/0Lbaz5HM2uXy95xvwHqdwM
         2PWv0R1ZYYZEgLGtPjyA09vTNn51Z+1bEKV4Dy/U28ptVPGXsb6zxySf4KxycZp0oPwP
         uS5pT7YlbBbnjoo+RBVjxdyM7/w8ew8X74JtWogBY3unOTINoXgZCOCxDOoSKM5Ny1OD
         45foP3W8vgunjjfJhh3AngAJBFe1xsgAKJ7dCqNFJouqbD7Qfz+MnKSKL90lQdRVIiLm
         Ak5obTG97N5uNST/TPIWhpQTASqMDaEeZQLeL+IBsv2D/+QmZCOEk2En+yU/vNws+Efd
         dA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiU4qkKTxqLRQZua0UpbtywphpRbroeK8KZoUoUZELg=;
        b=b0dMkshYZ1pGjlvtLyfwW2yaGkbDdD2zS5BUyP/Xgx3mrrpcc2Hepdhz+U6gA3CfV5
         /PZPHjxa25sstgQB+FdMTSdvjV8ae17+bSqLBai+3fJLkHRW5Vp0BqH0Z6s2s21sy7ys
         zREIbC5PVEm4+WxLy13eOy4XslFhx8AjfcCi6jl9N+29YsQtaD+kfdhC3uPkYD5qN5CN
         xyQ6hlj5Ev0QNZRIL3N0MxLny/jnT1qTX8+mwJWmPfZR8nisvWYUtCz8hF9y1ryOGrZg
         YQKtvTfziuEVjD3HX0WJV5OFzBzMAsk5WW9paI7DrB41q2sisRACaVFZ+mbTrt1zyGRS
         YhYw==
X-Gm-Message-State: AOAM5333HjuKi5KBFffCuJAVCyWr/ozvlpvo4AlHDQoQyNd2s9YoBDGk
        lmSR35L7VOul5uDCYDn+SVWMVfaovK0=
X-Google-Smtp-Source: ABdhPJw+5w9NgiUA3XJIdnXTGicP3oVMj4kThn4bB1R7kXGcnuk2OsMHZZiphnO7DVYqJs1ysMZf0w==
X-Received: by 2002:a17:902:e851:b029:12b:c50a:1ebc with SMTP id t17-20020a170902e851b029012bc50a1ebcmr18608639plg.84.1627429906376;
        Tue, 27 Jul 2021 16:51:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:46 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 08/11] Bluetooth: btintel: Refactoring setup routine for legacy bootloader
Date:   Tue, 27 Jul 2021 16:51:24 -0700
Message-Id: <20210727235127.173149-9-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch refactors the setup routines for legacy bootloader devices
into combined setup, and move the related functions from btusb to
btintel.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 419 +++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  12 ++
 drivers/bluetooth/btusb.c   | 377 +++++---------------------------
 3 files changed, 479 insertions(+), 329 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 24b79f449527..944203cae8e0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1675,6 +1675,392 @@ static int btintel_legacy_rom_setup(struct hci_dev *hdev,
 	return 0;
 }
 
+static int btintel_download_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	ktime_t delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
+
+	bt_dev_info(hdev, "Waiting for firmware download to complete");
+
+	err = wait_on_bit_timeout(&intel->flags, INTEL_DOWNLOADING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(msec));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Firmware loading interrupted");
+		return err;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Firmware loading timeout");
+		return -ETIMEDOUT;
+	}
+
+	if (test_bit(INTEL_FIRMWARE_FAILED, &intel->flags)) {
+		bt_dev_err(hdev, "Firmware loading failed");
+		return -ENOEXEC;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
+
+	return 0;
+}
+
+static int btintel_boot_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	ktime_t delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	bt_dev_info(hdev, "Waiting for device to boot");
+
+	err = wait_on_bit_timeout(&intel->flags, INTEL_BOOTING,
+				  TASK_INTERRUPTIBLE, msecs_to_jiffies(msec));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Device boot interrupted");
+		return -EINTR;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Device boot timeout");
+		return -ETIMEDOUT;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
+
+	return 0;
+}
+
+static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	ktime_t calltime;
+	int err;
+
+	calltime = ktime_get();
+
+	set_bit(INTEL_BOOTING, &intel->flags);
+
+	err = btintel_send_intel_reset(hdev, boot_addr);
+	if (err) {
+		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		return err;
+	}
+
+	/* The bootloader will not indicate when the device is ready. This
+	 * is done by the operational firmware sending bootup notification.
+	 *
+	 * Booting into operational firmware should not take longer than
+	 * 1 second. However if that happens, then just fail the setup
+	 * since something went wrong.
+	 */
+	err = btintel_boot_wait(hdev, calltime, 1000);
+	if (err == -ETIMEDOUT)
+		btintel_reset_to_bootloader(hdev);
+
+	return err;
+}
+
+static int btintel_get_fw_name(struct intel_version *ver,
+					     struct intel_boot_params *params,
+					     char *fw_name, size_t len,
+					     const char *suffix)
+{
+	switch (ver->hw_variant) {
+	case 0x0b:	/* SfP */
+	case 0x0c:	/* WsP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
+			le16_to_cpu(ver->hw_variant),
+			le16_to_cpu(params->dev_revid),
+			suffix);
+		break;
+	case 0x11:	/* JfP */
+	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
+		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
+			le16_to_cpu(ver->hw_variant),
+			le16_to_cpu(ver->hw_revision),
+			le16_to_cpu(ver->fw_revision),
+			suffix);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int btintel_download_fw(struct hci_dev *hdev,
+					 struct intel_version *ver,
+					 struct intel_boot_params *params,
+					 u32 *boot_param)
+{
+	const struct firmware *fw;
+	char fwname[64];
+	int err;
+	struct btintel_data *intel = hci_get_priv(hdev);
+	ktime_t calltime;
+
+	if (!ver || !params)
+		return -EINVAL;
+
+	/* The firmware variant determines if the device is in bootloader
+	 * mode or is running operational firmware. The value 0x06 identifies
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
+	if (ver->fw_variant == 0x23) {
+		clear_bit(INTEL_BOOTLOADER, &intel->flags);
+		btintel_check_bdaddr(hdev);
+
+		/* SfP and WsP don't seem to update the firmware version on file
+		 * so version checking is currently possible.
+		 */
+		switch (ver->hw_variant) {
+		case 0x0b:	/* SfP */
+		case 0x0c:	/* WsP */
+			return 0;
+		}
+
+		/* Proceed to download to check if the version matches */
+		goto download;
+	}
+
+	/* Read the secure boot parameters to identify the operating
+	 * details of the bootloader.
+	 */
+	err = btintel_read_boot_params(hdev, params);
+	if (err)
+		return err;
+
+	/* It is required that every single firmware fragment is acknowledged
+	 * with a command complete event. If the boot parameters indicate
+	 * that this bootloader does not send them, then abort the setup.
+	 */
+	if (params->limited_cce != 0x00) {
+		bt_dev_err(hdev, "Unsupported Intel firmware loading method (%u)",
+			   params->limited_cce);
+		return -EINVAL;
+	}
+
+	/* If the OTP has no valid Bluetooth device address, then there will
+	 * also be no valid address for the operational firmware.
+	 */
+	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
+		bt_dev_info(hdev, "No device address configured");
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
+
+download:
+	/* With this Intel bootloader only the hardware variant and device
+	 * revision information are used to select the right firmware for SfP
+	 * and WsP.
+	 *
+	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
+	 *
+	 * Currently the supported hardware variants are:
+	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
+	 *   12 (0x0c) for iBT3.5 (WsP)
+	 *
+	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
+	 * variant, HW revision and FW revision, as these are dependent on CNVi
+	 * and RF Combination.
+	 *
+	 *   17 (0x11) for iBT3.5 (JfP)
+	 *   18 (0x12) for iBT3.5 (ThP)
+	 *
+	 * The firmware file name for these will be
+	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
+	 *
+	 */
+	err = btintel_get_fw_name(ver, params, fwname, sizeof(fwname), "sfi");
+	if (err < 0) {
+		if (!test_bit(INTEL_BOOTLOADER, &intel->flags)) {
+			/* Firmware has already been loaded */
+			set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
+			return 0;
+		}
+
+		bt_dev_err(hdev, "Unsupported Intel firmware naming");
+		return -EINVAL;
+	}
+
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
+	err = btintel_download_firmware(hdev, ver, fw, boot_param);
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
+	 * INTEL_DOWNLOADING flag will be cleared.
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
+static int btintel_bootloader_setup(struct hci_dev *hdev,
+				    struct intel_version *ver)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	struct intel_version new_ver;
+	struct intel_boot_params params;
+	u32 boot_param;
+	char ddcname[64];
+	int err;
+	struct intel_debug_features features;
+
+	BT_DBG("%s", hdev->name);
+
+	/* Set the default boot parameter to 0x0 and it is updated to
+	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
+	 * command while downloading the firmware.
+	 */
+	boot_param = 0x00000000;
+
+	set_bit(INTEL_BOOTLOADER, &intel->flags);
+
+	err = btintel_download_fw(hdev, ver, &params, &boot_param);
+	if (err)
+		return err;
+
+	/* controller is already having an operational firmware */
+	if (ver->fw_variant == 0x23)
+		goto finish;
+
+	err = btintel_boot(hdev, boot_param);
+	if (err)
+		return err;
+
+	clear_bit(INTEL_BOOTLOADER, &intel->flags);
+
+	err = btintel_get_fw_name(ver, &params, ddcname,
+						sizeof(ddcname), "ddc");
+
+	if (err < 0) {
+		bt_dev_err(hdev, "Unsupported Intel firmware naming");
+	} else {
+		/* Once the device is running in operational mode, it needs to
+		 * apply the device configuration (DDC) parameters.
+		 *
+		 * The device can work without DDC parameters, so even if it
+		 * fails to load the file, no need to fail the setup.
+		 */
+		btintel_load_ddc_config(hdev, ddcname);
+	}
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
+	err = btintel_read_version(hdev, &new_ver);
+	if (err)
+		return err;
+
+	btintel_version_info(hdev, &new_ver);
+
+finish:
+	/* All Intel controllers that support the Microsoft vendor
+	 * extension are using 0xFC1E for VsMsftOpCode.
+	 */
+	switch (ver->hw_variant) {
+	case 0x11:	/* JfP */
+	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
+		hci_set_msft_opcode(hdev, 0xFC1E);
+		break;
+	}
+
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
@@ -1750,7 +2136,7 @@ int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x12:      /* ThP */
 		case 0x13:      /* HrP */
 		case 0x14:      /* CcP */
-			/* TODO: call setup routine for bootloader product */
+			err = btintel_bootloader_setup(hdev, &ver);
 			break;
 		default:
 			bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
@@ -1818,6 +2204,37 @@ void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
 }
 EXPORT_SYMBOL_GPL(btintel_set_flags);
 
+void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	const struct intel_bootup *evt = ptr;
+
+	if (len != sizeof(*evt))
+		return;
+
+	if (test_and_clear_bit(INTEL_BOOTING, &intel->flags))
+		wake_up_bit(&intel->flags, INTEL_BOOTING);
+}
+EXPORT_SYMBOL_GPL(btintel_bootup);
+
+void btintel_secure_send_result(struct hci_dev *hdev,
+				const void *ptr, unsigned int len)
+{
+	struct btintel_data *intel = hci_get_priv(hdev);
+	const struct intel_secure_send_result *evt = ptr;
+
+	if (len != sizeof(*evt))
+		return;
+
+	if (evt->result)
+		set_bit(INTEL_FIRMWARE_FAILED, &intel->flags);
+
+	if (test_and_clear_bit(INTEL_DOWNLOADING, &intel->flags) &&
+	    test_bit(INTEL_FIRMWARE_LOADED, &intel->flags))
+		wake_up_bit(&intel->flags, INTEL_DOWNLOADING);
+}
+EXPORT_SYMBOL_GPL(btintel_secure_send_result);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index abc438b9c62e..f02ccd7e76fb 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -191,6 +191,9 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
+void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
+void btintel_secure_send_result(struct hci_dev *hdev,
+				const void *ptr, unsigned int len);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -337,4 +340,13 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+static inline void btintel_bootup(struct hci_dev *hdev,
+				  const void *ptr, unsigned int len)
+{
+}
+
+static inline void btintel_secure_send_result(struct hci_dev *hdev,
+				const void *ptr, unsigned int len)
+{
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e83df93faed6..189820b92c5e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -365,12 +365,12 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
 	/* Intel Bluetooth devices */
-	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
 						     BTUSB_WIDEBAND_SPEECH},
@@ -384,13 +384,13 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_READ_VERSION |
 						     BTUSB_INTEL_BROKEN_LED },
-	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_INTEL_BROKEN_READ_VERSION |
 						     BTUSB_INTEL_BROKEN_LED |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 
@@ -1999,11 +1999,14 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 				 int count)
 {
+	struct btintel_data *intel = hci_get_priv(data->hdev);
+
 	/* When the device is in bootloader mode, then it can send
 	 * events via the bulk endpoint. These events are treated the
 	 * same way as the ones received from the interrupt endpoint.
 	 */
-	if (test_bit(BTUSB_BOOTLOADER, &data->flags))
+	if (test_bit(BTUSB_BOOTLOADER, &data->flags) ||
+				test_bit(INTEL_BOOTLOADER, &intel->flags))
 		return btusb_recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
@@ -2040,6 +2043,7 @@ static void btusb_intel_secure_send_result(struct btusb_data *data,
 static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btintel_data *intel = hci_get_priv(hdev);
 
 	if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
 		struct hci_event_hdr *hdr = (void *)skb->data;
@@ -2069,19 +2073,49 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
+	if (test_bit(INTEL_BOOTLOADER, &intel->flags)) {
+		struct hci_event_hdr *hdr = (void *)skb->data;
+
+		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
+		    hdr->plen > 0) {
+			const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
+			unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
+
+			switch (skb->data[2]) {
+			case 0x02:
+				/* When switching to the operational firmware
+				 * the device sends a vendor specific event
+				 * indicating that the bootup completed.
+				 */
+				btintel_bootup(hdev, ptr, len);
+				break;
+			case 0x06:
+				/* When the firmware loading completes the
+				 * device sends out a vendor specific event
+				 * indicating the result of the firmware
+				 * loading.
+				 */
+				btintel_secure_send_result(hdev, ptr, len);
+				break;
+			}
+		}
+	}
+
 	return hci_recv_frame(hdev, skb);
 }
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btintel_data *intel = hci_get_priv(hdev);
 	struct urb *urb;
 
 	BT_DBG("%s", hdev->name);
 
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
-		if (test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+		if (test_bit(BTUSB_BOOTLOADER, &data->flags) ||
+				test_bit(INTEL_BOOTLOADER, &intel->flags)) {
 			struct hci_command_hdr *cmd = (void *)skb->data;
 			__u16 opcode = le16_to_cpu(cmd->opcode);
 
@@ -2133,36 +2167,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
-					     struct intel_boot_params *params,
-					     char *fw_name, size_t len,
-					     const char *suffix)
-{
-	switch (ver->hw_variant) {
-	case 0x0b:	/* SfP */
-	case 0x0c:	/* WsP */
-		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
-			le16_to_cpu(ver->hw_variant),
-			le16_to_cpu(params->dev_revid),
-			suffix);
-		break;
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* CcP */
-		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
-			le16_to_cpu(ver->hw_variant),
-			le16_to_cpu(ver->hw_revision),
-			le16_to_cpu(ver->fw_revision),
-			suffix);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
 						 char *fw_name, size_t len,
 						 const char *suffix)
@@ -2322,173 +2326,6 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	return err;
 }
 
-static int btusb_intel_download_firmware(struct hci_dev *hdev,
-					 struct intel_version *ver,
-					 struct intel_boot_params *params,
-					 u32 *boot_param)
-{
-	const struct firmware *fw;
-	char fwname[64];
-	int err;
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	ktime_t calltime;
-
-	if (!ver || !params)
-		return -EINVAL;
-
-	/* The firmware variant determines if the device is in bootloader
-	 * mode or is running operational firmware. The value 0x06 identifies
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
-	if (ver->fw_variant == 0x23) {
-		clear_bit(BTUSB_BOOTLOADER, &data->flags);
-		btintel_check_bdaddr(hdev);
-
-		/* SfP and WsP don't seem to update the firmware version on file
-		 * so version checking is currently possible.
-		 */
-		switch (ver->hw_variant) {
-		case 0x0b:	/* SfP */
-		case 0x0c:	/* WsP */
-			return 0;
-		}
-
-		/* Proceed to download to check if the version matches */
-		goto download;
-	}
-
-	/* Read the secure boot parameters to identify the operating
-	 * details of the bootloader.
-	 */
-	err = btintel_read_boot_params(hdev, params);
-	if (err)
-		return err;
-
-	/* It is required that every single firmware fragment is acknowledged
-	 * with a command complete event. If the boot parameters indicate
-	 * that this bootloader does not send them, then abort the setup.
-	 */
-	if (params->limited_cce != 0x00) {
-		bt_dev_err(hdev, "Unsupported Intel firmware loading method (%u)",
-			   params->limited_cce);
-		return -EINVAL;
-	}
-
-	/* If the OTP has no valid Bluetooth device address, then there will
-	 * also be no valid address for the operational firmware.
-	 */
-	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
-		bt_dev_info(hdev, "No device address configured");
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-	}
-
-download:
-	/* With this Intel bootloader only the hardware variant and device
-	 * revision information are used to select the right firmware for SfP
-	 * and WsP.
-	 *
-	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
-	 *
-	 * Currently the supported hardware variants are:
-	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
-	 *   12 (0x0c) for iBT3.5 (WsP)
-	 *
-	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
-	 * variant, HW revision and FW revision, as these are dependent on CNVi
-	 * and RF Combination.
-	 *
-	 *   17 (0x11) for iBT3.5 (JfP)
-	 *   18 (0x12) for iBT3.5 (ThP)
-	 *
-	 * The firmware file name for these will be
-	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
-	 *
-	 */
-	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
-						sizeof(fwname), "sfi");
-	if (err < 0) {
-		if (!test_bit(BTUSB_BOOTLOADER, &data->flags)) {
-			/* Firmware has already been loaded */
-			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-			return 0;
-		}
-
-		bt_dev_err(hdev, "Unsupported Intel firmware naming");
-		return -EINVAL;
-	}
-
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
-	err = btintel_download_firmware(hdev, ver, fw, boot_param);
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
 static int btusb_boot_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2551,109 +2388,6 @@ static int btusb_intel_boot(struct hci_dev *hdev, u32 boot_addr)
 	return err;
 }
 
-static int btusb_setup_intel_new(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct intel_version ver;
-	struct intel_boot_params params;
-	u32 boot_param;
-	char ddcname[64];
-	int err;
-	struct intel_debug_features features;
-
-	BT_DBG("%s", hdev->name);
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
-	err = btintel_read_version(hdev, &ver);
-	if (err) {
-		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
-		return err;
-	}
-
-	err = btintel_version_info(hdev, &ver);
-	if (err)
-		return err;
-
-	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
-	if (err)
-		return err;
-
-	/* controller is already having an operational firmware */
-	if (ver.fw_variant == 0x23)
-		goto finish;
-
-	err = btusb_intel_boot(hdev, boot_param);
-	if (err)
-		return err;
-
-	clear_bit(BTUSB_BOOTLOADER, &data->flags);
-
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
-						sizeof(ddcname), "ddc");
-
-	if (err < 0) {
-		bt_dev_err(hdev, "Unsupported Intel firmware naming");
-	} else {
-		/* Once the device is running in operational mode, it needs to
-		 * apply the device configuration (DDC) parameters.
-		 *
-		 * The device can work without DDC parameters, so even if it
-		 * fails to load the file, no need to fail the setup.
-		 */
-		btintel_load_ddc_config(hdev, ddcname);
-	}
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
-	err = btintel_read_version(hdev, &ver);
-	if (err)
-		return err;
-
-	btintel_version_info(hdev, &ver);
-
-finish:
-	/* All Intel controllers that support the Microsoft vendor
-	 * extension are using 0xFC1E for VsMsftOpCode.
-	 */
-	switch (ver.hw_variant) {
-	case 0x11:	/* JfP */
-	case 0x12:	/* ThP */
-	case 0x13:	/* HrP */
-	case 0x14:	/* CcP */
-		hci_set_msft_opcode(hdev, 0xFC1E);
-		break;
-	}
-
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
 static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -4229,18 +3963,17 @@ static int btusb_probe(struct usb_interface *intf,
 
 	priv_size = 0;
 
-	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+	data->recv_event = hci_recv_frame;
+	data->recv_bulk = btusb_recv_bulk;
+
+	if (id->driver_info & BTUSB_INTEL_COMBINED ||
+				id->driver_info & BTUSB_INTEL_NEW) {
 		/* Allocate extra space for Intel device */
 		priv_size += sizeof(struct btintel_data);
-	}
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
+		/* Override the rx handlers */
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
-		set_bit(BTUSB_BOOTLOADER, &data->flags);
-	} else {
-		data->recv_event = hci_recv_frame;
-		data->recv_bulk = btusb_recv_bulk;
 	}
 
 	hdev = hci_alloc_dev(priv_size);
@@ -4320,8 +4053,10 @@ static int btusb_probe(struct usb_interface *intf,
 	/* Combined Intel Device setup to support multiple setup routine */
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		hdev->manufacturer = 2;
+		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btintel_setup_combined;
 		hdev->shutdown = btintel_shutdown_combined;
+		hdev->hw_error = btintel_hw_error;
 		hdev->set_diag = btintel_set_diag_combined;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
@@ -4336,20 +4071,6 @@ static int btusb_probe(struct usb_interface *intf,
 			btintel_set_flags(hdev, INTEL_BROKEN_LED);
 	}
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
-		hdev->manufacturer = 2;
-		hdev->send = btusb_send_frame_intel;
-		hdev->setup = btusb_setup_intel_new;
-		hdev->shutdown = btusb_shutdown_intel_new;
-		hdev->hw_error = btintel_hw_error;
-		hdev->set_diag = btintel_set_diag;
-		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-	}
-
 	if (id->driver_info & BTUSB_INTEL_NEWGEN) {
 		hdev->manufacturer = 2;
 		hdev->send = btusb_send_frame_intel;
-- 
2.26.3

