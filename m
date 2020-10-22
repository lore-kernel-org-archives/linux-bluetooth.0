Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F12C4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B4A223BF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwxk6Byi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894837AbgJVITU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443979AbgJVITT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 04:19:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB0C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r10so561255plx.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mPrFcnY4OFxADSgpq9DDcI2iUS/rN/5Cba2JCqz3PLU=;
        b=Vwxk6ByiaSn8Y/nuQ6oX4QZXW/Hld7GHrghKiA1Zp03NKO2hhIxFHR6pjjbTyceeAf
         8qbicWms5atfmDLnmQuQUAE5Tm2a1OmO2qzhExJrqDRZVdv2CNEO5XJSIdzclepucdB4
         GmJkORM55gYGYXEckMbUJjPNv19HqF6fpOP+FJmahPOcFyMnqeLxuU7wa1OsPAshFGVl
         cn4fmUv9vE7hhuJ1zbhim/RgSkx6a+SWQvhysjkxvjwRz3J+s8ESXWzJTfZptMQOkiZc
         QWkDl4u+AiVnPmGItHsNaYgLXgubY16zgtNdb33rLfGdgMDHD8V/9FZQ8IQGpKBOwL5y
         GZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mPrFcnY4OFxADSgpq9DDcI2iUS/rN/5Cba2JCqz3PLU=;
        b=oDrtIhNjwcYzjdQKRlRAnQMSWZ+ltlsumkY+r2YomO+gBPK8PftAtTNQYLk0+KHVep
         YfNnauSyXmaBNu/92xK0gK6IosuHe92knwgVhYGZuilmbqp1b4I5wnIOI3OBawoOzxZd
         gBtbfpQnxpBZ4/rfgpbBZPlc952URVSWhFJm0BPM0Cj9yjdqdvOXvmqxZhwMrXUcdA74
         otOPQvhT331M3HYSCbl64anAPCHBF0F4JyDgr4ykKtzX5gzK5/lmvkRRVlIkG3Ei1qFZ
         AVK9FSgCX5lkIFgELdOSpM1W7p467DRMSgRqoM9m3d+x8yoQyr8vKzu/AN7LYxJF1v5x
         940Q==
X-Gm-Message-State: AOAM532OJe5BY2P5wpTto9y3Twi+gSaaUxAhP3YdPj5iKiIyydIFtTjn
        M3urPLJZYKkWrx8Bmzf15I2r31GYQdyi++Hf
X-Google-Smtp-Source: ABdhPJx4qGRWZSms2pYFv99NB0fzDFSvPlLQHblpSvNbr3ek3NoU59qKmWwGm5OR/ectGTft2cjjDw==
X-Received: by 2002:a17:902:7042:b029:d5:c0e6:8e35 with SMTP id h2-20020a1709027042b02900d5c0e68e35mr1594531plt.9.1603354757281;
        Thu, 22 Oct 2020 01:19:17 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id j5sm1179514pjb.56.2020.10.22.01.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:19:16 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 3/3] Bluetooth: btusb: Use the new btintel read version
Date:   Thu, 22 Oct 2020 13:54:35 +0530
Message-Id: <20201022082435.31831-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022082435.31831-1-sathish.narasimman@intel.com>
References: <20201022082435.31831-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Replace the legacy btintel_read_version to btintel_read_verison_new.
The new intel firmware has the support to parse TLV structure during
operational mode. The patch takes care of both legacy and tlv structure.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 drivers/bluetooth/btintel.h |  1 +
 drivers/bluetooth/btusb.c   | 41 +++++++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 08406ef935a3..e3025b90eda5 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -140,6 +140,7 @@ struct btintel_version {
 	};
 };
 
+#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #if IS_ENABLED(CONFIG_BT_INTEL)
 
 int btintel_check_bdaddr(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e8ff74..c63bc8a0c84f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2554,7 +2554,8 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct intel_version ver;
+	struct btintel_version bt_ver;
+	u8 hw_variant;
 	struct intel_boot_params params;
 	u32 boot_param;
 	char ddcname[64];
@@ -2577,19 +2578,33 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version_new(hdev, &bt_ver);
 	if (err) {
 		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
 		btintel_reset_to_bootloader(hdev);
 		return err;
 	}
 
-	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
+	/* If TLV format is supported then it is in Operational Firmware. TLV
+	 * structure is supported only in operational mode in latest Firmware.
+	 */
+	if (bt_ver.tlv_format && bt_ver.ver_tlv.img_type == 0x03) {
+		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
+		clear_bit(BTUSB_BOOTLOADER, &data->flags);
+		goto finish;
+	}
+
+	err = btusb_intel_download_firmware(hdev, &bt_ver.ver,  &params,
+					    &boot_param);
 	if (err)
 		return err;
 
-	/* controller is already having an operational firmware */
-	if (ver.fw_variant == 0x23)
+	/* In case if old firmware is used, it should be backward compatible
+	 * to check for operational firmware. only on latest firmware the
+	 * support for TLV structure is added. so check for tlv is not
+	 * required here.
+	 */
+	if (bt_ver.ver.fw_variant == 0x23)
 		goto finish;
 
 	rettime = ktime_get();
@@ -2641,7 +2656,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-	err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
+	err = btusb_setup_intel_new_get_fw_name(&bt_ver.ver, &params, ddcname,
 						sizeof(ddcname), "ddc");
 
 	if (!err) {
@@ -2665,17 +2680,25 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	btintel_set_debug_features(hdev, &features);
 
 	/* Read the Intel version information after loading the FW  */
-	err = btintel_read_version(hdev, &ver);
+	err = btintel_read_version_new(hdev, &bt_ver);
 	if (err)
 		return err;
 
-	btintel_version_info(hdev, &ver);
+	if (bt_ver.tlv_format)
+		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
+	else
+		btintel_version_info(hdev, &bt_ver.ver);
 
 finish:
 	/* All Intel controllers that support the Microsoft vendor
 	 * extension are using 0xFC1E for VsMsftOpCode.
 	 */
-	switch (ver.hw_variant) {
+	if (!bt_ver.tlv_format)
+		hw_variant = bt_ver.ver.hw_variant;
+	else
+		hw_variant = INTEL_HW_VARIANT(bt_ver.ver_tlv.cnvi_bt);
+
+	switch (hw_variant) {
 	case 0x12:	/* ThP */
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
-- 
2.17.1

