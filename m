Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D31EC77B78
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 13:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjECNkQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjECNkP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 09:40:15 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB4A5272
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=1Cvfce/pAbE/ytwHNkPKg1BpVNhU/77VV8
        IYSuC/d+8=; b=MlcHB396PxMOm1swVGwF8y5KasBrCkJwKC9T7SfSb68K5wFCbl
        ticdz6QO0oBWKywP9Cza8UwfyzR8eYmpcD1rDHx2LrvrIR9qZOFy7cKxsXrdSW4q
        ru0B3eqCiUDoejA/i7ak68W9oLM07CY8XUVe26TcqZmkhegkc4Jmh3e4E=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogDn7k4iZFJkTkloEg--.11342S4;
        Wed, 03 May 2023 21:40:05 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v4 3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
Date:   Wed,  3 May 2023 21:39:36 +0800
Message-Id: <20230503133937.169647-3-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503133937.169647-1-lrh2000@pku.edu.cn>
References: <20230503133937.169647-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogDn7k4iZFJkTkloEg--.11342S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyDWFW3Cry5Gr15Cr45ZFb_yoWrury8pa
        y5Wa45ur4kJrn3ZF1jyw4kAFn0qr1kZFy3KrW8J345J3yYyr4kArs0yryUtw45ArWkJF4U
        ZF4jqryxKFyUJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbX18DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEABVPy77yBwwAAs2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 33 +++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a6c8aee2f..8baf34639 100644
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
index 44d0643fc..ce588359b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1088,6 +1088,14 @@ static void hci_conn_unlink(struct hci_conn *conn)
 
 			hci_conn_unlink(child);
 
+			/* If hdev is down it means
+			 * hci_dev_close_sync/hci_conn_hash_flush is in progress
+			 * and links don't need to be cleanup as all connections
+			 * would be cleanup.
+			 */
+			if (!test_bit(HCI_UP, &hdev->flags))
+				continue;
+
 			/* Due to race, SCO connection might be not established
 			 * yet at this point. Delete it now, otherwise it is
 			 * possible for it to be stuck and can't be deleted.
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

