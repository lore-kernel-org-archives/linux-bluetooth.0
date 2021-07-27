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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4905C4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8B460FA0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 23:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhG0Xvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhG0Xvu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 19:51:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78376C061765
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so7275274pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIj4LSRHJj+nUrzMRomDFsfCDLySvb1T1lr9q3VJMXU=;
        b=ufq+Fc2MJSxLSZqurAk1DgmuBK2Pl/NDtAV737S4JACfaLOpxSLeLayH9EEf05GVUd
         autsgH0BTKjlbNylwRByrJuEj0I/krnf5scVFAeKjcTqfQFjjhofO1VCfmSD4BCd+Xcr
         kKa4OumXEU3wky3C+Qe21cT40lVqUPWMSyyheLHtGu7oZTaQmahLVv+rhu9ZjpFmTnPR
         XIH3bobWRtGufbvUWuJKB35d34OqSh1EwPoNf81/4gEVuPaAed7Pw5JTaOzmAzSa3D1/
         TvUHUcsxWi5yRLV+zCiLIChfj19U1Vv66JaMHBnfnX1PikAXzrmlr5NosOXjlJNBOUOW
         Jo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIj4LSRHJj+nUrzMRomDFsfCDLySvb1T1lr9q3VJMXU=;
        b=WOKduloKIcY/E2xTSQsb9yjPKd6JeGQMqIGnpHWCKDm+mpZ63ALGbuWssHml/8kqhs
         d+p5xP0DoxEAGq4if2q5Bu2YXgZjS50d1LQQBnBM0HoCYLO2gBKIV055IMHDKNZGKLUY
         oorcR7OGKGABwccOViKpj0T/GZneDicQzHRS9l1GEqWsG+xxJSN2KxqDQGo6VuM8bcHL
         AoRucadGiEhO941w/YVjJ/R1tc6yn/qYgpXZGbmUu2n1MR6VMRjPlqznrMDvSpRG2UxR
         NUdENqmwjg90VEiVJIh025JIDLl+DnzgkkVAs2+3A10vIKtEJyX9KkqroyhXaFaubfxR
         cSMg==
X-Gm-Message-State: AOAM533L7IECSw/4S/Of0cYfTaqzNMzNWOFsIX0IxrsKJUFunLwWWVHF
        42+39Nzimav9sVehn81TxI5AZe+yLao=
X-Google-Smtp-Source: ABdhPJwWhlE10TqEvRz26Do1lIgplbFmGuOjmR5Wp8x+tAjbOQVCke3BYVkBR3KBZqxv1mOLxYJj/g==
X-Received: by 2002:a05:6a00:2494:b029:340:298b:acf7 with SMTP id c20-20020a056a002494b0290340298bacf7mr25454029pfv.18.1627429907817;
        Tue, 27 Jul 2021 16:51:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830::7cb2])
        by smtp.gmail.com with ESMTPSA id y9sm1545332pfq.199.2021.07.27.16.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:51:47 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [RFC PATCH v4 10/11] Bluetooth: btintel: Clean the exported function to static
Date:   Tue, 27 Jul 2021 16:51:26 -0700
Message-Id: <20210727235127.173149-11-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
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
2.26.3

