Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37CCC4320E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05D260F22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 18:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhG2SgS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhG2SgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 14:36:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88EC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so10755138pji.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcaTGFKm0iYVqnUA9ZTdPjCCMxpVHq8kqRcp7JDMO5Q=;
        b=SJFUdGxjssoly5QxqUKfDDtHb6RPfq+elZl4ku5pSpZddzg8WPOZf73omM0sTAQ/PW
         8uwjUDhb+04rZnE8bEtpsYXampzq8EMBtzOyHEGKpXosCUBzoaTTeDz/6iJs5EoGO8qV
         05plj2EzuASYdBqEIvice/SuQQ8c7/C2O/dg3yQheOqWg1cp+7Lg5JZ5ZABeH6ta+wus
         kRAf4yDqORNgzFFpV39y7aLAM0GUgRzZ3zKm8B26QNRdteLIb0Pu/yb7Sf09bf5ajtNu
         iMEuG96ru8ecjYhpzWfXHv4uEndX6fAscHevcRqqki8NKRU9UTc018FkM9EdgKt9vT6M
         ehaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcaTGFKm0iYVqnUA9ZTdPjCCMxpVHq8kqRcp7JDMO5Q=;
        b=c1Tyi8XtqAxhNNGXObKbPodhdw7GhSsASdn69p4RoUOmmNaHtQWoB8DT6E4wwDcVaB
         C+VX5iXkUbplHF8qTvBOwth2UNr6HFsYUfxZdWr0t/eQ83har1BSWg20976Nu89luxMZ
         F+HPCfF/lubl62y0ej7x14tAAKZ0QBVAuMc3K4r0kIFgGSpDkQeZVdKtRr4MPFi+JW1v
         rpiWGvVgl9o4oBA3xot9Wp9OA7igrxc0T1iLVzYnj3tJ5fBLN4Uytcl8tao1CkS+Sxkg
         xfC2GGG4uWgQIlrTrlubJVFB+QLPMIsEawCoeOEH+v1LwLtMuQDFBWGhyUQghJZP5hue
         f2bQ==
X-Gm-Message-State: AOAM531jpA9s1XXMEgHvJmOtDjeURZoZreso6C0GOM6GJnq9npAb0Bjl
        apCOIb0bBn8bW1FcO1529IJX6g2tQkQ=
X-Google-Smtp-Source: ABdhPJyssfc5/o5BEwlbyM3V4pYw2bkCxbmBdcRZyj5NF2Nz2YQWq5sGGY0DFzcL5QAqSsmEIzdGDw==
X-Received: by 2002:a17:90b:1683:: with SMTP id kv3mr6801681pjb.72.1627583773352;
        Thu, 29 Jul 2021 11:36:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:6349:1ee2:dda3:7891])
        by smtp.gmail.com with ESMTPSA id i1sm10943130pjs.31.2021.07.29.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:36:12 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v5 10/11] Bluetooth: btintel: Clean the exported function to static
Date:   Thu, 29 Jul 2021 11:35:59 -0700
Message-Id: <20210729183600.281586-11-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729183600.281586-1-hj.tedd.an@gmail.com>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch changes the exported functions to static if they are no
longer used by others.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 65 +++++++++++++++++--------------------
 drivers/bluetooth/btintel.h | 50 ----------------------------
 2 files changed, 30 insertions(+), 85 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dc5e2b255605..57b64d744f0a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -131,6 +131,26 @@ int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btintel_set_bdaddr);
 
+static int btintel_set_event_mask(struct hci_dev *hdev, bool debug)
+{
+	u8 mask[8] = { 0x87, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	struct sk_buff *skb;
+	int err;
+
+	if (debug)
+		mask[1] |= 0x62;
+
+	skb = __hci_cmd_sync(hdev, 0xfc52, 8, mask, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Setting Intel event mask failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 int btintel_set_diag(struct hci_dev *hdev, bool enable)
 {
 	struct sk_buff *skb;
@@ -296,8 +316,8 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_version_info);
 
-int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
-			const void *param)
+static int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
+			       const void *param)
 {
 	while (plen > 0) {
 		struct sk_buff *skb;
@@ -319,7 +339,6 @@ int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_secure_send);
 
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 {
@@ -366,27 +385,6 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 }
 EXPORT_SYMBOL_GPL(btintel_load_ddc_config);
 
-int btintel_set_event_mask(struct hci_dev *hdev, bool debug)
-{
-	u8 mask[8] = { 0x87, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
-	struct sk_buff *skb;
-	int err;
-
-	if (debug)
-		mask[1] |= 0x62;
-
-	skb = __hci_cmd_sync(hdev, 0xfc52, 8, mask, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		bt_dev_err(hdev, "Setting Intel event mask failed (%d)", err);
-		return err;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(btintel_set_event_mask);
-
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 {
 	int err, ret;
@@ -430,7 +428,8 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
-int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+static int btintel_version_info_tlv(struct hci_dev *hdev,
+				    struct intel_version_tlv *version)
 {
 	const char *variant;
 
@@ -507,7 +506,6 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
 static int btintel_parse_version_tlv(struct hci_dev *hdev,
 				     struct intel_version_tlv *version,
@@ -601,7 +599,8 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 	return 0;
 }
 
-int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+static int btintel_read_version_tlv(struct hci_dev *hdev,
+				    struct intel_version_tlv *version)
 {
 	struct sk_buff *skb;
 	const u8 param[1] = { 0xFF };
@@ -628,7 +627,6 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 	kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
 
 /* ------- REGMAP IBT SUPPORT ------- */
 
@@ -1202,7 +1200,7 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 	return 0;
 }
 
-void btintel_reset_to_bootloader(struct hci_dev *hdev)
+static void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
 	struct intel_reset params;
 	struct sk_buff *skb;
@@ -1245,10 +1243,9 @@ void btintel_reset_to_bootloader(struct hci_dev *hdev)
 	 */
 	msleep(150);
 }
-EXPORT_SYMBOL_GPL(btintel_reset_to_bootloader);
 
-int btintel_read_debug_features(struct hci_dev *hdev,
-				struct intel_debug_features *features)
+static int btintel_read_debug_features(struct hci_dev *hdev,
+				       struct intel_debug_features *features)
 {
 	struct sk_buff *skb;
 	u8 page_no = 1;
@@ -1277,9 +1274,8 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 	kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 
-int btintel_set_debug_features(struct hci_dev *hdev,
+static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
 	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
@@ -1304,7 +1300,6 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 	kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 696656fd7e99..71af25cd1672 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -162,15 +162,9 @@ int btintel_set_diag_combined(struct hci_dev *hdev, bool enable);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
 int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
-int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version);
-int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
-			const void *param);
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name);
-int btintel_set_event_mask(struct hci_dev *hdev, bool debug);
 int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);
 int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
-int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver);
-
 struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16 opcode_read,
 				   u16 opcode_write);
 int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param);
@@ -181,11 +175,6 @@ int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 int btintel_setup_combined(struct hci_dev *hdev);
 int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_set_flags(struct hci_dev *hdev, unsigned int flag);
-void btintel_reset_to_bootloader(struct hci_dev *hdev);
-int btintel_read_debug_features(struct hci_dev *hdev,
-				struct intel_debug_features *features);
-int btintel_set_debug_features(struct hci_dev *hdev,
-			       const struct intel_debug_features *features);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
@@ -231,29 +220,12 @@ static inline int btintel_version_info(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_version_info_tlv(struct hci_dev *hdev,
-					   struct intel_version_tlv *version)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type,
-				      u32 plen, const void *param)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int btintel_load_ddc_config(struct hci_dev *hdev,
 					  const char *ddc_name)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_set_event_mask(struct hci_dev *hdev, bool debug)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug)
 {
 	return -EOPNOTSUPP;
@@ -265,12 +237,6 @@ static inline int btintel_read_version(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_read_version_tlv(struct hci_dev *hdev,
-					   struct intel_version_tlv *ver)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
 						 u16 opcode_read,
 						 u16 opcode_write)
@@ -311,22 +277,6 @@ static inline void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
 {
 }
 
-static inline void btintel_reset_to_bootloader(struct hci_dev *hdev)
-{
-}
-
-static inline int btintel_read_debug_features(struct hci_dev *hdev,
-					      struct intel_debug_features *features)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int btintel_set_debug_features(struct hci_dev *hdev,
-					     const struct intel_debug_features *features)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void btintel_bootup(struct hci_dev *hdev,
 				  const void *ptr, unsigned int len)
 {
-- 
2.25.1

