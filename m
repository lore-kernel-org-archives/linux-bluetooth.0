Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE11C433E8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C372068F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opUp1mgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgGMGI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGI6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B686C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so5525810pfn.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f1oHIKp+Xl1MtDR3jCF7Dp+Qm8VEDoGCEovuZWBlKwk=;
        b=opUp1mgiqEffoAGAiGzfX0j/sMLfLwQUNb1w+FbqcvexS5XvmotvlAln4jxDZDQ1kw
         2IaVtk+P5h/AdjOEenkbm3sj9xOGPuKfHjcDOyuYJaO7SZRTGUyyjzfXegaJpKgTYcEB
         R6pddPdBPKJ+NsSyRzyBJsjoyvRRvVLsSHCwCEdfSWhS6uVBeUuIvRdODgTekF4ikSh2
         7mTg5CkG/2zG7LrqvXkWQysgcpaOEKjrP5H6S0iTh2gXg0qnuW60OwReogjkDL4aw8Dp
         IBhgQMLqyjX4M+iy7vIJOq4oD7s8kVQSfsJGhRHDlrM672Dt974H8LkvVfpNfHVY1WaN
         Sz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f1oHIKp+Xl1MtDR3jCF7Dp+Qm8VEDoGCEovuZWBlKwk=;
        b=ZzPsSWgyxlQ+2AtwgQ2YumV4RCMSAe4VBbc1Qeh3HE7A5ybyxu8bNPxIHcHYn5mUph
         OK4j6Od3HcL5HFcqVXQNzu+UYD/+lly+SDW/hggB9QeTIohKQASf8I5xKafutExLWpvZ
         6jEvu6CU0QNyVoeAMcHfI7MCri7hV5HH6izOUmdGE7juXGg9Qx4jnfO+RYGMuAc6P7pE
         WeM9AqVqw3Au8B9r4Q5RFzcIO6/4hkByx1ZUH7wfVh4/sRGPHwqKoRxAabXm7H+CEF5V
         PNqLFsNbkUwjVbufh+RhiVptN0JcTooY9KQyr1OOWgcoM6Ca1G9bIfneXT88tpfHl617
         8v0w==
X-Gm-Message-State: AOAM531+38UmehCViCaAYBfuambuuRjHzck1OI2tJknZ1tfImsVhCxHE
        xL0/bZ8ZPHwPeDVr4dNj6ayJBUhLPZUxXw==
X-Google-Smtp-Source: ABdhPJyXcXuFvO1GAtWOvs49o5HbgXpUT38BhwxbIFeklm2RDU2fJuvAmp/ASIx6L1qNLBEmeBtW0Q==
X-Received: by 2002:a63:6cd:: with SMTP id 196mr67430676pgg.169.1594620537567;
        Sun, 12 Jul 2020 23:08:57 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id e5sm12787172pjy.26.2020.07.12.23.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:08:57 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 8/8] Bluetooth: Enable controller RPA resolution using Experimental feature
Date:   Mon, 13 Jul 2020 11:42:20 +0530
Message-Id: <20200713061220.3252-9-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713061220.3252-1-sathish.narasimman@intel.com>
References: <20200713061220.3252-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support to enable the use of RPA Address resolution
using expermental feature mgmt command.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   |  3 ++-
 net/bluetooth/hci_request.c |  6 +++--
 net/bluetooth/mgmt.c        | 52 +++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4ff2fc4498f3..cb284365b4c1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -307,6 +307,7 @@ enum {
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
 	HCI_LL_RPA_RESOLUTION,
+	HCI_ENABLE_RPA_RESOLUTION,
 	HCI_CMD_PENDING,
 	HCI_FORCE_NO_MITM,
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 684c68cb5c76..c8a5e1e4dba2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5222,7 +5222,8 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
 
-	if (use_ll_privacy(hdev) &&
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
+	    use_ll_privacy(hdev) &&
 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
 		hci_req_disable_address_resolution(hdev);
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c3193f7f9ff0..cb44b83539e6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -677,7 +677,8 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 	}
 
 	/* Disable address resolution */
-	if (use_ll_privacy(hdev) &&
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
+	    use_ll_privacy(hdev) &&
 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
 		__u8 enable = 0x00;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
@@ -870,7 +871,8 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		return;
 	}
 
-	if (use_ll_privacy(hdev) && addr_resolv) {
+	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
+	    use_ll_privacy(hdev) && addr_resolv) {
 		u8 enable = 0x01;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c292d5de4dc3..fbe02ab5fa05 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3759,6 +3759,12 @@ static const u8 simult_central_periph_uuid[16] = {
 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
 };
 
+/* 15c0a148-c273-11ea-b3de-0242ac130004 */
+static const u8 rpa_resolution_uuid[16] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
+	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
@@ -3795,6 +3801,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
+	if (hdev) {
+		if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION))
+			flags = BIT(0);
+		else
+			flags = 0;
+
+		memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
@@ -3895,6 +3912,41 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	if (!memcmp(cp->uuid, rpa_resolution_uuid, 16)) {
+		bool val;
+		int err;
+
+		/* Parameters are limited to a single octet */
+		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		/* Only boolean on/off is supported */
+		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
+			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
+					       MGMT_OP_SET_EXP_FEATURE,
+					       MGMT_STATUS_INVALID_PARAMS);
+
+		val = !!cp->param[0];
+
+		if (val)
+			hci_dev_set_flag(hdev, HCI_ENABLE_RPA_RESOLUTION);
+		else
+			hci_dev_clear_flag(hdev, HCI_ENABLE_RPA_RESOLUTION);
+
+		memcpy(rp.uuid, rpa_resolution_uuid, 16);
+		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
+
+		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
+
+		err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+					MGMT_OP_SET_EXP_FEATURE, 0,
+					&rp, sizeof(rp));
+
+		return err;
+	}
+
 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 			       MGMT_OP_SET_EXP_FEATURE,
 			       MGMT_STATUS_NOT_SUPPORTED);
-- 
2.17.1

