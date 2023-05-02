Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB8C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 14:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjEBO6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjEBO6A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 10:58:00 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDE91273C
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=5F7Xn4VuaYHkhG59E72wk6A+DGy1euMitS
        xWn5Qzcc4=; b=nvHp7qSt/32GAyT6oiapULjO84JpoJTv04/ae8muEZyZtbGJfM
        FmRbz1Qi/AIb99cgJyddc6Z+L+Lqn5cKIHcmC0c1RLqEm6ixN9221FPTxzKzMz5u
        8+EGNja7B7f2FObgww++ZyvOLjBRoCPsfcc14qoxjHv5U+TEEygfJsVcE=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBXX5fjJFFk6i5LAQ--.10226S8;
        Tue, 02 May 2023 22:57:48 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH v3 6/6] Bluetooth: Avoid recursion in hci_conn_unlink
Date:   Tue,  2 May 2023 22:57:37 +0800
Message-Id: <20230502145737.140856-7-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502145737.140856-1-lrh2000@pku.edu.cn>
References: <20230502145737.140856-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBXX5fjJFFk6i5LAQ--.10226S8
X-Coremail-Antispam: 1UD129KBjvJXoWxury8Cr17ZF4fWF1UJw1DWrg_yoW5XFy8pa
        43Wa4fZr48twna9F42yw1DJrn0qr1kZFy3KryrJF1kJw4Fvw4qyr40k34UKry5ZrWkWFy7
        AF4jqF18KF4UGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AAds-
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Previously, hci_conn_unlink was implemented as a recursion function. To
unlink physical connections (e.g. ACL/LE), it calls itself to unlink all
its logical channels (e.g. SCO/eSCO/ISO).

Recursion is not required. This patch refactors hci_conn_unlink into two
functions, where hci_conn_unlink_parent takes a physical connection,
checks out all its logical channels, and calls hci_conn_unlink_child for
each logical channel to unlink it.

Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 net/bluetooth/hci_conn.c | 55 +++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index de553e062..243d68a64 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1074,34 +1074,13 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return conn;
 }
 
-static void hci_conn_unlink(struct hci_conn *conn)
+static void hci_conn_unlink_parent(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
-	if (!conn->parent) {
-		struct hci_link *link, *t;
-
-		list_for_each_entry_safe(link, t, &conn->link_list, list) {
-			struct hci_conn *child = link->conn;
-
-			hci_conn_unlink(child);
-
-			/* Due to race, SCO connection might be not established
-			 * yet at this point. Delete it now, otherwise it is
-			 * possible for it to be stuck and can't be deleted.
-			 */
-			if ((child->type == SCO_LINK ||
-			     child->type == ESCO_LINK) &&
-			    child->handle == HCI_CONN_HANDLE_UNSET)
-				hci_conn_del(child);
-		}
-
-		return;
-	}
-
-	if (!conn->link)
+	if (WARN_ON(!conn->link))
 		return;
 
 	list_del_rcu(&conn->link->list);
@@ -1115,6 +1094,36 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	conn->link = NULL;
 }
 
+static void hci_conn_unlink_children(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_link *link, *t;
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	list_for_each_entry_safe(link, t, &conn->link_list, list) {
+		struct hci_conn *child = link->conn;
+
+		hci_conn_unlink_parent(child);
+
+		/* Due to race, SCO connection might be not established
+		 * yet at this point. Delete it now, otherwise it is
+		 * possible for it to be stuck and can't be deleted.
+		 */
+		if (child->type == SCO_LINK || child->type == ESCO_LINK)
+			if (child->handle == HCI_CONN_HANDLE_UNSET)
+				hci_conn_del(child);
+	}
+}
+
+static void hci_conn_unlink(struct hci_conn *conn)
+{
+	if (conn->parent)
+		hci_conn_unlink_parent(conn);
+	else
+		hci_conn_unlink_children(conn);
+}
+
 void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-- 
2.40.0

