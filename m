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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38815C433E5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09692619C8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhCWS7R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 14:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhCWS7J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 14:59:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BECC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y200so15268594pfb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=61ee+0CsnnmhnN9bNvQh7INhbAp79hNtI7De/C4MKXY=;
        b=nmw4fT8xFRuWigT8lAn9u0rJxU0tLZU4Km7iUFzqH1h4wrOEOarm57T6D/y3tGycdV
         7AstE3/cZDPAKJMWuUT5YD/kdfS8Vn2rPrVJZCeXzQfbueyfrQ0DUL7Clxcb1a7aLWCk
         /aNbDQF1lU7sAiXuF7CMb9HPMOYTJ5Pzier4pTvQeVvT6dQYSoQZqHzJsQj128ynz9m3
         DjwK8CfE1CLN/jEiEtogHeMBbTGi8+n03+WJr+UI/xH2FkwvA+DU//85eHjL15cGId6V
         IHJ7Pxm8EtbeZJGmxiC/S/5P4MA23QeUhsktJviDiRmz+kogQfNIoRk0zSt3+ezGDgnE
         X9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61ee+0CsnnmhnN9bNvQh7INhbAp79hNtI7De/C4MKXY=;
        b=E1diDe1Rtey7a4/OrNXMtXmiQAHZhghTT7Hdn4dKIUjKnJ+l/ZRkkKqxQvkwbVVPhp
         TuzwHGgGqvlWvTfkHijFBdc851H9gAIO5uIdze3eh6+mUgNl8p1pW9+jO5ncRnuPbpvW
         t+wnMuapVYvOAyiWIB7QjO0wotCXdxKRQE/C03ETc9nQExjN6Ivurnix5j8BNs7EtgjN
         mDSfPmmNPrSpu6l2a/+RZA0FMa3eELWz+pPw++D4s9PbO5VXodHiLPDUAqK1kwhrZUPj
         J/7DfED/c6CSnlFwT6CjFfjD3DDZZ3KB3GGAJHaYL/tePIPLdn0WTT8DY4Ox1o2xryXg
         qs2Q==
X-Gm-Message-State: AOAM5333mRIaI0i0K2Dyy/hp2/0p1TwOQ9ZUZ+FOSxG9JZUaEEYK14Xl
        ItCepffslMEYH4xKswNj9i0y1UrKkw7CLw==
X-Google-Smtp-Source: ABdhPJyLUEBeODqTjFC53Oc+crNBkTgeTVenagucP4eGjMcprJJyJm91+2HKtUIu6CUXnyEn+euR7g==
X-Received: by 2002:a63:5924:: with SMTP id n36mr5436920pgb.183.1616525948477;
        Tue, 23 Mar 2021 11:59:08 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b10sm16132325pgm.76.2021.03.23.11.59.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:59:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 4/9] Bluetooth: btintel: Consolidate intel_version parsing
Date:   Tue, 23 Mar 2021 11:58:59 -0700
Message-Id: <20210323185904.3372987-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323185904.3372987-1-luiz.dentz@gmail.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves version checks of intel_version() to btintel_version_info().

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c | 36 ++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  7 ++++---
 drivers/bluetooth/btusb.c   | 12 ++++--------
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bb2546c4374a..bddaa4f32566 100644
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
index 56f30eaa1e3c..d184064a5e7c 100644
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
@@ -211,9 +211,10 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 
-static inline void btintel_version_info(struct hci_dev *hdev,
-					struct intel_version *ver)
+static inline int btintel_version_info(struct hci_dev *hdev,
+				       struct intel_version *ver)
 {
+	return -EOPNOTSUPP;
 }
 
 static inline int btintel_version_info_tlv(struct hci_dev *hdev,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f163f174185b..2d3498b74296 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2407,12 +2407,6 @@ static int btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
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
@@ -2582,8 +2576,6 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	if (!ver || !params)
 		return -EINVAL;
 
-	btintel_version_info(hdev, ver);
-
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
 	 * the bootloader and the value 0x23 identifies the operational
@@ -2776,6 +2768,10 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
2.30.2

