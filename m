Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B051C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 14:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjEBO6E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjEBO6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 10:58:01 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDC582733
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=+23j70KJbA3hTfSGNHgn4j0Bbr5o3LtuB5
        dNkDC+QWE=; b=RHMoB8tpZc7+Vwm4SpuMtjw9OraKJpBFCJDuNlDCNttPZ11stM
        7bU6oyo97473y0TvMD5rVp0i1lmPb9gitcKwlWCuggHvSbAS9lpf6qvx7Bjzl47H
        Kihkoe9PCZAhF9f20hG2qZLqPaGzHWnUdLuoc0b6mF+kBOzwc38oqNz/k=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBXX5fjJFFk6i5LAQ--.10226S3;
        Tue, 02 May 2023 22:57:47 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Subject: [PATCH v3 1/6] Bluetooth: Fix potential double free caused by hci_conn_unlink
Date:   Tue,  2 May 2023 22:57:32 +0800
Message-Id: <20230502145737.140856-2-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502145737.140856-1-lrh2000@pku.edu.cn>
References: <20230502145737.140856-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBXX5fjJFFk6i5LAQ--.10226S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWkCrWrXrW8JryrKr1xXwb_yoW8ur45pa
        y3WayfurWktrnavF4jyw48WFs0vw1kZFy3Krn5tryrXws0vr48Ar40kryjqrZ8ZrZ5WF4Y
        vF4Utr18KF4UG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgETBVPy77xtrwAAsl
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The hci_conn_unlink function is being called by hci_conn_del, which
means it should not call hci_conn_del with the input parameter conn
again. If it does, conn may have already been released when
hci_conn_unlink returns, leading to potential UAF and double-free
issues.

This patch resolves the problem by modifying hci_conn_unlink to release
only conn's child links when necessary, but never release conn itself.

Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 net/bluetooth/hci_conn.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 640b951bf..70e1655a9 100644
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
 
 int hci_conn_del(struct hci_conn *conn)
-- 
2.40.0

