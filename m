Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8AEEE4992
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 21:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjHRVWV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjHRVWQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 17:22:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A72102
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 14:22:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68879c4cadeso1159804b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692393734; x=1692998534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CeEF0KFlvROAnj/Hr1tnN6/F0MeAwLQILMiV5hupfqY=;
        b=siAckDC5NFRq6Pa+8IcGXmRUfh6YjgW9vHaqkSXJ0m93pGq+VeQMpkUxWccOPxqvKz
         ecoYf69vP+uiM4U7HhvoBiIbLcNhHhfISi/miGk5/gDL2TZS9oqe86Oygqcd9rQxbbIf
         eLrfco60l1nQPv9PX48R1D+6yig5+SHzuG8GvQ92jNLZ+/rvPvRf28ABSS4iAq8sjzq6
         6H92SYayqtFgoVtCj1Xp+K8xtz0P/1t1K8UOZhPLEEyUFXIs/+kpRbxDRrwis2LuZYBo
         hduA6jVZTsHNa6F9neK9EdBNM41sPpzKhoWX64kuz8sgaL7N6OwL2lAvo6/jK9HABiaW
         LaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692393734; x=1692998534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeEF0KFlvROAnj/Hr1tnN6/F0MeAwLQILMiV5hupfqY=;
        b=jrcjixx4Kjz1BNAjt0xmYHITtCo3aYpH+Nmjof15fvqZb7LQ+acOUZ8tvMh7jeKmjc
         u7Ohcxf+xlx2JG6IMbEC9Xb6WLUUqsEJJdP+DRnLnKt+O/N2ygDmUvpse53bLOK+Zh0u
         7l0IrM18izem2EzI9sfGFqFNOx3I6gKH6DpIdKwkA3WamT963NWHzSkkVg/pJTXFa1Ml
         2KK1/dTnvNuKM4Jz2Gt9Pku/jniLq4e7K1Io2xnhaaDbkwDMXgYLCzAz0SInjCuN0V3X
         xEunKlfnWUySNemgy+NjwogNnoPhg0B+uDs/Ro8yO+LTO5887S530m/MoivyyA1v0Bej
         8Eqg==
X-Gm-Message-State: AOJu0YxTEZSjH+mEdVQRfxRX+3YsKQ2A5fPVCrB16j8prRXqAFlBtJDH
        cpTZ0h+y7Pz7ejWC0AAMo8IoIKevZdc=
X-Google-Smtp-Source: AGHT+IF8siERWs/5p1GC9xApK10cx6eQccHZktZSPZgGIFbq2P56T/5b/w4/n9+p8C1OR/4vpTAeCg==
X-Received: by 2002:a05:6a20:3d83:b0:134:2b44:decf with SMTP id s3-20020a056a203d8300b001342b44decfmr508203pzi.21.1692393733827;
        Fri, 18 Aug 2023 14:22:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id ey6-20020a056a0038c600b0064fde7ae1ffsm1955282pfb.38.2023.08.18.14.22.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 14:22:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH
Date:   Fri, 18 Aug 2023 14:22:11 -0700
Message-ID: <20230818212211.3207580-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There a few instances still using HCI_MAX_AD_LENGTH instead of using
max_adv_len which takes care of detecting what is the actual maximum
length depending on if the controller supports EA or not.

Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 6 +++---
 net/bluetooth/eir.c              | 2 +-
 net/bluetooth/mgmt.c             | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6fb055e3c595..6e2988b11f99 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -83,7 +83,7 @@ struct discovery_state {
 	u8			last_adv_addr_type;
 	s8			last_adv_rssi;
 	u32			last_adv_flags;
-	u8			last_adv_data[HCI_MAX_AD_LENGTH];
+	u8			last_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	u8			last_adv_data_len;
 	bool			report_invalid_rssi;
 	bool			result_filtering;
@@ -290,7 +290,7 @@ struct adv_pattern {
 	__u8 ad_type;
 	__u8 offset;
 	__u8 length;
-	__u8 value[HCI_MAX_AD_LENGTH];
+	__u8 value[HCI_MAX_EXT_AD_LENGTH];
 };
 
 struct adv_rssi_thresholds {
@@ -726,7 +726,7 @@ struct hci_conn {
 	__u16		le_conn_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
-	__u8		le_adv_data[HCI_MAX_AD_LENGTH];
+	__u8		le_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8		le_adv_data_len;
 	__u8		le_per_adv_data[HCI_MAX_PER_AD_LENGTH];
 	__u8		le_per_adv_data_len;
diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 8a85f6cdfbc1..0f66097b0693 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -33,7 +33,7 @@ u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 	size_t complete_len;
 
 	/* no space left for name (+ NULL + type + len) */
-	if ((HCI_MAX_AD_LENGTH - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
+	if ((max_adv_len(dev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
 		return ad_len;
 
 	/* use complete name if present and fits */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d6c9b7bc8592..ba2e00646e8e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5381,9 +5381,9 @@ static u8 parse_adv_monitor_pattern(struct adv_monitor *m, u8 pattern_count,
 	for (i = 0; i < pattern_count; i++) {
 		offset = patterns[i].offset;
 		length = patterns[i].length;
-		if (offset >= HCI_MAX_AD_LENGTH ||
-		    length > HCI_MAX_AD_LENGTH ||
-		    (offset + length) > HCI_MAX_AD_LENGTH)
+		if (offset >= HCI_MAX_EXT_AD_LENGTH ||
+		    length > HCI_MAX_EXT_AD_LENGTH ||
+		    (offset + length) > HCI_MAX_EXT_AD_LENGTH)
 			return MGMT_STATUS_INVALID_PARAMS;
 
 		p = kmalloc(sizeof(*p), GFP_KERNEL);
-- 
2.41.0

