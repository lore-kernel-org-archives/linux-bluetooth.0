Return-Path: <SRS0=G13S=DD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765D6C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 05:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E083207F7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 05:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHc4UcWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIZFXQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 01:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIZFXQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 01:23:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A9C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 22:23:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so533811pjb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 22:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aO04e3FBhmUT87gvICm638iciG1scOxA1nHwussZRZw=;
        b=fHc4UcWIbRzq8Tbt6EXlJJam4siz0Nr+9G69G+G1KXJ8h3dJ8TgBhsAcw+5tXLvmpr
         82B2tYryT60Ouw/7El884NLPFD3d9yHCBgDF7z/HKgvm+fNy+wXlxsqPSgJZdahTgGUT
         GbZNdnYiLG+p7rIrPmxv4T7Ih0xXQatzJYvtZiNBWRlASLkUwr5VxN41nHDZo5JsVtUA
         DQwyASJRUQv0zmLJD6mcE0nzRq+4Re1K5O3BoGZ01tLQMaIBG+hpjulkkm9mtjBR0B6I
         nR46Q6satoRCw4a7XA/q4oDthIsw0GXybN10faTzmlQsV0cMiD6rHE1ALqLcCeNJN+5W
         qyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aO04e3FBhmUT87gvICm638iciG1scOxA1nHwussZRZw=;
        b=d7+rK1ceoB04q58iPlmQxNDuW3sn8a0kHjh7MkXdoL0yw6tlIKAi+HLL8a4QwaFVDE
         EryhUPkrV+wBTYYnwcN5EQ/yeJxnpzcO3SFDCYkryKGJDZjuijnIDql4P62k6XbC/BPj
         sanLUZV9Uiw+td2EozSuNC4kQNGXsWaqnPI/nuulrHqGwG/4d3wv0Sax+Yi35L1djg1m
         1j1poReIEdSbwvSxWM8XmI4B0sXKsEqzuIyrBZiDPppgryhXjDEpLHPgOA031egScKm8
         hplA9AlPlWsk7vVm6pyi4cH1CdGfr+l+dUQPBNamRo79rzvsC2M7qArbkjbeGu0otK9w
         XVew==
X-Gm-Message-State: AOAM532xjFTvAkAapeic0B1N34tADfj7fDIaH4QDPdFAgu7yT8djE7YJ
        mf9BhUGAz+bL6QMTwJ5I1Uc65/wKuiiJYA==
X-Google-Smtp-Source: ABdhPJz3L4n6J6UGpSljEGHGESihp6QsJxNBIyleilaJCKYBsxYVs/aIHZwZX8/mQEjJPR/HF7opCw==
X-Received: by 2002:a17:902:eb44:b029:d1:cbfc:6159 with SMTP id i4-20020a170902eb44b02900d1cbfc6159mr2660403pli.37.1601097794764;
        Fri, 25 Sep 2020 22:23:14 -0700 (PDT)
Received: from localhost.localdomain ([122.172.180.132])
        by smtp.gmail.com with ESMTPSA id u22sm3698636pgi.85.2020.09.25.22.23.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 22:23:13 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel: Add helper function to download firmware
Date:   Sat, 26 Sep 2020 10:52:22 +0530
Message-Id: <1601097743-8409-1-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

1) ddd a helper function to download firmware for new generation
   Intel controllers

2) ddd a function to construct firmware / ddc file name for new
   generation Intel controllers

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.h |   6 ++
 drivers/bluetooth/btusb.c   | 183 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 09346ae..f5c26dc 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,12 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+#define INTEL_HW_PLATFORM(cnvx_bt)      ((u8)(((cnvx_bt) & 0x0000ff00)  >> 8))
+#define INTEL_HW_VARIANT(cnvx_bt)       ((u8)(((cnvx_bt) & 0x003f0000)   >> 16))
+#define INTEL_CNVX_TOP_TYPE(cnvx_top)   ((cnvx_top) & 0x00000fff)
+#define INTEL_CNVX_TOP_STEP(cnvx_top)   (((cnvx_top) & 0x0f000000) >> 24)
+#define INTEL_CNVX_TOP_PACK_SWAB(t, s)  __swab16(((__u16)(((t) << 4) | (s))))
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9f294b9..ab3d890 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2354,6 +2354,189 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 	return true;
 }
 
+static bool btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
+						 char *fw_name, size_t len,
+						 const char *suffix)
+{
+	/*
+	 * The firmware file name for new generation controllers will be
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 */
+	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvi_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvi_top)),
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvr_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvr_top)),
+		 suffix);
+	return true;
+}
+
+int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
+					 struct intel_version_tlv *ver,
+					 u32 *boot_param)
+{
+	const struct firmware *fw;
+	char fwname[64];
+	int err;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (!ver || !boot_param)
+		return -EINVAL;
+
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (INTEL_HW_PLATFORM(ver->cnvi_bt) != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
+			   INTEL_HW_PLATFORM(ver->cnvi_bt));
+		return -EINVAL;
+	}
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
+		clear_bit(BTUSB_BOOTLOADER, &data->flags);
+		btintel_check_bdaddr(hdev);
+		return 0;
+	}
+
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
+	switch (INTEL_HW_VARIANT(ver->cnvi_bt)) {
+	case 0x17:	/* TyP */
+	case 0x18:	/* Slr */
+	case 0x19:	/* Slr-F */
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
+			   INTEL_HW_VARIANT(ver->cnvi_bt));
+		return -EINVAL;
+	}
+
+	/* If the device is not in bootloader mode, then the only possible
+	 * choice is to return an error and abort the device initialization.
+	 */
+	if (ver->img_type != 0x01) {
+		bt_dev_err(hdev, "Unsupported Intel firmware variant (0x%x)",
+			   ver->img_type);
+		return -ENODEV;
+	}
+
+	/* It is required that every single firmware fragment is acknowledged
+	 * with a command complete event. If the boot parameters indicate
+	 * that this bootloader does not send them, then abort the setup.
+	 */
+	if (ver->limited_cce != 0x00) {
+		bt_dev_err(hdev, "Unsupported Intel firmware loading method (0x%x)",
+			   ver->limited_cce);
+		return -EINVAL;
+	}
+
+	/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
+	if (ver->sbe_type > 0x01) {
+		bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
+			   ver->sbe_type);
+		return -EINVAL;
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
+	err = btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname),
+						   "sfi");
+	if (!err) {
+		bt_dev_err(hdev, "Unsupported Intel firmware naming");
+		return -EINVAL;
+	}
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)", err);
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
+	set_bit(BTUSB_DOWNLOADING, &data->flags);
+
+	/* Start firmware downloading and get boot parameter */
+	err = btintel_download_firmware_newgen(hdev, fw, boot_param,
+					       INTEL_HW_VARIANT(ver->cnvi_bt),
+					       ver->sbe_type);
+	if (err < 0) {
+		/* When FW download fails, send Intel Reset to retry
+		 * FW download.
+		 */
+		btintel_reset_to_bootloader(hdev);
+		goto done;
+	}
+	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+
+	bt_dev_info(hdev, "Waiting for firmware download to complete");
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
+	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(5000));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Firmware loading interrupted");
+		goto done;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Firmware loading timeout");
+		err = -ETIMEDOUT;
+		btintel_reset_to_bootloader(hdev);
+		goto done;
+	}
+
+	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
+		bt_dev_err(hdev, "Firmware loading failed");
+		err = -ENOEXEC;
+		goto done;
+	}
+
+done:
+	release_firmware(fw);
+	return err;
+}
 static int btusb_intel_download_firmware(struct hci_dev *hdev,
 					 struct intel_version *ver,
 					 struct intel_boot_params *params,
-- 
2.7.4

