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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA121C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 05:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1042080A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Sep 2020 05:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNI30zWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgIZFtO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 01:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZFtN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 01:49:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEADFC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 22:49:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t18so245188plo.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3cSVu026nB57lq0SBV8o3h/lMYrHWr95LGOYzS4CXI=;
        b=dNI30zWf8ezE7FYQggTjitm6kNpg2iC2pEsZvJ8ZJXmGV18pYi4eNTu0jOCFMw5h8W
         GU0X7yyQqXs9IRuBbH6pLGS6j1mw1TaKsWM61vYdXr0UVK9mcYTkeyFDJ/Zhq/N8dJPr
         ShJt9vKKJqGvEF7yo6BEgRbSsAVR4IvihVqd2EeUZTFgcN0Gl4TzGfeArdNYKuqTNIM6
         zO8LMOhNToZH7OXKZwx+RBc/SU4D5mqAOqn+yAiHcgijDKPtBhr6JV9oft/KvbZY4o/X
         g0bmvU5K0b2gu5hlYa6iTOXP/jDESxpbU2OCjBx7TLlH2LXWa6zt2J0pKX7a7AzAFIrE
         29KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3cSVu026nB57lq0SBV8o3h/lMYrHWr95LGOYzS4CXI=;
        b=V7iilnC9NMGet3OzRCIWx+p+LoFZaEFTBPl3p5gKVpYEX0w1rCiF6R/QwwhFbrz+e9
         Kr+8hhhtCwAGmwK9YROgF8qBbdPZ8cV7F3DRQUKNZ2q/B30KM9od4taHeNSSd89882M/
         Tqpg3lcVRS4fWWW+qBPhj0Lg4Fi4urvL3ou34kMOqW2iDiV6Hyyj5yc8b3iA1RHPt8fk
         AY/sQuMRzOsW9wuobb+eFowKLOpXydomBfcGR4MM5YFVHhg4mnacJ1cyOtP6NLHkJq9+
         n9pe1k1yF0Xa8k0ty7+oNs4aEaWbAKioMbKw2IUSU8kEOSBV9FJqpXrXIqEEoYfqwxhO
         FI5A==
X-Gm-Message-State: AOAM530WPvqiTs9NYgwPHJe65QXfNoKZfl8SYE76DIaeCo3K9mzADfj5
        X9BjlrGWTUM/vnbM/j+ON6FkUhbxdo2S9g==
X-Google-Smtp-Source: ABdhPJx6nIrU+qfE+ng/OFVXeNKJcbhqDTwpZeXgKFPisgFFnErZLQGGbsVTG3wLhmvHvj75VjdYYQ==
X-Received: by 2002:a17:90b:138a:: with SMTP id hr10mr926286pjb.8.1601099352777;
        Fri, 25 Sep 2020 22:49:12 -0700 (PDT)
Received: from localhost.localdomain ([122.172.180.132])
        by smtp.gmail.com with ESMTPSA id 64sm4293367pfg.98.2020.09.25.22.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 22:49:12 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btintel: Add *setup* function for new generation Intel controllers
Date:   Sat, 26 Sep 2020 11:18:42 +0530
Message-Id: <1601099322-9415-2-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601099322-9415-1-git-send-email-kiran.k@intel.com>
References: <1601099322-9415-1-git-send-email-kiran.k@intel.com>
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
Changes in v2:
- None

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

