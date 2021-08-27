Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A65C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C322160FD9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 16:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhH0Qyh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhH0Qy0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 12:54:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E71C061796
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 09:53:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x16so2648997pll.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRNQFBF3VxCoF+P7ni/P61pjQ4N1kLpGihICfJaePfU=;
        b=sV3GzuxRp/61cn48QcROmwQHjO6uA+/V4u4DE1SX1kr08nAfiZMSvpRGFFCUcQXPOE
         wgNpCefD1+zrXzX2TLvJ/yjthhTC69h6gD7oN7WwauxZyvCtRzigtKgS3I51jIDkzduN
         NwyI+4eMv7/1OF8hJU4wonbCb2RzzEoxj8T9VyI3pv36ikrqXLOxZV/btED74LNnz6lF
         RMgeXBdjQTwMsxrwyUh7vGvDD6nGt0R36UI3YZf9z48xKoG5IW0yLN0RVdjj2MDeyoL4
         G+hstOoDIwyY1KP87DhP7BBcP4iPEJum3hwhXY3+KjE+P7xTvu/aeTGKOCbdf6FyEsXw
         zEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRNQFBF3VxCoF+P7ni/P61pjQ4N1kLpGihICfJaePfU=;
        b=lAGSZ92AJmNGPdr1CrTZ0bb23d1EaBC5BeTHwlihf5JwfAfUSmI9FL5N4evtp5ehKz
         o6Nb9SXG+EmTElWJ0cr7+hA/DH5Oo+P39SuCnI5wj/dgjtT9m5i2HWNaKsZHvgyZGUni
         978EWS5mJJxzkyUkLBHsqpAGURlL7qYOqXYNXn4Zw3RSpwHS/FwlTMuUOWtYogcathWU
         A9SpsyxHxRCQLfmiA9rkKIonldUeq4qqtZBQTqAuZAdWbphRh9WE/GTMc2bawf6gVHdj
         3XhLoX4qItR3/cbtxoGbo42bmI/oZIVdvLn5Bw1M6jCxuZF9pyX922Z/eoZSvl85qYKm
         WXmQ==
X-Gm-Message-State: AOAM532LJ9SfDKf/1oEBND8UmjOybrX8FtCSEzwkFtgFGyiiSzmaQaZN
        Q07QCCjIxjvP+LYIG13aCpnsDSPMn9Q=
X-Google-Smtp-Source: ABdhPJz/NlFJNF45BRNUhsKE61/rol3GUIZIIa/U/d8OCyrc4abz1XpIox//e/PofDJqjEmaB3rAUQ==
X-Received: by 2002:a17:90b:1645:: with SMTP id il5mr11772414pjb.57.1630083215376;
        Fri, 27 Aug 2021 09:53:35 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v3sm6928445pjd.27.2021.08.27.09.53.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 09:53:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Fix using address type from events
Date:   Fri, 27 Aug 2021 09:53:32 -0700
Message-Id: <20210827165332.1562474-1-luiz.dentz@gmail.com>
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

Also don't connect using RPA as peer address when LL Privacy is
enabled since the controller will be resolving the addresses it should
be able to generate the RPA.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 10 +++++---
 net/bluetooth/hci_core.c  |  9 -------
 net/bluetooth/hci_event.c | 52 ++++++++++++++++++---------------------
 3 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bdaa64cb2f3a..28f23654b8a6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1087,10 +1087,12 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * be resolved back into the original identity address
 	 * from the connect request.
 	 */
-	irk = hci_find_irk_by_addr(hdev, dst, dst_type);
-	if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
-		dst = &irk->rpa;
-		dst_type = ADDR_LE_DEV_RANDOM;
+	if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		irk = hci_find_irk_by_addr(hdev, dst, dst_type);
+		if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
+			dst = &irk->rpa;
+			dst_type = ADDR_LE_DEV_RANDOM;
+		}
 	}
 
 	if (conn) {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6ab0ff3cd4bc..e83a3accfc33 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3562,15 +3562,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
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
index 24d0773b861a..028cdf7ef075 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2411,6 +2411,24 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static u8 ev_bdaddr_type(struct hci_dev *hdev, u8 type)
+{
+	/* When using controller based address resolution, then the new
+	 * address types 0x02 and 0x03 are used. These types need to be
+	 * converted back into either public address or random address type
+	 */
+	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		switch (type) {
+		case ADDR_LE_DEV_PUBLIC_RESOLVED:
+			return ADDR_LE_DEV_PUBLIC;
+		case ADDR_LE_DEV_RANDOM_RESOLVED:
+			return ADDR_LE_DEV_RANDOM;
+		}
+	}
+
+	return type;
+}
+
 static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 			      u8 peer_addr_type, u8 own_address_type,
 			      u8 filter_policy)
@@ -2422,20 +2440,7 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	if (!conn)
 		return;
 
-	/* When using controller based address resolution, then the new
-	 * address types 0x02 and 0x03 are used. These types need to be
-	 * converted back into either public address or random address type
-	 */
-	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
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
@@ -5333,20 +5338,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		conn->dst_type = irk->addr_type;
 	}
 
-	/* When using controller based address resolution, then the new
-	 * address types 0x02 and 0x03 are used. These types need to be
-	 * converted back into either public address or random address type
-	 */
-	if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
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
@@ -5663,6 +5655,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * controller address.
 	 */
 	if (direct_addr) {
+		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type);
+
 		/* Only resolvable random addresses are valid for these
 		 * kind of reports and others can be ignored.
 		 */
@@ -5690,6 +5684,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		bdaddr_type = irk->addr_type;
 	}
 
+	bdaddr_type = ev_bdaddr_type(hdev, bdaddr_type);
+
 	/* Check if we have been requested to connect to this device.
 	 *
 	 * direct_addr is set only for directed advertising reports (it is NULL
-- 
2.31.1

