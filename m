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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE922C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A051D600AA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 20:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhH3U4d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhH3U4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 16:56:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442AC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 13:55:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 18so13173988pfh.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fs8tltrsV8xclICbODzQWO9IGQ6I5dIdxIuMc/1+bRU=;
        b=OXocsa3kZQOTVbN1ngJZOYViZx73joslVHVy+/81l9ZiC4FCakqgxdYTZqvrtQzuTm
         fW0laF1C3TtF2NWEVzVNuJ9C0M9d6LHuEml0ZGrPMC0GPF/rrJFs6gIIWltPZc8VJH40
         DuII6oxJtJir3ECDA3wmx1TIQXMcZiVQ0rQ93nbviCECO4VBYP2PvOsYirYd7/qL4GPW
         zXEIUejDLvcR0sONK0X26S3jwQAnVJNNg+bUGiZslhCDuUccNrWeZlt6Cpfqd1U8d2BF
         PRD3A5RyXlsA0pyd47+r1PPtJ6zYlY02tjKov2RPC5alkSXRyPIrlIs7LTkez/pkILHO
         jR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fs8tltrsV8xclICbODzQWO9IGQ6I5dIdxIuMc/1+bRU=;
        b=g5ED5VlJ0UoOYlkpHubZusjRyfc2MzFZITXBhXGDBC1gLw198FRevcWh03s6B0m9Y3
         D5U1uMjfnHEYaMP8wRd0PpPo4eumbp/KQzqc4/P/Q+CFWYMDPgRIUJh2cRZN4QHLYnTr
         tkggJN3Gorg9bCq9BVMgTVpZufA6AZd979Cl3EH279VO/g8CeFbIsLYsoSPOxAfy1qM9
         cZhn+Rs0MjZJSzzOzgJSi6g8RFCkk2CJusNcA3T9fGEQqURE955E2g1RaASVzbhgexzM
         I4NwwWKq6URZkuUOp2v80fIQCb1gIIxg9ud3oiboSwtG4Guy8Ib+n46jTIicRZ0FMgOi
         ZZ0A==
X-Gm-Message-State: AOAM531IFRnsX/6c2UzHcWrrnEEvG+uYRxMlDozMtAMZ+bPIPf8hQoAB
        k5dA8JdKn2plPp3YU8YeqfeUTWPHyIc=
X-Google-Smtp-Source: ABdhPJyFlteRjbDU2RbyjWGUWlaJodsQkbnjKIeziQ5KmjMogn+VfJjWIXQaZo+kDsZE4iAb8YBDTA==
X-Received: by 2002:a05:6a00:2405:b0:3e1:9f65:9703 with SMTP id z5-20020a056a00240500b003e19f659703mr25172526pfh.6.1630356938291;
        Mon, 30 Aug 2021 13:55:38 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e12sm15610557pfv.146.2021.08.30.13.55.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:55:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Fix using address type from events
Date:   Mon, 30 Aug 2021 13:55:36 -0700
Message-Id: <20210830205537.118960-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Address types ADDR_LE_DEV_PUBLIC_RESOLVED and
ADDR_LE_DEV_RANDOM_RESOLVED shall be converted to ADDR_LE_PUBLIC and
ADDR_LE_RANDOM repectively since they are not safe to be used beyond
the scope of the events themselves.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c  |  9 -------
 net/bluetooth/hci_event.c | 53 ++++++++++++++++-----------------------
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a47a3017d61..f3a18d16b81f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3487,15 +3487,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 {
 	struct hci_conn_params *param;
 
-	switch (addr_type) {
-	case ADDR_LE_DEV_PUBLIC_RESOLVED:
-		addr_type = ADDR_LE_DEV_PUBLIC;
-		break;
-	case ADDR_LE_DEV_RANDOM_RESOLVED:
-		addr_type = ADDR_LE_DEV_RANDOM;
-		break;
-	}
-
 	list_for_each_entry(param, list, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 293d4c9c4b09..1934a4b6c047 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2367,6 +2367,22 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static u8 ev_bdaddr_type(struct hci_dev *hdev, u8 type)
+{
+	/* When using controller based address resolution, then the new
+	 * address types 0x02 and 0x03 are used. These types need to be
+	 * converted back into either public address or random address type
+	 */
+	switch (type) {
+	case ADDR_LE_DEV_PUBLIC_RESOLVED:
+		return ADDR_LE_DEV_PUBLIC;
+	case ADDR_LE_DEV_RANDOM_RESOLVED:
+		return ADDR_LE_DEV_RANDOM;
+	}
+
+	return type;
+}
+
 static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 			      u8 peer_addr_type, u8 own_address_type,
 			      u8 filter_policy)
@@ -2378,21 +2394,7 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	if (!conn)
 		return;
 
-	/* When using controller based address resolution, then the new
-	 * address types 0x02 and 0x03 are used. These types need to be
-	 * converted back into either public address or random address type
-	 */
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
-		switch (own_address_type) {
-		case ADDR_LE_DEV_PUBLIC_RESOLVED:
-			own_address_type = ADDR_LE_DEV_PUBLIC;
-			break;
-		case ADDR_LE_DEV_RANDOM_RESOLVED:
-			own_address_type = ADDR_LE_DEV_RANDOM;
-			break;
-		}
-	}
+	own_address_type = ev_bdaddr_type(hdev, own_address_type);
 
 	/* Store the initiator and responder address information which
 	 * is needed for SMP. These values will not change during the
@@ -5282,22 +5284,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		conn->dst_type = irk->addr_type;
 	}
 
-	/* When using controller based address resolution, then the new
-	 * address types 0x02 and 0x03 are used. These types need to be
-	 * converted back into either public address or random address type
-	 */
-	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
-		switch (conn->dst_type) {
-		case ADDR_LE_DEV_PUBLIC_RESOLVED:
-			conn->dst_type = ADDR_LE_DEV_PUBLIC;
-			break;
-		case ADDR_LE_DEV_RANDOM_RESOLVED:
-			conn->dst_type = ADDR_LE_DEV_RANDOM;
-			break;
-		}
-	}
+	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type);
 
 	if (status) {
 		hci_le_conn_failed(conn, status);
@@ -5619,6 +5606,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * controller address.
 	 */
 	if (direct_addr) {
+		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type);
+
 		/* Only resolvable random addresses are valid for these
 		 * kind of reports and others can be ignored.
 		 */
@@ -5646,6 +5635,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		bdaddr_type = irk->addr_type;
 	}
 
+	bdaddr_type = ev_bdaddr_type(hdev, bdaddr_type);
+
 	/* Check if we have been requested to connect to this device.
 	 *
 	 * direct_addr is set only for directed advertising reports (it is NULL
-- 
2.31.1

