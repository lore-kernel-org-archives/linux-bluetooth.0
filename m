Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC37C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50BC610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbhJZXGF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbhJZXGD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B44C061767
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa4so624771pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KSlf9ZxtXFIPRycexknrzEdLsKC0gmPg58RrYP1bdLY=;
        b=gsRhO/TCpu671r1SZKzhmOKdQ3obqS9KZIZQii/iF3nPZCUbQV3+bn+wyBwLLcHGdh
         K5KcDH6ZvB4XZRZnl95VySZsA11wbogeyg/Ac6+cGGoqONSQ1I0PpXBN4OyYYHj/3S3h
         2L49QVTXqGdE9FpukqNYBfMfp99xypeD0SLOBx2a6dhnqk4qv+cQGVDEW2z+tIb251el
         +M7kx2+XZghzzveSAs+fOUduR1uQ8Gn9h3sszDFAFVke4ySHU3cl4wMpDxMC0V1muXbp
         0iST+/3MZEuzVupm6a4EGDOGsNOZyiX6ZdxJliRHfOUDdd9FK6ZLJXxFdsLFq4cQ7JA0
         xrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSlf9ZxtXFIPRycexknrzEdLsKC0gmPg58RrYP1bdLY=;
        b=F2Sa3L9uL36lwbphsnQEAfYxowv5H3xRHFlILWyHPer5TkCxRW/ieRrqbsaaCEqVhe
         X0HDKliG87ofaV7gRbgeS3Cyf4PuqqBKqM6d3YGn4ZfcBwvnGPUJ6oqEXj96wqUmd6xv
         lMTaQ8f5Qsx8tk2E3w3FHPowiawby4vNU8z9ZCsl5FCqRJZQU8e24baa723X/OG4Ntfq
         NCKgBfSCAOlR1lTkGx1s6m5B+t7SY6VGDOX6a3DCyAICTijkADmCQGYEF7/KfmTndfiP
         Jqxy1g9R9wPufTiN7yaLmkq1R+qbw3f1z6UdXX90nf44lGzcAi0MbYeTQwrgFHpEVVF1
         ePVg==
X-Gm-Message-State: AOAM532JzRBlSWT62cpYU9UCNJMS32sQksHN9qnWy8SpfAwqikFMWY3Z
        BVIxia/kQMu1err/JLJ1frTZGSUIvo8=
X-Google-Smtp-Source: ABdhPJw0wpIvbB3W/uktEbgMjDeH+p0V44YoFNqEwVCTnaSIs/1CvWYGf/PM1Kcl/LnfTcNNFtRoNg==
X-Received: by 2002:a17:902:b94b:b0:13d:b1af:f9d4 with SMTP id h11-20020a170902b94b00b0013db1aff9d4mr25474102pls.0.1635289418493;
        Tue, 26 Oct 2021 16:03:38 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 16/23] Bluetooth: hci_sync: Convert MGMT_OP_READ_LOCAL_OOB_EXT_DATA
Date:   Tue, 26 Oct 2021 16:03:17 -0700
Message-Id: <20211026230324.1533907-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
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
index a0997b0f3366..20cefd3e2295 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7365,21 +7365,27 @@ static int set_public_address(struct sock *sk, struct hci_dev *hdev,
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
 
@@ -7391,7 +7397,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 		r192 = NULL;
 		h256 = NULL;
 		r256 = NULL;
-	} else if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
+	} else if (!bredr_sc_enabled(hdev)) {
 		struct hci_rp_read_local_oob_data *rp;
 
 		if (skb->len != sizeof(*rp)) {
@@ -7472,6 +7478,9 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 				 mgmt_rp, sizeof(*mgmt_rp) + eir_len,
 				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
 done:
+	if (skb && !IS_ERR(skb))
+		kfree_skb(skb);
+
 	kfree(mgmt_rp);
 	mgmt_pending_remove(cmd);
 }
@@ -7480,7 +7489,6 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 				  struct mgmt_cp_read_local_oob_ext_data *cp)
 {
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	int err;
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
@@ -7488,14 +7496,9 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
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

