Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565D4C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3488A20724
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGCg1l8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCLKHJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:07:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42112 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLKHJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:07:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id x2so2658266pfn.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/zcprjgIRbmIdLFXtpyP+sMyaGODDY39obss3o04Ujs=;
        b=lGCg1l8EBg3FnK7janYyZR33tAcvBofsxkcmuXPnjXxDAr7eOpaeUavXH42YKF2t7b
         hyW5q+So302Sr+cM8urfVaBRpey++QaQkNL3J9TmxACHU9g1iYf+CUMUHnWxpIHXkxeS
         tU39tLklJ3WLBN7y1wxpBSF3Lq70zb1ygBtXOXaGhSXZ72KVixCpErdY5H4MHjoGTCNh
         pEUA87bSvBILBWdjUvnNQsulNWwBBP42Zxr5YqLsgw2nW7wd3sAGDBP/Ky5AiDwYnyW9
         gZ67XmGXQZgg42W8Laq03A/FZMFvwfmetnl7WnnryWqMQ7g6lE1MTVxisWLZcyoIcpn4
         x1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/zcprjgIRbmIdLFXtpyP+sMyaGODDY39obss3o04Ujs=;
        b=iKmuMvo3XypP+rzDtHpLlSH9G2utb9by2KPLdhIhIxq1ppa9tQ9Ebtvaxouag0WGWn
         GzXhA11JUfPxjkcts+ryNBQ1LAEU4Tvque7+ZA1dGmUn7KOj7zhYuLg6qqtwp7u0NK5c
         CXzkiROg8q0+U8/rO0IhEQ73uisu6OaLbtUbrCJxk8Xnc3qFGwsajdrYHc1kSBWjqtB6
         iF0q/NDF6bHEh3KLuXu/TVyaa1ERmTvSU0YyCh3tzqY1ENASZmukEvFlyrRuky4raKKm
         O88ZCzcOfI6z1ftQ8blv++wttpunlDTG7OacoUN7WEt/QtOlIlqwiQ6Ot6UuFMdIbDHk
         DcUw==
X-Gm-Message-State: ANhLgQ0TSyu7iX0cA98++v8Pz7mpePwmMKPSof5pf8HW4uWAtGyONOcL
        +CaaArvNF03bYhHgyxBd+57JuJUgLCjQFw==
X-Google-Smtp-Source: ADFU+vvDFfeNTPobROmpH0Buk1XHlAlsGdrlK7bkMhEeZRIiTn1pwGXeJGDk/x/dI1H+3YTM1IHelg==
X-Received: by 2002:a63:2cc3:: with SMTP id s186mr6866953pgs.71.1584007628485;
        Thu, 12 Mar 2020 03:07:08 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:07:08 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Subject: [PATCH 5/7] Bluetooth: LL Privacy Check and Update the Resolving List
Date:   Thu, 12 Mar 2020 15:37:52 +0530
Message-Id: <20200312100754.3445-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch is an helper function which will be usefull to check
the Local Resolving list and update the controller Resolving list
during le_create_conn , le_directed_adv.

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
Signed-off-by: Joy Shermin <shermin.joy@intel.com>
---
 net/bluetooth/hci_request.c | 21 +++++++++++++++++++++
 net/bluetooth/hci_request.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e17db3103a3d..6b685cdc7de5 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1015,6 +1015,27 @@ void hci_req_update_resolving_list_local_irk(struct hci_dev *hdev)
 	hci_req_run(&req, NULL);
 }
 
+void hci_req_check_and_update_resolving_list(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr)
+{
+	struct smp_irk *irk;
+
+	BT_DBG("");
+
+	/* Nothing to be done if LL privacy is not supported */
+	if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
+		return;
+
+	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
+	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	      hci_lookup_le_connect(hdev) ) )
+		return;
+
+	irk = hci_find_irk_by_addr(hdev, bdaddr, type);
+	if (irk)
+		hci_req_update_resolving_list(hdev, irk->addr_type, &irk->bdaddr, irk->val);
+}
+
 void hci_load_resolving_list (struct hci_dev *hdev)
 {
 	struct smp_irk *irk;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 0e81614d235e..92a71f35543b 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -90,6 +90,8 @@ void __hci_req_clear_ext_adv_sets(struct hci_request *req);
 int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 			   bool use_rpa, struct adv_info *adv_instance,
 			   u8 *own_addr_type, bdaddr_t *rand_addr);
+void hci_req_check_and_update_resolving_list(struct hci_dev *hdev, u8 addr_type,
+					     bdaddr_t *bdaddr);
 
 void __hci_req_update_class(struct hci_request *req);
 
-- 
2.17.1

