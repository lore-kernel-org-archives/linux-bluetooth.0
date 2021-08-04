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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F81C43216
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A576112E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 04:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhHDElI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 00:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhHDElF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 00:41:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C5C0617B9
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 21:40:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u2so1641527plg.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 21:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rbWJMG2CAQmAt5K8u+PLibYdnplF02EC25W3/v3q/A=;
        b=Eo/P+54TmF/cOsfZBJli9g+2G0WrwFlpF3JfU9jH3DK90Wkd6FZpRzNlZFfLbMUcK8
         57YMW0W4haFRY+BcJSjGtTam9A31HNsEvK9E46pOgm20GjSZRRAcUXdNDISzMU+8949t
         rlC3L5ZmjbBNIzBlKS2T87Kn3nCT8KBBY3+agg0iUabEva06GSg/m9KL+baxosclFQNT
         QmqWm8MX+AAvwM54GpnZh45YAbfLOuQzly5D8RpVlJL6O+es0mA978NfUktsJUBwzQKm
         c30PLBWDpXuvBJ38U4LoRarwJUQjy41XpLYlec4ucyYSM/s1Tzb9Co8Y6PdUddkaTnOA
         /hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rbWJMG2CAQmAt5K8u+PLibYdnplF02EC25W3/v3q/A=;
        b=M/gfLNIF697vXKz/5EJW6qM1oDWPoV+2qL4Jm+6L2QWHdK5DpKQvMoBCMZJQbcXzhg
         BytuvmAEFNpHAfEpm11o25wFQniM15LeKZLqTH/pPKn9KPuvKoJai7K8JdS7KKe+Qx8U
         xI7vnCDFjb+GdKsXgAFIC/AnzO/17AW0k7rCwZ4Va2I8eN05KYMDv+/CQc7QT2Zt15aD
         8gPeZmPkgNEux6wQRwT4LDmMBibF3QjzU6jsCtjhPV/LL3LRWefUZtEZOFsoJY73j6br
         r6H083Nt9E8q5G3PZbpeTUoFW9PlPYjJYFqsJ8Y44DB9ye7HBCT1HiPrYbjpSWFP6tGA
         HooA==
X-Gm-Message-State: AOAM532lwWoabeMlgKuYafW5m9VrxtswvXjGwi2v28FR/Zj2bvw/7dYz
        RE2gDSALotcPPtOljCEBibWaO+ZruQU=
X-Google-Smtp-Source: ABdhPJx77gONalCs/USOt3V1K+DIKJUkLYqSdY8FOFzGlancQwdA/lq2ggMNJUFzPAX2e6+OZlOxdg==
X-Received: by 2002:a05:6a00:224c:b029:3c4:f13a:79e4 with SMTP id i12-20020a056a00224cb02903c4f13a79e4mr2509028pfu.46.1628052050992;
        Tue, 03 Aug 2021 21:40:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:12af:cd05:f7eb:e8f5])
        by smtp.gmail.com with ESMTPSA id w2sm835478pjq.5.2021.08.03.21.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 21:40:50 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v6 10/12] Bluetooth: btintel: Clean the exported function to static
Date:   Tue,  3 Aug 2021 21:40:30 -0700
Message-Id: <20210804044032.59729-11-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804044032.59729-1-hj.tedd.an@gmail.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
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
 drivers/bluetooth/btintel.c | 68 +++++++++++++++++--------------------
 drivers/bluetooth/btintel.h | 55 ------------------------------
 2 files changed, 31 insertions(+), 92 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 41eabdf6a30f..57cbe8191524 100644
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
@@ -198,7 +218,7 @@ static int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
 	return ret;
 }
 
-void btintel_hw_error(struct hci_dev *hdev, u8 code)
+static void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct sk_buff *skb;
 	u8 type = 0x00;
@@ -230,7 +250,6 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 
 	kfree_skb(skb);
 }
-EXPORT_SYMBOL_GPL(btintel_hw_error);
 
 int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 {
@@ -294,8 +313,8 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_version_info);
 
-int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
-			const void *param)
+static int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
+			       const void *param)
 {
 	while (plen > 0) {
 		struct sk_buff *skb;
@@ -317,7 +336,6 @@ int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_secure_send);
 
 int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 {
@@ -364,27 +382,6 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
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
@@ -428,7 +425,8 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 }
 EXPORT_SYMBOL_GPL(btintel_read_version);
 
-int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+static int btintel_version_info_tlv(struct hci_dev *hdev,
+				    struct intel_version_tlv *version)
 {
 	const char *variant;
 
@@ -505,7 +503,6 @@ int btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
 
 static int btintel_parse_version_tlv(struct hci_dev *hdev,
 				     struct intel_version_tlv *version,
@@ -608,7 +605,8 @@ static int btintel_parse_version_tlv(struct hci_dev *hdev,
 	return 0;
 }
 
-int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
+static int btintel_read_version_tlv(struct hci_dev *hdev,
+				    struct intel_version_tlv *version)
 {
 	struct sk_buff *skb;
 	const u8 param[1] = { 0xFF };
@@ -635,7 +633,6 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
 	kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
 
 /* ------- REGMAP IBT SUPPORT ------- */
 
@@ -1209,7 +1206,7 @@ static int btintel_download_fw_tlv(struct hci_dev *hdev,
 	return 0;
 }
 
-void btintel_reset_to_bootloader(struct hci_dev *hdev)
+static void btintel_reset_to_bootloader(struct hci_dev *hdev)
 {
 	struct intel_reset params;
 	struct sk_buff *skb;
@@ -1252,10 +1249,9 @@ void btintel_reset_to_bootloader(struct hci_dev *hdev)
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
@@ -1284,9 +1280,8 @@ int btintel_read_debug_features(struct hci_dev *hdev,
 	kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 
-int btintel_set_debug_features(struct hci_dev *hdev,
+static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
 	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
@@ -1311,7 +1306,6 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 	kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 5a8a696eecf2..aa64072bbe68 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -188,18 +188,11 @@ int btintel_enter_mfg(struct hci_dev *hdev);
 int btintel_exit_mfg(struct hci_dev *hdev, bool reset, bool patched);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btintel_set_diag(struct hci_dev *hdev, bool enable);
-void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
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
@@ -207,11 +200,6 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
-void btintel_reset_to_bootloader(struct hci_dev *hdev);
-int btintel_read_debug_features(struct hci_dev *hdev,
-				struct intel_debug_features *features);
-int btintel_set_debug_features(struct hci_dev *hdev,
-			       const struct intel_debug_features *features);
 int btintel_configure_setup(struct hci_dev *hdev);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
@@ -243,39 +231,18 @@ static inline int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	return -EOPNOTSUPP;
 }
 
-static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
-{
-}
-
 static inline int btintel_version_info(struct hci_dev *hdev,
 				       struct intel_version *ver)
 {
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
@@ -287,12 +254,6 @@ static inline int btintel_read_version(struct hci_dev *hdev,
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
@@ -319,22 +280,6 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 	return -EOPNOTSUPP;
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
 static inline int btintel_configure_setup(struct hci_dev *hdev)
 {
 	return -ENODEV;
-- 
2.25.1

