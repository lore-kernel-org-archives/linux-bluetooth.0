Return-Path: <SRS0=CDO+=DV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB31DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4672A20878
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Oct 2020 12:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO7TWEFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgJNM27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 08:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbgJNM27 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 08:28:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E7AC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:28:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so1859504pgp.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9+a7cLLni7cDAnrU5j2NAKb9H6OSOhXIziEff9Pq+m0=;
        b=UO7TWEFgcSSTRs2M2HzRl25Pb12KELypvujWgYpi1YrWBToU2sbOR6gJvrfT1BtEfX
         7Ck5GJdDkRHIGDb+mlMardBdjqvF+gEIHl1/sRgKY3eszswTCvYxbXwKXHnbX97Q4jcY
         CZHq+1mtd9fo1bDWRC5VTre2lieZDAOdVEkA0tcycy42eIusrrPgYHNsLAHbMuMJTgIF
         toAWcm9Gzcu0bTeFk6RN9rSx62NWrRNb2VD6hM4U/cam/1mk7hToECh0RnMb5uvKfdsS
         6GRdPJay1Gp6wIE8tGp6tmHs9QaRm2VE8O3VXAeb8GLk0mx1Ek+qZk4CchxiqYcYsyzY
         K22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9+a7cLLni7cDAnrU5j2NAKb9H6OSOhXIziEff9Pq+m0=;
        b=LeZh9xIlVsL9DMAUT3l7jvGnULDT13bsXgY/3rgguLHyQSIFccHZ/hyRDSCDdXIH1R
         kF7sGvmD5HYCO995Xv4WGgKOyBh+0LA5kMFDJzBL/qnKSiuYWbyZwYUbyBMHQNjOWRYJ
         qwstF9fLtvJtPATZ7uehJZjbgEKeJhi/WTe320+bzh3vv3QcLdVNB/FAubKV/lNWTmSQ
         eyr3pxkZY++qkyguieqhj01w+xVw2MFQqtKgint66AHt7dIqzAgih9JrnCjAIAQxZQI+
         /6nSFW2U6LkCYm+HX54CxtMWyZPRw/96KSOZaA/Xq4iOjqDWYN3ivoho7Pa20vIo7HP3
         Dn/A==
X-Gm-Message-State: AOAM530P9W7it7m//dzXr6zJyQtkjWDqmmXGl+7n3bvKI+C+1KKywMBO
        zeQ28dgm0jVfZGZZcRM8uJPR6PwPE0tctQ==
X-Google-Smtp-Source: ABdhPJxS8JoGQvOUefra9ekdiJRYX9mh//JnrduqvdYSW0kRQh9ri8m/tny7KwjLkHQuMgJHnVKrVA==
X-Received: by 2002:a63:d80e:: with SMTP id b14mr3664343pgh.114.1602678537189;
        Wed, 14 Oct 2020 05:28:57 -0700 (PDT)
Received: from localhost.localdomain ([122.179.122.132])
        by smtp.gmail.com with ESMTPSA id r16sm2930000pjo.19.2020.10.14.05.28.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 05:28:56 -0700 (PDT)
From:   Kiran K <kiraank@gmail.com>
X-Google-Original-From: Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com, kiraank@gmail.com,
        Kiran K <kiran.k@intel.com>, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: [PATCH v7 1/4] Bluetooth: btusb: Add *setup* function for new generation Intel controllers
Date:   Wed, 14 Oct 2020 17:58:34 +0530
Message-Id: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a new  *setup* function for new generation Intel controllers

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
Changes in v7:
* split code in to multiple patches

Changes in v6: 
* Revert to v4
* Move TyphoonPeak controller mapping to BTUSB_INTEL_NEWGEN to  
  a separte patch

Changes in v5: 
* Remove BTUSB_INTEL_NEWGEN and use usb vid/pid combination to
  identify controller type

Changes in v4: 
* Rebase patchset
* Fix indentation issues
* make btusb_setup_intel_new_get_fw_name to return void as return value is  
  not getting used

Changes in v3: 
* Combine the two patches in v2 series to one to avoid compiler warnings
   reported by kernel bot (lkp)

Changed in v2: 
* Fix typo in commit message

 drivers/bluetooth/btusb.c | 144 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e..2e40885 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -60,6 +60,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
 #define BTUSB_QCA_WCN6855	0x1000000
+#define BTUSB_INTEL_NEWGEN	0x2000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -2693,6 +2694,132 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
+	/* TODO: Plugin in code here to download firmware */
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
+	/* TODO: Insert function call here to get the ddc file name */
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
@@ -3969,7 +4096,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
+	if ((id->driver_info & BTUSB_INTEL_NEW) ||
+	    (id->driver_info & BTUSB_INTEL_NEWGEN)) {
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
 		set_bit(BTUSB_BOOTLOADER, &data->flags);
@@ -4078,6 +4206,20 @@ static int btusb_probe(struct usb_interface *intf,
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

