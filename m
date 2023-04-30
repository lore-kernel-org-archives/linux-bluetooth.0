Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F00C77B60
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 17:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjD3R2b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjD3R23 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 13:28:29 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Apr 2023 10:28:24 PDT
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6C1310EA
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=TsL3VhsI9J
        107+YAWBivRtnC8Kfba1pt+UAOZUvb52c=; b=sucICNf5flJl1AHZO/PYfBuA9l
        VHrnKueo8cFefIBJR+JJbt/P+mPwZ5ctA8q0CMDtjPlfVcjO+4SSzvvkgG2BOGm3
        oRG/tXHtdaUtyVM4wTI8sCASd9JD/wOHHhS+dtrkQCHqR/fJvoYHK+9UljV2QjxR
        Sa4IixXB8+pESQeYw=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogA3Mrzoo05kqKb1AA--.32944S2;
        Mon, 01 May 2023 01:22:56 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: Fix UAF in hci_conn_hash_flush again
Date:   Mon,  1 May 2023 01:18:49 +0800
Message-Id: <20230430171847.156825-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogA3Mrzoo05kqKb1AA--.32944S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UJFWkGrWUJr15Cw1UAwb_yoWrGF4fpa
        y5ua45Zr4kJryrZF1jyw4kAFs0qr1kZFy3KrW8X345t3yYyr4UArs0yryjy3y5ArZ5JFyj
        vF4jgr1xKFyUA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw2
        0F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AAEsm
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple
hcon") reintroduces a previously fixed bug [1] ("KASAN: slab-use-after-free
Read in hci_conn_hash_flush"). This bug was originally fixed by commit
5dc7d23e167e ("Bluetooth: hci_conn: Fix possible UAF").

The hci_conn_unlink function was added to avoid invalidating the link
traversal caused by successive hci_conn_del operations releasing extra
connections. However, currently hci_conn_unlink itself also releases extra
connections, resulted in the reintroduced bug.

This patch follows a more robust solution for cleaning up all connections,
by repeatedly removing the first connection until there are none left. This
approach does not rely on the inner workings of hci_conn_del and ensures
proper cleanup of all connections.

However, we need to make sure that hci_conn_del never fails. Indeed it
doesn't, as it now always returns zero. To make this a bit clearer, this
patch also changes its return type to void.

Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8bb72f86fc823817bc5d
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 28 ++++++++++++----------------
 2 files changed, 13 insertions(+), 17 deletions(-)

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
index 640b951bf..85c34c837 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1109,7 +1109,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 		hci_conn_del(conn);
 }
 
-int hci_conn_del(struct hci_conn *conn)
+void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -1160,8 +1160,6 @@ int hci_conn_del(struct hci_conn *conn)
 	 * rest of hci_conn_del.
 	 */
 	hci_conn_cleanup(conn);
-
-	return 0;
 }
 
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
@@ -2462,22 +2460,20 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
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
-
-		/* Unlink before deleting otherwise it is possible that
-		 * hci_conn_del removes the link which may cause the list to
-		 * contain items already freed.
-		 */
-		hci_conn_unlink(c);
-		hci_conn_del(c);
+	/* We should not traverse the list here, because hci_conn_del
+	 * can remove extra links, which may cause the link traversal
+	 * to hit items that have already been released.
+	 */
+	while ((conn = list_first_entry_or_null(head,
+				struct hci_conn, list)) != NULL) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
+		hci_conn_del(conn);
 	}
 }
 
-- 
2.40.0

