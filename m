Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8AAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B28C20674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at5OV/Ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgFCROW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCROV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2358C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so2146419pgm.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KNTecTNnvShK+jbDcWYwGt/NrIa6D+tmpxROB3vM6M8=;
        b=at5OV/Aphg1X15SJ6Eudv7cdLkdv7OEmmo396zQMsxOfwC/sWeS+XPG4o1UD0SzG6f
         o6Ukg+ZtxUln86oN8/N40G6gnwv0xDqRSHAn+kRg2JHsiL5dDDBFuDiEDMV2XJGgsCfu
         mYGTvXQBbgLWAlqgS2rSH8rmvtKjWoLjGVh9Yj6uKQQmz/IyQFUtyFfLeMd1FRfFV3mc
         iWdhW7r3GSeVXcaKl8wpsavS8HjBmJj5jsrdfsPqUxf7SWZl3Kl2ruS9Cwv4ZHK8kcWa
         7RnFZLGn0Hn7iorgCT8l4sPvH6YgTQjsjW73IE2j7iJF3X+nsx3b2A0Zf6VdDSqOZMu5
         5E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KNTecTNnvShK+jbDcWYwGt/NrIa6D+tmpxROB3vM6M8=;
        b=F2Y72uy7ZSbUHkELxCnWqJuO2yyJxr8T/alTwy8oQ+tJToYiVm/Vo9kc7EXdip6zli
         GNarDLAPIWy/XEJnFazTd4ckujrZosFodYbnl+QlK7j8C+1U1Qc8MiUQJNVqGVr3mYur
         nIqpDQ8CIgTVYIhQizdNbBfiCIb1+3/RrjcEXXlw2bXQdphokUcIqmkvpS71ThvV49PN
         81tWIcP9RqyLobIlY/cJBb+in+LhUwThCbiT1vThu3/hsFQNGicXMck+DhTJhIDX6AP6
         UwOGtFocAorZkAqnPt8m7pwdNJexdg0Skdbq0fDU+UeGZ5kss1AWOBcM5TFA4OKCrOYH
         0TTg==
X-Gm-Message-State: AOAM530YwzG1DRhytowvGEAL0ESroe2P+DS2nzXkOzvhuJtUOrCaYKJh
        6Dpp/rKzC/Ypy38Siaq2cD0/0NKBhbA=
X-Google-Smtp-Source: ABdhPJzPrAn/CfCdGQdubXhoEHCkt0WT4eBfzj6FiObTSH+o1CLa/41tC0gU1QARYqsZ3WqDXKDR8w==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr883420pjq.73.1591204460934;
        Wed, 03 Jun 2020 10:14:20 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:20 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 3/7] Bluetooth: Update resolving list when updating whitelist
Date:   Wed,  3 Jun 2020 22:47:09 +0530
Message-Id: <20200603171713.9882-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
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
index 1d885ccd5419..bcd64dec9989 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -695,6 +695,21 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
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
@@ -715,7 +730,7 @@ static int add_to_white_list(struct hci_request *req,
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

