Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F1FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 21:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356960AbiEFWBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444626AbiEFWBb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:01:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17AE3EBA3
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 14:57:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e15so9504327iob.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 14:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCvHkTgUJPXdUl27Xc90pd5nJnvEbH2ygjEL3W2BokQ=;
        b=mOzTYD0XlP+XyZLNWHdDbBr706vcnB7VS9Wnc8cbSK6SaGlyi1IOMxuVeSkJQoMKE/
         PbotlYO2Z4AnaCFF1mBo3Uyzl5uKBDnDfxd9s4OP+L4ZTBcJmh8tAUNS95P8Gv6vQVjx
         0fzHQ0XQN11p3ZqJ3jGFnRRB+UvA7PzENJZHUcXyPuUS38pnRAgCNfwpyHP7AHTN1Ahv
         fiqKGm/+UfMNLmN0Mu9tZJ9Ijkuq+pc5zS4xbETLNjJAYRScgMYmyWpIDPjEUS5QMjcH
         MA7kh57Tmb9vAuJM3MvJT2es4+HkrHoJd3+HcmefG+Ok89HawHVN+Lvy7YYybKNyaME1
         jwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KCvHkTgUJPXdUl27Xc90pd5nJnvEbH2ygjEL3W2BokQ=;
        b=u8q4LjifqkmmtspZbS9xOFVWlLuA0Oc98a4HQNdGoog+5n6j7+SkL1muHWMHPV787M
         fNjtNEWIn8fgrq7P1EBpXlCawgx7t69djGK2ka/zt+FWqwFpQy7WpnGdREH1RNwXfofm
         fJigdgUUIpwsW/ERlPh+RuXg5e4QYn67aIwsMpYCY3x9PLYJ3/Pa8iMTLMtLSAc86seg
         6AhXOTo16WFF3uAYquVPILBASdXJsc7eUjc+1Q5DRPo2tumoQXt+deQ5Rzzkn76WuG/O
         VntQr8CjmX8fdXfgUsPDhoY6NM+rgE5bb3zR9Ru9JUSR2aDLsYwpi4ESJffykpqorirI
         w9hA==
X-Gm-Message-State: AOAM531BKaL9sa6TAV7o+iVhxnrG7rWcwU0/iT0csMVCOjMgm39YAi0R
        CarokeGtmPSJZ7VnL9ST3VKCuPy6ye4=
X-Google-Smtp-Source: ABdhPJyBEndyl14H+/GQJR5nnar3IiaS2qlS8wBudDGLeJJ6tpGwz09Qkg6iJIp3Ng22rTUSZvchTA==
X-Received: by 2002:a02:8605:0:b0:32b:1dd7:fc31 with SMTP id e5-20020a028605000000b0032b1dd7fc31mr2256425jai.174.1651874265733;
        Fri, 06 May 2022 14:57:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s14-20020a5e980e000000b0065aab053448sm1572281ioj.21.2022.05.06.14.57.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 14:57:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/8] Bluetooth: eir: Add helpers for managing service data
Date:   Fri,  6 May 2022 14:57:36 -0700
Message-Id: <20220506215743.3870212-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds helpers for accessing and appending service data (0x16) ad
type.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fixes CI/kernel test robot findings

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/eir.c         | 31 +++++++++++++++++++++++++++++++
 net/bluetooth/eir.h         |  4 ++++
 3 files changed, 36 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 62a9bb022aed..fe7935be7dc4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -625,6 +625,7 @@ enum {
 #define EIR_SSP_RAND_R192	0x0F /* Simple Pairing Randomizer R-192 */
 #define EIR_DEVICE_ID		0x10 /* device ID */
 #define EIR_APPEARANCE		0x19 /* Device appearance */
+#define EIR_SERVICE_DATA	0x16 /* Service Data */
 #define EIR_LE_BDADDR		0x1B /* LE Bluetooth device address */
 #define EIR_LE_ROLE		0x1C /* LE role */
 #define EIR_SSP_HASH_C256	0x1D /* Simple Pairing Hash C-256 */
diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 7e930f77ecab..7d77fb00c2bf 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -55,6 +55,19 @@ u8 eir_append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 	return eir_append_le16(ptr, ad_len, EIR_APPEARANCE, hdev->appearance);
 }
 
+u8 eir_append_service_data(u8 *eir, u16 eir_len, u16 uuid, u8 *data,
+			   u8 data_len)
+{
+	eir[eir_len++] = sizeof(u8) + sizeof(uuid) + data_len;
+	eir[eir_len++] = EIR_SERVICE_DATA;
+	put_unaligned_le16(uuid, &eir[eir_len]);
+	eir_len += sizeof(uuid);
+	memcpy(&eir[eir_len], data, data_len);
+	eir_len += data_len;
+
+	return eir_len;
+}
+
 static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 {
 	u8 *ptr = data, *uuids_start = NULL;
@@ -333,3 +346,21 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 	return scan_rsp_len;
 }
+
+void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
+{
+	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, len))) {
+		u16 value = get_unaligned_le16(eir);
+
+		if (uuid == value) {
+			if (len)
+				*len -= 2;
+			return &eir[2];
+		}
+
+		eir += *len;
+		eir_len -= *len;
+	}
+
+	return NULL;
+}
diff --git a/net/bluetooth/eir.h b/net/bluetooth/eir.h
index 43f1945bffc5..62f2374078f2 100644
--- a/net/bluetooth/eir.h
+++ b/net/bluetooth/eir.h
@@ -14,6 +14,8 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr);
 
 u8 eir_append_local_name(struct hci_dev *hdev, u8 *eir, u8 ad_len);
 u8 eir_append_appearance(struct hci_dev *hdev, u8 *ptr, u8 ad_len);
+u8 eir_append_service_data(u8 *eir, u16 eir_len, u16 uuid, u8 *data,
+			   u8 data_len);
 
 static inline u16 eir_precalc_len(u8 data_len)
 {
@@ -92,3 +94,5 @@ static inline void *eir_get_data(u8 *eir, size_t eir_len, u8 type,
 
 	return NULL;
 }
+
+void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len);
-- 
2.35.1

