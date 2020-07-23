Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C98AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6540A20825
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueAuxZRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgGWMfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMfX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 08:35:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB68C0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so3030343pgc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sagG6XzvqD+5UW5Prg99qLND7K39EzY9lxq7YJmMj5Q=;
        b=ueAuxZRVROtqPGEVGJ7NwIauUFNArra6i37gxwfBGbgcuMNiGOy+5bnZcqdjybOo4J
         0D9zDvFvG0Fx+ADL7PahKmUgNAoM0O8UFhuUKMrFAU0gDUPC/K8KU6s3xcpT7zs3D/kN
         IqhV3MttPce7B9zbdcbPOhQq/J/NM1wntvuoK2ZJuEx3rJH1L7cw9rhB5ks3JzUusTOh
         ZXGtlFpLKS5hfFGNnI3eEO1J3Pvm29NTjgSuvJ6rXHooZHDUj+RIYlcNATDd9qXlaNQY
         xzAAlU8SVVrPwUuezalsH+PNLmMS0kOBvkFnVtMVCviWUUXS4EftRj4dzkUte4mY4MGo
         T9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sagG6XzvqD+5UW5Prg99qLND7K39EzY9lxq7YJmMj5Q=;
        b=fvkDjM6F3020WNfh5eimWLuhkwFAVvxmnx6WpT+OqOcaT75nclQ3dOS2MqAKBOBA6E
         +5RJwRIDFyiAoiuuSn1fxQDt0nBDLlrGXxNghHZVr2O4O4M9hQgPi7WLyhUifxC91KqL
         e7IQoHABVF0y63WN1LtJxxVVaA5fMhL3CCIAwXqvI0z/LEXL1aHMOMbyvGCxfwRqUyzw
         aaT1mwfSi1/CvxsfOs1HWfzgri80pxvyhQWiUi+v2LPJORMKM8jUSLUYfWTVzlEqC2kc
         W6oQUElWK0MCD1upg9as3jRVIaYVIcof6ynZuahKew2BQ8tXlqwtYoBluNjhIZ6RVAaT
         dAOg==
X-Gm-Message-State: AOAM530w2AMPlixRfDbBHBPj9bQDOLeAm+Bi1kAwQ4XZCN0hRWDYMH9N
        OgNWyTTzkM+8e+5NMaqJ5ZqdiXHedtkbsQ==
X-Google-Smtp-Source: ABdhPJzbyaP61Sycn73zd2NzweTw9CHvEnFjTM1VPt6jA5L0jfMPrkgJZeh/z8ja/wrYHLgih2cNKw==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr4001072pfd.159.1595507723125;
        Thu, 23 Jul 2020 05:35:23 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id z11sm2849823pfr.71.2020.07.23.05.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:35:22 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 3/8] Bluetooth: Update resolving list when updating whitelist
Date:   Thu, 23 Jul 2020 18:08:58 +0530
Message-Id: <20200723123903.29337-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723123903.29337-1-sathish.narasimman@intel.com>
References: <20200723123903.29337-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

When the whitelist is updated, then also update the entries of the
resolving list for devices where IRKs are available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_request.c | 41 +++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7d0ba53ffed0..85de1f356610 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -694,6 +694,21 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
 	bt_dev_dbg(req->hdev, "Remove %pMR (0x%x) from whitelist", &cp.bdaddr,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
+
+	if (use_ll_privacy(req->hdev)) {
+		struct smp_irk *irk;
+
+		irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
+		if (irk) {
+			struct hci_cp_le_del_from_resolv_list cp;
+
+			cp.bdaddr_type = bdaddr_type;
+			bacpy(&cp.bdaddr, bdaddr);
+
+			hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
+				    sizeof(cp), &cp);
+		}
+	}
 }
 
 /* Adds connection to white list if needed. On error, returns -1. */
@@ -714,7 +729,7 @@ static int add_to_white_list(struct hci_request *req,
 		return -1;
 
 	/* White list can not be used with RPAs */
-	if (!allow_rpa &&
+	if (!allow_rpa && !use_ll_privacy(hdev) &&
 	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
 		return -1;
 	}
@@ -732,6 +747,28 @@ static int add_to_white_list(struct hci_request *req,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
 
+	if (use_ll_privacy(hdev)) {
+		struct smp_irk *irk;
+
+		irk = hci_find_irk_by_addr(hdev, &params->addr,
+					   params->addr_type);
+		if (irk) {
+			struct hci_cp_le_add_to_resolv_list cp;
+
+			cp.bdaddr_type = params->addr_type;
+			bacpy(&cp.bdaddr, &params->addr);
+			memcpy(cp.peer_irk, irk->val, 16);
+
+			if (hci_dev_test_flag(hdev, HCI_PRIVACY))
+				memcpy(cp.local_irk, hdev->irk, 16);
+			else
+				memset(cp.local_irk, 0, 16);
+
+			hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST,
+				    sizeof(cp), &cp);
+		}
+	}
+
 	return 0;
 }
 
@@ -772,7 +809,7 @@ static u8 update_white_list(struct hci_request *req)
 		}
 
 		/* White list can not be used with RPAs */
-		if (!allow_rpa &&
+		if (!allow_rpa && !use_ll_privacy(hdev) &&
 		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
 			return 0x00;
 		}
-- 
2.17.1

