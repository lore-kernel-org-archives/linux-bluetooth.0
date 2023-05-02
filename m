Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C936C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 14:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjEBO6J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjEBO6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 10:58:01 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD9962723
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=HxCd4rFmxpf8MfjsXA8dHp1Xyd+DZGMT1H
        r7aQFCMrA=; b=epzL2WH+Ohcrpl9r2IjoNk68zWNUJ4I1S1L/rm+dGXp86Zwjl7
        kQKrwWLvsOrTyBQu65+hI28oNNzDuSRPZV9AFq733/A0psdtg2l43FoLaR8u095n
        dplnxVItw7NhNsqSQg8Wticf01g9bw+dLkcCpUc54BZ1ppfOFSFCZFKK0=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBXX5fjJFFk6i5LAQ--.10226S6;
        Tue, 02 May 2023 22:57:48 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH v3 4/6] Bluetooth: Perform hci_conn_drop in hci_conn_unlink
Date:   Tue,  2 May 2023 22:57:35 +0800
Message-Id: <20230502145737.140856-5-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502145737.140856-1-lrh2000@pku.edu.cn>
References: <20230502145737.140856-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBXX5fjJFFk6i5LAQ--.10226S6
X-Coremail-Antispam: 1UD129KBjvJXoW7trykKF4xuw1DCr1UAw4xWFg_yoW8KF4Dpa
        4Y934UXa1kJrZ09Fn2kr4kXFnYqr1DAFy7tr18Jr18Jws5tr1jyw4SkF18Kr45ZrWkJF1x
        ZF4jqr1IgF1UGr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9j1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VU1c4S5UUUUU==
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgETBVPy77xtrQAAsn
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
---
 net/bluetooth/hci_conn.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index eef148291..e76ebb50d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1105,6 +1105,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	list_del_rcu(&conn->link->list);
 	synchronize_rcu();
 
+	hci_conn_drop(conn->parent);
 	hci_conn_put(conn->parent);
 	conn->parent = NULL;
 
@@ -1118,7 +1119,6 @@ void hci_conn_del(struct hci_conn *conn)
 
 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
 
-	cancel_delayed_work_sync(&conn->disc_work);
 	cancel_delayed_work_sync(&conn->auto_accept_work);
 	cancel_delayed_work_sync(&conn->idle_work);
 
@@ -1134,12 +1134,7 @@ void hci_conn_del(struct hci_conn *conn)
 		else
 			hdev->acl_cnt += conn->sent;
 	} else {
-		struct hci_conn *acl = conn->parent;
-
-		if (acl) {
-			hci_conn_unlink(conn);
-			hci_conn_drop(acl);
-		}
+		hci_conn_unlink(conn);
 
 		/* Unacked ISO frames */
 		if (conn->type == ISO_LINK) {
@@ -1152,6 +1147,11 @@ void hci_conn_del(struct hci_conn *conn)
 		}
 	}
 
+	/* hci_conn_unlink may trigger additional disc_work, so
+	 * ensure to perform cancelling after that.
+	 */
+	cancel_delayed_work_sync(&conn->disc_work);
+
 	if (conn->amp_mgr)
 		amp_mgr_put(conn->amp_mgr);
 
-- 
2.40.0

