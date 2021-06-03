Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C99C47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE572610A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 20:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFCUNt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 16:13:49 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:42980 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCUNr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 16:13:47 -0400
Received: by mail-pg1-f169.google.com with SMTP id t8so5984766pgb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jun 2021 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zyR2oaW1I6ukUnJq/oDMqQPxK1dvJ0wMFZLdjqrTI2Q=;
        b=g4rb3SzFdi1L6MUVTRTBd8u2YyrAjgU8PPQenP6IH5FAZ8ws/kTlEn6LhJCie6r5HJ
         eiKI4+Qc76Wq8uzCY1zAKIIObfrR12TQQWKSayAw3nK5Uc2Eac4IMJ+ucTqltErLCcfp
         WL7YbhSqmqPUz7Z2i3QADK7nnWPxx4HTlI1qrCjpgto5ZQk6i3F2vJrIiBpsgRjAwB+2
         DgWHhWfQKB+sBTavPinCn5j2S6+FELH71XBVQiIe/nW5fEhBaVFT2ATWnl6QmyeSKYst
         OJALrwnmVqkeOq8pUQ5r004jca8emegtyf7hsc1deHnYOcQbsq3/Ycka8rqc8VhGxSU2
         shRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zyR2oaW1I6ukUnJq/oDMqQPxK1dvJ0wMFZLdjqrTI2Q=;
        b=mxK+7j9LArOYLCr1F0y8Z54cAslu6SJu96eY+2yUHJofbn2ak4d9wC26sjwU7Xo1lW
         BV2u9k1LRHU9YCuhK+ZE1LRTLMdgW71HqXG5T19MTCyLF+FraudiTTq3JQtkiLXORX4V
         /7j1gh0wkMApEj1ViFG5uuK6/ysLYtz7Ztw0NfvZHKSbGesdbzX2LDpGj3ZPCatYkfar
         IDdtyeqoDcVdEOxTMF4US9+Q0ojibBoaavYWiVaZd/L3Q48KIjkx7cmh/9LoR4euTAPu
         ygQ709E4dN9qlKxtsLGiX+wOTKT53dsEM4FVeiswMTkcX4iFvst1I6Z7s3gKYf5q4Y3m
         hNBw==
X-Gm-Message-State: AOAM530ckHIOFXY13XMbGatQrRc14/WNk+HB3aOFpCFTtu4uhdeHG3Uf
        /ved8azATIQvDyokvaLZfwB0JB1Ei+c=
X-Google-Smtp-Source: ABdhPJxZAJrvjFR8eiOan42cHCiZht3RLxLKHp76AE8YEZSX4mYx8Lkog334LrrFozFT+n73hODmMA==
X-Received: by 2002:a65:458b:: with SMTP id o11mr1167749pgq.51.1622751047739;
        Thu, 03 Jun 2021 13:10:47 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i10sm3033910pfk.74.2021.06.03.13.10.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 13:10:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 5.13-rc4] Bluetooth: btusb: Fix failing to init controllers with operation firmware
Date:   Thu,  3 Jun 2021 13:10:45 -0700
Message-Id: <20210603201045.964496-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some firmware when operation don't may have broken versions leading to
error like the following:

[    6.176482] Bluetooth: hci0: Firmware revision 0.0 build 121 week 7 2021
[    6.177906] bluetooth hci0: Direct firmware load for intel/ibt-20-0-0.sfi failed with error -2
[    6.177910] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-20-0-0.sfi (-2)

Since we load the firmware file just to check if its version had changed
comparing to the one already loaded we can just skip since the firmware
is already operation.

Fixes: ac0565462e330 ("Bluetooth: btintel: Check firmware version before
download")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d603ef39bad..b88c63fbf7fb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2527,10 +2527,17 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	}
 
 	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
-	err = request_firmware(&fw, fwname, &hdev->dev);
+	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
+		if (!test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+			/* Firmware has already been loaded */
+			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+			return 0;
+		}
+
 		bt_dev_err(hdev, "Failed to load Intel firmware file %s (%d)",
 			   fwname, err);
+
 		return err;
 	}
 
@@ -2680,12 +2687,24 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
 						sizeof(fwname), "sfi");
 	if (err < 0) {
+		if (!test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+			/* Firmware has already been loaded */
+			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+			return 0;
+		}
+
 		bt_dev_err(hdev, "Unsupported Intel firmware naming");
 		return -EINVAL;
 	}
 
-	err = request_firmware(&fw, fwname, &hdev->dev);
+	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
 	if (err < 0) {
+		if (!test_bit(BTUSB_BOOTLOADER, &data->flags)) {
+			/* Firmware has already been loaded */
+			set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+			return 0;
+		}
+
 		bt_dev_err(hdev, "Failed to load Intel firmware file %s (%d)",
 			   fwname, err);
 		return err;
-- 
2.31.1

