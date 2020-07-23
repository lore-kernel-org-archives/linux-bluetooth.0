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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF1C433E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5123620888
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t34FZrqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgGWMf1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMf0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 08:35:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94590C0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l6so2499204plt.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bwkuLTs6JjWfQ9Oc/vq1HcUJ3U5T2anKNWaBV3h5b4U=;
        b=t34FZrqpJguHXObyN++EfG8CiEe1r70HOONJmln+mbhgRW+GbH4f1buS8rMj9fSW+g
         RcOp6eK4BVKBwGlh+a+Smq6qeIg4F4XLDal6X2VUVhn9SJDeoGo4FhB+8UCX7F18pD5u
         B+aJG9kybl/3NJi8FA+p2Rct5dVLWhHkkfwRG5ds/k3U4T/v+kLijxZwDeuFgXtkfmRo
         dSZ03ZBSCrjmSTfWM3FiNUVKQDwaDdJcQkiOwKCoK1r1lHBWe1CUEZySpBp91ZyD4O1z
         7iY0LST6wt2rGB91SPlsyDoRxBCZmXlsCuTgfVzcnLb05XoHniB9AH9j3Cd3/40V5al9
         ZutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwkuLTs6JjWfQ9Oc/vq1HcUJ3U5T2anKNWaBV3h5b4U=;
        b=oQ1ZXZfJTfhJvhYmULIZoJUDoFlacyf+CZod1k04sbTbvCyIqPIiznx5nL1HBQ4eyS
         lv5ojT2NE1WoqLQgSpy8NbRu4yF3Cs2YtxUdPwk8NIYUI924mrn+LmsPwTjwVHSVRp7N
         kpPdE0oxgRgooCHGyMTRBJKMgJZE4bhlQV37mxoYgssQijWwI/3mxGVvtfeV7pkqFzAV
         jE4HrSLLjognxrieNV7Kl1XgknWuWd37maEE4GbPZcLYsh0pXqC+H7gry3ZjFtsQDPNJ
         Rt4b1mrmZngjXO37nzv1mQpiSC3OnHAmqkZRkfMMEwabnk0dEi8ZbnZGWNi1v9mG9pVR
         DumQ==
X-Gm-Message-State: AOAM531Oybrn5QLp2eiXgtIOxMhtITo85IF9UYCdqm9+MJKFWV6FGR5t
        yaSN4C7j2R1sX3MPY7Wwy0jr1CAEPMADDA==
X-Google-Smtp-Source: ABdhPJwgU9AyjfneBLNPjhnm1MnH0AufFjYwpW6dkFZFaII5j4d2y7Y6obC+Y/K/Vt32vhcjIxLwwg==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr3626123pld.33.1595507725921;
        Thu, 23 Jul 2020 05:35:25 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id z11sm2849823pfr.71.2020.07.23.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:35:25 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 4/8] Bluetooth: Translate additional address type during le_conn
Date:   Thu, 23 Jul 2020 18:08:59 +0530
Message-Id: <20200723123903.29337-4-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723123903.29337-1-sathish.narasimman@intel.com>
References: <20200723123903.29337-1-sathish.narasimman@intel.com>
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
index 61f8c4d12028..6388fb55b4d2 100644
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

