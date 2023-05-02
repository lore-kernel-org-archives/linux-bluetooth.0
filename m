Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF989C77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjEBO6G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjEBO6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 10:58:01 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE0142D41
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=9xGmf8aJdntu7YhLTCkjnA49nu1UugN/HF
        b1MKGUwPM=; b=YQnlniD7cSnV3PFVXCc0pBsUeC9CN01uDZ4OZhlMFDc5oFwkK6
        qoYkVvKl3k2miQLjUxYfEwJO++Lh79xUmNgLJ5YhOrdFIMCpB1byOh+SQWJq0Glu
        L2BzA2u3Xqyfrq0SLwkQwsT5kl6UfCajh+YJsW4DpnXr5wCXGroEsIMyg=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBXX5fjJFFk6i5LAQ--.10226S7;
        Tue, 02 May 2023 22:57:48 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH v3 5/6] Bluetooth: Unlink CISes when LE disconnects in hci_conn_del
Date:   Tue,  2 May 2023 22:57:36 +0800
Message-Id: <20230502145737.140856-6-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502145737.140856-1-lrh2000@pku.edu.cn>
References: <20230502145737.140856-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBXX5fjJFFk6i5LAQ--.10226S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15ZrWDtFW8tw4DXw4ruFg_yoW5CFyUpa
        43K3s7ur4kJwn3uFnYvay8AFsYvr1kAFy7Kr48Xw1Ut390qr1vyr4Fkw1qgrZ8Cr95Za4U
        ZF4jqr42gF15C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgETBVPy77xtsAAAs6
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

This peculiarity has nothing to do with the code, as long as the current
implementation always ties the CIS handle, the CIS connection, and the
LE connection together in hci_link, and manually performs CIS deletion
in cis_cleanup after CIS disconnections.

Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 net/bluetooth/hci_conn.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e76ebb50d..de553e062 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1092,7 +1092,9 @@ static void hci_conn_unlink(struct hci_conn *conn)
 			 * yet at this point. Delete it now, otherwise it is
 			 * possible for it to be stuck and can't be deleted.
 			 */
-			if (child->handle == HCI_CONN_HANDLE_UNSET)
+			if ((child->type == SCO_LINK ||
+			     child->type == ESCO_LINK) &&
+			    child->handle == HCI_CONN_HANDLE_UNSET)
 				hci_conn_del(child);
 		}
 
@@ -1119,11 +1121,17 @@ void hci_conn_del(struct hci_conn *conn)
 
 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
 
+	hci_conn_unlink(conn);
+
+	/* hci_conn_unlink may trigger additional disc_work, so
+	 * ensure to perform cancelling after that.
+	 */
+	cancel_delayed_work_sync(&conn->disc_work);
+
 	cancel_delayed_work_sync(&conn->auto_accept_work);
 	cancel_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
-		hci_conn_unlink(conn);
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
 	} else if (conn->type == LE_LINK) {
@@ -1134,8 +1142,6 @@ void hci_conn_del(struct hci_conn *conn)
 		else
 			hdev->acl_cnt += conn->sent;
 	} else {
-		hci_conn_unlink(conn);
-
 		/* Unacked ISO frames */
 		if (conn->type == ISO_LINK) {
 			if (hdev->iso_pkts)
@@ -1147,11 +1153,6 @@ void hci_conn_del(struct hci_conn *conn)
 		}
 	}
 
-	/* hci_conn_unlink may trigger additional disc_work, so
-	 * ensure to perform cancelling after that.
-	 */
-	cancel_delayed_work_sync(&conn->disc_work);
-
 	if (conn->amp_mgr)
 		amp_mgr_put(conn->amp_mgr);
 
-- 
2.40.0

