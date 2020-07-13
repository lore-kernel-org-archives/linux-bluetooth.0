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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980DC433E5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E332068F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX+daJPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgGMGIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191C3C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so5591558pgh.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s2IcTEAY6E8gqIiH1UvcKWcRD7F04eaPXNmCRRgH/EI=;
        b=UX+daJPIEuP+dPh8PvOHWEB96LtLs8zZGJ2Sf6WAnNrDdiFL7t/n21KdDqUnkzJveF
         l1a2A2P+XBmqMMCP+uYgo6Pf87yzjZL5IGshlMRuYCUKLKtw0XITUOmgFkUucLXU3MGJ
         tOPq6Y+HdDZm6OO1gmb0Dsy06o+ARmCygSpY8YIiASNNvctF2xTldH9i2b56lM6+jiF0
         IzCDAU34IH1JzG1TPiVFk+zcbMXR5cp04DR3X3sqPYs4v3ufcVGrGJvKam9r1YLG11nj
         n8GeXfceaekQGucTVpDOrSOeqiFtmSyBCl82v0u8qoX0H6J2CMyllQDebbzYI4sR8Sxe
         VcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s2IcTEAY6E8gqIiH1UvcKWcRD7F04eaPXNmCRRgH/EI=;
        b=Qi8/aEk01bResru4tJGJF5ldsmP0RdybwUXTCISyhtgd0uetS2xdlHugC7pXg8zBf4
         oW8fcY/3ACIo8tpVKQJQX9Pa37LZv7bLxmSj/2LLJiwaJiSGd7R2Gb1f2RM1TMn5EHnt
         5nO9T17azBNaKt415eGnVTMCTgWa1P6cga7M5rNdq5rSd6YsKu1w8cXCqIYYDANegzXl
         X5MOHdfwg3aYHXvpZqy2sVAlM4jDz8w3QtgilUlXNNMmh1VlgIOIoItRj9CaZARQbnNj
         xirXRlxt+d2cSDgsnsUHkwLkodGbgz2dchHhIVctH+70TR8CbNSDVjmBkgld5K4/ZyFj
         y3LQ==
X-Gm-Message-State: AOAM532Ie/wNtOuyLFCe0j7fihVapDZql/ZD5q9dGo9XteCMw9K5LjjV
        y+4LVPA5aDnlQFv9Qf4w8DyEydfFFzyJ8g==
X-Google-Smtp-Source: ABdhPJy9Uc1Yz2TEZcgp9KLzQFPJzYdZ/F1ZFmHPYFIvdbA+QirBsDe7f06Zg1P2gijcyDo5EGDIrA==
X-Received: by 2002:a63:b90a:: with SMTP id z10mr64900272pge.277.1594620525467;
        Sun, 12 Jul 2020 23:08:45 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id e5sm12787172pjy.26.2020.07.12.23.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:08:45 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 4/8] Bluetooth: Translate additional address type during le_conn
Date:   Mon, 13 Jul 2020 11:42:16 +0530
Message-Id: <20200713061220.3252-5-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713061220.3252-1-sathish.narasimman@intel.com>
References: <20200713061220.3252-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When using controller based address resolution, then the new address
types 0x02 and 0x03 are used. These types need to be converted back into
either public address or random address types.

This patch is specially during LE_CREATE_CONN if using own_add_type as 0x02
or 0x03.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_event.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 927bde511170..eae5bd4a53ac 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2296,6 +2296,22 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	if (!conn)
 		return;
 
+	/* When using controller based address resolution, then the new
+	 * address types 0x02 and 0x03 are used. These types need to be
+	 * converted back into either public address or random address type
+	 */
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		switch (own_address_type) {
+		case ADDR_LE_DEV_PUBLIC_RESOLVED:
+			own_address_type = ADDR_LE_DEV_PUBLIC;
+			break;
+		case ADDR_LE_DEV_RANDOM_RESOLVED:
+			own_address_type = ADDR_LE_DEV_RANDOM;
+			break;
+		}
+	}
+
 	/* Store the initiator and responder address information which
 	 * is needed for SMP. These values will not change during the
 	 * lifetime of the connection.
-- 
2.17.1

