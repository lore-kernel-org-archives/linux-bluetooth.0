Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33130C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125242073E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/GL13uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgGAKBO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0B7C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so4272750pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AmvPW4v1t8mYI78mS127zBVBOMVhLn3jVVhr+y7gx+4=;
        b=J/GL13uO37fsfo/YLPOhh6CluFhyg3ONCqjCal+Y127YZd95FXn/NnfZk6goc8iczP
         iZeaM1PlJQaHxhhHqcdouA9hOPPIqt1jQQT/SB2pUAY2El8obZYHelzhQ1L1YBm0k8UE
         5Fe1iD/jMx8qwxttwd8YU6ll37AzWaTNcUgn5Am/0oZqB2HIwbWnwQ+2mpVZOJ8+Z8h/
         sgSpvn30RGQtFK/6Rtc7WAdsBlVqLK1zMFwFk0N03C35nMZGxoqOqxRAe7wawGf2DRmk
         O771KfW5wKekafGYw7IJ6H5IHcgfytCh2w8bYDM9OViuRTeUTi+mF+uljpIJQdcCP2Jb
         8Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AmvPW4v1t8mYI78mS127zBVBOMVhLn3jVVhr+y7gx+4=;
        b=hjEEyj5i1lvGQR6Vs8GMvsYMgdA3fJ+XyYeUjzwF4Xx7FsGBkEaNZUEMm+S/TfjEc1
         G0RkYGxuc/PqAdx6i++N96CyT4cEtZH3RKva2UcqolG3amxPQw17bJ7LSu9RDpIQ/cva
         QuBxDoXq8qMGJk68vMhZsIj3mHMBCCTOzp85NrGkcYrtyAssMPuLgOSXmoTel7/M9xOK
         Tqf3Wkzm5cY5C+MnDbhNXBDXoXovCdtWxhjZ1nAVnj8W+UA3j/0azCYb//q/XU/f8XVH
         1HE+tLAsoohQd3vAaZiyLj6HQDvE0L9hbwWqWGryos79oS3R8lqKbU66qUgcrV9Kpues
         Ip5g==
X-Gm-Message-State: AOAM532qJS9QKo7q3UVm6L0OwfNz0hjNFF/p+5XYAqBNaYsntu6VbNdc
        KMhSJdOwrMlhnHcyPQZaL9TaTEqzM62Cqg==
X-Google-Smtp-Source: ABdhPJxuYu3xiadLfkFpoOWQ+teaogD4zTLxCsfxU++1RMK3odcmqoIrm32A7ONexAhHcjHYyDVODA==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr5705538plr.152.1593597673438;
        Wed, 01 Jul 2020 03:01:13 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:13 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 3/8] Bluetooth: Update resolving list when updating whitelist
Date:   Wed,  1 Jul 2020 15:34:27 +0530
Message-Id: <20200701100432.28038-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
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
index 5978f9177b3d..622016287628 100644
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

