Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819F8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 23:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5987A613B1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Apr 2021 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhD3XFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 19:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhD3XFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 19:05:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52963C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 16:05:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2540399pjh.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5yBrOEO4mBZR1eneZPct9A5ks6kiNG1RYNHqHO9WfM=;
        b=fGasIHgFFA9ucEjiLpA8vWyqnRIWLXbFGgJZxJDpblYtrcCTXt+xNkXcJSHyib2qeq
         8vKbGyBRDuUEC+cPBnZOeoQEqo1OV4qf8Y8sQRxe2HozAcncxMq87iTWeKI339YiCM1z
         tmzyZTg2NGjMEGdbcr2ZVqCqqqQhBS+nXqxgkco98YOXrCpf4idPZItfq0kVhRa/z9zC
         SREUa/3UOGSIL99jQ15K54d4w72KMPbGNrwvg7io/IOmSTAdad5vTUspOc4TgN2xZjiA
         J6+sMRWBDa1P4Vy3xRYHelhHWvHf5nps3ooMf2LAtzEe4o3C24OjdZ1jlvXwsO9PT7lz
         q/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5yBrOEO4mBZR1eneZPct9A5ks6kiNG1RYNHqHO9WfM=;
        b=Mfu5fKH+ubLuTuuehHtBLgxoiOIDKK+PqhOlchtgcptDgGqr7BWm3Jra5aRitOoeGz
         sGQpjuU2qaQFXlgH7wYmKVuBgVmDv6PkbfNVsQaTVMugUiyTdgGi832DjX7vuHEAbNVb
         fTYIzP1HYGuYyyuFhOlZ3x407zMT1pzoI+UU3P0SihIS6PZbguX2SkFHcLZo7NPGaSx8
         v5ILs3r4DLV6WYsjcnvK2HTzx/Z1zlAg56oeCFcwj3JfqvSMWK5qONz78O/rfDXG4lyv
         AhOhsp2SL8F1cxxRUhL9bB2cUtg6mDRcbz3JDSt2tIRbztFNJ5mj/5bzqdiSAUYgKPpZ
         tkZA==
X-Gm-Message-State: AOAM531kh6QFrcOK56/dnL3XNJxwrha52b8+E4npzAlKn6JHtx8hD8je
        KRtFVIAwR/QATYOm/fO6TB6msmw1LLjlsg==
X-Google-Smtp-Source: ABdhPJyfodqgOz9FfdQIfAsPBPJw2bXDm6XYKZCbTRBQvhtUg41GF2KBCTP5VRmg5r9eR3rgT7PaDA==
X-Received: by 2002:a17:902:7444:b029:ed:5334:40b6 with SMTP id e4-20020a1709027444b02900ed533440b6mr7462123plt.35.1619823902582;
        Fri, 30 Apr 2021 16:05:02 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i123sm3293758pfc.53.2021.04.30.16.05.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 16:05:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix failing to init controllers with operation firmware
Date:   Fri, 30 Apr 2021 16:05:01 -0700
Message-Id: <20210430230501.603111-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some firmware when operation don't may have broken versions leading to
error like the following:

[    6.176482] Bluetooth: hci0: Firmware revision 0.0 build 121 week 7
2021
[    6.177906] bluetooth hci0: Direct firmware load for
intel/ibt-20-0-0.sfi failed with error -2
[    6.177910] Bluetooth: hci0: Failed to load Intel firmware file
intel/ibt-20-0-0.sfi (-2)

Since we load the firmware file just to check if its version had changed
comparing to the one already loaded we can just skip since the firmware
is already operation.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 90e7e9d35805..9b84ada0aac6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2603,8 +2603,15 @@ static int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
 	btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname), "sfi");
 	err = request_firmware(&fw, fwname, &hdev->dev);
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
 
@@ -2754,12 +2761,24 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
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
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
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
2.30.2

