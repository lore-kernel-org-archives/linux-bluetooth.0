Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C107AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Dec 2021 07:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhLNHcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Dec 2021 02:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhLNHcS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Dec 2021 02:32:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABB9C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 23:32:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k4so12957292plx.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 23:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XmjpY6V5hM1Up10m3kosJr+9rKV8sIPoQGhCb8sywo=;
        b=cHv/r4pT6LMifxcyz/j7mqUVMoeCahShACrhYzA7R+TWPL8mmRAXmk2O2T0tX3g74A
         LWW5oHCExZ+Unn+Irw+h5I2JVWee8ULQHD3m1ucXRmvW+UeKdHeCcZwtxlBT1G0/pYx2
         57xLdbIZ4oXTIlXVc0KubFBwW9+PGXBeJZCnuH+OtuKKhWYNkuHAcKw1GXQ6XFaqHuAX
         hNBodTbss7pI45cNv5D7DUUPquUuK+elZFheXGDsNWAl9N1x81h29RqjHmMZWTNiBqAH
         spOcXIwktlDYShK0Hz89yWO4SA3z5mGoqEbZYpIcP4IzQyfgyXH6MEoWFiXpI1W2YbWg
         lMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XmjpY6V5hM1Up10m3kosJr+9rKV8sIPoQGhCb8sywo=;
        b=2c9+fYrMG3q8G2kvvQw5hCSlunaTQOFOgF81LaU1Lmr2xU7W4u0Q7gZQ8pZr2D4gFM
         aQtsZbExZFLw1e3Jk+hhF2r+zy3ZvS+n/zhscNwAtFIO9JuD5jmSumHR6fLs4jpXFxEC
         YDW9Fum30+EPOWcV2OHE4LStXZhqF74MUGnHUUfvFJ2n3kZR1QhRJ6PgJ7cndbu7s2Pq
         RdI6bHXvVf1U3MNjOPdF+N4IMRLc5rKfWQJt93YfPUt86dwhlUhZhO+WYYwgnEGCf6MW
         GQImYOh3qCStKp31j6XZh4O9++mFlqYvyhvZ/CERUAGsKBA5VQvmb4wz4BHnwCrv/GS5
         pv8w==
X-Gm-Message-State: AOAM532dQDM7jYkHCkhTeHrI8GAjM0HS4W4Ud0H69ZriPynspzLcMRbB
        AkjjYG64sMWj3cbGPa6NXe4uTsbEtGU=
X-Google-Smtp-Source: ABdhPJw6/s+ykIQAhWIEQcYnWCgzCfm1VaKX9NLOiAcJOS+O6GYH4ekNDvgU4R7GxNaGNzkgqs4WeA==
X-Received: by 2002:a17:902:9a4a:b0:146:8ce2:672 with SMTP id x10-20020a1709029a4a00b001468ce20672mr4003580plv.29.1639467137604;
        Mon, 13 Dec 2021 23:32:17 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:970e:d2de:7ba2:8e18])
        by smtp.gmail.com with ESMTPSA id v25sm14539706pfg.175.2021.12.13.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 23:32:17 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH] Bluetooth: btintel: Add missing quirks and msft ext for legacy bootloader
Date:   Mon, 13 Dec 2021 23:32:14 -0800
Message-Id: <20211214073214.320397-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch add missing HCI quirks and MSFT extension for legacy
bootloader when it is running in the operational firmware.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8f9109b40961..e1f96df847b8 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2498,10 +2498,14 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x12:      /* ThP */
 	case 0x13:      /* HrP */
 	case 0x14:      /* CcP */
-		/* Some legacy bootloader devices from JfP supports both old
-		 * and TLV based HCI_Intel_Read_Version command. But we don't
-		 * want to use the TLV based setup routines for those legacy
-		 * bootloader device.
+		/* Some legacy bootloader devices starting from JfP,
+		 * the operational firmware supports both old and TLV based
+		 * HCI_Intel_Read_Version command based on the command
+		 * parameter.
+		 *
+		 * For upgrading firmware case, the TLV based version cannot
+		 * be used because the firmware filename for legacy bootloader
+		 * is based on the old format.
 		 *
 		 * Also, it is not easy to convert TLV based version from the
 		 * legacy version format.
@@ -2513,6 +2517,20 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		err = btintel_read_version(hdev, &ver);
 		if (err)
 			return err;
+
+		/* Apply the device specific HCI quirks
+		 *
+		 * All Legacy bootloader devices support WBS
+		 */
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+
+		/* Valid LE States quirk for JfP/ThP familiy */
+		if (ver.hw_variant == 0x11 || ver.hw_variant == 0x12)
+			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+
+		/* Setup MSFT Extension support */
+		btintel_set_msft_opcode(hdev, ver.hw_variant);
+
 		err = btintel_bootloader_setup(hdev, &ver);
 		break;
 	case 0x17:
-- 
2.25.1

