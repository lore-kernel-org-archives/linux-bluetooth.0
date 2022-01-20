Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jan 2022 19:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347014AbiATToX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jan 2022 14:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiATToV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jan 2022 14:44:21 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F7C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 11:44:21 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d5so4535986pjk.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jan 2022 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OThgPxXbOdMprFjyK/8qYqyu6iKQIOIkcWfmxarfAIE=;
        b=QyoPH5lzW4IoesNX20Rz+wKQVxnHhqOAAcedrkiocTlcHR8j0nOsBKE0S2Yt1JRHcM
         me5KoAZQVrItwoFcbHP1bKyjzdu3Z/V3RyBjA5tSR630dETMektnyBkWbTSqOd+Ho5cI
         FLghrxaa2ddOoHg35s3JUYpCJOoN1aaHbCp4Kwx3uC5wzKf5rs20fXuQVZh/tqHO/2Ly
         KjLsJP13NfCr5PCpkw6dBkU7+YRo4VzoYvxij4CwFo4kap3Vy60zUJSoP75DzkPLMB6w
         KjebZSkeefnbZG+Sy8DpsJtQtuk8qJvrxHGgL4u/MIcbuOcHPEfhyN3w0IQQspiVIUph
         OzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OThgPxXbOdMprFjyK/8qYqyu6iKQIOIkcWfmxarfAIE=;
        b=ad54KIp3W4RLwF64fbgmuctABkY2+Ad8GoqjTU8+PrAlUlENS4wqB39A5HIG86Kd3f
         edao1W0woOsNRLOIzCfJJoyuiDpX1Rc4ocaeiZ0r0hsYCJ34nH2o2ZLL/SiN/FUJfG8g
         xGXJAsj/PYnkWgG8znaqM4CjxVCt3YQ1QXQ+hG8Cpq+e1Yl09rqnhod2GSyUoBKqp4ri
         ZeUEOjCqeyfyGQigfMga2NBYDepxDemvyfRjb5YmDVdebl232LwXmV6CujTRXoCWRJB4
         hrrC6y8/CdIo5cn65xj+ymOY+OJTBIkbs5P/QXnQ4wSOmWJXHPnEQ5layNC6G26xca0i
         Wg6w==
X-Gm-Message-State: AOAM533EDZiwzVOqTvArP85cwbp66xkfTfS8C1BH5QX+M/BBRlvuFd27
        xnE4GdnBy50OGSPpqId5p55QQZMXL/E=
X-Google-Smtp-Source: ABdhPJxS2qr5kzfe1pmi/xePZKRQb3pwkzWiaaTxMniI/Pp8cV3oAi5W2w+OQy7ZJ7CDlzMdtrZd1A==
X-Received: by 2002:a17:903:110d:b0:149:a908:16a2 with SMTP id n13-20020a170903110d00b00149a90816a2mr204243plh.77.1642707860849;
        Thu, 20 Jan 2022 11:44:20 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6e28:6472:c5bd:5307])
        by smtp.gmail.com with ESMTPSA id y16sm4062279pfl.128.2022.01.20.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 11:44:20 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Fix WBS setting for Intel legacy ROM products
Date:   Thu, 20 Jan 2022 11:44:18 -0800
Message-Id: <20220120194418.349438-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds the flag to identify the Intel legacy ROM products that
don't support WBS like WP and StP.

Fixes: 3df4dfbec0f29 ("Bluetooth: btintel: Move hci quirks to setup routine")
Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 11 ++++++++---
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   |  6 ++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 1a4f8b227eac..8ddb476fabf6 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2428,10 +2428,15 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
 			/* Apply the device specific HCI quirks
 			 *
-			 * WBS for SdP - SdP and Stp have a same hw_varaint but
-			 * different fw_variant
+			 * WBS for SdP - For the Legacy ROM products, only SdP
+			 * supports the WBS. But the version information is not
+			 * enough to use here because the StP2 and SdP have same
+			 * hw_variant and fw_variant. So, this flag is set by
+			 * the transport driver(btusb) based on the HW info
+			 * (idProduct)
 			 */
-			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
+			if (!btintel_test_flag(hdev,
+					       INTEL_ROM_LEGACY_NO_WBS_SUPPORT))
 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 					&hdev->quirks);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c9b24e9299e2..e0060e58573c 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -152,6 +152,7 @@ enum {
 	INTEL_BROKEN_INITIAL_NCMD,
 	INTEL_BROKEN_SHUTDOWN_LED,
 	INTEL_ROM_LEGACY,
+	INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
 
 	__INTEL_NUM_FLAGS,
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c30d131da784..cbd0eaa05e17 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_QCA_WCN6855	0x1000000
 #define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	0x2000000
 #define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
+#define BTUSB_INTEL_NO_WBS_SUPPORT	0x8000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -385,9 +386,11 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x8087, 0x0033), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_NO_WBS_SUPPORT |
 						     BTUSB_INTEL_BROKEN_INITIAL_NCMD |
 						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
+						     BTUSB_INTEL_NO_WBS_SUPPORT |
 						     BTUSB_INTEL_BROKEN_SHUTDOWN_LED },
 	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
@@ -3737,6 +3740,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->send = btusb_send_frame_intel;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
 
+		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
+			btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_SUPPORT);
+
 		if (id->driver_info & BTUSB_INTEL_BROKEN_INITIAL_NCMD)
 			btintel_set_flag(hdev, INTEL_BROKEN_INITIAL_NCMD);
 
-- 
2.25.1

