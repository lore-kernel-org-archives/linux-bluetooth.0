Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF7BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 00:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiEEAKd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 20:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiEEAKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 20:10:21 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A444193F2
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 17:06:33 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f2so3192939ioh.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PHw6Ja1gV4BwAEbVqGX7HauFqMEnbEUQr0i4Ezt55rU=;
        b=nVT0gpZA/t6SqKVmn6Ee5tzIFIlQwzk/txcq9AXwfb6/r6Bwz0uGDeJq0HG2gnDsU2
         Jrty+KgdkVuY3yvAxqgTOFaQQ3eUeNXUMEIMrVHnnrzfMLxp9TI6ky/LYT0z9pbhmvOZ
         dLSDRyBtOGf9o9GTiUM/zCTZUodl/K5LrgY4YX94Wn76fxM9HyxLnNfRUTQqxPON/ut8
         GkrgLvLuYudwnB6eYzwDO6+sj8ZbqkJjk+VL+nA34dw4iLGR8P6MfQ40M/KMklHi5BFm
         syYy5uYRAPz928wVLABS/rI66MoKzC1lS0u9m2fgK+6OIQI8B+jLUOW2h7YI/ZTj+FG/
         Zx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHw6Ja1gV4BwAEbVqGX7HauFqMEnbEUQr0i4Ezt55rU=;
        b=GupTdWRaJ8SOXMGZKwnz0yd490vzz1npeW7jhEhqSJHHeCKqPsQh8pGJIho1sk1wS7
         M5mbkIySmKbOTzZjQjBYhks0YhhEVs3YQuEpffE6cJio78zC9cWo9+58Z1dZxh03ymt0
         +9sYHMKsff0ywF8Iofkblpy8js4L0/iGtQcCLCDVtBEFnUo4Z4yEl+q6oHK3iqKKmyUd
         rviv6jyN008xUfsO3y5CfHvurhRszw+SMmJT5fh17IwMFlPhsON7blyM/4aCKKurPZr0
         eINA1iUa37i83VXRb8w5oKetKhwVJejnjW3esboirVrJsVRuaaL6RHZJPFtIm5mai1uI
         jqug==
X-Gm-Message-State: AOAM531PS5aRXUSBPx4K8MjQ06WRknGeFmGqXtzxAQHnX3AHIr3S5UUt
        bBvaAO+O1wwtze6mDgMu6zdafo9cDws=
X-Google-Smtp-Source: ABdhPJxYu6O/zAsdmRiG+xlyWem5zwxHqBWUCYhLnTrqNwDwMnzm6wIzb4Pey+XqsHOeu/NFuqu8kw==
X-Received: by 2002:a5d:9647:0:b0:649:484e:6194 with SMTP id d7-20020a5d9647000000b00649484e6194mr9222832ios.125.1651709192518;
        Wed, 04 May 2022 17:06:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f5-20020a056e020b4500b002cde6e352d2sm57926ilu.28.2022.05.04.17.06.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 17:06:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: eir: Add helpers for managing service data
Date:   Wed,  4 May 2022 17:06:28 -0700
Message-Id: <20220505000629.2903297-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505000629.2903297-1-luiz.dentz@gmail.com>
References: <20220505000629.2903297-1-luiz.dentz@gmail.com>
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

