Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A362CD6E56
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 10:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjJKKBH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 06:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjJKKBF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 06:01:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F192
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 03:01:03 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S57VM4fdPzVl97;
        Wed, 11 Oct 2023 17:57:31 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 18:01:00 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Make handle of hci_conn be unique
Date:   Wed, 11 Oct 2023 17:57:31 +0800
Message-ID: <20231011095731.1947052-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The handle of new hci_conn is always HCI_CONN_HANDLE_MAX + 1 if
the handle of the first hci_conn entry in hci_dev->conn_hash->list
is not HCI_CONN_HANDLE_MAX + 1. Use ida to manage the allocation of
hci_conn->handle to make it be unique.

Fixes: 9f78191cc9f1 ("Bluetooth: hci_conn: Always allocate unique handles")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 30 +++++++++++++-----------------
 net/bluetooth/hci_core.c         |  3 +++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f36c1fd5d64e..a0c0e12e3a18 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -350,6 +350,8 @@ struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
 
+	struct ida	unset_handle_ida;
+
 	const char	*name;
 	unsigned long	flags;
 	__u16		id;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 974631e652c1..6ec161bf569a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -153,6 +153,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 	hci_conn_hash_del(hdev, conn);
 
+	if (HCI_CONN_HANDLE_UNSET(conn->handle))
+		ida_free(&hdev->unset_handle_ida, conn->handle);
+
 	if (conn->cleanup)
 		conn->cleanup(conn);
 
@@ -929,29 +932,17 @@ static void cis_cleanup(struct hci_conn *conn)
 	hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
 }
 
-static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
+static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
 {
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn  *c;
-	u16 handle = HCI_CONN_HANDLE_MAX + 1;
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		/* Find the first unused handle */
-		if (handle == 0xffff || c->handle != handle)
-			break;
-		handle++;
-	}
-	rcu_read_unlock();
-
-	return handle;
+	return ida_alloc_range(&hdev->unset_handle_ida, HCI_CONN_HANDLE_MAX + 1,
+			       U16_MAX, GFP_ATOMIC);
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role)
 {
 	struct hci_conn *conn;
+	int handle;
 
 	BT_DBG("%s dst %pMR", hdev->name, dst);
 
@@ -961,7 +952,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	bacpy(&conn->dst, dst);
 	bacpy(&conn->src, &hdev->bdaddr);
-	conn->handle = hci_conn_hash_alloc_unset(hdev);
+	handle = hci_conn_hash_alloc_unset(hdev);
+	if (unlikely(handle < 0)) {
+		kfree(conn);
+		return NULL;
+	}
+	conn->handle = handle;
 	conn->hdev  = hdev;
 	conn->type  = type;
 	conn->role  = role;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 195aea2198a9..65601aa52e0d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2535,6 +2535,8 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
+	ida_init(&hdev->unset_handle_ida);
+
 	INIT_LIST_HEAD(&hdev->mesh_pending);
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->reject_list);
@@ -2789,6 +2791,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	hci_codec_list_clear(&hdev->local_codecs);
 	hci_dev_unlock(hdev);
 
+	ida_destroy(&hdev->unset_handle_ida);
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
 	kfree_skb(hdev->recv_event);
-- 
2.25.1

