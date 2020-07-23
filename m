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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C82C433EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A94120768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qal8nDsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGWMf3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMf3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 08:35:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0CC0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so2507329ple.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6RSAZAZCD/2zvtqQwxc8kimw5YBb8FQUpkwthAppgoM=;
        b=qal8nDsq0om4u2aaDE6pcQwPdv763EX+ngNdNXdmJc/QkMTCc4pM3LoKF2mUiPaav8
         4TfWVAAnVYwmrKRrYWcLAo8LQum3tq1iq8cOt0SgpntLPpz4g/t86iO5QXTasYYUrEK2
         WZKpCQvaJgwShVkNlilQBh/mQSIjVHEkYnSi858k81NGVYECAfmTASzCJRd0unb6Pn1B
         7QCKT+nNCRNO3tvKkypFdBhYDDZoqr0cT3UG9hOZJzpF8++19hIIV0XJU/einrC8iv9F
         oSQfUM2Dg6zAfOGJ0ralWP8prXhi4IsXpmwuTabYHmC52WVki0u8wMHxh014pk/2t+R+
         wlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6RSAZAZCD/2zvtqQwxc8kimw5YBb8FQUpkwthAppgoM=;
        b=AwYc16AyqNs4IDscbTIs68w3oGUbKQyi4FrFZKx28BX3/ADwXcOt9xC+9dINc19hjS
         LchmpVLM5oFBXgflWrSY2a7+iVk5oUgjckbg8BVxNeZXMM9DKEyG5fg0U/0kWOz3xCly
         lrF0V3sbPHs7S1c1ogY4EweaBCGQk2v43RSsX0t/C86zhUiKHJwvROLnI5S93y/XnUd6
         Cg94jS0UOVcleDJdxsLhNAPvdw2xICDCxOsN3LSN4DvY4RJqXg70WM2N4KYFktwd3se8
         55FNs4DZVVgEfqNha4GhOWYfxmcylRFKNKK0Z+hGCsrvuyWogrsXv9mS9qPoSiKS59xo
         hcmA==
X-Gm-Message-State: AOAM531pMBFFGkuBkleoqFrfl5YgAVk/etQfotVsP4jDqVS0C+YyTSSx
        O4ekQK+u9OaOEZqQV1FoerjeHAkBqUppCw==
X-Google-Smtp-Source: ABdhPJz78QFN8ZkZLfp1Cze+RNjKlr4DkYy2DTbdaRcpSPZSVg8EMVaPbRHDUqt146KMLZ18i7hYJg==
X-Received: by 2002:a17:90a:7487:: with SMTP id p7mr178809pjk.233.1595507728801;
        Thu, 23 Jul 2020 05:35:28 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id z11sm2849823pfr.71.2020.07.23.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:35:28 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 5/8] Bluetooth: Let controller creates RPA during le create conn
Date:   Thu, 23 Jul 2020 18:09:00 +0530
Message-Id: <20200723123903.29337-5-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723123903.29337-1-sathish.narasimman@intel.com>
References: <20200723123903.29337-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When address resolution is enabled and set_privacy is enabled let's
use own address type as 0x03

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_request.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 85de1f356610..e48f0945a417 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2242,7 +2242,13 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	if (use_rpa) {
 		int to;
 
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		/* If Controller supports LL Privacy use own address type is
+		 * 0x03
+		 */
+		if (use_ll_privacy(hdev))
+			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
+		else
+			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
 		    !bacmp(&hdev->random_addr, &hdev->rpa))
-- 
2.17.1

