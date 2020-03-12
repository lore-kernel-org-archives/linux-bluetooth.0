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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E645C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9C4206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 10:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpoWLV81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCLKHS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:07:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41737 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLKHS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 06:07:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so3023146pfz.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WEssHPdmc+CHUX/J9svOx4jP0pCE2+tppJ8olfTleQM=;
        b=qpoWLV81qW2rMTAtb/JdQk5gDvpAAFkaURhKCNhCgEhSq6rDaf/0BYz5U9PB4XG9Rc
         TKITRI8R0Yj4w3td0YabE7JrZMSLdyE2S+Sh3dpKTmSWXNuv7IEVkyZeAVY4Qi6cAVKY
         tStB8dvV5sz2vtdX7QNcPLdnZH7aBrtA/I+nAX91jedSkxv1CWu4M5m1XUpkkDtbNKac
         K0XsU6zBsDd6MBT7MUiZ2vnCOASH+XLUE87DfFvV6444cZOjMrrYhK1qgEs8ElX4B5hm
         N5NgEOxBJ++iY1Jdbnq/5mnvMuj97EN/Un+NtPPcS6wJkesJkt4tgzxDgNST/LJnraHR
         ooXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WEssHPdmc+CHUX/J9svOx4jP0pCE2+tppJ8olfTleQM=;
        b=Nd+ucwx+v4eyD+l7GYV1pGINZKmvEXrgVsohSohluqFDfFfcssXfX8ixa0KQ3G/umS
         pYeVxC5VNrI3g749p+3Iw0VSlOhHBgDDETQKGN6YOorDAUQfPl7+xT1rDQuG9wZVQmkD
         W2NHu6fp7ej1Bwn9evkT8XYftzjypjqA7H9lPAWkuANE+rashwsrVBRaxACO6HcgoYyj
         FDOG3qEOZe3w174LZ53VxB7osI9eEJkA7Q1QyIk3vK4HkTDQg77IEwrU+bGytA0P5HEV
         0SbPKXBmV1Lr+F0tWJG7k8BkaelfkL/E++CUnwMywu7rMuHl9AnPNLetJNjO4HGuKXM0
         n58g==
X-Gm-Message-State: ANhLgQ26foEnmROzn3Y2fSE/Kyaa15vRgmF4pGWxaZYdR/V6Gu671BjW
        VLgbgComD1AP8gUGv38e3z15oHXu1vL1ZA==
X-Google-Smtp-Source: ADFU+vsFeH6BJ/hJhMrE2LaFWr11OZIO66iMMHFEWjUiE9MHIaZ8tqxui9+WBuGrFCLwr1iMaiGPqQ==
X-Received: by 2002:a63:e007:: with SMTP id e7mr6982851pgh.414.1584007636397;
        Thu, 12 Mar 2020 03:07:16 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id e9sm10578295pfl.179.2020.03.12.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:07:15 -0700 (PDT)
From:   Sathish Narsimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narsimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Cc:     chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH 7/7] Bluetooth LL Privacy update White list
Date:   Thu, 12 Mar 2020 15:37:54 +0530
Message-Id: <20200312100754.3445-8-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312100754.3445-1-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update white list filter policy of if LL Privacy is enabled
When Address Resolution is enabled and device is already in the white
list then follow the filter policy

Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_request.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 12868caf50ea..47cb2602713a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -711,7 +711,16 @@ static int add_to_white_list(struct hci_request *req,
 	/* White list can not be used with RPAs */
 	if (!allow_rpa &&
 	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
-		return -1;
+		/* White list can not be used with RPAs if address
+		 * resolution is disabled in the controller
+		 */
+		if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+			return -1;
+
+		/* if  the peer device is not present in the resolving list */
+		if (!hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, &b->bdaddr,
+						     b->bdaddr_type))
+			return -1;
 	}
 
 	/* During suspend, only wakeable devices can be in whitelist */
@@ -768,7 +777,16 @@ static u8 update_white_list(struct hci_request *req)
 		/* White list can not be used with RPAs */
 		if (!allow_rpa &&
 		    hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
-			return 0x00;
+			/* White list can not be used with RPAs if address
+			 * resolution is disabled in the controller
+			 */
+			if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+				return 0x00;
+
+			/* if  the peer device is not present in the resolving list */
+			if (!hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, &b->bdaddr,
+							     b->bdaddr_type))
+				return 0x00;
 		}
 
 		num_entries++;
-- 
2.17.1

