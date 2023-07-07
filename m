Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E798EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 22:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGGWn7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGGWn6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 18:43:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F49C2688
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 15:43:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-765942d497fso219725485a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688769801; x=1691361801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ouw02jZWi/s79zedc1y3o/UBqif9/zA8Pb5KBdWb480=;
        b=D0fcYslXLL0pNO/h+59nbN4CPimAIiAYXS5zumr4VsAGN5MpZD4m7EQ2R+IxsMvKYo
         rWti9NkKMxyjbTRoS0rOyoTEJ5t3wwYPZLQ/Vu60cDb+kcny9Z/tmY5Nd8XTBnrdnESD
         O2RA6JUiaty7sPItkvn+yMxmYhh4CxrOZBX12H5CoVbSRE48PS+TKSQa8T9s/k2JSvg1
         s/gNXo/cb3Bx5G4CHN+lpZiJmYL6zG3DNta7E1AA3G6aOtB6hfbWFRPeDJIrqeGGDx0q
         cFQJupz2RGn58UHohA9Nz4/R4C3wPNmftillfvGYpbZcTi2/VmPYPnge0U/ySEzv2Kdi
         1s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688769801; x=1691361801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ouw02jZWi/s79zedc1y3o/UBqif9/zA8Pb5KBdWb480=;
        b=cZhZKItIL3E8fIqS7/G9LOqNFSL8FkfmHuKs2sLjM8je5TIaLOaxMyHxQfEtZRO59u
         +fIjlHlyuGyo+0/GUL3II957iCX7M+vzSmih8GlbeICpjNHdX2FzJA15g9d+pJQckkBJ
         pvl4RphXjU0KiS3jbStrQRQF3U+GYl/ee1woqv8RP4gqMkMtV8hZLBSgR9dnCD8IIHFh
         gLHg5hTWej2Y4VpSefXBhIy8J0Eu0amPlxU5lpkWhtIn0rWGzLjf1+lM1o36iFIs0GsW
         sB54E+BX6IC23zDaHAG3Ds/euS0joo1MUR6ds/Ipfp/1Dsj49IDnmdRmUxJBF/1NswBh
         C23g==
X-Gm-Message-State: ABy/qLbpmDu+aRguSvKivVxK1Uq2L4OJgVcTX4t1hbP06PemN+hWeGvm
        5wcthKjLb3msy+6u/8IcwuuMkfIkyjw=
X-Google-Smtp-Source: APBJJlEa8r3nOmLsJU1gNvvAUDRNgDNe5Vjuqk8uE145AaK01ClnEBTm4uQWfC/0h3mJRsmk7QrJlA==
X-Received: by 2002:a05:620a:3916:b0:765:4bf1:e737 with SMTP id qr22-20020a05620a391600b007654bf1e737mr7747132qkn.65.1688769801374;
        Fri, 07 Jul 2023 15:43:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id m11-20020ae9e00b000000b00762255dced0sm2291705qkk.0.2023.07.07.15.43.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:43:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
Date:   Fri,  7 Jul 2023 15:43:17 -0700
Message-Id: <20230707224318.677205-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

HCI_MAX_AD_LENGTH shall only be used if the controller doesn't support
extended advertising, otherwise HCI_MAX_EXT_AD_LENGTH shall be used
instead.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_event.c        | 12 +++++++-----
 net/bluetooth/mgmt.c             |  6 +++---
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 105c1c394f82..8200a6689b39 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1801,6 +1801,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* Maximum advertising length */
+#define max_adv_len(dev) \
+	(ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH)
+
 /* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 1789:
  *
  * C24: Mandatory if the LE Controller supports Connection State and either
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c29eece88d2c..f1fcece29e7d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1747,7 +1747,7 @@ static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct discovery_state *d = &hdev->discovery;
 
-	if (len > HCI_MAX_AD_LENGTH)
+	if (len > max_adv_len(hdev))
 		return;
 
 	bacpy(&d->last_adv_addr, bdaddr);
@@ -6249,8 +6249,9 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		return;
 	}
 
-	if (!ext_adv && len > HCI_MAX_AD_LENGTH) {
-		bt_dev_err_ratelimited(hdev, "legacy adv larger than 31 bytes");
+	if (len > max_adv_len(hdev)) {
+		bt_dev_err_ratelimited(hdev,
+				       "adv larger than maximum supported");
 		return;
 	}
 
@@ -6315,7 +6316,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 */
 	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, bdaddr_resolved,
 				     type);
-	if (!ext_adv && conn && type == LE_ADV_IND && len <= HCI_MAX_AD_LENGTH) {
+	if (!ext_adv && conn && type == LE_ADV_IND &&
+	    len <= max_adv_len(hdev)) {
 		/* Store report for later inclusion by
 		 * mgmt_device_connected
 		 */
@@ -6456,7 +6458,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 					info->length + 1))
 			break;
 
-		if (info->length <= HCI_MAX_AD_LENGTH) {
+		if (info->length <= max_adv_len(hdev)) {
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0, rssi,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3156bc27088e..33c06f7c7641 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8428,8 +8428,8 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	supported_flags = get_supported_adv_flags(hdev);
 
 	rp->supported_flags = cpu_to_le32(supported_flags);
-	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
-	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
+	rp->max_adv_data_len = max_adv_len(hdev);
+	rp->max_scan_rsp_len = max_adv_len(hdev);
 	rp->max_instances = hdev->le_num_of_adv_sets;
 	rp->num_instances = hdev->adv_instance_cnt;
 
@@ -8465,7 +8465,7 @@ static u8 calculate_name_len(struct hci_dev *hdev)
 static u8 tlv_data_max_len(struct hci_dev *hdev, u32 adv_flags,
 			   bool is_adv_data)
 {
-	u8 max_len = HCI_MAX_AD_LENGTH;
+	u8 max_len = max_adv_len(hdev);
 
 	if (is_adv_data) {
 		if (adv_flags & (MGMT_ADV_FLAG_DISCOV |
-- 
2.40.1

