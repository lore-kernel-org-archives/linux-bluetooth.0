Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0C2C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 17:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245621AbiFNRqu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbiFNRqu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 13:46:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA940E6B
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 10:46:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x4so9188181pfj.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHwS31x9zJjvTs6bruI9Ze7jthhDWC8YQgh98IC0AUM=;
        b=U29nWZM0MJXQPqSfOEh5OIUtYdqEyPSeVO17T9lxMsNXjetXb+7pnWSH/LQgrsdTat
         ZiK5norARSg0NC1m+Ru5hh5KZSFFtGlOR0diCPsVt/gQlB22lKdK5o89j6DJVCgSSUeh
         0CmtOxD4aUyObBqTVl4G/GRwQyDYEicDgENf6rGvfWaB4E3hpFgA7eTrzIrpNBYWbmCo
         tKIMLmX5iaNZKL/TkHj8x+qnVb12pG91X3wf2r+wKGqTgbG49SigI/fWw9j+MiknMh/+
         LZBdfeKXzSfgAu9Lx04t1h5ZHIw15WsnnXYSUboQuEVRiDk4cBXWwBGaAcdkhhWsUJEu
         GM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHwS31x9zJjvTs6bruI9Ze7jthhDWC8YQgh98IC0AUM=;
        b=ncwqQ7jPKspMT06aUyjF51VINqzRw904ooZ2aTvwgERW0rml6qP+5iP4FOYXpa0LzA
         eENQpgo/l7SEf5C0UerVvLJsyYPSiW1dnF7LI79M4m+toftx8gTOc2VzgtkdtGp2CsaI
         Qg50PT9Ne/IWWSi3Kjlgh71btQuy5yZWQ4t+U4T5t7txlsbVgBNapHW6YrY7pIjUpfVH
         L0ReQ8W9vePAC/qzBNuqknceUA+M7E+wfSAuOq+aMIrjrX9w1m4zdTD7n2a5NJhmnUCQ
         TblJY0N3t9H3ts5OZ71ISdGYLcxENvzl7n937qyTHpWD2bElSP56FFIOzJ7vK5JRpZKw
         jGpA==
X-Gm-Message-State: AOAM5334RV5DhPtSbT/Tm159xheEmvkQjEsZuAGookMm8DwY7v/4ljmY
        p6Ye4aQOGYVHJEHLZULtc4jjfXtCg8Q=
X-Google-Smtp-Source: ABdhPJynllNFhwhzdBeOHIDifY9bOSB69i2Jp0RNImnJ/xiWBWjejwFNs/O2nYHT115UJqzKRwJ0Tw==
X-Received: by 2002:a05:6a00:b8c:b0:51c:2d3d:4595 with SMTP id g12-20020a056a000b8c00b0051c2d3d4595mr5724894pfj.80.1655228807969;
        Tue, 14 Jun 2022 10:46:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902680e00b00167736c8568sm7526344plk.70.2022.06.14.10.46.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:46:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: HCI: Fix not always setting Scan Response/Advertising Data
Date:   Tue, 14 Jun 2022 10:46:45 -0700
Message-Id: <20220614174645.518132-1-luiz.dentz@gmail.com>
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
v2: Mark scan_rsp_changed when either MGMT_ADV_FLAG_APPEARANCE or
MGMT_ADV_FLAG_LOCAL_NAME have been set.

 include/net/bluetooth/hci_core.h | 11 ++++++
 net/bluetooth/hci_core.c         | 42 ++++++++++----------
 net/bluetooth/hci_sync.c         | 66 ++++++++++++++++++++++----------
 3 files changed, 76 insertions(+), 43 deletions(-)

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
index 6faae50d933d..05c13f639b94 100644
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
@@ -1761,29 +1755,33 @@ int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
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
 
+	/* Mark as changed if there are flags which would affect it */
+	if (((adv->flags & MGMT_ADV_FLAG_APPEARANCE) && hdev->appearance) ||
+	    adv->flags & MGMT_ADV_FLAG_LOCAL_NAME)
+		adv->scan_rsp_changed = true;
+
 	return 0;
 }
 
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

