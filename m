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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD163C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A7F64E74
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Feb 2021 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhBJTTM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhBJTSy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 14:18:54 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3D1C061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:14 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n10so1857643pgl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Feb 2021 11:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tkqnacfo+narT8vPBOUM8ULxxKuIrYpcbRBr4hgtWng=;
        b=p4bypGooAc0XX888ZKsoMv9PVuGAFen89Qwt71JNmxVB0VFjabN9rfEaoliN+rbJOL
         iqdEBdbsqxyck0fWE6l3Qv0nufihX7rP4l23v1qBwQ/UNhA91vVKwx4ayFwIi/Qm84MS
         stcJiWTG1TvFm1XlsjkkCHUfS/dPY7cEgRlist7OnfR5jTv2/vGsD8gbVjdTbxGd+Pon
         XtUL72mfwseVPZC9T3mqisEYwueX7ibzfPtIUkutM6xw1At7FO7qKsjjUyO8RUXuuE8X
         kYMF2LnF0IanVAirgBUM0VQm4XFfHMa2Po2KN3SkwnxjYGdWcApUiv1y9MN4hD2fEtHr
         /OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkqnacfo+narT8vPBOUM8ULxxKuIrYpcbRBr4hgtWng=;
        b=I2rnSqkNKMeGnjvlgsRelNVbAUCpK4nOSGoiFr5psqVWBos3yC9io5V3HdTLL5onSR
         aW9b5mOQLqfEhyCVfOD1UuJRzAjeYeXrkbEe3IJOYOdpSqz9hDxB4/eCmnlXF7Qds2+l
         QN8BbJ9v4kG0T32ZAC9Rrl1YnmjQT6DY25feZKDDYHMZA2nrHgiqzBtvC9dxLJzwSw0K
         eNIcBjO/hFzh3audFBZKgb3TTYpKT9jak+zt84Tjeed7KwP/MJLsiY3sNPRn7olaW51t
         qne+6epcEYjDETKNXWeMtQJB2SSTyRgndtaGV5cE28J6pvcZSDE72QGZNJpeRVacF60T
         uFFA==
X-Gm-Message-State: AOAM530QP54sGF+xMX/Wu/Eh5mCsU+xwP0Tpsq/AG7zKDcGXa/a6DHA7
        2sGX0nx6AXuHga0Y25/l0yhfivRtuh+Cbg==
X-Google-Smtp-Source: ABdhPJwe2npcTYtrIcqvpk82DTGIXHZIlB4HaCGjTdSzTH7VR4kY6DrQs1ZH0x5Kb8MKrPLnp1zDmw==
X-Received: by 2002:a62:860c:0:b029:1d8:51f5:91bb with SMTP id x12-20020a62860c0000b02901d851f591bbmr4397031pfd.62.1612984693699;
        Wed, 10 Feb 2021 11:18:13 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 125sm2988822pfu.7.2021.02.10.11.18.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:18:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/6] Bluetooth: btintel: Consolidate intel_version parsing
Date:   Wed, 10 Feb 2021 11:18:07 -0800
Message-Id: <20210210191809.2181630-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210210191809.2181630-1-luiz.dentz@gmail.com>
References: <20210210191809.2181630-1-luiz.dentz@gmail.com>
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

