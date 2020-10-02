Return-Path: <SRS0=UfNv=DJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE83EC4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Oct 2020 06:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B577206E3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Oct 2020 06:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2e7jOLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJBGwl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBGwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Oct 2020 02:52:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CADC0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 23:52:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e10so32272pfj.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eteMFv1WgjnIxogWH4TNf4mIce2oi3TA9bgP1vGLnjU=;
        b=O2e7jOLzOnMi81oZgMsERPr+mIygAy+5Ap2UH6CDbD8tI+wikOIESpXbuBRhEzvD0S
         TSuKTt/NUBiwuj7B/MK83mw8qULHBbSuA5Zn1H0fWIN9/a3jF3QkqcfHx2NXPJiSiUi+
         USUYUp9h9dVZy6SD1gNOTAWCzze9ZT4ZHnd0W3Pm06cqKuzf0tuZ7J8yVh6AedQrLWkG
         QxgCOsor96H9ilUv+zDszxvJl8Cc+G8lBo6+NkMDZbCXU9zyY5iq1i/Dc7YWfkiYiRIl
         SGS4GphdO3Pf/W0y9vgwbKPag31EkToPDJ5JP5RolUvdjsyOK4O1TKV0BMjZthiC9F3S
         E1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eteMFv1WgjnIxogWH4TNf4mIce2oi3TA9bgP1vGLnjU=;
        b=nneY5797mvfGUJM0UzXWg4SwEpiF7e4/xQLmp3Ci6r2Xp09QLbUVrxNN0AlMcqFvlX
         XVAtyAXFOted5c8ScDi/Ij5oE7c+L9GsT5aB6Ys8Fbwm4KJ9xHBiExCHsAodF6+M3RqQ
         VJMdSNfCb9v2zhSqeYHr9wYlgcwjiHFNBnTlHWeQ9dTLbXik3Xm02PD/3uoM7tGJagN3
         JXY2T07swO0ST9X3gk3xLo5hmRoWwr24/5FnHVPtTf8EQvXJYDwcP3ySiwwOESgVmZPL
         0P6DGcGmn8yGuJ9Dwi0+vc6nUtnceV9kkaKpYbNk+yLuyoA9lcKV5XMITzfdKaS22Rn0
         zvCg==
X-Gm-Message-State: AOAM531a+pVm67my3oNuP7OnUOk3V2ccNwIzLJdK47ugp3HKWeG+ihso
        rgAPWS5P6Uym5rWk7lng1sggS58Gvt7ixQ==
X-Google-Smtp-Source: ABdhPJxdZjr+/KUHx1UBdzp88dY8snw0kSzi/DQWNvgVM8Ui3wz67YlHs9xOVpNAp946KiklJTYgDQ==
X-Received: by 2002:a63:e354:: with SMTP id o20mr752368pgj.317.1601621559737;
        Thu, 01 Oct 2020 23:52:39 -0700 (PDT)
Received: from localhost.localdomain ([122.171.53.200])
        by smtp.gmail.com with ESMTPSA id d128sm680705pfd.94.2020.10.01.23.52.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 23:52:38 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v4] Bluetooth: btintel: Add *setup* function for new generation Intel controllers
Date:   Fri,  2 Oct 2020 12:22:10 +0530
Message-Id: <1601621530-2803-1-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Kiran K <kiraank@gmail.com>

1) add a helper function to download firmware

2) add a function to construct firmware / ddc file name

3) add a flag to identify new geneeration Intel controllers

4) define *setup* and hook it up for new genertion Intel controllers

5) map Typhoon Peak controller (PID:0x0032) to new generation controller

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.h |   6 +
 drivers/bluetooth/btusb.c   | 324 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 328 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 09346ae..c4e28a8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -132,6 +132,12 @@ struct intel_debug_features {
 	__u8    page1[16];
 } __packed;
 
+#define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
+#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
+#define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
+#define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
+#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
+
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e..5e51749 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
+#define BTUSB_INTEL_NEWGEN	0x2000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -365,7 +366,7 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
 						     BTUSB_WIDEBAND_SPEECH},
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
@@ -2359,6 +2360,181 @@ static bool btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 	return true;
 }
 
+static void btusb_setup_intel_newgen_get_fw_name(const struct intel_version_tlv *ver_tlv,
+						 char *fw_name, size_t len,
+						 const char *suffix)
+{
+	/* The firmware file name for new generation controllers will be
+	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
+	 */
+	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvi_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvi_top)),
+		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvr_top),
+					  INTEL_CNVX_TOP_STEP(ver_tlv->cnvr_top)),
+		 suffix);
+}
+
+static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
+						struct intel_version_tlv *ver,
+						u32 *boot_param)
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
+	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
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
@@ -2693,6 +2869,135 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btusb_setup_intel_newgen(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	u32 boot_param;
+	char ddcname[64];
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err;
+	struct intel_debug_features features;
+	struct intel_version_tlv version;
+
+	BT_DBG("%s", hdev->name);
+
+	/* Set the default boot parameter to 0x0 and it is updated to
+	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
+	 * command while downloading the firmware.
+	 */
+	boot_param = 0x00000000;
+
+	calltime = ktime_get();
+
+	/* Read the Intel version information to determine if the device
+	 * is in bootloader mode or if it already has operational firmware
+	 * loaded.
+	 */
+	err = btintel_read_version_tlv(hdev, &version);
+	if (err) {
+		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		return err;
+	}
+
+	btintel_version_info_tlv(hdev, &version);
+
+	err = btusb_intel_download_firmware_newgen(hdev, &version, &boot_param);
+	if (err)
+		return err;
+
+	/* check if controller is already having an operational firmware */
+	if (version.img_type == 0x03)
+		goto finish;
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
+
+	calltime = ktime_get();
+
+	set_bit(BTUSB_BOOTING, &data->flags);
+
+	err = btintel_send_intel_reset(hdev, boot_param);
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
+	bt_dev_info(hdev, "Waiting for device to boot");
+
+	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
+
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Device boot interrupted");
+		return -EINTR;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Device boot timeout");
+		btintel_reset_to_bootloader(hdev);
+		return -ETIMEDOUT;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
+
+	clear_bit(BTUSB_BOOTLOADER, &data->flags);
+
+	btusb_setup_intel_newgen_get_fw_name(&version, ddcname, sizeof(ddcname),
+					     "ddc");
+
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
+	btintel_read_debug_features(hdev, &features);
+
+	/* Set DDC mask for available debug features */
+	btintel_set_debug_features(hdev, &features);
+
+	/* Read the Intel version information after loading the FW  */
+	err = btintel_read_version_tlv(hdev, &version);
+	if (err)
+		return err;
+
+	btintel_version_info_tlv(hdev, &version);
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
 static int btusb_shutdown_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -3969,7 +4274,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
+	if ((id->driver_info & BTUSB_INTEL_NEW) ||
+	    (id->driver_info & BTUSB_INTEL_NEWGEN)) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
@@ -4078,6 +4384,20 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 	}
 
+	if (id->driver_info & BTUSB_INTEL_NEWGEN) {
+		hdev->manufacturer = 2;
+		hdev->send = btusb_send_frame_intel;
+		hdev->setup = btusb_setup_intel_newgen;
+		hdev->shutdown = btusb_shutdown_intel_new;
+		hdev->hw_error = btintel_hw_error;
+		hdev->set_diag = btintel_set_diag;
+		hdev->set_bdaddr = btintel_set_bdaddr;
+		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+	}
+
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-- 
2.7.4

