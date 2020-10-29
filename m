Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62014C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056D52076B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 07:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rwbh0bwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgJ2HnZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgJ2HnG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B552C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 00:43:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f21so900668plr.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ai82IumdM6vSuy+0h7CKxIsXNbX0OvBZ2DK13resGTY=;
        b=Rwbh0bwSAjeIvy2uZ5kttEgHA5Pi5jyepchcqNjREjjj8zKrFwnI50cr7x39V7NP5d
         nC3SQeOEiaf+NObwMC/cGL3kTMo3MuIBvQmrqGd6mFx9oiM9RR1HSnGIdH5Sr//MCS+j
         +mpPWq6jaiHKs5Q/4pldVOdQiHAkvge0TLleeH0jIYYg6YCy2UF5TxaEd1i8Rpx5xPlZ
         xO2NDD2Y+X+6Wvaqm8znHrskeWZSCWZc97UakOs/Ipl9Z6COL7TQ7VLczDouJoAjdLAA
         Wk6ogWNSgKhTDbiH9wMjd9/Mp+8nag6yOP6RX4hoiNhRl4S6naoZOYJBBmVk4LBb1w4s
         wLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ai82IumdM6vSuy+0h7CKxIsXNbX0OvBZ2DK13resGTY=;
        b=idv7ZmPxYZU1Bh6NUIZ+jAUznF8zf7ui8iOKkK/jnCphxUXu5pXI4r4qtCXpkIJFxt
         EzYjDdqX74dBCSxj/QvTXKsjM3X7zpYu0zHbuoX+HdRDgS/z216wPqefebD71OwDf6hH
         /Matu70MiqbMwZI10zB3IgfKtOiGOBccCF8s7s/DemQUzfa7tQC6UVXKsjZoExav4+6N
         GZIJX2M/ZIYREbiikj6gKzqASIjLvRDWKy3LUoOyhwaXCE6UvnePiG7hCLgVF3L9njGx
         ol/pQ4jfT/+YaR0gkP0t9BZRh5D0GiooLHAO46FuYy8ZqI/uCUbFmMjItcyazuZHf6ei
         nOzw==
X-Gm-Message-State: AOAM531tL2GkYf6WmoQMPsKnnbCtdnnLA32nrVg5M/D5bjC6ef5VPCwe
        LFlqT5CYSznpH+aNEKRh7wdwxzRMBEwUOXuv
X-Google-Smtp-Source: ABdhPJzR0v/JE2Fb0w5eOmpFlpCcDUzeAxjCJfr9srtRjJy0uzZLggy11iBqS8eCcnJZZEB5IzzNFA==
X-Received: by 2002:a17:902:704b:b029:d3:eca2:d221 with SMTP id h11-20020a170902704bb02900d3eca2d221mr2918412plt.74.1603957384909;
        Thu, 29 Oct 2020 00:43:04 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id x29sm1846565pfp.152.2020.10.29.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:43:04 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
Date:   Thu, 29 Oct 2020 13:18:21 +0530
Message-Id: <20201029074821.29950-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When adding device to white list the device is added to resolving list
also. It has to be added only when HCI_ENABLE_LL_PRIVACY flag is set.
HCI_ENABLE_LL_PRIVACY flag has to be tested before adding/deleting devices
to resolving list. use_ll_privacy macro is used only to check if controller
supports LL_Privacy.

https://bugzilla.kernel.org/show_bug.cgi?id=209745

Fixes: 0eee35bdfa3b ("Bluetooth: Update resolving list when updating whitelist")

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_request.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 6f12bab4d2fa..610ed0817bd7 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -698,7 +698,8 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
 
-	if (use_ll_privacy(req->hdev)) {
+	if (use_ll_privacy(req->hdev) &&
+	    hci_dev_test_flag(req->hdev, HCI_ENABLE_LL_PRIVACY)) {
 		struct smp_irk *irk;
 
 		irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
@@ -732,7 +733,8 @@ static int add_to_white_list(struct hci_request *req,
 		return -1;
 
 	/* White list can not be used with RPAs */
-	if (!allow_rpa && !use_ll_privacy(hdev) &&
+	if (!allow_rpa &&
+	    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
 	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
 		return -1;
 	}
@@ -750,7 +752,8 @@ static int add_to_white_list(struct hci_request *req,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
 
-	if (use_ll_privacy(hdev)) {
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
 		struct smp_irk *irk;
 
 		irk = hci_find_irk_by_addr(hdev, &params->addr,
@@ -812,7 +815,8 @@ static u8 update_white_list(struct hci_request *req)
 		}
 
 		/* White list can not be used with RPAs */
-		if (!allow_rpa && !use_ll_privacy(hdev) &&
+		if (!allow_rpa &&
+		    !hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
 		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
 			return 0x00;
 		}
-- 
2.17.1

