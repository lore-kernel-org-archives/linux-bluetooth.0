Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4269C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 23:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386584AbiEEXJk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 19:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383013AbiEEXJe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 19:09:34 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625FA5EDCB
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 16:05:53 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b5so3823830ile.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHw6Ja1gV4BwAEbVqGX7HauFqMEnbEUQr0i4Ezt55rU=;
        b=odrSEimn642lX30BhyZ/K5SUsnIf8+NckzJa1s6V6awDjknjXYHWLlcy2bX0iWmSsW
         UbumJ3toWjpvs4MiqBNHb+k8Kr6J4TLAYK3nGY1I9aMM9dO1J789IMoqsotyFegTxMQ0
         rAIgGVPLNxhevxdfVcxGifcK9mamVCsCzEnJTkO113XIJaD4AoyQjvAO7z+KLCMP5P9r
         yZHPlwo4plU5+15+ADo9tDCrovS/EldwldxbuqlHGp/QaXXLrEgmk6xE3J2ABGign366
         ZPvFtISh96yQZ3tgl4NtVBHYrSf02x4OGSzZPMca2WsWHH68UK7WiYXcR+bt/RbmVguz
         hYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHw6Ja1gV4BwAEbVqGX7HauFqMEnbEUQr0i4Ezt55rU=;
        b=vnhSLNKX1cqeATnqi9KIXUvvracxrG9iZ+k5eARI+vJBdh/v59y0Au3tf5dhBIwEe0
         mJFJ0hYThqsWRxxEBqUn56W0wkNIGdGvW/pFGmufc2vxY/cHEaIp/KV/4k6O7vrpzmx8
         9+0sqZoW3m9rLok8DsBnslRcpW8lYoCWtaTFTNOQJI/0YfJ0sMiN4BPI51iTB4O2h91v
         Ja6VgigRSeX1H3n4Ak9GFq+/fLAbyUjRGVtTtlmJcCHlciG0E2nAk1z13DPeZPv45QSS
         x4eomDZTq+6vY35KmXDpNrE9iXRLSZbZ+7Q2ssZpvS99PipBNexPsKQO4S0/cM1xngaG
         zH7A==
X-Gm-Message-State: AOAM530CB4ME/2A4lUe+zczP6obrk/r9awzBSAp4vXU4W0unjnG06j+X
        lR4IjBUoMjapwEEcSAGM5t/cmiSF7fA=
X-Google-Smtp-Source: ABdhPJw6Lc7UC27J5JkZW3knK8bWNSaAzmcsT0sWkR7Lh6qxn4WIIUgYSMclLq5rXvtIVpDZdDf13w==
X-Received: by 2002:a05:6e02:2144:b0:2cf:196f:7b1c with SMTP id d4-20020a056e02214400b002cf196f7b1cmr173131ilv.231.1651791952272;
        Thu, 05 May 2022 16:05:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l10-20020a92d8ca000000b002cde6e352bfsm780757ilo.9.2022.05.05.16.05.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:05:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: eir: Add helpers for managing service data
Date:   Thu,  5 May 2022 16:05:43 -0700
Message-Id: <20220505230550.3450617-1-luiz.dentz@gmail.com>
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

