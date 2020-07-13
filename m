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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F386C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E535E207BC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7r1+2ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgGMGSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGSm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634FC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k5so5050557plk.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3K8YriwZsyJ0Zz+v0ZMtNGnBg6m3R1aaPPOtC++AWHM=;
        b=l7r1+2ibixy8apzMhAuVaOsq8w1ErNaDrFgvnQWRdtBPq6k2i9t41yo1oOtUz2ROHu
         OYNHQ02kojU884wfCU4H1ijFOYTIpXxrmFUD5wpFbE06ILkj8pNzrpd1iM34MDFiPQxw
         LtVAyGl2eIYC3uYdsIqeBZJ1wZtyjt10aRCQZoTdKt/HxqOEoP2Qtj74d9MJ2PuyWCpx
         xVK684TDkCCbC1I6pYVCS0fzI94eZpVzYWmLq5zX5aQKmPV8EwQrzQ9b8kSb6NsIS3sz
         XITkco4F1vKA3T6+OayCP4qg1C8gmALJHpbuRvUP3zhhUkU8welCJa2hbAM/5oY6I4jq
         L0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3K8YriwZsyJ0Zz+v0ZMtNGnBg6m3R1aaPPOtC++AWHM=;
        b=dBDJl8jVE07omojxl2EegmDaxtFG/YwcLPaXzAjKn1bxLzv2CKX3RS6Zu+sGDfApx0
         j3ytRaEUwL0VuquWCxScIevcwCy0/m5CbpEkCTooMH+8Zl9U1tD7nzUCHrghYRnTgCqn
         +Z8pkDbPZUc1N6yeV8DjWBmpFcKu7JZRk3aVoPtIFeW+zJwlvUBnkTSG0I80X+G0Sn3e
         Kdt+tPIUb80ioJezTwXvT3JkijoYrxOnmB7zYATQ+OI2JKtv1oJ6zzabN7Rf9tR7uCod
         ofpUDZ1y8jAuLbid85smU7zX+lFl5h9j6ILXQ2QHZTnxzN+AncYo28mgx4C9dZ2Qk6XZ
         dLzA==
X-Gm-Message-State: AOAM530fBqHJGMG23N0cXe0h3R40Qc4wTVYa67w7Nm4su03hcI3sYX6m
        59G4IGdy06Ob2IEn7JRL6iYtAnOvIAxHWw==
X-Google-Smtp-Source: ABdhPJyLJ7HNm2uwWsfCO2XXgDAfyFxkE51/JUsXzkLqYj5npPSEIpp1cWTMx+UtuKQ37Dpev0oydA==
X-Received: by 2002:a17:90a:764c:: with SMTP id s12mr18481758pjl.201.1594621121796;
        Sun, 12 Jul 2020 23:18:41 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:41 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 3/8] Bluetooth: Update resolving list when updating whitelist
Date:   Mon, 13 Jul 2020 11:52:08 +0530
Message-Id: <20200713062213.3692-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
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
index d3c7ddbcff33..2dc00604412c 100644
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

