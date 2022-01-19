Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B50C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 04:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351550AbiASEvb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jan 2022 23:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351546AbiASEvb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jan 2022 23:51:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EBCC06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 20:51:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so5096264pja.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 20:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEgFmDgo3w6Jffnt8VKTDrZcIrWTG9ANzhjyGQZEAqQ=;
        b=H0iK5vMBQEp8F3MgEJnyRBluasT22qWJaGzJOqdj9lS+6OA88aO4zmgItdxgko+tMS
         xrhNksC0cX+4U2D0LhwTYhRdZM3thcwGvCdCvqOEY2j/PC0am5lsFcdimnTynOy1k2OJ
         dqQM/R4C5ytxFxcAwDwbmBoB8F10SSIgrF9hgKNyeaUtyvEf7G222dvXc3lsI+L+8h3F
         RAVTn282GO2HWyMoFwBC+I5iz+lm31m/X4IP1awEcCRovWaXDKfnuF1Fi3295ROMz0X6
         yNFKsx/Xj6M7D3wUO5Q8weERjRlZZUiooMIfBcCpm3n7lZKH2xR5X2/xfbJWXQM6/uff
         ILDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VEgFmDgo3w6Jffnt8VKTDrZcIrWTG9ANzhjyGQZEAqQ=;
        b=PMBAguKkcvPPPfPMDSv+RwOXIHvgXAhaujzI+qqE9amq16KYA3a1MeJmlG/oZbhl+j
         RQLS3v94+435RNtDhjXDmxLgxVSZyiBrIJV1zxciVHj8Zb7JGfuYPziLugAyGiQfZE7k
         1Sg1EJItq+XNWhitFbz/At6/arMo2P/mbLcL5AyC3if4uGrWd4TyzNU8xX9kajzXsdNK
         APZzaPy09rLZq9QyWAZRRDM0QYaU5dkSr0ezv2OEtcli9o6dfxKn4CtXc5Sir3jOI6jZ
         2kcbdf3DzD1kb5aRUVS15pPZFi99IsfOrb/53db0ZF7KSdPzon9Mut0Dnu403Rq2uqIl
         wg7A==
X-Gm-Message-State: AOAM532TCGO8ENTgS0CI3wl9/LFuCMXDJi00ILOK2cOC1/nzAIVVSgK2
        SWAQbmdxc1vmo0rPCYUJZ06hTT4KNgY=
X-Google-Smtp-Source: ABdhPJzPvWk1OD6aSW3o/EmCn2P7ulHBP8iAdMhJzcKkOjqDmIoBKzlhYkEhMU26e/rNOkAvIBPy8Q==
X-Received: by 2002:a17:903:4115:b0:14a:efa0:2779 with SMTP id r21-20020a170903411500b0014aefa02779mr2206604pld.12.1642567883449;
        Tue, 18 Jan 2022 20:51:23 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:2227:6627:3120:5131])
        by smtp.gmail.com with ESMTPSA id s21sm19427378pfg.75.2022.01.18.20.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 20:51:22 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH RFC] Bluetooth: btintel: Fix WBS setting for Intel legacy ROM products
Date:   Tue, 18 Jan 2022 20:51:19 -0800
Message-Id: <20220119045119.132191-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Intel Legacy ROM Products don't support WBS except the SdP(8087:0aa7).
But StP2(8087:0a2a) and SdP have the same version information, and
btintel cannot distinguish between StP2 and SdP for WBS support.

This patch sets the WBS support flag for SdP based on USB idProduct and
uses it in btintel to configure the WBS.

This flag is only applicable for Legacy ROM products.

Fixes: 3df4dfbec0f29 ("Bluetooth: btintel: Move hci quirks to setup routine")
Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 10 +++++++---
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   | 12 ++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 1a4f8b227eac..6730c9b2ae33 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2428,10 +2428,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 
 			/* Apply the device specific HCI quirks
 			 *
-			 * WBS for SdP - SdP and Stp have a same hw_varaint but
-			 * different fw_variant
+			 * WBS for SdP - The version information is the same for
+			 * both StP2 and SdP, so it cannot be used to
+			 * distinguish between StP2 and SdP. Instead, it uses
+			 * the flag set by the transport driver(btusb) for
+			 * the Legacy ROM SKU and sets the quirk for WBS.
 			 */
-			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
+			if (btintel_test_flag(hdev,
+					      INTEL_ROM_LEGACY_WBS_SUPPORTED))
 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 					&hdev->quirks);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c9b24e9299e2..efdb3d738abf 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -152,6 +152,7 @@ enum {
 	INTEL_BROKEN_INITIAL_NCMD,
 	INTEL_BROKEN_SHUTDOWN_LED,
 	INTEL_ROM_LEGACY,
+	INTEL_ROM_LEGACY_WBS_SUPPORTED,
 
 	__INTEL_NUM_FLAGS,
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c30d131da784..286e2fa1ef44 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3742,6 +3742,18 @@ static int btusb_probe(struct usb_interface *intf,
 
 		if (id->driver_info & BTUSB_INTEL_BROKEN_SHUTDOWN_LED)
 			btintel_set_flag(hdev, INTEL_BROKEN_SHUTDOWN_LED);
+
+		/* Intel's Legacy ROM products don't support WBS except
+		 * the SdP(8087:0aa7). But the StP2(8087:0a2a) and SdP have the
+		 * same version information, and btintel can't distinguish
+		 * between StP2 and SdP for the WBS support.
+		 * It sets the flag here based on the USB PID to enable the WBS
+		 * support for legacy ROM products.
+		 * Note that this flag is only applicable to legacy ROM
+		 * products.
+		 */
+		if (id->idProduct == 0x0aa7)
+			btintel_set_flag(hdev, INTEL_ROM_LEGACY_WBS_SUPPORTED);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.25.1

