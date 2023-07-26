Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B181FC04A94
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGZV0I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGZV0D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:03 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B426AC
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:47 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RB6Q16qHjz107y;
        Thu, 27 Jul 2023 00:25:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690406746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4V1uWl2v29EFzh2Lvit/4KNTqlM0Wa8H2yX7NKORRM=;
        b=qDNONah0H9kCE6/Pscyne1JCu3EsO34+Gc1kSsT+W0lYN7dAJguvdOR3fnTbYZfRr+Oj1z
        kLmsIA6D2p1xsvpUJLpqDG0zy+DkJ9gKojb/0bGHb3tEXKt4hIlKfiPSpdqQnraSRdf1iu
        HR5uFpplqpNTZJDakx7CLJSez5WT6JI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690406746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4V1uWl2v29EFzh2Lvit/4KNTqlM0Wa8H2yX7NKORRM=;
        b=uq0+fuzSwpVrlkQs5SsaLb7EuhJ5u4ATgQ6U9AEfXkbShgWsLCkW+X8Gg+ffWbn43M12Au
        N6CcLQb/NcXFwOOefRaP+M77S7gA0ZgsiSJcpnrfAyPQYyMTL7ipCqrau5slSXTtA7bVGk
        BtJ2s+1kWGAidJmxzh+YraYMvfu42vk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690406746; a=rsa-sha256; cv=none;
        b=k4nI/Pebyex6kD5QB3682gnD/MyhsCBgxowKDEEIV9wD1Tw99SzAx1IT1QJ6cdzsIIU3+p
        gtS4c8FibwUCrmEju5LeLyMeZBACfIvLoeuB0H8szCT6yAEKKzfiF7deI1Ry79WwUnOrQ6
        WChSPRAwpvsPZ+j0p6x4EmZu7J7uMZM=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 4/6] Bluetooth: hci_sync: fix locking in hci_conn_abort and hci_disconnect_all_sync
Date:   Thu, 27 Jul 2023 00:25:24 +0300
Message-ID: <70a377ca228992facffcc57d77e9acdbde8e46a7.1690399379.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690399379.git.pav@iki.fi>
References: <cover.1690399379.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_conn_abort may run concurrently with operations that e.g. change
conn handle or delete it.  Similarly, hci_disconnect_all_sync iterates
conn_hash without locks/RCU which is not OK.

To make it correct vs locking, use hci_conn_sync_queue to hold
hdev->lock and check hci_conn aliveness after waiting for events.

Make iteration in hci_disconnect_all_sync safe. Since we don't have a
flag for indicating whether a connection was aborted, just make a copy
of the conn_hash and iterate the copy.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    The iterate-over-copy is ugly, could add another hci_conn flag.  Or
    change things so that hci_conn_get keeps the hci_conn in conn_hash so we
    can always continue the iteration safely as long as a reference was
    held.

 net/bluetooth/hci_conn.c | 10 ++------
 net/bluetooth/hci_sync.c | 52 ++++++++++++++++++++++++++++------------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 208eb5eea451..ba339a0eb851 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2845,12 +2845,7 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
+	struct hci_conn *conn = data;
 
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
 }
@@ -2886,8 +2881,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		}
 	}
 
-	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
-				  NULL);
+	return hci_conn_sync_queue(conn, abort_conn_sync, conn, NULL);
 }
 
 struct hci_conn_sync_work_entry {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6a295a9e1f5d..101548fe81da 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5407,6 +5407,8 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err;
 
+	lockdep_assert_held(&hdev->lock);
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
@@ -5418,21 +5420,15 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		 * or in case of LE it was still scanning so it can be cleanup
 		 * safely.
 		 */
-		if (err) {
-			hci_dev_lock(hdev);
+		if (err && hci_conn_is_alive(hdev, conn))
 			hci_conn_failed(conn, err);
-			hci_dev_unlock(hdev);
-		}
 		return err;
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
 	case BT_OPEN:
 		/* Cleanup bises that failed to be established */
-		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags)) {
-			hci_dev_lock(hdev);
+		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags))
 			hci_conn_failed(conn, reason);
-			hci_dev_unlock(hdev);
-		}
 		break;
 	default:
 		conn->state = BT_CLOSED;
@@ -5444,16 +5440,42 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 {
-	struct hci_conn *conn, *tmp;
-	int err;
+	struct hci_conn *conn;
+	struct hci_conn **conns;
+	int err = 0;
+	size_t i, n;
 
-	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
-		err = hci_abort_conn_sync(hdev, conn, reason);
-		if (err)
-			return err;
+	hci_cmd_sync_dev_lock(hdev);
+
+	/* Make a copy of conn_hash, because hci_abort_conn_sync may release the
+	 * lock and wait for events, during which the list may be mutated
+	 * arbitrarily.
+	 */
+	n = 0;
+	list_for_each_entry(conn, &hdev->conn_hash.list, list)
+		++n;
+
+	conns = kvcalloc(n, sizeof(*conns), GFP_KERNEL);
+	if (!conns) {
+		err = -ENOMEM;
+		goto unlock;
 	}
 
-	return 0;
+	i = 0;
+	list_for_each_entry(conn, &hdev->conn_hash.list, list)
+		conns[i++] = hci_conn_get(conn);
+
+	for (i = 0; i < n; ++i) {
+		if (!err)
+			err = hci_abort_conn_sync(hdev, conns[i], reason);
+		hci_conn_put(conns[i]);
+	}
+
+	kvfree(conns);
+
+unlock:
+	hci_cmd_sync_dev_unlock(hdev);
+	return err;
 }
 
 /* This function perform power off HCI command sequence as follows:
-- 
2.41.0

