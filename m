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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC4DC433EB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1752065F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgQsTLPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGMGSs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGSs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC915C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f2so5062069plr.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nCVTz/TW1C8kDWW89hWnxqM0hLVoG7bmfidmPtnLD50=;
        b=JgQsTLPhaOkj5WpKoQTBdC0hd15AEi3eR+BAxFwUa4FmUr1K13f7vAo8cR24V3CVxj
         UDjufzkeTE4vvM3swvHZvaTQsl+RL6xv0wfxkEX7+SNWlwqVBImvISzRrJ1Gscr92Rl+
         VF40S6A8c054Ys2CTDO92263itje5gqOq4gq+RLiM8RtWbkenJuk5Of27Q2jsDxblaE7
         McxjtkYnb7AO+rFmlxaPAkzed2Drba4KdGI0FBOFMaLTWpxZbRjXN0NCou3BXMI+60uR
         PKo7CdzwnMTo1WXwtM82ak+pMzYTTnL5chGciLPTbzGtxL8AaLaabMa1AU4BS/Fq4jYe
         SA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nCVTz/TW1C8kDWW89hWnxqM0hLVoG7bmfidmPtnLD50=;
        b=WN4a+rIoRzs8GLtbsvxn9oJXGDnkXpb2WH8iC4iVmshctDegG/7p8wRsYd1unyjAYl
         rDjVbJD/zdihy31ZcAsiuZ6Ir6yF1OKWufDpDgmsXohB2LaMxxwzvhoXo7XxEfML2/Ux
         OzelOW/sNpPCpPrSMPtpOaDdMlPvR77lbDmzqfFt+piMkdTE5lOdRYu5T5QBC8akjP09
         5sRPujto/tGsR2cfgR3XGvnIhqcwE8PWANPLmTFDpaNaK/vfBEBfDsJEXg0eVrZSF0OL
         KCIKEOM0Yt5KdgMWIvS5EILeU9Nc0AJND/PCnZTVOHUi5fmdOFGkT8R64BaOt2th8w4X
         6PjA==
X-Gm-Message-State: AOAM532DYR6jLJXhPn/2pjs+gmXi1/d0NisPWuQD7eikomfk01+h/Vu3
        Yeq5HPyByHonrZODGZ1+2dfayhJOre29AA==
X-Google-Smtp-Source: ABdhPJz2kM9OG9o0jmvaS+BzXUTQcpngBKNaoIG2RfbaTjGsVy3WXY4bHWEIewCHLVYcD30xRVDWYA==
X-Received: by 2002:a17:90a:1d06:: with SMTP id c6mr19291143pjd.194.1594621127375;
        Sun, 12 Jul 2020 23:18:47 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:46 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 5/8] Bluetooth: Let controller creates RPA during le create conn
Date:   Mon, 13 Jul 2020 11:52:10 +0530
Message-Id: <20200713062213.3692-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
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
index 2dc00604412c..e16d5154b2cf 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2201,7 +2201,13 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
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

