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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AB7C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2FB64E31
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 23:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhBJXqp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBJXqn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 18:46:43 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C213C06178A
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:54 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 18so2395856pfz.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 15:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=32q3VSV4R5tSaHOiOidac0vtxnFRQrCA5qbcm0JQE4g=;
        b=tee/x7HeWrnbKB3pgva0k2ipOw+eYc2NLzznA1Cc7+vPbpa4unW3SzfFGhPu5NtSpn
         kt0e+9LR2yMQNwga888wnbgxM08us43q4gwiGn+O5N/JFrzABKZK1FGfXQbrgAupkZf7
         l9xkbFdB6W2mPfDEmfpT7XOQyMaH8uNuA60CGx4lwJZLlDyhwb4lFK3I9caku/rldZ3P
         K4Pq0PIxjLGQg8XIytljiG0ClZ5nXyxpTEO7NE/00C1zYDN5N4mEMVuzqLsqCWu0AN7u
         8D3PCT9J5WYGYWXEH4SWBRSqrNe/Ex2cPB44cRjcaOLpLoIfZyj/o5jyfPnR2YftZ5tr
         Y/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32q3VSV4R5tSaHOiOidac0vtxnFRQrCA5qbcm0JQE4g=;
        b=VydrZKWfA+MOUg4Ur20AOls4cSmNauTvNxCC2tbK6tOr4jMBgP+7EzjkC33GxfdJMN
         zK84JvP6Ccp5PNtkRQ7AHfOk+sNDoWADyXGnyQ2vblW+a75TKd14H4cXrgn/i5V9DwDx
         nbI11gPzCDkdCDnPPBn2DdLE1etU2P8caW2iYHntZLWlhOMNFTmJFsitLeruJyebTnlh
         fpqgCCCaaq1Pd4UZqBTzzkm6E33x9Ad15ZA/f30ga5BZZFlsomFdMu20C9qdFxG+Jbat
         1BMliCP0DrW5hYN8RNaqYePkKfGlPfnbZmowo8mpZbrPH2GlA0SXfL7icZBgzB4OyWK0
         iIwQ==
X-Gm-Message-State: AOAM532YTQqmHhWAeROGCqOSQ+jdl0AGKS0AL/yDa6fss9TXr4GV96SJ
        JtcF+0N33muTPgpTsW3WRbwsQZoFjwTwSA==
X-Google-Smtp-Source: ABdhPJyRBI5xm5ByTFowNav9k6SPq6v89ZCr5pU22yz6dpp4GQLqQJ2eSPIhlG88BCTTgKQjydnhbg==
X-Received: by 2002:a63:a10a:: with SMTP id b10mr5199081pgf.121.1613000753348;
        Wed, 10 Feb 2021 15:45:53 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w124sm3377569pfw.176.2021.02.10.15.45.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:45:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 4/6] Bluetooth: btintel: Consolidate intel_version parsing
Date:   Wed, 10 Feb 2021 15:45:47 -0800
Message-Id: <20210210234549.2293917-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210234549.2293917-1-luiz.dentz@gmail.com>
References: <20210210234549.2293917-1-luiz.dentz@gmail.com>
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
index c907a4d6b37c..452233a06aaa 100644
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
index 23d2af4b0433..1f2b74eaaccf 100644
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
@@ -2648,8 +2642,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (!ver || !params)
 		return -EINVAL;
 
-	btintel_version_info(hdev, ver);
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -2841,6 +2833,10 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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

