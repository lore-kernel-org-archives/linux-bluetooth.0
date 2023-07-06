Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADEEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGFTxH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFTxG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 15:53:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268771BF4
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 12:53:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e97fcc60so897972b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688673184; x=1691265184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ouw02jZWi/s79zedc1y3o/UBqif9/zA8Pb5KBdWb480=;
        b=IZ50v//iVJ+PuEBz7OAhIVw0omth+G80/HoX+Z70nOgXOIrah9snOU6wxIKhRhNmC/
         l5nRxevJaPqVsZb/nnvpN7qZVfnhcwwtOhnEY5SVHEIjQ0A4rChU9gAzkSwfpjijZXxv
         lWSkeZbLbso1VDP12MfpRDv7benQhwCSZYfrME4GSJfnzkBA6Cf8A0R9GsFvfqlZLnhb
         mx4jjZOozweqCbGgvCdpE+fzh57Fmyl05ltpQw2RwrvTH6Hjl+epHbfQpwCs5IVAI+y2
         RgIAigZdG6OAO/6LQeKh3TWs2Qmn4S9Bv+sS2sXrLEJZk7Tjpgu4tPx4uYeNkZAF5U6S
         ZxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688673184; x=1691265184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ouw02jZWi/s79zedc1y3o/UBqif9/zA8Pb5KBdWb480=;
        b=W1m43W+7SqXSYpGPIcRwBDvUkgcAeNtkt9fXWMJYAeKZnKvJHBWoGJrumbMUAtYmja
         r1Tx3LuBbMhF/I++LFW5Ntq3baAcT+Bw4gYQoMOnheMDNBj1wQ/VxishTd3h3rbriuJh
         LCb/dXce9Fm/jptfBE3KPHDcDkfwQMQHFVtkCHpxUPT/7CfUCl5Ia/c4TZ2mlB+qzzJm
         1SRzJ/QxwzI7+rw+Nqy/mrU26zhmDHCWMZmeo5CyX63pVTFiygylAYIXkFUbe0ouErg1
         siT9PMbjZlMtS6alMNEQuSNDzU7HnSmgsiJtLkJgstrKEdpKTvUJTsZKu3eL+poLmOq6
         bwbg==
X-Gm-Message-State: ABy/qLZuAB3u0TcHXBU3zOYnR9suoRcidCD/nezLQfrCMiygHNbYxiqn
        2PmWFRXjR7RucQYJHqX7lEFSg+5ig14=
X-Google-Smtp-Source: APBJJlHODSDguiN1BTMkm+uZAm/Sk2lZg3u7EZRPm6pHetz67ft/NqsyuKkQnBiBqA41IU0qwbU7wQ==
X-Received: by 2002:a05:6a20:2a0a:b0:12e:641b:454a with SMTP id e10-20020a056a202a0a00b0012e641b454amr2217130pzh.30.1688673183717;
        Thu, 06 Jul 2023 12:53:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902eb4b00b001b80b583092sm1773803pli.210.2023.07.06.12.53.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:53:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
Date:   Thu,  6 Jul 2023 12:53:01 -0700
Message-Id: <20230706195301.395052-1-luiz.dentz@gmail.com>
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

