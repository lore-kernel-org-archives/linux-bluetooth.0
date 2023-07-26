Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9488FC001DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGZV0G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjGZV0D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:03 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2998326A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:47 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RB6Q161v0z107j;
        Thu, 27 Jul 2023 00:25:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690406745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hPuiy3xlYhwpql/vmJpKc986dGEM1JauIIbxMsiXH8=;
        b=iNQSvc2B4ZbViTPjNdWYH0WPRfzD/dDo24qdIVZNFezRnZa4KxnfO2pXXELhEVvBR+4suN
        s6dwuxeL63kvs1C/yKeEcSmZm7cnd/jW3PhUzEmTWiPgqgy+wcGlheYxb1LuT60rwz2BmM
        Pu9nbOZ7drrGVqF7mJa2KLfPW5bzQHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690406745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hPuiy3xlYhwpql/vmJpKc986dGEM1JauIIbxMsiXH8=;
        b=c5zXbYQ3tSt8uk1c0wJxqh/5OCbhpAa1TDJwFhYGWvc4zGy6N1VlpRr5Xye7viBpMpMffX
        4Wv6QEjPiC3hu1NPqUK3rV73ZtBUeCOBFRmpuTiGEz7XDYW8iyA6PZ7H3dViM/12jqFzyK
        ybA73niXV0BpXazi9FZ1qbS9LhheoW0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690406745; a=rsa-sha256; cv=none;
        b=Pazk0Y4BXQZLYzzMP0dmYy/EberXneDdcMVWF0t6mD0iGpCwNQNtw1/8zwYQo0F1MXvGfL
        IAKcsWuUTErJ+ScmcMRcuc36nXKJcBpMvWHj5JXhxOtd9bJ66lIPuQg3w//N2Ec7a6P5R9
        7gOrP/9gUy0S7kInvSxz1Z+zBw4rFC4=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 3/6] Bluetooth: hci_sync: add hci_conn_sync_queue and hci_cmd_sync_dev_(un)lock
Date:   Thu, 27 Jul 2023 00:25:23 +0300
Message-ID: <15e7863c06bd87cd991ab963132fa9d12ef7e11a.1690399379.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690399379.git.pav@iki.fi>
References: <cover.1690399379.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Operations on a given hci_conn in hci_sync are hard to write safely,
because the conn might be deleted or modified unexpectedly either
concurrently or when waiting for the events.  Holding hci_dev_lock in
the sync callbacks is also inconvenient since it has to be manually
released before entering the event waits.

Add convenience utilities to make things easier:

Add hci_cmd_sync_dev_lock/unlock, for easier writing of hci_sync
callbacks where hci_dev_lock should be held. The lock is however still
released and reacquired around request waits. Callbacks using them can
then assume that state changes protected by hci_dev_lock can only occur
when waiting for events. (This is currently assumed in many of the
callbacks.)

Add hci_conn_sync_queue/submit, whose callback on entry holds
hci_dev_lock and the hci_conn has not been deleted.  If it was deleted
while the sync command was queued, the destroy routine has err -ENODEV.
Similarly, synchronous commands called in the callback fail with ENODEV
if the conn was deleted during the wait.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h |  7 ++++
 include/net/bluetooth/hci_sync.h |  3 ++
 net/bluetooth/hci_conn.c         | 60 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.c         | 31 +++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 34e4ad7c32e7..8e218300ef4e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -519,6 +519,9 @@ struct hci_dev {
 	struct work_struct	cmd_sync_cancel_work;
 	struct work_struct	reenable_adv_work;
 
+	bool			cmd_sync_locked;
+	struct hci_conn		*cmd_sync_conn;
+
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
 
@@ -1400,6 +1403,10 @@ void hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
+void hci_conn_sync_set_conn(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_conn_sync_queue(struct hci_conn *conn, hci_cmd_sync_work_func_t func,
+			void *data, hci_cmd_sync_work_destroy_t destroy);
+
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
 void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index b516a0f4a55b..a9a94950d523 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -46,6 +46,9 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
 
+void hci_cmd_sync_dev_lock(struct hci_dev *hdev);
+void hci_cmd_sync_dev_unlock(struct hci_dev *hdev);
+
 int hci_update_eir_sync(struct hci_dev *hdev);
 int hci_update_class_sync(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ee304618bf0a..208eb5eea451 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2889,3 +2889,63 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
 				  NULL);
 }
+
+struct hci_conn_sync_work_entry {
+	struct hci_conn *conn;
+	hci_cmd_sync_work_func_t func;
+	void *data;
+	hci_cmd_sync_work_destroy_t destroy;
+};
+
+static int hci_conn_sync_work_run(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn_sync_work_entry *entry = data;
+	int err;
+
+	hci_cmd_sync_dev_lock(hdev);
+	hdev->cmd_sync_conn = entry->conn;
+
+	if (hci_conn_is_alive(hdev, entry->conn))
+		err = entry->func(hdev, entry->data);
+	else
+		err = -ENODEV;
+
+	hdev->cmd_sync_conn = NULL;
+	hci_cmd_sync_dev_unlock(hdev);
+
+	return err;
+}
+
+static void hci_conn_sync_work_destroy(struct hci_dev *hdev, void *data,
+				       int err)
+{
+	struct hci_conn_sync_work_entry *entry = data;
+
+	if (entry->destroy)
+		entry->destroy(hdev, entry->data, err);
+	hci_conn_put(entry->conn);
+	kfree(entry);
+}
+
+int hci_conn_sync_queue(struct hci_conn *conn, hci_cmd_sync_work_func_t func,
+			void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	struct hci_conn_sync_work_entry *entry;
+	int err;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->func = func;
+	entry->data = data;
+	entry->destroy = destroy;
+	entry->conn = hci_conn_get(conn);
+
+	err = hci_cmd_sync_queue(conn->hdev, hci_conn_sync_work_run, entry,
+				 hci_conn_sync_work_destroy);
+	if (err)
+		kfree(entry);
+
+	return err;
+}
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3348a1b0e3f7..6a295a9e1f5d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -164,10 +164,16 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	if (err < 0)
 		return ERR_PTR(err);
 
+	if (hdev->cmd_sync_locked)
+		hci_dev_unlock(hdev);
+
 	err = wait_event_interruptible_timeout(hdev->req_wait_q,
 					       hdev->req_status != HCI_REQ_PEND,
 					       timeout);
 
+	if (hdev->cmd_sync_locked)
+		hci_dev_lock(hdev);
+
 	if (err == -ERESTARTSYS)
 		return ERR_PTR(-EINTR);
 
@@ -185,6 +191,11 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		break;
 	}
 
+	if (hdev->cmd_sync_conn) {
+		if (!hci_conn_is_alive(hdev, hdev->cmd_sync_conn))
+			err = -ENODEV;
+	}
+
 	hdev->req_status = 0;
 	hdev->req_result = 0;
 	skb = hdev->req_skb;
@@ -740,6 +751,26 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
+void hci_cmd_sync_dev_lock(struct hci_dev *hdev)
+{
+	lockdep_assert_held(&hdev->req_lock);
+
+	hci_dev_lock(hdev);
+
+	WARN_ON_ONCE(hdev->cmd_sync_locked);
+	hdev->cmd_sync_locked = true;
+}
+
+void hci_cmd_sync_dev_unlock(struct hci_dev *hdev)
+{
+	lockdep_assert_held(&hdev->req_lock);
+
+	WARN_ON_ONCE(!hdev->cmd_sync_locked);
+	hdev->cmd_sync_locked = false;
+
+	hci_dev_unlock(hdev);
+}
+
 int hci_update_eir_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_write_eir cp;
-- 
2.41.0

