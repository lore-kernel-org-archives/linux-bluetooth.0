Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE2C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 20:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEBUQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjEBUP7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 16:15:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E91FE3
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 13:15:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaef97652fso22319835ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683058541; x=1685650541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jGjRdSM45bNUBJFmbAVw08c7UDEaSwJ+p/sRBnUNBc=;
        b=FAbGKTaWIQU8cvEQ2R/oAlqkHEPBOG4Q9fDbDevuLH9/oWNqy+KsXP7uTzAtT/aL2K
         thTddXZuHQ0rbe5a3r76J2WTCFNDILmnGqpV6okOw9AL/O1uvTmnxgTqcWboszVigWX5
         s+NdYFrwhCia6Rbd6Q1fF6WujVjw3Hr69hjd/WIIcjXYUv0djESetHtRTZAuuSJIgw/k
         jUAJ4NtstZaCAIS3yPuVoQube6gQ/yXf1GLknN//kjcYJbxJqIUcubGJjx6SyLdmbaWC
         kwjuQ5BKtXEDXluGFLiwg1uqsgZs4lV45s47j1b9SjxJZKZgXsvDtcxdgQ8BOoo6Whed
         zLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058541; x=1685650541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jGjRdSM45bNUBJFmbAVw08c7UDEaSwJ+p/sRBnUNBc=;
        b=DH3d6CS7k9mwEIYZ5rW8pjUSqTNeXc8uSMlBxCW+buoCmnXowOmBGkUxNDlzWLMisr
         HkajLGqaUrlL76RXm+k1lr9q20Hx/NQ5B345ZTAbSDXQ+fEUQuB6WG9sgDyF6i4IDto6
         5FkyG7Vcc2q0RxRONLsfwQ1g2mSx8vhQShQ9+fvzCVe1Ar9Z7Dv9YZvhIhIMPp4cOzLG
         1vuwmV/+iUMZr4B+BniBNLrzUeLrGrmnKebhxRwH7fIOjZHT+k2AtGkRPUWVGqn6wM3J
         Zp/qluTM/9yJYyJ0yTxk2l/9BozUIMwfIzM2t20hIJ9nZOg8y8Z7pwdUsA+B9FKGbJbY
         lFjg==
X-Gm-Message-State: AC+VfDxmkLFxH3PjNFh9jKp1zfltIxMvslDzIvyOY78Wi3R7OMciY6qQ
        u3h+fcONhAd52coYW46fQswUyF8jmlE=
X-Google-Smtp-Source: ACHHUZ4v9wq5D5MggBRwtN7Vyn9BLAXGGACtc/CM9UFzeRcWZUhOy9gG+gylpRVM1kTInD0og8IUGQ==
X-Received: by 2002:a17:902:ecc5:b0:1a1:b440:3773 with SMTP id a5-20020a170902ecc500b001a1b4403773mr23543955plh.27.1683058541461;
        Tue, 02 May 2023 13:15:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0019cb6222691sm20133364plo.133.2023.05.02.13.15.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:15:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
Date:   Tue,  2 May 2023 13:15:33 -0700
Message-Id: <20230502201534.1500462-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502201534.1500462-1-luiz.dentz@gmail.com>
References: <20230502201534.1500462-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

Commit 06149746e720 ("Bluetooth: hci_conn: Add support for linking
multiple hcon") reintroduced a previously fixed bug [1] ("KASAN:
slab-use-after-free Read in hci_conn_hash_flush"). This bug was
originally fixed by commit 5dc7d23e167e ("Bluetooth: hci_conn: Fix
possible UAF").

The hci_conn_unlink function was added to avoid invalidating the link
traversal caused by successive hci_conn_del operations releasing extra
connections. However, currently hci_conn_unlink itself also releases
extra connections, resulted in the reintroduced bug.

This patch follows a more robust solution for cleaning up all
connections, by repeatedly removing the first connection until there are
none left. This approach does not rely on the inner workings of
hci_conn_del and ensures proper cleanup of all connections.

Meanwhile, we need to make sure that hci_conn_del never fails. Indeed it
doesn't, as it now always returns zero. To make this a bit clearer, this
patch also changes its return type to void.

Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000aa920505f60d25ad@google.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 33 +++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a6c8aee2f256..8baf34639939 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1327,7 +1327,7 @@ int hci_le_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
-int hci_conn_del(struct hci_conn *conn);
+void hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 44d0643fc681..1e8910c50bef 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1083,6 +1083,14 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
+		/* If hdev is down it means
+		 * hci_dev_close_sync/hci_conn_hash_flush is in progress
+		 * and links don't need to be cleanup as all connections would
+		 * be cleanup.
+		 */
+		if (!test_bit(HCI_UP, &hdev->flags))
+			return;
+
 		list_for_each_entry_safe(link, t, &conn->link_list, list) {
 			struct hci_conn *child = link->conn;
 
@@ -1112,7 +1120,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	conn->link = NULL;
 }
 
-int hci_conn_del(struct hci_conn *conn)
+void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -1163,8 +1171,6 @@ int hci_conn_del(struct hci_conn *conn)
 	 * rest of hci_conn_del.
 	 */
 	hci_conn_cleanup(conn);
-
-	return 0;
 }
 
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
@@ -2465,22 +2471,27 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 /* Drop all connection on the device */
 void hci_conn_hash_flush(struct hci_dev *hdev)
 {
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn *c, *n;
+	struct list_head *head = &hdev->conn_hash.list;
+	struct hci_conn *conn;
 
 	BT_DBG("hdev %s", hdev->name);
 
-	list_for_each_entry_safe(c, n, &h->list, list) {
-		c->state = BT_CLOSED;
-
-		hci_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
+	/* We should not traverse the list here, because hci_conn_del
+	 * can remove extra links, which may cause the list traversal
+	 * to hit items that have already been released.
+	 */
+	while ((conn = list_first_entry_or_null(head,
+						struct hci_conn,
+						list)) != NULL) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
 
 		/* Unlink before deleting otherwise it is possible that
 		 * hci_conn_del removes the link which may cause the list to
 		 * contain items already freed.
 		 */
-		hci_conn_unlink(c);
-		hci_conn_del(c);
+		hci_conn_unlink(conn);
+		hci_conn_del(conn);
 	}
 }
 
-- 
2.40.0

