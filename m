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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DDFC433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE6C2075F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtgT0v66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgGMGIn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGIm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAE6C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k5so5040059plk.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3K8YriwZsyJ0Zz+v0ZMtNGnBg6m3R1aaPPOtC++AWHM=;
        b=OtgT0v669yyJ67928LZrReEFlyAUhdBrmf6BniYd3jo8P42mHDNHsjwP9g6Hfb+z6V
         /OswKBRefzMpfj+fzkP++Qwq0HBxSvzW+DgNnYUlhyhxbYZRbqyltWnTM2eLQBoZXDqn
         sS2W8ygJO2LqjdXwfAUu0BHN1Wn7EJcsgPao/rttJ92wOFGlKCpRXvOR8eFyrZ9hEzoO
         hfEfLz4xDhPetRLjchOlUV+NTPUMsjwL++uePtOc8l3StkoQdN/iifL5cehhUHdnbcZj
         EIY+6ZdtDdKa41CO+49eacDEUlfBPaI+PRYvpqovKUJWuqcKDEmM98vCXcoLb88+q5WH
         bG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3K8YriwZsyJ0Zz+v0ZMtNGnBg6m3R1aaPPOtC++AWHM=;
        b=Q5H9fDVA1XcfWeyRtCvGF4lTv0+QDKku90z5t5SEMiLs/xJURv0Vs6O0sm6Y4xSCZy
         R7ApMEFBOFIO2IuRdq6EOAi1QfxizzB04mwUHQ+R96Bxl8d8wR1QGiXUALfcgGvvFBK1
         CGtOPiKqzrns9ReHZ6/M1YlhqhVkXqLn9G4fSvuLz01YD6VewD8sv93UQxl156W3Ol97
         L3rSM4uY8d4MVZDS2Ol0ZyfQsDoKj/hsLhWRpFxA9HdKhIFrRYehFZtsc04SUkPWS8B8
         tNCDNMaDRlK+x9GdkxpiiPxW0V4p5Xpk+KEyaSyfyGBscb5EwHPIRENBtx/a6wNo8B+k
         eqhw==
X-Gm-Message-State: AOAM532D7Q/IlORqkmf/ksAr5lh6HxxbXL0nd2AznSRCAYp+qXsso6O7
        Q5MyFhk/tDLJar+maD29bRlWdrqFdBdjUg==
X-Google-Smtp-Source: ABdhPJxqmaDnD9WQSziZUjlE86gBRjb9rxh79IXSexxrC3EL9cB0KVOxhLcwNieGFYMBHDM+AKUrvA==
X-Received: by 2002:a17:90a:d086:: with SMTP id k6mr4616498pju.171.1594620522122;
        Sun, 12 Jul 2020 23:08:42 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id e5sm12787172pjy.26.2020.07.12.23.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:08:41 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH 3/8] Bluetooth: Update resolving list when updating whitelist
Date:   Mon, 13 Jul 2020 11:42:15 +0530
Message-Id: <20200713061220.3252-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713061220.3252-1-sathish.narasimman@intel.com>
References: <20200713061220.3252-1-sathish.narasimman@intel.com>
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

