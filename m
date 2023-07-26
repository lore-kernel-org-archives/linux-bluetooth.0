Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A5BC001DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjGZV0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjGZV0C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:02 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A202D64
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:47 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RB6Q15NvBz107J;
        Thu, 27 Jul 2023 00:25:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690406745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1am/h+ATMBUgghrZPssfKQla6Kn6yuarwxQv/n87UQ=;
        b=TrLP1CbBqUc1DgZizM18niZgl6Y6J2g7sUKtGqCe/NwiQipY8Y7uUmNZ0O2mELRDBBzyQj
        mZPB5eZli3qrnCR7NKGA0X47/GCdPNEWMFsIolDp1WewrzgS2lppoGhkXQuQTK8+ivxhHX
        PAQYEn6fDHElkhUdpo7sFRdW+f7QT+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690406745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1am/h+ATMBUgghrZPssfKQla6Kn6yuarwxQv/n87UQ=;
        b=x4tGfuAjYecbMm0g0GKlWbVvPk937reMea6M4KJx9Kgp3aUkyM9cOIyiFpFmDYZ4xf9Kuw
        TPUpB1BElXv3bt+UfUtaE3keeOPvFjLcBIl7byeZczqWDDCkFX8vcid5BIPK27zpq7ojeT
        Y+trnRZvz3bjID4D2TMQAUCgJ+947Fg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690406745; a=rsa-sha256; cv=none;
        b=qVEh7rWsNWkm40lTk68xtO0z4IkMHM4fTuCbL+lnLPeDFAhjd0BnzjhvAHR2sSBYI7HbJM
        ZpGhX107mFjhHuJ6/IYksuYaF3I4QgfXPTo+fgSMLqTHlJeDa9/rUD1BGfuDbAEiLH0WL9
        3F0WvQ8ULbBCdLY99+2QOB85JUYWaLM=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 2/6] Bluetooth: hci_conn: add hci_conn_is_alive
Date:   Thu, 27 Jul 2023 00:25:22 +0300
Message-ID: <053df33e4e3b35982b257238edcde451780fc832.1690399379.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690399379.git.pav@iki.fi>
References: <cover.1690399379.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There's currently no good way to know if a given hci_conn we hold
hci_conn_get reference for has been deleted in the meanwhile.

To enable checking whether a connection is still alive, add
HCI_CONN_DELETED flag to indicate whether hci_conn_del has run.

The flag is meaningful also with RCU lock only, but with different
semantics.  If hci_conn_is_alive(conn) returns true inside
rcu_read_lock, conn was in conn_hash from the point of view of the
current task when the flag was read. Then its deletion will not complete
at least before rcu_read_unlock.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This is now suggesting the same thing once again, because the
    alternatives seem limited, and it's currently hard to write code in
    hci_sync safe against memory bugs.
    
    One alternative here is to remove the connection from conn_hash only
    when hci_conn_get/put refcount goes to zero. This simplifies resuming
    interrupted conn_hash iteration, as hci_conn_get then ensures the conn
    remains a valid iteration cursor. However, some deletion indicator flag
    is still needed, if we want to do something else with the conn.
    
    The suggestion to use conn->refcnt seems a bit hard to make it work,
    since that is used for different purpose (marking what connections
    userspace keeps alive), and it seems we'd need to change all callsites
    for hci_conn_del.
    
    E.g. in Disconnect Complete event we must remove the conn from sysfs and
    invalidate its handle immediately as the handle can be reused.
    Similarly for failed LE Create CIS while hci_conn_abort is running.
    
    It maybe could also be possible to not allow events to run while
    hci_sync is running, except when it is waiting for an event.  This seems
    actually to be the concurrency model what is assumed in the hci_sync
    code (but it is not what is actually happening).  However, it seems the
    deletion flag would be needed also here, as the conn might be gone while
    we are waiting for events.

 include/net/bluetooth/hci_core.h | 15 +++++++++++++++
 net/bluetooth/hci_conn.c         |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8200a6689b39..34e4ad7c32e7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -978,6 +978,7 @@ enum {
 	HCI_CONN_CREATE_CIS,
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
+	HCI_CONN_DELETED,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -997,6 +998,7 @@ static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
+	WARN_ON(test_bit(HCI_CONN_DELETED, &c->flags));
 	list_add_tail_rcu(&c->list, &h->list);
 	switch (c->type) {
 	case ACL_LINK:
@@ -1024,6 +1026,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 
+	WARN_ON(!test_bit(HCI_CONN_DELETED, &c->flags));
 	list_del_rcu(&c->list);
 	synchronize_rcu();
 
@@ -1049,6 +1052,18 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	}
 }
 
+/* With hdev->lock: whether hci_conn is in conn_hash.
+ * With RCU: if true, the hci_conn is valid conn_hash iteration cursor and
+ * hci_conn_hash_del has not completed. (Note that if hci_conn was obtained in
+ * this critical section it is always valid, but this may return false!)
+ */
+static inline bool hci_conn_is_alive(struct hci_dev *hdev, struct hci_conn *c)
+{
+	RCU_LOCKDEP_WARN(!lockdep_is_held(&hdev->lock) && !rcu_read_lock_held(),
+			 "suspicious locking");
+	return !test_bit(HCI_CONN_DELETED, &c->flags);
+}
+
 static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a71a54a5c8d8..ee304618bf0a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1052,9 +1052,13 @@ static void hci_conn_unlink(struct hci_conn *conn)
 void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+	bool deleted;
 
 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
 
+	deleted = test_and_set_bit(HCI_CONN_DELETED, &conn->flags);
+	WARN_ON(deleted);
+
 	hci_conn_unlink(conn);
 
 	cancel_delayed_work_sync(&conn->disc_work);
-- 
2.41.0

