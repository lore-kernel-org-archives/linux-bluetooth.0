Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C06C433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 17:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D967B64E02
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 17:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhBJRAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhBJRAC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 12:00:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185FC061786
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 08:59:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z9so1480661pjl.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 08:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L/6TTARE4LQ7F0qmUhOJSqmb/WUIXb2oUiJbDYB8wjs=;
        b=f8f0bZQBRjgDU4XzoO6aRuLHA5r+eXgx6jfzNXRwpArXushMvvuwwa9W7MGsF99Qnp
         NW7xCU5ixrwEH081DyfZRnjyGKFtOnSqfm++9JXCWQhkmDqxO2Hzs6Y7CpZmV/de6V6T
         IKdCh8XB/3LB76kyXNKcBo/C4zHBuA6cb5pEZIO9coNL3mBemMKXC+/12HndWoLdVJ8v
         UId03GQduxu8EdHBl/cGzcmhasvnRN5eSkyfO5KgvwRMp35QKF7JcMxXfdhklQCuyS0D
         atevawtO1TtReu5oUB78Dg8J7J0L9xYmV+BE1Emg3buBBgJCOK8y8GII4PDPyw/Txhso
         QYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/6TTARE4LQ7F0qmUhOJSqmb/WUIXb2oUiJbDYB8wjs=;
        b=S7Svdp2gFn6Im52W/xjLPhA6lkma9BsMXBKl/awdeUGFzTZDpUW91qIX7fAPQC8Xi2
         zW5p1ICVQVmiQDjivEMBVvC9zNxYh219Nf55NCr+ASr4/4hFz+tIk5umSATjpAWKOG7b
         BDtH9iqw+k4xwf+70F+hI6uYeZrIEXNBIRehbnO1E5/omKdmTR2yPS64eVDPfzGc699S
         zTT9t3PGxRJ9gmVXWoBG5UDrwpCPPTvixXY7eEsh2Za3zAbRzhTKp0AFDBzEMVey5T2c
         YZ6L7weX20iRoIEF8seAcQzjK7zFh21K4EwyVVNuK1Q8Wlbbx8mNLT9bK3iftJEsmatL
         i/ug==
X-Gm-Message-State: AOAM531NKzsTRRC3333cGVSSaduNUsNCqfOaij5ng7MFhLS6phRN+D3v
        nO+xhKUy607j7wX1NbGPqqK1hWbY4fl/Tw==
X-Google-Smtp-Source: ABdhPJyJHgNtNJnFpHWJ2AxSk1pGfL8EM95g+8KYOe9AY2hUAqTgUGWGej+TVFiKH2q5dCWdUDELAw==
X-Received: by 2002:a17:90a:5d87:: with SMTP id t7mr4057533pji.175.1612976361467;
        Wed, 10 Feb 2021 08:59:21 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id cu5sm2881492pjb.27.2021.02.10.08.59.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:59:21 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/6] Bluetooth: btintel: Consolidate intel_version parsing
Date:   Wed, 10 Feb 2021 08:59:14 -0800
Message-Id: <20210210165916.2148856-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210165916.2148856-1-luiz.dentz@gmail.com>
References: <20210210165916.2148856-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves checks version checks of intel_version to
btintel_version_info.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  2 +-
 drivers/bluetooth/btusb.c   | 12 ++++--------
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 82fba6b9328f..490a7d9d42eb 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -216,10 +216,39 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 {
 	const char *variant;
 
+	/* The hardware platform number has a fixed value of 0x37 and
+	 * for now only accept this single value.
+	 */
+	if (ver->hw_platform != 0x37) {
+		bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
+			   ver->hw_platform);
+		return -EINVAL;
+	}
+
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
+	 *
+	 * This check has been put in place to ensure correct forward
+	 * compatibility options when newer hardware variants come along.
+	 */
+	switch (ver->hw_variant) {
+	case 0x0b:      /* SfP */
+	case 0x0c:      /* WsP */
+	case 0x11:      /* JfP */
+	case 0x12:      /* ThP */
+	case 0x13:      /* HrP */
+	case 0x14:      /* CcP */
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
+			   ver->hw_variant);
+		return -EINVAL;
+	}
+
 	switch (ver->fw_variant) {
 	case 0x06:
 		variant = "Bootloader";
@@ -228,13 +257,16 @@ void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		variant = "Firmware";
 		break;
 	default:
-		return;
+		bt_dev_err(hdev, "Unsupported firmware variant(%02x)", ver->fw_variant);
+		return -EINVAL;
 	}
 
 	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
 		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
 		    ver->fw_build_num, ver->fw_build_ww,
 		    2000 + ver->fw_build_yy);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_version_info);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 94a63e898826..7163170410a8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -148,7 +148,7 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable);
 int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
-void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
+int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
 int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 634406058ccf..df0b1f8c7ed7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2474,12 +2474,6 @@ static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
 					     char *fw_name, size_t len,
 					     const char *suffix)
 {
-	/* The hardware platform number has a fixed value of 0x37 and
-	 * for now only accept this single value.
-	 */
-	if (ver->hw_platform != 0x37)
-		return -EINVAL;
-
 	switch (ver->hw_variant) {
 	case 0x0b:	/* SfP */
 	case 0x0c:	/* WsP */
@@ -2658,8 +2652,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (!ver || !params)
 		return -EINVAL;
 
-	btintel_version_info(hdev, ver);
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -2847,6 +2839,10 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return err;
 	}
 
+	err = btintel_version_info(hdev, &ver);
+	if (err)
+		return err;
+
 	err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
 	if (err)
 		return err;
-- 
2.26.2

