Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1839C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E99C60FE8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhJYXnm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbhJYXnj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E3C061767
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n12so4327273plc.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V3PxBTiA45adEreuM6Z122I+pwNQVgRbkOB0eiGq0Z0=;
        b=MP2NOoxifJ3J6ULqvy/70pGPdXfOYq2lvQE440qypkTsG4OxPXrk0+Kgal1Z1y6BRZ
         PhlLSlwl9SUUuXzpmQcdqBRVq2YDtePCboh/xUMRYZhjKpUvyaeo9GUgRr5g/aRmTXvR
         /utGy9YkPIBLyJ3AzAfETqDOCCylyRdrK/yOoHazoq7ZN5j9Qz7uZZgZLYZ3f+CQ+ou7
         57eCsRTO/c5H1U/VwCgfNsau885ARD8PCoT3jNzlwWQ6jUSsWZ3PcMUYQsPf1k+DIlbk
         IvHvCBM2c6BztipNlsqQCmgRrE83eWIhWYNvYdC9q5RMnfP1Y9xvk9EXfG2STcL9JLa1
         C4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3PxBTiA45adEreuM6Z122I+pwNQVgRbkOB0eiGq0Z0=;
        b=xXPX2sWJd4sCe7keEzHpdqw7Lv/7MVO4VqNyyjspUeSeA908qQfUR/s2vy8rsKiD6D
         sdzT6s5v+4PnquUveZ1KKVMw+ieHYkSBafUkUU86qVImzhVZhNuAY4X60FJ2ePDhkGG0
         fnitC7cyK2rWNByci4nB0bQepvOCj+t4zy93XQmVSqvlzHOPIm1AdUTkxZXKugfKVSEi
         4lYwcepi4r1g6Anr+kOUWMdJw8hTHlgkXRLI4qCL6y4eUap8HOJ55SP2BVIv2G/04xlC
         /GMUj2JyQ5idAtx/cDornd4KranVnVl/6rRjEQwT+1r2eEQKSbSlAtEAkLGQc32OA6Bo
         +WmA==
X-Gm-Message-State: AOAM532IbfQdKkfiYaq3JtuDkl4wwnjIVKhMqr1J9btgWkowN5YFZr4K
        GxMnut5dHg6X6BOFJRdX8lJdu3Z5c2s=
X-Google-Smtp-Source: ABdhPJxLqTIVH0x12FDDTbtA36mzjMc7ZnYCH3n4bI64MQdjBpSeXUrdxiWi2zRPwnMyg2o+sBtUlw==
X-Received: by 2002:a17:902:d202:b0:13a:709b:dfb0 with SMTP id t2-20020a170902d20200b0013a709bdfb0mr19144607ply.34.1635205275684;
        Mon, 25 Oct 2021 16:41:15 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 16/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_EXT_DATA
Date:   Mon, 25 Oct 2021 16:40:55 -0700
Message-Id: <20211025234102.1140719-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Uses existing *_sync functions

mgmt-test paths:
Read Local OOB Ext Data - Invalid index
Read Local OOB Ext Data - Legacy pairing
Read Local OOB Ext Data - Success SSP
Read Local OOB Ext Data - Success SC

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/mgmt.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fb35a860096c..2cfcb526eded 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7369,21 +7369,27 @@ static int set_public_address(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
-					     u16 opcode, struct sk_buff *skb)
+static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
+									int err)
 {
 	const struct mgmt_cp_read_local_oob_ext_data *mgmt_cp;
 	struct mgmt_rp_read_local_oob_ext_data *mgmt_rp;
 	u8 *h192, *r192, *h256, *r256;
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd = data;
+	struct sk_buff *skb = cmd->skb;
+	u8 status = mgmt_status(err);
 	u16 eir_len;
-	int err;
 
-	bt_dev_dbg(hdev, "status %u", status);
+	if (!status) {
+		if (!skb)
+			status = MGMT_STATUS_FAILED;
+		else if (IS_ERR(skb))
+			status = mgmt_status(PTR_ERR(skb));
+		else
+			status = mgmt_status(skb->data[0]);
+	}
 
-	cmd = pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev);
-	if (!cmd)
-		return;
+	bt_dev_dbg(hdev, "status %u", status);
 
 	mgmt_cp = cmd->param;
 
@@ -7395,7 +7401,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 		r192 = NULL;
 		h256 = NULL;
 		r256 = NULL;
-	} else if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
+	} else if (!bredr_sc_enabled(hdev)) {
 		struct hci_rp_read_local_oob_data *rp;
 
 		if (skb->len != sizeof(*rp)) {
@@ -7476,6 +7482,9 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 				 mgmt_rp, sizeof(*mgmt_rp) + eir_len,
 				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
 done:
+	if (skb && !IS_ERR(skb))
+		kfree_skb(skb);
+
 	kfree(mgmt_rp);
 	mgmt_pending_remove(cmd);
 }
@@ -7484,7 +7493,6 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 				  struct mgmt_cp_read_local_oob_ext_data *cp)
 {
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
@@ -7492,14 +7500,9 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 	if (!cmd)
 		return -ENOMEM;
 
-	hci_req_init(&req, hdev);
-
-	if (bredr_sc_enabled(hdev))
-		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_EXT_DATA, 0, NULL);
-	else
-		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+	err = hci_cmd_sync_queue(hdev, read_local_oob_data_sync, cmd,
+			read_local_oob_ext_data_complete);
 
-	err = hci_req_run_skb(&req, read_local_oob_ext_data_complete);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
 		return err;
-- 
2.31.1

