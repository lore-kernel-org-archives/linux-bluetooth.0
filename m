Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D05C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 13:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjECNkM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjECNkK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 09:40:10 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 801791A5
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=00kMfnGmTcd1V572l2rO+bM343Vt/bZlJS
        kWe7670UY=; b=RfiVIbn3wrEZPXdFTm5ixxuxe7+e517ltPVDzTXKKQW2rjhCrE
        uPvXgYhY1ptbnRwB3n/P+TfXkGUV5Hiv4Ay64boPYx7+QIGoroMgRbv6/OuuyVG2
        KT8SxZ4Jf1Fx0adCwuJUYa4N2uKk6lXEK1X8zoocQqvhZjISQUzDvGt9U=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogDn7k4iZFJkTkloEg--.11342S5;
        Wed, 03 May 2023 21:40:06 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v4 4/4] Bluetooth: Unlink CISes when LE disconnects in hci_conn_del
Date:   Wed,  3 May 2023 21:39:37 +0800
Message-Id: <20230503133937.169647-4-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503133937.169647-1-lrh2000@pku.edu.cn>
References: <20230503133937.169647-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogDn7k4iZFJkTkloEg--.11342S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15ZrWDtFW8tw4DXw4ruFg_yoWrAFy5pa
        4ag347Wa1kJrnxuFn2y3WkGFnYvr1DAFy7tr4rXr18J3yYqr1jyr4Fkr18KrZ8Wr95AF1U
        ZF4jqr4IgF45C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VUbX18DUUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEABVPy77yBwQAAs0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently, hci_conn_del calls hci_conn_unlink for BR/EDR, (e)SCO, and
CIS connections, i.e., everything except LE connections. However, if
(e)SCO connections are unlinked when BR/EDR disconnects, CIS connections
should also be unlinked when LE disconnects.

In terms of disconnection behavior, CIS and (e)SCO connections are not
too different. One peculiarity of CIS is that when CIS connections are
disconnected, the CIS handle isn't deleted, as per [BLUETOOTH CORE
SPECIFICATION Version 5.4 | Vol 4, Part E] 7.1.6 Disconnect command:

        All SCO, eSCO, and CIS connections on a physical link should be
        disconnected before the ACL connection on the same physical
        connection is disconnected. If it does not, they will be
        implicitly disconnected as part of the ACL disconnection.
        ...
        Note: As specified in Section 7.7.5, on the Central, the handle
        for a CIS remains valid even after disconnection and, therefore,
        the Host can recreate a disconnected CIS at a later point in
        time using the same connection handle.

Since hci_conn_link invokes both hci_conn_get and hci_conn_hold,
hci_conn_unlink should perform both hci_conn_put and hci_conn_drop as
well. However, currently it performs only hci_conn_put.

This patch makes hci_conn_unlink call hci_conn_drop as well, which
simplifies the logic in hci_conn_del a bit and may benefit future users
of hci_conn_unlink. But it is noted that this change additionally
implies that hci_conn_unlink can queue disc_work on conn itself, with
the following call stack:

        hci_conn_unlink(conn)  [conn->parent == NULL]
                -> hci_conn_unlink(child)  [child->parent == conn]
                        -> hci_conn_drop(child->parent)
                                -> queue_delayed_work(&conn->disc_work)

Queued disc_work after hci_conn_del can be spurious, so during the
process of hci_conn_del, it is necessary to make the call to
cancel_delayed_work(&conn->disc_work) after invoking hci_conn_unlink.

Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ce588359b..f75ef12f1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1100,7 +1100,9 @@ static void hci_conn_unlink(struct hci_conn *conn)
 			 * yet at this point. Delete it now, otherwise it is
 			 * possible for it to be stuck and can't be deleted.
 			 */
-			if (child->handle == HCI_CONN_HANDLE_UNSET)
+			if ((child->type == SCO_LINK ||
+			     child->type == ESCO_LINK) &&
+			    child->handle == HCI_CONN_HANDLE_UNSET)
 				hci_conn_del(child);
 		}
 
@@ -1113,6 +1115,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	list_del_rcu(&conn->link->list);
 	synchronize_rcu();
 
+	hci_conn_drop(conn->parent);
 	hci_conn_put(conn->parent);
 	conn->parent = NULL;
 
@@ -1126,12 +1129,13 @@ void hci_conn_del(struct hci_conn *conn)
 
 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
 
+	hci_conn_unlink(conn);
+
 	cancel_delayed_work_sync(&conn->disc_work);
 	cancel_delayed_work_sync(&conn->auto_accept_work);
 	cancel_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
-		hci_conn_unlink(conn);
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
 	} else if (conn->type == LE_LINK) {
@@ -1142,13 +1146,6 @@ void hci_conn_del(struct hci_conn *conn)
 		else
 			hdev->acl_cnt += conn->sent;
 	} else {
-		struct hci_conn *acl = conn->parent;
-
-		if (acl) {
-			hci_conn_unlink(conn);
-			hci_conn_drop(acl);
-		}
-
 		/* Unacked ISO frames */
 		if (conn->type == ISO_LINK) {
 			if (hdev->iso_pkts)
@@ -2485,12 +2482,6 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 						list)) != NULL) {
 		conn->state = BT_CLOSED;
 		hci_disconn_cfm(conn, HCI_ERROR_LOCAL_HOST_TERM);
-
-		/* Unlink before deleting otherwise it is possible that
-		 * hci_conn_del removes the link which may cause the list to
-		 * contain items already freed.
-		 */
-		hci_conn_unlink(conn);
 		hci_conn_del(conn);
 	}
 }
-- 
2.40.0

