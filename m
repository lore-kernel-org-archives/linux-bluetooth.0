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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB92C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8452073E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG4tVNAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgGAKBV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D199C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so9711636plo.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZfCBwWzszt0wp19IOQjQbWYB7ZUb16MS4aRNucJyhyI=;
        b=PG4tVNAmrYY6eQRIYWaffh3ohZNEpAr/1AHTsZTtAefCoamTRGLx1MM7XVIQcOBLfr
         vQdLmfN6Dyre2fXtb9+SuCWxUY+uDNPoZxhtdGKNVkkujDlZNSyLgsul6k6sC7nVcImV
         dIBtGFBw/ebHd7klghTjkGudMbAPIJilsLqnlA7UxhdMBsD4dI4cyfBDqb5H/LYpqQEW
         y3fCZWQZ8o67UqdKjEW3hjshjFaC4Gklxu3OnVpWC4JAQkZ0FqrRsj3o2LC/fM5F1tD8
         H0IBApfv8hzPef4jUvZwnkRKwBvqUXWLS4vFaX6AaUrwa4Ap0y/ODO7neL7sRgg2hlEE
         oNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZfCBwWzszt0wp19IOQjQbWYB7ZUb16MS4aRNucJyhyI=;
        b=DsnjCnu7cg0a/MUTkBsmwFdM89PYRu2MEuEXhcGlN27a+hTNjcwjKUZ14puNCq6zbr
         ThQ9G79JxMH7yLa8MYDbmv1z0ZY1tSExwpr7eA0xc29BUY7Myj1ysHNP8i4w7Ly8vcRm
         /ndfXj2abgChkYfihLV6qYjbAQ5JkQ3Uh7oiyUcIn8XVsHcUpsxFpmUHbt1OjHjgSc7n
         k72W2L2kujbOVOtAbN19ieM2Jgc9BEyYQ16hGfG9vC86d7y1P0brUUEfTNF+2elE03JP
         1shb8QqkMejWg0tYegXHoSxb1m/7G0FFsCkouDFosPBraKOwNFECsh8LfIijvcU+dG2T
         yUBQ==
X-Gm-Message-State: AOAM532FJTfwV8m+uBmM1Q2fTxNRbqu+wF27k39UIlpIrlq6FDecPiNP
        gXfTMNuwBp40LPzIAHGoyjThJZFyoI5CSg==
X-Google-Smtp-Source: ABdhPJzKEsybwvFlzN+HoJvW9b9lD5678LZfi6sECRNqybPbiruESbcTxfId5jWVksMvWjmjh0Ggiw==
X-Received: by 2002:a17:90a:ce96:: with SMTP id g22mr6851044pju.9.1593597679527;
        Wed, 01 Jul 2020 03:01:19 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:19 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 5/8] Bluetooth: Let controller creates RPA during le create conn
Date:   Wed,  1 Jul 2020 15:34:29 +0530
Message-Id: <20200701100432.28038-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
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
index 622016287628..906721759c2f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2200,7 +2200,13 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
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

