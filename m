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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95E9C4320E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 20:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C234460FA0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 20:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhH3U4e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhH3U4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 16:56:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80EFC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 13:55:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w7so13488992pgk.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mjbV5K7/f7gSNzYKWkw6zaH4KXZ706SuSbDwsGkuI4w=;
        b=d4qOCX6DjnQdrczblkll6yfk4HfqO/NnQplcWT91wTppPqJ+B8UyLuR2ukhHfUEgsT
         xqCxR0iGNo5PW4Nlri3yWaa/WRVGaM3Cnbgrm9chwWdhbLy00qjqz9HUThnObulj+P8U
         V7RkVBG9esxBe0iEVQuGHmM/gybFlZsNVPlsDQzpEpurkdofbMCP2i7G3142TC6i5Qku
         5pu+u14utYnWMDt7uriQ9t2Os308g4Dxj0LuJZO0yiLm1qfadLdRAtYo3Xht+tR8Mkvp
         9Fdc1Y/jjGhs0be/rQ3iSmTOb3N/PnXat9mKmNG44AJpw2Fe1N8XP2aIFK2IZFKy8XXg
         fOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjbV5K7/f7gSNzYKWkw6zaH4KXZ706SuSbDwsGkuI4w=;
        b=MoUkb9bBBnFGvyS7T8qDOHQFwQPBrNVFi66CXhowEdClNaHIbHs9lEjz412Sprie+G
         YRl05Bg3CNv6roKsLCZHV2gDimTR7aOnF4rtCj5eqMtlcPaBlAlBNSvMLBcZC2Zrdfb3
         AH4gPVSrYqlBMb9m+53ahVMS3RNso8HlkVDTP1HRIiv61b5dpcWy0PXp75C3hRLjiH9d
         WCIO7A8rR2qHHxC1gEtXeDgyopnCYzk9lq13Fx7VzHRaKubojL9KqWR2/3KNcljrY+X1
         WkfejcPe6e3JlHqsj/3zoANVd8k9zPY0ekvgcPsOx8Zl/uO4DYQTqB4HM+xSYUnCN15I
         cctw==
X-Gm-Message-State: AOAM532rQouJTcFtIh+zfK2ACHlkvfLruZK5R2eNo2oQLNVOTWiK1iuY
        CgZHYb1qd3Y95qaj41xzjO7URex1NGM=
X-Google-Smtp-Source: ABdhPJyEELfNGhtRx4Pz4PCpPKHj3lYc4ah14KcM41Pe/+78cPlECtYGX36T4Jme9HpyqAaXhO4MkQ==
X-Received: by 2002:a62:e302:0:b0:3f2:628b:3103 with SMTP id g2-20020a62e302000000b003f2628b3103mr23478689pfh.39.1630356938906;
        Mon, 30 Aug 2021 13:55:38 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e12sm15610557pfv.146.2021.08.30.13.55.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:55:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix using RPA when address has been resolved
Date:   Mon, 30 Aug 2021 13:55:37 -0700
Message-Id: <20210830205537.118960-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830205537.118960-1-luiz.dentz@gmail.com>
References: <20210830205537.118960-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When connecting to a device using an RPA if the address has been
resolved by the controller (types 0x02 and 0x03) the identity address
shall be used as the actual RPA in the advertisement won't be visible
to the host.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  5 +++--
 net/bluetooth/hci_conn.c         | 33 ++++++++++++++++++--------------
 net/bluetooth/hci_event.c        | 33 +++++++++++++++++++-------------
 net/bluetooth/l2cap_core.c       |  2 +-
 4 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 77ea1a8a3db5..24ad6ebd00e2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1101,8 +1101,9 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     u16 conn_timeout,
 				     enum conn_reasons conn_reason);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				u8 role, bdaddr_t *direct_rpa);
+				u8 dst_type, bool dst_resolved, u8 sec_level,
+				u16 conn_timeout, u8 role,
+				bdaddr_t *direct_rpa);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type,
 				 enum conn_reasons conn_reason);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2b5059a56cda..3ab60b75d865 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1040,8 +1040,8 @@ static void hci_req_directed_advertising(struct hci_request *req,
 }
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				u8 role, bdaddr_t *direct_rpa)
+				u8 dst_type, bool dst_resolved, u8 sec_level,
+				u16 conn_timeout, u8 role, bdaddr_t *direct_rpa)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -1078,19 +1078,24 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EBUSY);
 	}
 
-	/* When given an identity address with existing identity
-	 * resolving key, the connection needs to be established
-	 * to a resolvable random address.
-	 *
-	 * Storing the resolvable random address is required here
-	 * to handle connection failures. The address will later
-	 * be resolved back into the original identity address
-	 * from the connect request.
+	/* Check if the destination address has been resolved by the controller
+	 * since if it did then the identity address shall be used.
 	 */
-	irk = hci_find_irk_by_addr(hdev, dst, dst_type);
-	if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
-		dst = &irk->rpa;
-		dst_type = ADDR_LE_DEV_RANDOM;
+	if (!dst_resolved) {
+		/* When given an identity address with existing identity
+		 * resolving key, the connection needs to be established
+		 * to a resolvable random address.
+		 *
+		 * Storing the resolvable random address is required here
+		 * to handle connection failures. The address will later
+		 * be resolved back into the original identity address
+		 * from the connect request.
+		 */
+		irk = hci_find_irk_by_addr(hdev, dst, dst_type);
+		if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
+			dst = &irk->rpa;
+			dst_type = ADDR_LE_DEV_RANDOM;
+		}
 	}
 
 	if (conn) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1934a4b6c047..b1062f5cf488 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2367,7 +2367,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static u8 ev_bdaddr_type(struct hci_dev *hdev, u8 type)
+static u8 ev_bdaddr_type(struct hci_dev *hdev, u8 type, bool *resolved)
 {
 	/* When using controller based address resolution, then the new
 	 * address types 0x02 and 0x03 are used. These types need to be
@@ -2375,11 +2375,17 @@ static u8 ev_bdaddr_type(struct hci_dev *hdev, u8 type)
 	 */
 	switch (type) {
 	case ADDR_LE_DEV_PUBLIC_RESOLVED:
+		if (resolved)
+			*resolved = true;
 		return ADDR_LE_DEV_PUBLIC;
 	case ADDR_LE_DEV_RANDOM_RESOLVED:
+		if (resolved)
+			*resolved = true;
 		return ADDR_LE_DEV_RANDOM;
 	}
 
+	if (resolved)
+		*resolved = false;
 	return type;
 }
 
@@ -2394,7 +2400,7 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	if (!conn)
 		return;
 
-	own_address_type = ev_bdaddr_type(hdev, own_address_type);
+	own_address_type = ev_bdaddr_type(hdev, own_address_type, NULL);
 
 	/* Store the initiator and responder address information which
 	 * is needed for SMP. These values will not change during the
@@ -5284,7 +5290,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		conn->dst_type = irk->addr_type;
 	}
 
-	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type);
+	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type, NULL);
 
 	if (status) {
 		hci_le_conn_failed(conn, status);
@@ -5466,8 +5472,8 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 					      bdaddr_t *addr,
-					      u8 addr_type, u8 adv_type,
-					      bdaddr_t *direct_rpa)
+					      u8 addr_type, bool addr_resolved,
+					      u8 adv_type, bdaddr_t *direct_rpa)
 {
 	struct hci_conn *conn;
 	struct hci_conn_params *params;
@@ -5519,9 +5525,9 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		}
 	}
 
-	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      hdev->def_le_autoconnect_timeout, HCI_ROLE_MASTER,
-			      direct_rpa);
+	conn = hci_connect_le(hdev, addr, addr_type, addr_resolved,
+			      BT_SECURITY_LOW, hdev->def_le_autoconnect_timeout,
+			      HCI_ROLE_MASTER, direct_rpa);
 	if (!IS_ERR(conn)) {
 		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
 		 * by higher layer that tried to connect, if no then
@@ -5562,7 +5568,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
 	struct hci_conn *conn;
-	bool match;
+	bool match, bdaddr_resolved;
 	u32 flags;
 	u8 *ptr;
 
@@ -5606,7 +5612,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * controller address.
 	 */
 	if (direct_addr) {
-		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type);
+		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type,
+						  &bdaddr_resolved);
 
 		/* Only resolvable random addresses are valid for these
 		 * kind of reports and others can be ignored.
@@ -5635,15 +5642,15 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		bdaddr_type = irk->addr_type;
 	}
 
-	bdaddr_type = ev_bdaddr_type(hdev, bdaddr_type);
+	bdaddr_type = ev_bdaddr_type(hdev, bdaddr_type, &bdaddr_resolved);
 
 	/* Check if we have been requested to connect to this device.
 	 *
 	 * direct_addr is set only for directed advertising reports (it is NULL
 	 * for advertising reports) and is already verified to be RPA above.
 	 */
-	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, type,
-								direct_addr);
+	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, bdaddr_resolved,
+				     type, direct_addr);
 	if (!ext_adv && conn && type == LE_ADV_IND && len <= HCI_MAX_AD_LENGTH) {
 		/* Store report for later inclusion by
 		 * mgmt_device_connected
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77ba68209dbd..4f8f37599962 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7902,7 +7902,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 			dst_type = ADDR_LE_DEV_RANDOM;
 
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-			hcon = hci_connect_le(hdev, dst, dst_type,
+			hcon = hci_connect_le(hdev, dst, dst_type, false,
 					      chan->sec_level,
 					      HCI_LE_CONN_TIMEOUT,
 					      HCI_ROLE_SLAVE, NULL);
-- 
2.31.1

