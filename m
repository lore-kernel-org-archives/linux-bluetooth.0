Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D42C10F06
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CBE2147C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 23:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxT2hCfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDCXIw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:08:52 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34876 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCXIv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 19:08:51 -0400
Received: by mail-pg1-f182.google.com with SMTP id g8so223305pgf.2;
        Wed, 03 Apr 2019 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsRfSaim7oF97knZ/li5hmGIZL31exGO0KpXeT6AtwM=;
        b=TxT2hCfyx53LnAnGewpxbwHVqnpqucV3t2clz2SMF3PLIr+u1bNRQpgurpJlvSqUUc
         q5ljMLJNfcxLeuBE7RQbL9cKnBQeLIl0nqFO+r20a+CBu9U5CBN74HzPPbw5vrM7MlPK
         vn0T5w3SUnw9QMnAG53ifFlQ08o5FSvV1C7Ut74edBRPPjjbLV/RFKs1yvoXxUyn1O/s
         YQJG2M96rtuQ68JY771L2m4pbV7xtAkgN/QnI192D0NPCPAkBXCXsQe3sbPFA7uz5lNV
         oYjNGPvIWwT7KVeBqv2mDHNP0sGP4xmOLTNcAclQ3OOgNUjk9OSYM1ySZH7UYqJWBOP4
         DAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsRfSaim7oF97knZ/li5hmGIZL31exGO0KpXeT6AtwM=;
        b=ZddlxSJFzjRw4wNKG6F/Fmah05rfcVNywXoipmXLlz7kwUAHx0Pn/ciCdBWHNlBn6m
         Su4uOJzv6d74MsIwpf51vQA08fTeXW2k4+9necaUyPEWfBLJ4oAVplEueWFaqdVPFBG1
         han1Rt34fAPQT3SZReSp4DH9wMeGeAyKTbMcG3le7gzEXqNiKZBJ2Zl+11oOHIu37E1A
         +uygXUEIsojWyCQIM+47Uf4X1877zP4GUf+OSzXSHngQf0DD1NdpOLKtl5X7bnHQJVyG
         wCC7xVM97R5acSLXMW3G/7TIDOneReggPqoVC8ydOUx+oEZtmSzYSJeK12UcfiMBM1qG
         TgsA==
X-Gm-Message-State: APjAAAWTtJGnn5d/862kUK8XBcnyHlpyCJ7Da3zsKv//Akl14lyLJ2NZ
        I9giL+nNaKastvU75flAqbG3lBUs
X-Google-Smtp-Source: APXvYqzSj9HuN+GtJCYHTpO3emjZjonTxhC/qA0PRjHENRSoDt2ljQFZAAe7FbHnQtfYH37s8oOyKA==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr2258902pff.152.1554332930584;
        Wed, 03 Apr 2019 16:08:50 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id a7sm23439574pfc.45.2019.04.03.16.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 16:08:49 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [Patch net v2 3/3] bluetooth: validate HCI_EV_CMD_COMPLETE packet carefully
Date:   Wed,  3 Apr 2019 16:08:35 -0700
Message-Id: <20190403230835.1174-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Similarly, we need to check skb->data boundary for
HCI_EV_CMD_COMPLETE event too.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/bluetooth/hci_event.c | 258 +++++++++++++++++++++++++++++++-------
 1 file changed, 215 insertions(+), 43 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 31aef14dd838..63e14c49f617 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -100,9 +100,13 @@ static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev,
 
 static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_role_discovery *rp = (void *) skb->data;
+	struct hci_rp_role_discovery *rp;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -119,9 +123,13 @@ static void hci_cc_role_discovery(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_link_policy *rp = (void *) skb->data;
+	struct hci_rp_read_link_policy *rp;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -138,10 +146,14 @@ static void hci_cc_read_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_write_link_policy *rp = (void *) skb->data;
+	struct hci_rp_write_link_policy *rp;
 	struct hci_conn *conn;
 	void *sent;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -163,7 +175,11 @@ static void hci_cc_write_link_policy(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_def_link_policy(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_def_link_policy *rp = (void *) skb->data;
+	struct hci_rp_read_def_link_policy *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -227,9 +243,13 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_stored_link_key *rp = (void *)skb->data;
+	struct hci_rp_read_stored_link_key *rp;
 	struct hci_cp_read_stored_link_key *sent;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_READ_STORED_LINK_KEY);
@@ -245,7 +265,11 @@ static void hci_cc_read_stored_link_key(struct hci_dev *hdev,
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_delete_stored_link_key *rp = (void *)skb->data;
+	struct hci_rp_delete_stored_link_key *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -281,7 +305,11 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_local_name *rp = (void *) skb->data;
+	struct hci_rp_read_local_name *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -381,7 +409,11 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_class_of_dev *rp = (void *) skb->data;
+	struct hci_rp_read_class_of_dev *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -418,9 +450,13 @@ static void hci_cc_write_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_voice_setting *rp = (void *) skb->data;
+	struct hci_rp_read_voice_setting *rp;
 	__u16 setting;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -471,7 +507,11 @@ static void hci_cc_write_voice_setting(struct hci_dev *hdev,
 static void hci_cc_read_num_supported_iac(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_read_num_supported_iac *rp = (void *) skb->data;
+	struct hci_rp_read_num_supported_iac *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -547,7 +587,11 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_local_version *rp = (void *) skb->data;
+	struct hci_rp_read_local_version *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -567,7 +611,11 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_local_commands(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_commands *rp = (void *) skb->data;
+	struct hci_rp_read_local_commands *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -582,7 +630,11 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 static void hci_cc_read_local_features(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_features *rp = (void *) skb->data;
+	struct hci_rp_read_local_features *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -632,7 +684,11 @@ static void hci_cc_read_local_features(struct hci_dev *hdev,
 static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_local_ext_features *rp = (void *) skb->data;
+	struct hci_rp_read_local_ext_features *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -649,7 +705,11 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_read_flow_control_mode *rp = (void *) skb->data;
+	struct hci_rp_read_flow_control_mode *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -661,7 +721,11 @@ static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_buffer_size *rp = (void *) skb->data;
+	struct hci_rp_read_buffer_size *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -687,7 +751,11 @@ static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_bd_addr *rp = (void *) skb->data;
+	struct hci_rp_read_bd_addr *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -704,7 +772,11 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_page_scan_activity(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_page_scan_activity *rp = (void *) skb->data;
+	struct hci_rp_read_page_scan_activity *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -739,7 +811,11 @@ static void hci_cc_write_page_scan_activity(struct hci_dev *hdev,
 static void hci_cc_read_page_scan_type(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_page_scan_type *rp = (void *) skb->data;
+	struct hci_rp_read_page_scan_type *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -769,7 +845,11 @@ static void hci_cc_write_page_scan_type(struct hci_dev *hdev,
 static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_read_data_block_size *rp = (void *) skb->data;
+	struct hci_rp_read_data_block_size *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -824,7 +904,11 @@ static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_amp_info *rp = (void *) skb->data;
+	struct hci_rp_read_local_amp_info *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -846,7 +930,11 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 					 struct sk_buff *skb)
 {
-	struct hci_rp_read_inq_rsp_tx_power *rp = (void *) skb->data;
+	struct hci_rp_read_inq_rsp_tx_power *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -858,10 +946,14 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 
 static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_pin_code_reply *rp = (void *) skb->data;
+	struct hci_rp_pin_code_reply *rp;
 	struct hci_cp_pin_code_reply *cp;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	hci_dev_lock(hdev);
@@ -886,7 +978,11 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_pin_code_neg_reply *rp = (void *) skb->data;
+	struct hci_rp_pin_code_neg_reply *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -902,7 +998,11 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_le_read_buffer_size *rp = (void *) skb->data;
+	struct hci_rp_le_read_buffer_size *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -920,7 +1020,11 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_le_read_local_features *rp = (void *) skb->data;
+	struct hci_rp_le_read_local_features *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -933,7 +1037,11 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_le_read_adv_tx_power *rp = (void *) skb->data;
+	struct hci_rp_le_read_adv_tx_power *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -945,7 +1053,11 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -961,7 +1073,11 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -976,7 +1092,11 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
 
 static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -992,7 +1112,11 @@ static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
-	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
+	struct hci_rp_user_confirm_reply *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1008,7 +1132,11 @@ static void hci_cc_user_passkey_neg_reply(struct hci_dev *hdev,
 static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
 				       struct sk_buff *skb)
 {
-	struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
+	struct hci_rp_read_local_oob_data *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 }
@@ -1016,7 +1144,11 @@ static void hci_cc_read_local_oob_data(struct hci_dev *hdev,
 static void hci_cc_read_local_oob_ext_data(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
+	struct hci_rp_read_local_oob_ext_data *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 }
@@ -1333,7 +1465,11 @@ static void hci_cc_le_set_ext_scan_enable(struct hci_dev *hdev,
 static void hci_cc_le_read_num_adv_sets(struct hci_dev *hdev,
 				      struct sk_buff *skb)
 {
-	struct hci_rp_le_read_num_supported_adv_sets *rp = (void *) skb->data;
+	struct hci_rp_le_read_num_supported_adv_sets *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x No of Adv sets %u", hdev->name, rp->status,
 	       rp->num_of_sets);
@@ -1347,7 +1483,11 @@ static void hci_cc_le_read_num_adv_sets(struct hci_dev *hdev,
 static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_le_read_white_list_size *rp = (void *) skb->data;
+	struct hci_rp_le_read_white_list_size *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
 
@@ -1411,7 +1551,11 @@ static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-	struct hci_rp_le_read_supported_states *rp = (void *) skb->data;
+	struct hci_rp_le_read_supported_states *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1424,7 +1568,11 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 static void hci_cc_le_read_def_data_len(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_le_read_def_data_len *rp = (void *) skb->data;
+	struct hci_rp_le_read_def_data_len *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1509,7 +1657,11 @@ static void hci_cc_le_clear_resolv_list(struct hci_dev *hdev,
 static void hci_cc_le_read_resolv_list_size(struct hci_dev *hdev,
 					   struct sk_buff *skb)
 {
-	struct hci_rp_le_read_resolv_list_size *rp = (void *) skb->data;
+	struct hci_rp_le_read_resolv_list_size *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x size %u", hdev->name, rp->status, rp->size);
 
@@ -1546,7 +1698,11 @@ static void hci_cc_le_set_addr_resolution_enable(struct hci_dev *hdev,
 static void hci_cc_le_read_max_data_len(struct hci_dev *hdev,
 					struct sk_buff *skb)
 {
-	struct hci_rp_le_read_max_data_len *rp = (void *) skb->data;
+	struct hci_rp_le_read_max_data_len *rp;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
@@ -1614,10 +1770,14 @@ static void hci_cc_set_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_le_set_ext_adv_params *rp = (void *) skb->data;
+	struct hci_rp_le_set_ext_adv_params *rp;
 	struct hci_cp_le_set_ext_adv_params *cp;
 	struct adv_info *adv_instance;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -1645,9 +1805,13 @@ static void hci_cc_set_ext_adv_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_rp_read_rssi *rp = (void *) skb->data;
+	struct hci_rp_read_rssi *rp;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -1665,9 +1829,13 @@ static void hci_cc_read_rssi(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_cp_read_tx_power *sent;
-	struct hci_rp_read_tx_power *rp = (void *) skb->data;
+	struct hci_rp_read_tx_power *rp;
 	struct hci_conn *conn;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*rp))))
+		return;
+	rp = (void *)skb->data;
+
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
@@ -3108,7 +3276,11 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 				 hci_req_complete_t *req_complete,
 				 hci_req_complete_skb_t *req_complete_skb)
 {
-	struct hci_ev_cmd_complete *ev = (void *) skb->data;
+	struct hci_ev_cmd_complete *ev;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ev) + 1)))
+		return;
+	ev = (void *)skb->data;
 
 	*opcode = __le16_to_cpu(ev->opcode);
 	*status = skb->data[sizeof(*ev)];
-- 
2.20.1

