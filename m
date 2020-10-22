Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B551BC4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4806721481
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecEk3Tc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894780AbgJVIRd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443831AbgJVIRd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 04:17:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61FC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:17:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so482271pgr.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UZlh+fxUzLJ1uC8gQyD6EpRae37oweBPUkkyoUkVHCc=;
        b=ecEk3Tc4XWs5RquLUKkANziqC7VUDXd1li/jCNK9fo5EdLHHBiDDuMiyGuyCunL83e
         R/eRK6RHiIfuDkllbuyUatRHMFuwUpErwt6tF30ehYBm/W6M8OBevI1wpetGMbBFIRUT
         +2HT4otu3G89KANrU1hJX/6MyFCo3woyqAn8JoIrrIhrN3blq04llqPf7WcPnPXD4gv+
         iZtiMZPh0xOBHTzTCRr4dvqYbM7z3h3o4Un2k04k33hylkZK1lJswuI0KUKk6a5ekZMj
         KM0iAONMZYRMFj8rTfAlJ1BIFCC+VSy8MmluwJkeJBRSCwbNVcWqcZl6j4R2+ky5N56I
         7uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UZlh+fxUzLJ1uC8gQyD6EpRae37oweBPUkkyoUkVHCc=;
        b=HAEFI2iTuI6yeohXARHxVpVPiUDZSs6NwIyGMW/M6e+UyW4Y24VVXNynVKAvGLYktn
         sI7x//fWUxvtn9DmiHVMxN3DEUyy249+EuR8anHn8y7oOcd4zNHMgfjYWxDAjADbQnal
         4Y9EB3FlHBsr6ulxP6oIL+U1cgGlw2ZnUf225EXY0hZSzoFGmRwwIJrbK2cgBbgrsBno
         tE1O4+9zUFYHHb3a1of/wlOjG70aGptiGhMXZpUuF3jES5Vya4M+GMWSp2mO4lvrh3ux
         Y68gYnGJq2ffn1sY7aOpliPsz4LB1F07V6vAd5AqgAghc7AXtD2SKlzP9CndmHaW1dDP
         V0Lg==
X-Gm-Message-State: AOAM530kOUEFhhKTpmwegnU218aTa/2ZaXV+wqnevfNBpR8vIR4kOC94
        4qdhVkvvc2OPrRJ1wlk4n1iTp4pm+D5eCw==
X-Google-Smtp-Source: ABdhPJzRPeq1BDXYs/gFWVPa1RSp5qcJ8aIlowOz7xfmlt3LnNq4iXiMz/USkgXd1v8rOV6FUe1dKA==
X-Received: by 2002:a62:ee10:0:b029:142:2501:3972 with SMTP id e16-20020a62ee100000b029014225013972mr1313414pfi.55.1603354652521;
        Thu, 22 Oct 2020 01:17:32 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id n18sm1188235pff.129.2020.10.22.01.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:17:31 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: Fix: LL PRivacy BLE device fails to connect
Date:   Thu, 22 Oct 2020 13:53:04 +0530
Message-Id: <20201022082304.31757-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When adding device to white list the device is added to resolving list
also it has to be added only when HCI_ENABLE_LL_PRIVACY flag is set.
HCI_ENABLE_LL_PRIVACY flag has to be tested before adding/deleting devices
to resolving list. use_ll_privacy macro is used only to check if controller
supports LL_Privacy.

https://bugzilla.kernel.org/show_bug.cgi?id=209745

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

