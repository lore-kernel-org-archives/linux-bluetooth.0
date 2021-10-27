Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75807C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6256D610CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhJ0WUq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhJ0WUo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0246C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l203so4081391pfd.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+QJiErqVlIPPKVnXG6gsVdNucBm345Q9PkMTpWmMlgQ=;
        b=O28wc6YD/XgcEGpUZosVMbe1V4Z42ur7QNZ20kOqDflS9bhNgOVB1aZ7U25YScZy8/
         h7w8CtPP1yU81NOVbU/jSRYC6V0Dm6m8/L6adMKo44UjlwT8amCwa3SeTdjrjfe1CLbp
         aZywztTTGoyseanXAhnXdkMVyVmwmAmqjbCiTNNmJDODHaKuLqrIzhJ13MDUhajEhR8w
         Rwb19aWaR8q37LNERtoaipIMzTNiIDnsA59L08KKg9lCvTwTuhoStDAbHAs/Feem482L
         bSnuTKKdW0EwoHCtsCgV9zMQMR62FUn0EDN0MUkT7LiZwWTK5QF+0SRfeBNsjUsYYWHD
         X2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QJiErqVlIPPKVnXG6gsVdNucBm345Q9PkMTpWmMlgQ=;
        b=Cu2R+BdX6/D73y51x9c8P2RDQFf7JSXp4FH06ivOEuN5wluySIsZD5BGohljrLWLKj
         77vQO3yU/WXauskpqsOLK60rvavPx+uJbVayopXEBH1v5NI0SRLE6F8P1+OZaY+9a0DU
         VuOstaRY65EZqedS7SB1zuwDBn8X6Ah/GKz6BDsf8z8vhqXO00ULZU8V5wLeqihBc9It
         2/Y0aMU76BxX7wMZPLW8Iei5hld2AWTdDOFQG6YF2Nm9mp0cyzLPjGVnNUG9OY/SI3Nm
         gmHNmkCRDptgwA/8YcIp54rL1ibdFOsVcWV98WtMt0cLLEYKKRMfHKx0uMVdMFEPxREA
         hpfQ==
X-Gm-Message-State: AOAM530h08mkLn8jUZaigR4Go12NmuEWfFWo9GC2Ux6rOQolMFyJBWxG
        BMLxWVELum65+g9ACc6ZW/pmyOJcCmY=
X-Google-Smtp-Source: ABdhPJy95SR/JkYQwA9gi4mmDIBVV+1jWXVyVHfCi9NosFkC7wC3BrOje4kOuQc7Nqw4J8NU4BmwoQ==
X-Received: by 2002:a05:6a00:14c2:b0:47c:2c90:df4f with SMTP id w2-20020a056a0014c200b0047c2c90df4fmr366179pfu.63.1635373097984;
        Wed, 27 Oct 2021 15:18:17 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 16/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_EXT_DATA
Date:   Wed, 27 Oct 2021 15:17:55 -0700
Message-Id: <20211027221802.1851851-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
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
index 1adee59a43d4..9893bd283139 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7364,21 +7364,27 @@ static int set_public_address(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
-					     u16 opcode, struct sk_buff *skb)
+static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
+					     int err)
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
 
@@ -7390,7 +7396,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 		r192 = NULL;
 		h256 = NULL;
 		r256 = NULL;
-	} else if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
+	} else if (!bredr_sc_enabled(hdev)) {
 		struct hci_rp_read_local_oob_data *rp;
 
 		if (skb->len != sizeof(*rp)) {
@@ -7471,6 +7477,9 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 				 mgmt_rp, sizeof(*mgmt_rp) + eir_len,
 				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
 done:
+	if (skb && !IS_ERR(skb))
+		kfree_skb(skb);
+
 	kfree(mgmt_rp);
 	mgmt_pending_remove(cmd);
 }
@@ -7479,7 +7488,6 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 				  struct mgmt_cp_read_local_oob_ext_data *cp)
 {
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
@@ -7487,14 +7495,9 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 	if (!cmd)
 		return -ENOMEM;
 
-	hci_req_init(&req, hdev);
-
-	if (bredr_sc_enabled(hdev))
-		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_EXT_DATA, 0, NULL);
-	else
-		hci_req_add(&req, HCI_OP_READ_LOCAL_OOB_DATA, 0, NULL);
+	err = hci_cmd_sync_queue(hdev, read_local_oob_data_sync, cmd,
+				 read_local_oob_ext_data_complete);
 
-	err = hci_req_run_skb(&req, read_local_oob_ext_data_complete);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
 		return err;
-- 
2.31.1

