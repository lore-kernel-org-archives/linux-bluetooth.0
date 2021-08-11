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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A7FC4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B929A61058
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Aug 2021 23:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhHKXUp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhHKXUo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Aug 2021 19:20:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82A7C061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 16:20:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a5so4794520plh.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Aug 2021 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ubteHlrgBNF/kKcsV8PMoJ4rULPJeD+bwGIxtttssLc=;
        b=gF7Yli4ve/Z7Irtf4Guarf1tQhfa4Io++VL55HsNy3mD8FWfAZyFYyAJzFy5jXxVQ9
         XPjfnEEwXIlaZHXg0VF9ARb6cvHATBbRpuAtuh8A2yHE80hOne092Hj3ccyz/2KoYI0V
         Ixczu4wo0WUV4H03wHtlPX5ssa/QcOCtKtrR6kcmrGbE4FPLEng4VY91mGL2nUKIzUYt
         lHk6ySZCxozhcaQIoleEQI6TUo7dVtNdthSlLHaQuaKHEjd/ofQG8aTnmDRf9NsgbF3O
         qiZ0iPcFFsgsoPsXB5tC9DELfwtooJBBJORS/rJztjBcKENy3n/7xaWvOJ5G7CV4n1j4
         7FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubteHlrgBNF/kKcsV8PMoJ4rULPJeD+bwGIxtttssLc=;
        b=pGs62YDta0A7RhzNB1++xMFxSDVsOg/cz17zR7DV0YBxOhSuhYdbxab4ltKDfylc2w
         V3z+/Kh0/oUA++cMYEpZb5Et0FEMtPrOkSC6c8d0NC4lXRoeVWufbMMPiYVh0z6cocJ8
         3Jlny3L2t13OE9SYHSqCsnsOW9yezxShD84b6gZJKSCWTIjOhEJAuThURFyEKacNGCpI
         VT5J4WVlLNWQEt725DmFq0GVMOf6+MzRholC0SSX1c4NW2U3H9G4gXb0jQKSpC8RCrN9
         wwLupvdqPLfGDnkMgluAPPSC8q4qebTdA6EG2BiKB8AHPPzJnAQr7LpBXa1yts9oudd2
         qhTQ==
X-Gm-Message-State: AOAM530U3rwJHZ9lTzt7DZBlkaiZZa/32caKmH586Ph2FBgeDb2HEvGO
        h1Qk1EJ4VRI3gfeIL0tah4JYx0znV1o=
X-Google-Smtp-Source: ABdhPJwndNuJ8pYbXn0tOj1IGKFlLP7vLY5DnDoayWAEJ8ky7vmPEjknRdvLxATArn6pitTbP7ORmg==
X-Received: by 2002:a17:902:9b87:b029:12c:c3ed:8a1d with SMTP id y7-20020a1709029b87b029012cc3ed8a1dmr1059796plp.7.1628724020172;
        Wed, 11 Aug 2021 16:20:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e27sm672835pfj.23.2021.08.11.16.20.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 16:20:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: Store advertising handle so it can be re-enabled
Date:   Wed, 11 Aug 2021 16:20:16 -0700
Message-Id: <20210811232016.757154-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811232016.757154-1-luiz.dentz@gmail.com>
References: <20210811232016.757154-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores the advertising handle/instance into hci_conn so it is
accessible when re-enabling the advertising once disconnected.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 45 ++++++++++++++++++++------------
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a7d06d7da602..a7360c8c72f8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -629,6 +629,7 @@ struct hci_conn {
 	__u8		init_addr_type;
 	bdaddr_t	resp_addr;
 	__u8		resp_addr_type;
+	__u8		adv_instance;
 	__u16		handle;
 	__u16		state;
 	__u8		mode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a8a199cfef60..1ee89d9b2ed4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2348,19 +2348,20 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
 	if (conn) {
-		u8 type = conn->type;
-
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, status);
 
+		if (conn->type == LE_LINK) {
+			hdev->cur_adv_instance = conn->adv_instance;
+			hci_req_reenable_advertising(hdev);
+		}
+
 		/* If the disconnection failed for any reason, the upper layer
 		 * does not retry to disconnect in current implementation.
 		 * Hence, we need to do some basic cleanup here and re-enable
 		 * advertising if necessary.
 		 */
 		hci_conn_del(conn);
-		if (type == LE_LINK)
-			hci_req_reenable_advertising(hdev);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2886,7 +2887,6 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	bool mgmt_connected;
-	u8 type;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -2941,10 +2941,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	type = conn->type;
-
 	hci_disconn_cfm(conn, ev->reason);
-	hci_conn_del(conn);
 
 	/* The suspend notifier is waiting for all devices to disconnect so
 	 * clear the bit from pending tasks and inform the wait queue.
@@ -2964,8 +2961,12 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * or until a connection is created or until the Advertising
 	 * is timed out due to Directed Advertising."
 	 */
-	if (type == LE_LINK)
+	if (conn->type == LE_LINK) {
+		hdev->cur_adv_instance = conn->adv_instance;
 		hci_req_reenable_advertising(hdev);
+	}
+
+	hci_conn_del(conn);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -5323,6 +5324,13 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	conn->handle = handle;
 	conn->state = BT_CONFIG;
 
+	/* Store current advertising instance as connection advertising instance
+	 * when sotfware rotation is in use so it can be re-enabled when
+	 * disconnected.
+	 */
+	if (!ext_adv_capable(hdev))
+		conn->adv_instance = hdev->cur_adv_instance;
+
 	conn->le_conn_interval = interval;
 	conn->le_conn_latency = latency;
 	conn->le_supv_timeout = supervision_timeout;
@@ -5406,13 +5414,13 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_evt_le_ext_adv_set_term *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	struct adv_info *adv;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
-	if (ev->status) {
-		struct adv_info *adv;
+	adv = hci_find_adv_instance(hdev, ev->handle);
 
-		adv = hci_find_adv_instance(hdev, ev->handle);
+	if (ev->status) {
 		if (!adv)
 			return;
 
@@ -5423,9 +5431,15 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
+	if (adv)
+		adv->enabled = false;
+
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->conn_handle));
 	if (conn) {
-		struct adv_info *adv_instance;
+		/* Store handle in the connection so the correct advertising
+		 * instance can be re-enabled when disconnected.
+		 */
+		conn->adv_instance = ev->handle;
 
 		if (hdev->adv_addr_type != ADDR_LE_DEV_RANDOM ||
 		    bacmp(&conn->resp_addr, BDADDR_ANY))
@@ -5436,9 +5450,8 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			return;
 		}
 
-		adv_instance = hci_find_adv_instance(hdev, ev->handle);
-		if (adv_instance)
-			bacpy(&conn->resp_addr, &adv_instance->random_addr);
+		if (adv)
+			bacpy(&conn->resp_addr, &adv->random_addr);
 	}
 }
 
-- 
2.31.1

