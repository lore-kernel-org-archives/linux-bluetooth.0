Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108D26109F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhJ1ABm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhJ1ABk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE95C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r5so3179996pls.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u5v61a2OGnwsJKWtsWGDql2JwgIIQSoi3VYDd5zs3XA=;
        b=GwEUPZhdPFFZr1tVNDLFNKspPDXQURIFjTDHhIgMJRPWtJMRLpuctdZWt3MYGdBlvd
         YoTfhHRYVQl2ZyNeTIleIFIXsgvP7uBnFypneUtIPJa20z7aZ0nZywJ/d9F++EWub+cF
         SXikCTJ4xJ7duL88YIKQsqkRrM+TSB3dQeemhqryJqGTYIF0gCAmbv9WrYnQ41svC8UD
         CdoYxRLAFX+L78BPXC1MoA9Uoi2HItAu22NDGE7oZuxKOWglBfaft56zYmrg1hiuUx1H
         CaLKCrfTp/fPGbAF28c0IWXYvMszadpqBHBgFPI1pAKibX8vJUiBGS3S/K/FuE2zyFcR
         atVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5v61a2OGnwsJKWtsWGDql2JwgIIQSoi3VYDd5zs3XA=;
        b=BXzUaFZgw4gL3vZJ4CgL+nvT7Ptjd5sSfmNg1T9wGi3UFrPlBp8WTyQquUGlROJxmn
         fW9OAzh5TpgryrvB4SnNiuuA8iTGckKcRj9tLqdPSVEK/n94ok1pzWWovI6eU+VS0/DY
         geFoS39Mj5sVnXoZgTvtFwIYUtwF6FrUaozQ4R+Wz6EoEyscBksbRtnVxV+IcahLZ4Yq
         Dwba6ZpLGxkvN3ccylfoVUCrE1QjcxOkAeLIkJQ6R2Gq5XNYcHQkdjRy2KyXVDWD8feR
         thXbedTIFiRfSk6A83WWq+y4E/qV6MNKAS/6L6eDLZ5wVJlB4BjApCIbEeexA0cfWsju
         Lj4A==
X-Gm-Message-State: AOAM533KqJ8alqN4b3wiJpXNxrGbBv3vp/6MyCBw9tmRvatLMuHrKcFc
        oR8F1DUqDt0HHJhr1LvwigpxdryUoT0=
X-Google-Smtp-Source: ABdhPJyflLqhxXmUgiYapV0hyP4Sf72anfOrbIUK+tpBGbStMA4unfo1dRpikzWuQLhV6U4MNQgg6g==
X-Received: by 2002:a17:902:bd01:b0:141:6232:6f89 with SMTP id p1-20020a170902bd0100b0014162326f89mr855360pls.12.1635379153684;
        Wed, 27 Oct 2021 16:59:13 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 16/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_EXT_DATA
Date:   Wed, 27 Oct 2021 16:58:53 -0700
Message-Id: <20211027235900.1882863-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
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
index 6bd75ec7f45e..4ac63e402ef6 100644
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

