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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE0C48BE0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6AA61960
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhFHSus (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:50:48 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:40569 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhFHSrx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 14:47:53 -0400
Received: by mail-pl1-f172.google.com with SMTP id e7so11163016plj.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvWOXTPueyrs2x/uQSk4+Xdap4QKR6xTeGr+M5KaG7w=;
        b=twnLortWHD42UWc0DyosXcmnrndkDzgUvMIw+UsZrn1dfnDy2MAFmEK0jkxTsKklME
         ShbjXQlD1qaMmtAzCgfLU+hRIpdG4B5puHVH5BU1eP0x/gsYzRKKC+RFBg9y1F3olNVH
         zwtwenAcH6Ftkj+R5C8IaDKQAd7Iz9Pijy117pFj/S77nhaQudqBhdmYhScwa9LuR4Jk
         hpTlpHgOrmyi+hL0ddEwlwfaYP6MpnOgSWR2fdM9X5kTq8+liKPv3lXA/PHvpPuJf3gL
         CpPBuMa9uZe7KR0zz4sCppynBL0ViD0ZOoXXu5UZliFHUvFYdLnnswvBBBHUCmZdq6zk
         CKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvWOXTPueyrs2x/uQSk4+Xdap4QKR6xTeGr+M5KaG7w=;
        b=Ds0DAP55Txf/3vjtWvki4S2xd3+rbL9x3GnVYF/WNqTnpJ7c0YxMK8Qs8oFes/NOQx
         FBRNBtioEO/t4wOQ3z2R03P+XhXz4MSaJ5Zj901fqeCbsaII/11SlUYwYKLJneUnLtXR
         QSweNj0NmWVE5HREwOPFRkXaBcre0ECWXQltuE1Yr3pSNV8jJMun95D7OdnJP6P3GOr4
         zL/Vrx+rJbrHtMGJZMA5tdzpn8RrYlQ8TvVObAOXDi7Dj2hTXg6QHpUhfncjz5057FkG
         u/p2CT3g2cFUQPEFVGZqytU1L3scA8gUQ9NXJFXLY5oVkQfOZz1ipE8O6LqPFQtm0llV
         P82Q==
X-Gm-Message-State: AOAM533RY5kFgfD7uXtvCbkFcszDD4gEq662DKjBHNmZU1pe9uOhevJd
        VeR1dBKNb1+1DluxYvLH5IG8PDfTIWQ=
X-Google-Smtp-Source: ABdhPJzPew3dhFbjBQDEXcW1F6Eipf4SBO1RcUeopLOJNB5VuKAqsQ+rGxAw9lVtZXwRNJquCpcBmQ==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr6238431pjs.64.1623177899311;
        Tue, 08 Jun 2021 11:44:59 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f13sm11480571pfa.207.2021.06.08.11.44.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:44:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: Fix Set Extended (Scan Response) Data
Date:   Tue,  8 Jun 2021 11:44:57 -0700
Message-Id: <20210608184457.3069064-1-luiz.dentz@gmail.com>
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

