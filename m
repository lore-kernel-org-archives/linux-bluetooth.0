Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE42C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 00:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiFNAjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 20:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFNAjj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 20:39:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D732CDD1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 17:39:38 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f65so7062283pgc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 17:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJ5vj5291/3FLSLYTYG0rDzrv4KxfVI3Cm5l4dTw/1E=;
        b=EGWSd9YCGzHml3957uGt5uVNQ/13R5W97L3eOosksduGVOYVtrTo+T4Yrp05Lu4O/4
         yqKpGmFTDlVGcwvx9xSn8N4cfmG57IT2UmuSQ5l4n1aIQX9uPH/ImznwMn9sw8ocUkU3
         khqM2rHT6Y7ZxGKMcVMvUJ7bfs6ey47v2FZCWyttLriSj31hlT4zErAmkGGdbboojtpy
         41xqZPbpilribbSimIbW+ZjygSGbiVh0tXhRDE6k9xkaOeLMoa0zpn8ojKQtNBYDQYhE
         vtxXW0ehh0tj4x9AujB5aHwyqZbQbfb1r8wPx9LlcJKXXMkSjX6OiktV5BlDE4W0qwLr
         GK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JJ5vj5291/3FLSLYTYG0rDzrv4KxfVI3Cm5l4dTw/1E=;
        b=1bHhVC5Dzn7DlRu3rAx2/1xI+2QcnRVFYnSJ+ITK8xUM9D76jb/kp/7TSc12DYjLG0
         OGmdLK0MwVVRKIruGrl43Ilz/zpF7PFbUEyzB2cAUgeAcF3fWHnTakC9gDemmNfAm93R
         qrl2EG7b/k0ieEQPQidBG7otRLP2SAEDTq0mA8Ggdycf1wmIpX8qFtn/tsSA+KCCRdMX
         Cj3whFkKmdvLqEy3p6Q32gXKf40c0BqFfoOr5gEDIgVaYSxIN/DSD19/GZNFSJWmrBn8
         Xij3N2tX6nZMWQ8AgrL/PyBY3bSLFbuVosGjqw6ehoukHZqadrQwDq0cXkrP2B6ecUWu
         mvkw==
X-Gm-Message-State: AOAM532Dclu5lM9qPOhGh4uS3V4XvSXhlC5FHtKs+pgNlJeY6rmsoG83
        2Bx3dIUi7xpK27XreikFRYxynt2VR48=
X-Google-Smtp-Source: ABdhPJx2LyWtl5hHJ2InDLnBPAu6OJ97wMqWm2DOs8PdxPrOfiS6d4sova13eWuyE7zh3me97FIhAQ==
X-Received: by 2002:a05:6a00:996:b0:505:b6d2:abc8 with SMTP id u22-20020a056a00099600b00505b6d2abc8mr1975268pfg.11.1655167177650;
        Mon, 13 Jun 2022 17:39:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jc10-20020a17090325ca00b0015e8d4eb1c6sm5737067plb.16.2022.06.13.17.39.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 17:39:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: Fix not always setting Scan Response/Advertising Data
Date:   Mon, 13 Jun 2022 17:39:35 -0700
Message-Id: <20220614003935.361245-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The scan response and advertising data needs to be tracked on a per
instance (adv_info) since when these instaces are removed so are their
data, to fix that new flags are introduced which is used to mark when
the data changes and then checked to confirm when the data needs to be
synced with the controller.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 11 ++++++
 net/bluetooth/hci_core.c         | 37 ++++++++----------
 net/bluetooth/hci_sync.c         | 66 ++++++++++++++++++++++----------
 3 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5b92a9abe141..15237ee5f761 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -246,8 +246,10 @@ struct adv_info {
 	__u16	duration;
 	__u16	adv_data_len;
 	__u8	adv_data[HCI_MAX_EXT_AD_LENGTH];
+	bool	adv_data_changed;
 	__u16	scan_rsp_len;
 	__u8	scan_rsp_data[HCI_MAX_EXT_AD_LENGTH];
+	bool	scan_rsp_changed;
 	__s8	tx_power;
 	__u32   min_interval;
 	__u32   max_interval;
@@ -261,6 +263,15 @@ struct adv_info {
 
 #define HCI_ADV_TX_POWER_NO_PREFERENCE 0x7F
 
+#define DATA_CMP(_d1, _l1, _d2, _l2) \
+	(_l1 == _l2 ? memcmp(_d1, _d2, _l1) : _l1 - _l2)
+
+#define ADV_DATA_CMP(_adv, _data, _len) \
+	DATA_CMP((_adv)->adv_data, (_adv)->adv_data_len, _data, _len)
+
+#define SCAN_RSP_CMP(_adv, _data, _len) \
+	DATA_CMP((_adv)->scan_rsp_data, (_adv)->scan_rsp_len, _data, _len)
+
 struct monitored_device {
 	struct list_head list;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6faae50d933d..ba7cd057a5d6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1727,18 +1727,12 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	}
 
 	adv_instance->flags = flags;
-	adv_instance->adv_data_len = adv_data_len;
-	adv_instance->scan_rsp_len = scan_rsp_len;
 	adv_instance->min_interval = min_interval;
 	adv_instance->max_interval = max_interval;
 	adv_instance->tx_power = tx_power;
 
-	if (adv_data_len)
-		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
-
-	if (scan_rsp_len)
-		memcpy(adv_instance->scan_rsp_data,
-		       scan_rsp_data, scan_rsp_len);
+	hci_set_adv_instance_data(hdev, instance, adv_data_len, adv_data,
+				  scan_rsp_len, scan_rsp_data);
 
 	adv_instance->timeout = timeout;
 	adv_instance->remaining_time = timeout;
@@ -1761,27 +1755,26 @@ int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
 			      u16 adv_data_len, u8 *adv_data,
 			      u16 scan_rsp_len, u8 *scan_rsp_data)
 {
-	struct adv_info *adv_instance;
+	struct adv_info *adv;
 
-	adv_instance = hci_find_adv_instance(hdev, instance);
+	adv = hci_find_adv_instance(hdev, instance);
 
 	/* If advertisement doesn't exist, we can't modify its data */
-	if (!adv_instance)
+	if (!adv)
 		return -ENOENT;
 
-	if (adv_data_len) {
-		memset(adv_instance->adv_data, 0,
-		       sizeof(adv_instance->adv_data));
-		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
-		adv_instance->adv_data_len = adv_data_len;
+	if (adv_data_len && ADV_DATA_CMP(adv, adv_data, adv_data_len)) {
+		memset(adv->adv_data, 0, sizeof(adv->adv_data));
+		memcpy(adv->adv_data, adv_data, adv_data_len);
+		adv->adv_data_len = adv_data_len;
+		adv->adv_data_changed = true;
 	}
 
-	if (scan_rsp_len) {
-		memset(adv_instance->scan_rsp_data, 0,
-		       sizeof(adv_instance->scan_rsp_data));
-		memcpy(adv_instance->scan_rsp_data,
-		       scan_rsp_data, scan_rsp_len);
-		adv_instance->scan_rsp_len = scan_rsp_len;
+	if (scan_rsp_len && SCAN_RSP_CMP(adv, scan_rsp_data, scan_rsp_len)) {
+		memset(adv->scan_rsp_data, 0, sizeof(adv->scan_rsp_data));
+		memcpy(adv->scan_rsp_data, scan_rsp_data, scan_rsp_len);
+		adv->scan_rsp_len = scan_rsp_len;
+		adv->scan_rsp_changed = true;
 	}
 
 	return 0;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0fa013816a9b..e974a888c0f3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -849,26 +849,38 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 		u8 data[HCI_MAX_EXT_AD_LENGTH];
 	} pdu;
 	u8 len;
+	struct adv_info *adv = NULL;
+	int err;
 
 	memset(&pdu, 0, sizeof(pdu));
 
+	if (instance) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->scan_rsp_changed)
+			return 0;
+	}
+
 	len = eir_create_scan_rsp(hdev, instance, pdu.data);
 
-	if (hdev->scan_rsp_data_len == len &&
-	    !memcmp(pdu.data, hdev->scan_rsp_data, len))
-		return 0;
-
-	memcpy(hdev->scan_rsp_data, pdu.data, len);
-	hdev->scan_rsp_data_len = len;
-
 	pdu.cp.handle = instance;
 	pdu.cp.length = len;
 	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
-				     sizeof(pdu.cp) + len, &pdu.cp,
-				     HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_RSP_DATA,
+				    sizeof(pdu.cp) + len, &pdu.cp,
+				    HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	if (adv) {
+		adv->scan_rsp_changed = false;
+	} else {
+		memcpy(hdev->scan_rsp_data, pdu.data, len);
+		hdev->scan_rsp_data_len = len;
+	}
+
+	return 0;
 }
 
 static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
@@ -1119,27 +1131,39 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 		u8 data[HCI_MAX_EXT_AD_LENGTH];
 	} pdu;
 	u8 len;
+	struct adv_info *adv = NULL;
+	int err;
 
 	memset(&pdu, 0, sizeof(pdu));
 
+	if (instance) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->adv_data_changed)
+			return 0;
+	}
+
 	len = eir_create_adv_data(hdev, instance, pdu.data);
 
-	/* There's nothing to do if the data hasn't changed */
-	if (hdev->adv_data_len == len &&
-	    memcmp(pdu.data, hdev->adv_data, len) == 0)
-		return 0;
-
-	memcpy(hdev->adv_data, pdu.data, len);
-	hdev->adv_data_len = len;
-
 	pdu.cp.length = len;
 	pdu.cp.handle = instance;
 	pdu.cp.operation = LE_SET_ADV_DATA_OP_COMPLETE;
 	pdu.cp.frag_pref = LE_SET_ADV_DATA_NO_FRAG;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				     sizeof(pdu.cp) + len, &pdu.cp,
-				     HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
+				    sizeof(pdu.cp) + len, &pdu.cp,
+				    HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Update data if the command succeed */
+	if (adv) {
+		adv->adv_data_changed = false;
+	} else {
+		memcpy(hdev->adv_data, pdu.data, len);
+		hdev->adv_data_len = len;
+	}
+
+	return 0;
 }
 
 static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
-- 
2.35.3

