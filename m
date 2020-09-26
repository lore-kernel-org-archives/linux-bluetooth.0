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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56DC4727E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 05:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C92207F7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 05:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2M42iAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIZFXT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 01:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgIZFXT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 01:23:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E436C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 22:23:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d13so4199026pgl.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 22:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qqpuLXN4r5Ir7EIatYll8CS9VE3fLlfuWYyAF8x7FCQ=;
        b=e2M42iAGcV4gnql8VFAJglP+MNmgRGBudNs5N/wHVKsOTRI0NwtK6VPC58hiD+mLkv
         hY+FH1wlhevrtbi4K5WXIr6W+F8xkh2w3g+ULDTK+RUNKA7XtQDIGlS2eWC+yWsbK3y1
         ujCe3lPVCcyric+t7QbIiwysc8gPPX1MHUuOAt249wdcaneYmpBJNsEb3kiayqJpzyeZ
         RovgqoFrcyeU0nfyfRe0ZPobGxYmO98RPqEjqorm6g3LBLUw3pSqQhF5hxi3tyi0riMg
         q6t2tdkSOgpr1xLxkZcKM9dVv+op9l0OGBcNiKBG7dNsD1mPbElzFLvSjp47gAL4S2Rs
         za2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qqpuLXN4r5Ir7EIatYll8CS9VE3fLlfuWYyAF8x7FCQ=;
        b=tfD4xOANQFEdLtovs3w3ZRuAErR3NirhifX0DpuoojSMxd8VrijjuZ+nW5HHMsZiWy
         EbIRNnvvuUA7S+hFU2ryLyZ/edFXJE0tRPah3hAAoG1MNW3hhQhLO/QrEEZfp+jLJ0c0
         g5B6p2BgzJtJsYrd/wPy64C3iP3i4h1rL/pruuZrjacS2RvzxG/52YaY2DnLzd8ZZKMH
         71gPevZlS0rSR0iQFIpB345v+TBrUNu93Bgw9NjRwqWISKCv46O0Xi4mjP8lxQlgy/ik
         l950HLGMFHHX3rt+Ys3Yg6LQNKqtEGkwA+UisUtUdeYy1VU8ek8tujZXZFTGU4yB1xYH
         oKug==
X-Gm-Message-State: AOAM533MPcIsiHwWwCJUx6nJ4PGyT8Ce1HY5diaSKPo8yeptJzbU0Bhy
        1FzJAXq4BLAkhMXeNwWSb39F2acmpfm/LA==
X-Google-Smtp-Source: ABdhPJxdZz7bv2pdE134R8l7mE1zZE7fK32ufkRpQOjlLHw2P6TcUeF7uKCrUos1Shq1JbdtR8mrxA==
X-Received: by 2002:aa7:8299:0:b029:142:2501:397a with SMTP id s25-20020aa782990000b02901422501397amr2313862pfm.63.1601097798136;
        Fri, 25 Sep 2020 22:23:18 -0700 (PDT)
Received: from localhost.localdomain ([122.172.180.132])
        by smtp.gmail.com with ESMTPSA id u22sm3698636pgi.85.2020.09.25.22.23.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 22:23:17 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel: Add *setup* function for new generation Intel controllers
Date:   Sat, 26 Sep 2020 10:52:23 +0530
Message-Id: <1601097743-8409-2-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601097743-8409-1-git-send-email-kiran.k@intel.com>
References: <1601097743-8409-1-git-send-email-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

1) add a flag to identify new geneeration Intel controllers

2) define *setup* and hook it up for new genertion Intel controllers

3) map Typhoon Peak controller (PID:0x0032) to new generation controller

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btusb.c | 145 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ab3d890..698ec95 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -59,6 +59,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
+#define BTUSB_INTEL_NEWGEN	0x1000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -360,7 +361,7 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEW |
+	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
 						     BTUSB_WIDEBAND_SPEECH},
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
@@ -2871,6 +2872,138 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
+	err = btusb_setup_intel_newgen_get_fw_name(&version, ddcname,
+						   sizeof(ddcname), "ddc");
+	if (!err) {
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
@@ -4119,7 +4252,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
+	if ((id->driver_info & BTUSB_INTEL_NEW) ||
+	    (id->driver_info & BTUSB_INTEL_NEWGEN)) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
@@ -4214,7 +4348,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 	}
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
+	if ((id->driver_info & BTUSB_INTEL_NEW) ||
+	    (id->driver_info & BTUSB_INTEL_NEWGEN)) {
 		hdev->manufacturer = 2;
 		hdev->send = btusb_send_frame_intel;
 		hdev->setup = btusb_setup_intel_new;
@@ -4228,6 +4363,10 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 	}
 
+	/* Overload only setup function for new generation Intel controllers */
+	if (id->driver_info & BTUSB_INTEL_NEWGEN)
+		hdev->setup = btusb_setup_intel_newgen;
+
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
-- 
2.7.4

