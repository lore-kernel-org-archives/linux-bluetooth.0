Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80BBC77B60
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 17:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjD3R35 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3R34 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 13:29:56 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14A5C1997
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=1UbMVhvH0F
        3nH+7yZ6gBu5L2luP5MRWn9iz/BGx8iyw=; b=pMd20aadPdgm0Z3ratL2PTL8m9
        DCvQTxtzHlqTp751gP2epGAg8X2kXUSt6DfuspEhJDdr4pJS+nTXEzXtQMIx2wT1
        E78+Rmq15DXnWZdYABQxuBDpBiFcPaldhnkwu0Tz0KDBvM2pe2DQIZS2NVF6ldB9
        yW4KGMsj8BCGWH7zM=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogCH7r6LpU5kh9D1AA--.45775S2;
        Mon, 01 May 2023 01:29:51 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH] Bluetooth: Fix potential double free caused by hci_conn_unlink
Date:   Mon,  1 May 2023 01:29:37 +0800
Message-Id: <20230430172937.157999-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogCH7r6LpU5kh9D1AA--.45775S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWkCrWrXrW8JryrKr1xXwb_yoW8CFy8pa
        43WayfXFWktwn3ZF4jyw4kWFs0vw1kZFy3Kr1rtryrJws0qr48Aw40kryUKFZ8ZrWkWF4j
        vF4Utr1xKF4UC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
        jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw2
        0F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AAGsk
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The hci_conn_unlink function is being called by hci_conn_del, which means
it should not call hci_conn_del with the input parameter conn again. If it
does, conn may have already been released when hci_conn_unlink returns,
leading to potential UAF and double-free issues.

This patch resolves the problem by modifying hci_conn_unlink to release
only conn's child links when necessary, but never release conn itself.

Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 net/bluetooth/hci_conn.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 85c34c837..5f388202f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1083,8 +1083,18 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
-		list_for_each_entry_safe(link, t, &conn->link_list, list)
-			hci_conn_unlink(link->conn);
+		list_for_each_entry_safe(link, t, &conn->link_list, list) {
+			struct hci_conn *child = link->conn;
+
+			hci_conn_unlink(child);
+
+			/* Due to race, SCO connection might be not established
+			 * yet at this point. Delete it now, otherwise it is
+			 * possible for it to be stuck and can't be deleted.
+			 */
+			if (child->handle == HCI_CONN_HANDLE_UNSET)
+				hci_conn_del(child);
+		}
 
 		return;
 	}
@@ -1100,13 +1110,6 @@ static void hci_conn_unlink(struct hci_conn *conn)
 
 	kfree(conn->link);
 	conn->link = NULL;
-
-	/* Due to race, SCO connection might be not established
-	 * yet at this point. Delete it now, otherwise it is
-	 * possible for it to be stuck and can't be deleted.
-	 */
-	if (conn->handle == HCI_CONN_HANDLE_UNSET)
-		hci_conn_del(conn);
 }
 
 void hci_conn_del(struct hci_conn *conn)
-- 
2.40.0

