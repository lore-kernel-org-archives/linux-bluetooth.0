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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A5FC48BCF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7901961184
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jun 2021 22:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFIWWs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jun 2021 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhFIWWs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jun 2021 18:22:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1CC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jun 2021 15:20:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h12so16894858pfe.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jun 2021 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XejPS2SxgaSma7UYPFxMSGQDLe3SrSlRCe8g7Osky3I=;
        b=TlGAGC0h5hkvE5CdZFNiteGBKw8g0aR+bHvRX/SPGme2uJbB69qy2UM4MIYHGYqnqO
         lmV+Y07vZCOfCqx8PcnL74JXYwilhDyWWRHByu2+nA7mGJFdvePZawTGRTkno6kCdEKY
         530Y1LM1uRy/MUVSGIBNwdk7zpzFN2EAPWmHdxKKA9Kj+oZhQCDSc/eiacfnmLdZVgmh
         9hnEubHH43OofoyUJvMxvGuFWPtwFUGSsv3iJzugt5zysRpTILfuX59F7n8VxbkisLTP
         3DwZsyI4XRNdEYiYZKNLEp8I2a/f7cqrZU22naUGzijW8vHenK9F+fZJoZ3E2N0LMj3O
         SwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XejPS2SxgaSma7UYPFxMSGQDLe3SrSlRCe8g7Osky3I=;
        b=goOCBbfD0LqrOFZ6gRcG+4+kQ+khMCJ2d/c7vxge3Od0LdIRG1QL03ERgepkzIZWF9
         7SasErfcn5GdviILAPoGgGspeS47yklE4erk4FNAISEBsDcH6Bfbz6dPMMeFh55gkcn2
         ZzFSKZrl2N3jVVfVOYB2dG/40zfSHNNByaVdpOZ1eph+Wgi6BVUkLPYzo4aAq5bAVO+8
         z7sKUA/Ab6E1qPv7qzVblJLe7f9RIeeSpszLf8xB3h3WD03ZFskzT4jb+4dXOAoyBVU6
         Al/YXczJB98Hu3bb6TAxXMXFaUDuPlGi2wQ+KOcb+mRG0mDgqooU+QbJHKqERmOjufYW
         FCOw==
X-Gm-Message-State: AOAM533/cwNNLf9G1v05qQUYwwFOMRrjcJHrgYCihsTD22fLgXtS+dGq
        bpp+5AwunZ9qrl2EaKNla3S0FZ7IirE=
X-Google-Smtp-Source: ABdhPJxnS233DHXEVgO9HKfm5iG6Kq45elPk9eFR8S1ya93Wjsk/DQ8CwZLWD+qAft4nPsaLIJWxPQ==
X-Received: by 2002:a63:1041:: with SMTP id 1mr1831346pgq.258.1623277238744;
        Wed, 09 Jun 2021 15:20:38 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n9sm460352pfu.121.2021.06.09.15.20.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:20:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HCI: Fix Set Extended (Scan Response) Data
Date:   Wed,  9 Jun 2021 15:20:30 -0700
Message-Id: <20210609222035.297833-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609222035.297833-1-luiz.dentz@gmail.com>
References: <20210609222035.297833-1-luiz.dentz@gmail.com>
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

