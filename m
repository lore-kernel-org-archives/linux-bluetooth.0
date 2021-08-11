Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33848C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1389A6101E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 23:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhHKXUo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhHKXUo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 19:20:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015FAC061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 16:20:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so7633160pjl.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COA5IYYET0BCU4kxEFZIKZwdZOFJ7sa2sc95IRVseJE=;
        b=vHDtDZMN1HYWTaSjyob++9Uu8vfrTuX1wzhTBh+pIjjSMHiqThSJNUfCRWLHda9Twf
         YwZWyxCDy4MMwdggMB5LihujkQVH3MGKi+Djwi1c6Sk9zgCBTwjOzCAGT4tE5jG6w5kV
         ZeEdiDA/4YRPFAVi8ttsjjPuT7x6kgE6Qu8zef+0bi2LVzWrnLeQwR76ebB+rtK5qDHG
         vHaHBjyp3O7ts86TybXdZ3jVJLj3vEFP1uPL5LLOL96VIEKUOJGly4Dy2m3fGkI9Ntu8
         CK2DZUYiRN2TZGfYT89MIs6IlasbLiMVFsrVZYLgAVTPyLcVaAJrWXBUi0I+RUL3ZAyK
         cYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COA5IYYET0BCU4kxEFZIKZwdZOFJ7sa2sc95IRVseJE=;
        b=cYWwgj33jVz5dzgsCdiWPhLhI7dZzQrZEJe/+w/1Sz2Cx115/xpH24pFdmWbwM7vB9
         8ZlFH/4LrkLaa+KrbIMdesfww4N8d9/8NMw1B4ETSWCUOF25wmegqjyilxa/bDbiTNql
         cUrrmoH6YQkmNTwnAIRDQVoweiZzcqIX9BQjUgT9KqNUTpCQV0WsGYrzY6y99ZgWkkL3
         iGBbz6f5JPvSGsUztH6f9foXben2Lz89T2D1VcB7KL42hKDA2nBvUH7snu0uTvEbtFw+
         2YPT5DJ+01z7cZP8QYKVmanurHaAeFuGJGxZTROCkqQtd/G/R2Gbz5MAQaqTazh1BNTL
         LMrg==
X-Gm-Message-State: AOAM532gvLldEdOfnwyz0G2vvvK+CTXakmjnBkS+xxYprSc/44kj1+Tc
        K+UmF0apxCd5vv6z9zyfGr/mXwp9xoM=
X-Google-Smtp-Source: ABdhPJz8fDA5gc1P9/LtdU2J4ep78eQefepUOR2d17HjNixAx6i8SylXGfgkGxnbK3LpT32RwfMWqA==
X-Received: by 2002:a17:902:e995:b029:12d:5f22:ce3f with SMTP id f21-20020a170902e995b029012d5f22ce3fmr1067472plb.66.1628724019158;
        Wed, 11 Aug 2021 16:20:19 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e27sm672835pfj.23.2021.08.11.16.20.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 16:20:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: Fix handling of LE Enhanced Connection Complete
Date:   Wed, 11 Aug 2021 16:20:15 -0700
Message-Id: <20210811232016.757154-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

LE Enhanced Connection Complete contains the Local RPA used in the
connection which must be used when set otherwise there could problems
when pairing since the address used by the remote stack could be the
Local RPA:

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 4, Part E
page 2396

  'Resolvable Private Address being used by the local device for this
  connection. This is only valid when the Own_Address_Type (from the
  HCI_LE_Create_Connection, HCI_LE_Set_Advertising_Parameters,
  HCI_LE_Set_Extended_Advertising_Parameters, or
  HCI_LE_Extended_Create_Connection commands) is set to 0x02 or
  0x03, and the Controller generated a resolvable private address for the
  local device using a non-zero local IRK. For other Own_Address_Type
  values, the Controller shall return all zeros.'

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 93 ++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 38decf474f31..a8a199cfef60 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5161,9 +5161,64 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 }
 #endif
 
+static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
+				u8 bdaddr_type, bdaddr_t *local_rpa)
+{
+	if (conn->out) {
+		conn->dst_type = bdaddr_type;
+		conn->resp_addr_type = bdaddr_type;
+		bacpy(&conn->resp_addr, bdaddr);
+
+		/* Check if the controller has set a Local RPA then it must be
+		 * used instead or hdev->rpa.
+		 */
+		if (local_rpa && bacmp(local_rpa, BDADDR_ANY)) {
+			conn->init_addr_type = ADDR_LE_DEV_RANDOM;
+			bacpy(&conn->init_addr, local_rpa);
+		} else if (hci_dev_test_flag(conn->hdev, HCI_PRIVACY)) {
+			conn->init_addr_type = ADDR_LE_DEV_RANDOM;
+			bacpy(&conn->init_addr, &conn->hdev->rpa);
+		} else {
+			hci_copy_identity_address(conn->hdev, &conn->init_addr,
+						  &conn->init_addr_type);
+		}
+	} else {
+		conn->resp_addr_type = conn->hdev->adv_addr_type;
+		/* Check if the controller has set a Local RPA then it must be
+		 * used instead or hdev->rpa.
+		 */
+		if (local_rpa && bacmp(local_rpa, BDADDR_ANY)) {
+			conn->resp_addr_type = ADDR_LE_DEV_RANDOM;
+			bacpy(&conn->resp_addr, local_rpa);
+		} else if (conn->hdev->adv_addr_type == ADDR_LE_DEV_RANDOM) {
+			/* In case of ext adv, resp_addr will be updated in
+			 * Adv Terminated event.
+			 */
+			if (!ext_adv_capable(conn->hdev))
+				bacpy(&conn->resp_addr,
+				      &conn->hdev->random_addr);
+		} else {
+			bacpy(&conn->resp_addr, &conn->hdev->bdaddr);
+		}
+
+		conn->init_addr_type = bdaddr_type;
+		bacpy(&conn->init_addr, bdaddr);
+
+		/* For incoming connections, set the default minimum
+		 * and maximum connection interval. They will be used
+		 * to check if the parameters are in range and if not
+		 * trigger the connection update procedure.
+		 */
+		conn->le_conn_min_interval = conn->hdev->le_conn_min_interval;
+		conn->le_conn_max_interval = conn->hdev->le_conn_max_interval;
+	}
+}
+
 static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
-			bdaddr_t *bdaddr, u8 bdaddr_type, u8 role, u16 handle,
-			u16 interval, u16 latency, u16 supervision_timeout)
+				 bdaddr_t *bdaddr, u8 bdaddr_type,
+				 bdaddr_t *local_rpa, u8 role, u16 handle,
+				 u16 interval, u16 latency,
+				 u16 supervision_timeout)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -5211,32 +5266,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
-	if (!conn->out) {
-		/* Set the responder (our side) address type based on
-		 * the advertising address type.
-		 */
-		conn->resp_addr_type = hdev->adv_addr_type;
-		if (hdev->adv_addr_type == ADDR_LE_DEV_RANDOM) {
-			/* In case of ext adv, resp_addr will be updated in
-			 * Adv Terminated event.
-			 */
-			if (!ext_adv_capable(hdev))
-				bacpy(&conn->resp_addr, &hdev->random_addr);
-		} else {
-			bacpy(&conn->resp_addr, &hdev->bdaddr);
-		}
-
-		conn->init_addr_type = bdaddr_type;
-		bacpy(&conn->init_addr, bdaddr);
-
-		/* For incoming connections, set the default minimum
-		 * and maximum connection interval. They will be used
-		 * to check if the parameters are in range and if not
-		 * trigger the connection update procedure.
-		 */
-		conn->le_conn_min_interval = hdev->le_conn_min_interval;
-		conn->le_conn_max_interval = hdev->le_conn_max_interval;
-	}
+	le_conn_update_addr(conn, bdaddr, bdaddr_type, local_rpa);
 
 	/* Lookup the identity address from the stored connection
 	 * address and address type.
@@ -5347,7 +5377,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	le_conn_complete_evt(hdev, ev->status, &ev->bdaddr, ev->bdaddr_type,
-			     ev->role, le16_to_cpu(ev->handle),
+			     NULL, ev->role, le16_to_cpu(ev->handle),
 			     le16_to_cpu(ev->interval),
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
@@ -5361,7 +5391,7 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
 	le_conn_complete_evt(hdev, ev->status, &ev->bdaddr, ev->bdaddr_type,
-			     ev->role, le16_to_cpu(ev->handle),
+			     &ev->local_rpa, ev->role, le16_to_cpu(ev->handle),
 			     le16_to_cpu(ev->interval),
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
@@ -5397,7 +5427,8 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn) {
 		struct adv_info *adv_instance;
 
-		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM)
+		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM ||
+		    bacmp(&conn->resp_addr, BDADDR_ANY))
 			return;
 
 		if (!ev->handle) {
-- 
2.31.1

