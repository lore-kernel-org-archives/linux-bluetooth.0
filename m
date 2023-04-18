Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0061DC77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 00:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDRAHM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Apr 2023 20:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDRAHK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Apr 2023 20:07:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F549DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 17:07:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id kh6so26096509plb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681776427; x=1684368427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hN06mOj+6Ju1p/ECpY7+ZYHqkLkE2tfd+WKoVM5sPLE=;
        b=ZamKaVsSTUxAHnHlXugFwY0uXE2hpe17q/tQVN3TErkI/IyDEmvGpiV7GB3ZYBEvyK
         ailXdIC5dFSiXjT6UF4hjUPYo93L08KN6XoLRy0hkJBnOFZkXncEEfhBDdGZNZNOvj6L
         VhrQQPqfE1elZn1X9F0ZDOuRp9uxi5PBwx6dEsQKd/cWMTMhqQ8Cf3B6BWWJtJ+Tt6aW
         cqtTodK5A1+9bwEvItIBWZlod9ap75DHf7OIS4Q7GngF877xThNidQ0Nuo4mHoRin8zp
         1WKajvRlxItNvwd8WCfuV+qFGGUnaH5CDOrl87nILEptDD6A8aN9GdGw7WldY6YSAlZC
         uEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681776427; x=1684368427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hN06mOj+6Ju1p/ECpY7+ZYHqkLkE2tfd+WKoVM5sPLE=;
        b=GFH7MwKRIQf4BLGreLkr7rSB3h+9Ikk4lC7/1ggCg9jvyvmFg5cBc6xxrnAihD4p67
         6lMNKbozXltuXcr5dlpTNw8Ury0GI7+VFyAHt7rpRnSlVGrCi/F7b9tOIdznYJmM0uce
         tJ/vO+6JISZyIv/a9R+Xwivabs2SBY/ghTa0P7xEmRBWj0UmkuOSLeLJmoymibsuj+rT
         mhdMAKiXCnO/wbZAMoxnqWV1PQHG2RGi1EcpdGkiFtnPhH8+XICrXp9DGnFGcMZEbhHi
         eILdi3Eg6itvKIGW161HRuVkFzyQl9UzY8ksZY9p6fY7cqv/BPPAFl0Q4pZQG694217T
         HOPw==
X-Gm-Message-State: AAQBX9esTMwGTHHzhUG1QA/FpnmXZPJsPjHfcE8nFE0wQM5S9qfwE5EX
        vbRjWqK8LjPFIoQOJetR4eUrcKWfeb0=
X-Google-Smtp-Source: AKy350ZPSSpLrHP3x74azTJiyOB2eM/f7SqGIObEBLiclAWAxbj8bwKV+HranrETIjxN1hvwCXUzyg==
X-Received: by 2002:a05:6a20:7fa6:b0:f0:718f:8ef0 with SMTP id d38-20020a056a207fa600b000f0718f8ef0mr1751610pzj.60.1681776426647;
        Mon, 17 Apr 2023 17:07:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b0063b867a1959sm3729705pff.133.2023.04.17.17.07.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 17:07:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btnxpuart: Fix sparse warnings
Date:   Mon, 17 Apr 2023 17:07:04 -0700
Message-Id: <20230418000704.1937843-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following sparse warnings:

   drivers/bluetooth/btnxpuart.c:681:23: sparse: sparse:
   restricted __le16 degrades to integer
   drivers/bluetooth/btnxpuart.c:690:82: sparse:
   sparse: incorrect type in argument 2 (different base types)
   @@     expected unsigned short [usertype] req_len
   @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:690:82: sparse:
   expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:690:82: sparse:
   got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:694:84: sparse:
   sparse: incorrect type in argument 2 (different base types)
   @@     expected unsigned short [usertype] req_len
   @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:694:84: sparse:
   expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:694:84: sparse:
   got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:708:23: sparse:
   sparse: incorrect type in assignment (different base types)
   @@     expected unsigned int [usertype] requested_len
   @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:708:23: sparse:
   expected unsigned int [usertype] requested_len
   drivers/bluetooth/btnxpuart.c:708:23: sparse:
   got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:787:78: sparse:
   sparse: incorrect type in argument 2 (different base types)
   @@     expected unsigned short [usertype] chipid
   @@     got restricted __le16 [usertype] chip_id @@
   drivers/bluetooth/btnxpuart.c:787:78: sparse:
   expected unsigned short [usertype] chipid
   drivers/bluetooth/btnxpuart.c:787:78: sparse:
   got restricted __le16 [usertype] chip_id
   drivers/bluetooth/btnxpuart.c:810:74: sparse:
   sparse: incorrect type in argument 2 (different base types)
   @@     expected unsigned short [usertype] req_len
   @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:810:74: sparse:
   expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:810:74: sparse:
   got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:815:76: sparse:
   sparse: incorrect type in argument 2 (different base types)
   @@     expected unsigned short [usertype] req_len
   @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:815:76: sparse:
   expected unsigned short [usertype] req_len
   drivers/bluetooth/btnxpuart.c:815:76: sparse:
   got restricted __le16 [usertype] len
   drivers/bluetooth/btnxpuart.c:834:16: sparse:
   sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:843:55: sparse:
   sparse: restricted __le32 degrades to integer
   drivers/bluetooth/btnxpuart.c:844:36: sparse:
   sparse: incorrect type in argument 3 (different base types)
   @@     expected unsigned long [usertype]
   @@     got restricted __le16 [usertype] len @@
   drivers/bluetooth/btnxpuart.c:844:36: sparse:
   expected unsigned long [usertype]
   drivers/bluetooth/btnxpuart.c:844:36: sparse:
   got restricted __le16 [usertype] len

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304160736.Tsa0zTBU-lkp@intel.com/
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/Kconfig     |  2 +-
 drivers/bluetooth/btnxpuart.c | 85 +++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index bc211c324206..fcb4f5e5f30f 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -469,7 +469,7 @@ config BT_VIRTIO
 config BT_NXPUART
 	tristate "NXP protocol support"
 	depends on SERIAL_DEV_BUS
-	select CRC32
+		select CRC32
 	select CRC8
 	help
 	  NXP is serial driver required for NXP Bluetooth
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 93f3afc0c0c8..31046f26e712 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -683,12 +683,14 @@ static int nxp_recv_chip_ver_v1(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct v1_start_ind *req;
+	__u16 chip_id;
 
-	req = (struct v1_start_ind *)skb_pull_data(skb, sizeof(struct v1_start_ind));
+	req = skb_pull_data(skb, sizeof(*req));
 	if (!req)
 		goto free_skb;
 
-	if ((req->chip_id ^ req->chip_id_comp) == 0xffff) {
+	chip_id = le16_to_cpu(req->chip_id ^ req->chip_id_comp);
+	if (chip_id == 0xffff) {
 		nxpdev->fw_dnld_v1_offset = 0;
 		nxpdev->fw_v1_sent_bytes = 0;
 		nxpdev->fw_v1_expected_len = HDR_LEN;
@@ -707,29 +709,34 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct btnxpuart_data *nxp_data = nxpdev->nxp_data;
 	struct v1_data_req *req;
-	u32 requested_len;
+	__u16 len;
 
 	if (!process_boot_signature(nxpdev))
 		goto free_skb;
 
-	req = (struct v1_data_req *)skb_pull_data(skb, sizeof(struct v1_data_req));
+	req = skb_pull_data(skb, sizeof(*req));
 	if (!req)
 		goto free_skb;
 
-	if ((req->len ^ req->len_comp) != 0xffff) {
+	len = __le16_to_cpu(req->len ^ req->len_comp);
+	if (len != 0xffff) {
 		bt_dev_dbg(hdev, "ERR: Send NAK");
 		nxp_send_ack(NXP_NAK_V1, hdev);
 		goto free_skb;
 	}
 	nxp_send_ack(NXP_ACK_V1, hdev);
 
+	len = __le16_to_cpu(req->len);
+
 	if (!nxp_data->helper_fw_name) {
 		if (!nxpdev->timeout_changed) {
-			nxpdev->timeout_changed = nxp_fw_change_timeout(hdev, req->len);
+			nxpdev->timeout_changed = nxp_fw_change_timeout(hdev,
+									len);
 			goto free_skb;
 		}
 		if (!nxpdev->baudrate_changed) {
-			nxpdev->baudrate_changed = nxp_fw_change_baudrate(hdev, req->len);
+			nxpdev->baudrate_changed = nxp_fw_change_baudrate(hdev,
+									  len);
 			if (nxpdev->baudrate_changed) {
 				serdev_device_set_baudrate(nxpdev->serdev,
 							   HCI_NXP_SEC_BAUDRATE);
@@ -748,13 +755,14 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			goto free_skb;
 	}
 
-	requested_len = req->len;
-	if (requested_len == 0) {
-		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes", nxpdev->fw->size);
+	if (!len) {
+		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
+			   nxpdev->fw->size);
 		if (nxp_data->helper_fw_name && !nxpdev->helper_downloaded) {
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
-			serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_SEC_BAUDRATE);
+			serdev_device_set_baudrate(nxpdev->serdev,
+						   HCI_NXP_SEC_BAUDRATE);
 			serdev_device_set_flow_control(nxpdev->serdev, 1);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -762,12 +770,12 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 		goto free_skb;
 	}
-	if (requested_len & 0x01) {
+	if (len & 0x01) {
 		/* The CRC did not match at the other end.
 		 * Simply send the same bytes again.
 		 */
-		requested_len = nxpdev->fw_v1_sent_bytes;
-		bt_dev_dbg(hdev, "CRC error. Resend %d bytes of FW.", requested_len);
+		len = nxpdev->fw_v1_sent_bytes;
+		bt_dev_dbg(hdev, "CRC error. Resend %d bytes of FW.", len);
 	} else {
 		nxpdev->fw_dnld_v1_offset += nxpdev->fw_v1_sent_bytes;
 
@@ -781,24 +789,23 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 		 * mismatch, clearly the driver and FW are out of sync,
 		 * and we need to re-send the previous header again.
 		 */
-		if (requested_len == nxpdev->fw_v1_expected_len) {
-			if (requested_len == HDR_LEN)
+		if (len == nxpdev->fw_v1_expected_len) {
+			if (len == HDR_LEN)
 				nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev->fw->data +
 									nxpdev->fw_dnld_v1_offset);
 			else
 				nxpdev->fw_v1_expected_len = HDR_LEN;
-		} else if (requested_len == HDR_LEN) {
+		} else if (len == HDR_LEN) {
 			/* FW download out of sync. Send previous chunk again */
 			nxpdev->fw_dnld_v1_offset -= nxpdev->fw_v1_sent_bytes;
 			nxpdev->fw_v1_expected_len = HDR_LEN;
 		}
 	}
 
-	if (nxpdev->fw_dnld_v1_offset + requested_len <= nxpdev->fw->size)
-		serdev_device_write_buf(nxpdev->serdev,
-					nxpdev->fw->data + nxpdev->fw_dnld_v1_offset,
-					requested_len);
-	nxpdev->fw_v1_sent_bytes = requested_len;
+	if (nxpdev->fw_dnld_v1_offset + len <= nxpdev->fw->size)
+		serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
+					nxpdev->fw_dnld_v1_offset, len);
+	nxpdev->fw_v1_sent_bytes = len;
 
 free_skb:
 	kfree_skb(skb);
@@ -828,13 +835,16 @@ static char *nxp_get_fw_name_from_chipid(struct hci_dev *hdev, u16 chipid)
 
 static int nxp_recv_chip_ver_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct v3_start_ind *req = skb_pull_data(skb, sizeof(struct v3_start_ind));
+	struct v3_start_ind *req = skb_pull_data(skb, sizeof(*req));
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	u16 chip_id;
 
 	if (!process_boot_signature(nxpdev))
 		goto free_skb;
 
-	if (!nxp_request_firmware(hdev, nxp_get_fw_name_from_chipid(hdev, req->chip_id)))
+	chip_id = le16_to_cpu(req->chip_id);
+	if (!nxp_request_firmware(hdev, nxp_get_fw_name_from_chipid(hdev,
+								    chip_id)))
 		nxp_send_ack(NXP_ACK_V3, hdev);
 
 free_skb:
@@ -846,23 +856,27 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct v3_data_req *req;
+	__u16 len;
+	__u32 offset;
 
 	if (!process_boot_signature(nxpdev))
 		goto free_skb;
 
-	req = (struct v3_data_req *)skb_pull_data(skb, sizeof(struct v3_data_req));
+	req = skb_pull_data(skb, sizeof(*req));
 	if (!req || !nxpdev->fw)
 		goto free_skb;
 
 	nxp_send_ack(NXP_ACK_V3, hdev);
 
+	len = __le16_to_cpu(req->len);
+
 	if (!nxpdev->timeout_changed) {
-		nxpdev->timeout_changed = nxp_fw_change_timeout(hdev, req->len);
+		nxpdev->timeout_changed = nxp_fw_change_timeout(hdev, len);
 		goto free_skb;
 	}
 
 	if (!nxpdev->baudrate_changed) {
-		nxpdev->baudrate_changed = nxp_fw_change_baudrate(hdev, req->len);
+		nxpdev->baudrate_changed = nxp_fw_change_baudrate(hdev, len);
 		if (nxpdev->baudrate_changed) {
 			serdev_device_set_baudrate(nxpdev->serdev,
 						   HCI_NXP_SEC_BAUDRATE);
@@ -873,25 +887,28 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (req->len == 0) {
-		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes", nxpdev->fw->size);
+		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
+			   nxpdev->fw->size);
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
 		goto free_skb;
 	}
 	if (req->error)
-		bt_dev_dbg(hdev, "FW Download received err 0x%02x from chip", req->error);
+		bt_dev_dbg(hdev, "FW Download received err 0x%02x from chip",
+			   req->error);
 
-	if (req->offset < nxpdev->fw_v3_offset_correction) {
+	offset = __le32_to_cpu(req->offset);
+	if (offset < nxpdev->fw_v3_offset_correction) {
 		/* This scenario should ideally never occur. But if it ever does,
 		 * FW is out of sync and needs a power cycle.
 		 */
-		bt_dev_err(hdev, "Something went wrong during FW download. Please power cycle and try again");
+		bt_dev_err(hdev, "Something went wrong during FW download");
+		bt_dev_err(hdev, "Please power cycle and try again");
 		goto free_skb;
 	}
 
-	serdev_device_write_buf(nxpdev->serdev,
-				nxpdev->fw->data + req->offset - nxpdev->fw_v3_offset_correction,
-				req->len);
+	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data + offset -
+				nxpdev->fw_v3_offset_correction, len);
 
 free_skb:
 	kfree_skb(skb);
-- 
2.39.2

