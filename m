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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D02C48BCD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57936613D7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 18:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhFISLZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFISLZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 14:11:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D349C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jun 2021 11:09:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 11so13004787plk.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XejPS2SxgaSma7UYPFxMSGQDLe3SrSlRCe8g7Osky3I=;
        b=n/yR2a0xGv1fifIZAWO8RRBVIkZ88ZA/1SeX9EFbKCi/fV58gr9i59gG34/qhcp2yr
         XeVfH4/rEooJJlxaUoFBA9cKgeQKY+4nUCkI1V/qp2xF8S4FVIq1ipPPHJbP4rlGndhK
         QYw0BeWw8GU6+7PCQncX5JYFWuE/x484TErSUyaFNX0i7PNzkuPjin1oquTB3Mba+ifj
         Gr86KG231zznaEE8zobhRPjXJBPotj4zlHrLWNpr7/h0fkUdKA2Ua0fQ4R3lJi7Oe9y0
         sq1bEjDxp+zXzzOEbSjoJh6tWP915giJn19OrhSLS8fZkddUe263I3yqHkFxZvANM051
         qDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XejPS2SxgaSma7UYPFxMSGQDLe3SrSlRCe8g7Osky3I=;
        b=NEDkTvI9BurKkGJl+o0bJ/TihkKyFLlzZh73rB5gES0Z5PTV8r5K88LtO8M94HwSTz
         l72gghlzrnw3vUb1sVQPZ27cP36hjEMorwoZBgAHcCnjoiWmMP8+ZAw7bzX3i67PvgCm
         HFyuCRRbUaWX/c2Qk/xna4n8iRFw+wz+lE+L7K8yRz0mv0gSgQLh8wjGqSkMZp4GMeMx
         JxtkYzx2NnqHW+7MuB2QbYvhp/IZcVk5kCPWHhshi1RcZwvR39ZzkFws+VrDYQnXzsef
         0w702YPYSQDtypRCzUJunEG38zLHkdhEzm4vglVbi6Qpz6RMxmvTD1vgCBLAUsC1c+5a
         el7A==
X-Gm-Message-State: AOAM532q5Q2Mas3Y8aG4dvFcCLYgOc9JZS+P1C7PmrQ9pW8x+7CZPGJA
        lFoHTG0dze0UmyKEaBvZQF8nl6QEIhQ=
X-Google-Smtp-Source: ABdhPJwCmssVHvO9vabgoMpefTLkQG3HHMmnJlJlQyWtTc+H2WmVy97tkB710mF+KqKyIlYdRWBOhw==
X-Received: by 2002:a17:902:d104:b029:113:4f33:47b8 with SMTP id w4-20020a170902d104b02901134f3347b8mr846997plw.14.1623262169425;
        Wed, 09 Jun 2021 11:09:29 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m134sm233236pfd.148.2021.06.09.11.09.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 11:09:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HCI: Fix Set Extended (Scan Response) Data
Date:   Wed,  9 Jun 2021 11:09:27 -0700
Message-Id: <20210609180927.179265-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These command do have variable length and the length can go up to 251,
so this changes the struct to not use a fixed size and then when
creating the PDU only the actual length of the data send to the
controller.

Fixes: a0fb3726ba551 ("Bluetooth: Use Set ext adv/scan rsp data if
controller supports")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  6 ++--
 include/net/bluetooth/hci_core.h |  8 ++---
 net/bluetooth/hci_request.c      | 51 ++++++++++++++++++--------------
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 479adbde6db4..cfd4e40594d1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1775,13 +1775,15 @@ struct hci_cp_ext_adv_set {
 	__u8  max_events;
 } __packed;
 
+#define HCI_MAX_EXT_AD_LENGTH	251
+
 #define HCI_OP_LE_SET_EXT_ADV_DATA		0x2037
 struct hci_cp_le_set_ext_adv_data {
 	__u8  handle;
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[HCI_MAX_AD_LENGTH];
+	__u8  data[];
 } __packed;
 
 #define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
@@ -1790,7 +1792,7 @@ struct hci_cp_le_set_ext_scan_rsp_data {
 	__u8  operation;
 	__u8  frag_pref;
 	__u8  length;
-	__u8  data[HCI_MAX_AD_LENGTH];
+	__u8  data[];
 } __packed;
 
 #define LE_SET_ADV_DATA_OP_COMPLETE	0x03
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 212f46806ce7..a53e94459ecd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -228,9 +228,9 @@ struct adv_info {
 	__u16	remaining_time;
 	__u16	duration;
 	__u16	adv_data_len;
-	__u8	adv_data[HCI_MAX_AD_LENGTH];
+	__u8	adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u16	scan_rsp_len;
-	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
+	__u8	scan_rsp_data[HCI_MAX_EXT_AD_LENGTH];
 	__s8	tx_power;
 	__u32   min_interval;
 	__u32   max_interval;
@@ -551,9 +551,9 @@ struct hci_dev {
 	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
 
 	__s8			adv_tx_power;
-	__u8			adv_data[HCI_MAX_AD_LENGTH];
+	__u8			adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8			adv_data_len;
-	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
+	__u8			scan_rsp_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8			scan_rsp_data_len;
 
 	struct list_head	adv_instances;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index f7a9d97f3e84..1d14adc023e9 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1716,30 +1716,33 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 		return;
 
 	if (ext_adv_capable(hdev)) {
-		struct hci_cp_le_set_ext_scan_rsp_data cp;
+		struct {
+			struct hci_cp_le_set_ext_scan_rsp_data cp;
+			u8 data[HCI_MAX_EXT_AD_LENGTH];
+		} pdu;
 
-		memset(&cp, 0, sizeof(cp));
+		memset(&pdu, 0, sizeof(pdu));
 
 		if (instance)
 			len = create_instance_scan_rsp_data(hdev, instance,
-							    cp.data);
+							    pdu.data);
 		else
-			len = create_default_scan_rsp_data(hdev, cp.data);
+			len = create_default_scan_rsp_data(hdev, pdu.data);
 
 		if (hdev->scan_rsp_data_len == len &&
-		    !memcmp(cp.data, hdev->scan_rsp_data, len))
+		    !memcmp(pdu.data, hdev->scan_rsp_data, len))
 			return;
 
-		memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+		memcpy(hdev->scan_rsp_data, pdu.data, len);
 		hdev->scan_rsp_data_len = len;
 
-		cp.handle = instance;
-		cp.length = len;
-		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-		cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+		pdu.cp.handle = instance;
+		pdu.cp.length = len;
+		pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+		pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
-		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA, sizeof(cp),
-			    &cp);
+		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
+			    sizeof(pdu.cp) + len, &pdu.cp);
 	} else {
 		struct hci_cp_le_set_scan_rsp_data cp;
 
@@ -1862,26 +1865,30 @@ void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 		return;
 
 	if (ext_adv_capable(hdev)) {
-		struct hci_cp_le_set_ext_adv_data cp;
+		struct {
+			struct hci_cp_le_set_ext_adv_data cp;
+			u8 data[HCI_MAX_EXT_AD_LENGTH];
+		} pdu;
 
-		memset(&cp, 0, sizeof(cp));
+		memset(&pdu, 0, sizeof(pdu));
 
-		len = create_instance_adv_data(hdev, instance, cp.data);
+		len = create_instance_adv_data(hdev, instance, pdu.data);
 
 		/* There's nothing to do if the data hasn't changed */
 		if (hdev->adv_data_len == len &&
-		    memcmp(cp.data, hdev->adv_data, len) == 0)
+		    memcmp(pdu.data, hdev->adv_data, len) == 0)
 			return;
 
-		memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+		memcpy(hdev->adv_data, pdu.data, len);
 		hdev->adv_data_len = len;
 
-		cp.length = len;
-		cp.handle = instance;
-		cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
-		cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+		pdu.cp.length = len;
+		pdu.cp.handle = instance;
+		pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
+		pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
-		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_DATA, sizeof(cp), &cp);
+		hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_DATA,
+			    sizeof(pdu.cp) + len, &pdu.cp);
 	} else {
 		struct hci_cp_le_set_adv_data cp;
 
-- 
2.31.1

