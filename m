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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CC520674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MI6QDVR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgFCRO0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCROZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8624C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s23so698084pfh.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RqbNZdfUYH4SzFn+I4Y/bQsxB/0Uon3AtvdfFK17OOE=;
        b=MI6QDVR0Dwcb1j/3WKvcigtl7WV1KSXclWfwvQGkjUUEHQUcWXRJcFCs8RzTtfnnYp
         Zwqhwfu0tdVq8NqsyMfB0tPOVQRam+awoDXi6lLUtkBlhnVJTXRvgjWIOz7dbnCo2Q1d
         ifpWtMLuSdcduOYHubxvixtIB7L53gJWLj8WEGhV6axEFfFDraBwKg9lO37mfOxW8voj
         wergH32sZHY2B3fviSybiiWFZNKtn6zElSccKMq3ziRcVPz5n2TLP5F5Ne9is428y4hs
         TITYIcxd+tz/qucRd8zqGCepaW8dtSWTMlezu81QKbHNliCWM1ZCFAqR/G+LQ38DwB6a
         N06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RqbNZdfUYH4SzFn+I4Y/bQsxB/0Uon3AtvdfFK17OOE=;
        b=MBQq8fJe67XH4b8MJDuSplYBEABHGWr0cpOO0cyUNO4SnglgiDjGrPXZ2Wzt2rVciO
         dQLTTLHafPQP4+ZdfmqXv4hSL5LVCkDsJ4NfqFn0gjYU/f+9/rdjQMPivcGCd9fzL3bT
         sDMwZruQKAbJ3QG8oSYt63EFSIXQeYbh1MzlPFSbF5XXKdWWddy+FVJSAkd2E/X+OnNF
         0PCD8T2KzQ6lMC4ICRheG81cKwLMo7dourZqAgmXr7G2nQmp5JDg0KEyhQ5/3KYq1bbV
         jfG0E6y0pUoZ+/T3WcfSlYuAjanloup4HwQfCZJBWJLRy49tlTDZB+PU317LuMpeAi1F
         DrXg==
X-Gm-Message-State: AOAM533Qrr63SHZnTlvpHbqf/osh100jHueRqaPZMj+YWOPB9xXWtxUL
        n4fYOeDEIOrCSXtQy6IsuIjFGzaeVfU=
X-Google-Smtp-Source: ABdhPJzEeePFIofDvFU8l1ZUa3xqvI7J6YTJ9CPxualxTNJBo84AxshxB6huOepSrJXaUSqOkYYwQw==
X-Received: by 2002:a62:e703:: with SMTP id s3mr133450pfh.43.1591204464098;
        Wed, 03 Jun 2020 10:14:24 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:23 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 4/7] Bluetooth: Translate additional address type during le_conn
Date:   Wed,  3 Jun 2020 22:47:10 +0530
Message-Id: <20200603171713.9882-5-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
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
index cfeaee347db3..9c9c434844f2 100644
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

