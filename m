Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7D0EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjFWRTQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjFWRS6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 13:18:58 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748D26BD
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 10:18:50 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QnkVJ0ZZMz49Q6x;
        Fri, 23 Jun 2023 20:18:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83dDQcYbe5pUPhhpcZmbxd8AG+PU0UpwwamkIDyKTnc=;
        b=O1BRBGfQwA30r8jYsv/ICrk333+u0tmT5vJZUT90LXy9saBmNxa5PQi38n/x94ihgX4IEE
        0L6fa/brW0rjIHm1AlikzezJ4OAQdqgZya9Hir8MJ3/PD0UeUF2NVsWLWlfUT3/ZUPs9SD
        A3YgDd3ZHKTITcUqEQgFGBk/2dTIaaD60iFmCvhzrsNU2JwK9+1hhwHcHuZ8Akn0JiDtap
        pmzVIlLc/ugIB+P5HsBm0UHE7A+L+az8XWRsdGoIPari5pqfgKm8dpYRT29x0PD9vmGcEv
        fqYSq0N5CtZtR7U8W0urUA9HMrzIZay5+w02mlFFJNM9idhi7hjbJXGa20ew2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83dDQcYbe5pUPhhpcZmbxd8AG+PU0UpwwamkIDyKTnc=;
        b=eA4220M6MRXLHtB3pGKTLnEnhjoTKdW4gf/SoR4s99ETkT3zfd4cN7eGnoJhpU3MbPqsyQ
        8yUbGEqOJyTLSn1537jTDXcfx0Ro6zZdwWYh2b5TSL/1tYNPQJ7jVp4mmMR84PnlzOcfsL
        KWADrRC2UPT8mak+73wZvHcUtBCIdvSt9Aw1UY2TZv75qu4NkHHzZTZYnn297GCGD97ymb
        zph2nfALUJqbCtYX/mcyUzAzO+SH4igCsjSmWdwmc+uhV6usD5wQZBSU4OmNZNM1cdaGKT
        Ds6HmlDigoHXpsngZOGaMnGzHp+AAytcTyGDXFbgY7bdq17+bWMN3X4q5DQhYA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687540728; a=rsa-sha256;
        cv=none;
        b=u6QMHw2+eNq9m5YagDl2g2hQC2dHpkujvJGcz/Oxd++LHOVoG3r1fApGJfBKrx8/fYcAPL
        fh1c5jmFDzeGbJ41+5IVR4Pn24qpWz/W7pa/KFOUhgOqvOLn3cj8TO6Wg3qDuBCSCDXKi4
        eqwDy0mTQlQv940ibTCmzhOBhufyMD+xuFONl1B0wxRmGiJzKFNr6sC9a8LloSpOw+uLuJ
        fgPyfCUBb4liABKkKG1AUdMG+JR6FOQW2xwN9hBE4BPw/OJEa/Eo1xnFeghOlw/zb+WZRJ
        BW91KPEyvBYXJyARXGGeNeG4AwDhBR3vlKFIdB6UD6HOsJ38KvP4XWfxMgIBEQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 1/5] Bluetooth: hci_conn: add hci_conn_is_alive
Date:   Fri, 23 Jun 2023 20:18:38 +0300
Message-ID: <45455ee45ccb3313618a48c01be714e14d372257.1687525956.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687525956.git.pav@iki.fi>
References: <cover.1687525956.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A delayed operation such as hci_sync on a given hci_conn needs to take
hci_conn_get, so that the hci_conn doesn't get freed in the meantime.
This does not guarantee the conn is still alive in a valid state, as it
may be cleaned up in the meantime, so one needs to check if it is still
in conn_hash to know if it's still alive.

Simplify this alive check, using HCI_CONN_DELETED flag. This is also
meaningful with RCU lock only, but with slightly different semantics.

If hci_conn_is_alive(conn) returns true inside rcu_read_lock, conn was
in conn_hash from the point of view of the current task when the flag
was read. Then its deletion cannot complete before rcu_read_unlock.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    This probably can be done with RCU primitives setting list.prev, but
    that's maybe more magical...

 include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
 net/bluetooth/hci_conn.c         | 10 +---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05a9b3ab3f56..cab39bdd0592 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -978,6 +978,7 @@ enum {
 	HCI_CONN_PER_ADV,
 	HCI_CONN_BIG_CREATED,
 	HCI_CONN_CREATE_CIS,
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
@@ -1023,6 +1025,10 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
+	bool deleted;
+
+	deleted = test_and_set_bit(HCI_CONN_DELETED, &c->flags);
+	WARN_ON(deleted);
 
 	list_del_rcu(&c->list);
 	synchronize_rcu();
@@ -1049,6 +1055,18 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	}
 }
 
+/* With hdev->lock: whether hci_conn is in conn_hash.
+ * With RCU: if true, the hci_conn is valid conn_hash iteration cursor and
+ * hci_conn_hash_del has not completed. (Note that if hci_conn was obtained in
+ * this critical section it is always valid, but this may return false!)
+ */
+static inline bool hci_conn_is_alive(struct hci_dev *hdev, struct hci_conn *c)
+{
+	RCU_LOCKDEP_WARN(lockdep_is_held(&hdev->lock) || rcu_read_lock_held(),
+			 "suspicious locking");
+	return !test_bit(HCI_CONN_DELETED, &c->flags);
+}
+
 static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 62a7ccfdfe63..d489a4829be7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -183,21 +183,13 @@ static void le_scan_cleanup(struct work_struct *work)
 	struct hci_conn *conn = container_of(work, struct hci_conn,
 					     le_scan_cleanup);
 	struct hci_dev *hdev = conn->hdev;
-	struct hci_conn *c = NULL;
 
 	BT_DBG("%s hcon %p", hdev->name, conn);
 
 	hci_dev_lock(hdev);
 
 	/* Check that the hci_conn is still around */
-	rcu_read_lock();
-	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
-		if (c == conn)
-			break;
-	}
-	rcu_read_unlock();
-
-	if (c == conn) {
+	if (hci_conn_is_alive(hdev, conn)) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
 		hci_conn_cleanup(conn);
 	}
-- 
2.41.0

