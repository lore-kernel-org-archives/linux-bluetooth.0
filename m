Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4833FC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 14:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjEBO6C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjEBO6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 10:58:01 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C4FD26BF
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding; bh=avNJ51aScZutbdGQ55v1LNc39r1/FL5jKi
        j8SkDff7k=; b=qceQn9oUNhzP03vjImu4OMXOYNPqf6B8DKaqOKZLqXu+T390eb
        07oyCTclMcQ4a617IxSEGo8rwqO3qGUcIpNnnjQ1caW9JQF5xhLtSLKrNz0Xsf8i
        +8PNWVGwYsbjgttGffkx82PN2CcIEHtz/+cbCdckVcJqs4Gr5FDWIbuK8=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBXX5fjJFFk6i5LAQ--.10226S4;
        Tue, 02 May 2023 22:57:47 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH v3 2/6] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
Date:   Tue,  2 May 2023 22:57:33 +0800
Message-Id: <20230502145737.140856-3-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502145737.140856-1-lrh2000@pku.edu.cn>
References: <20230502145737.140856-1-lrh2000@pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBXX5fjJFFk6i5LAQ--.10226S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4fKr1ftrW5WFWUGF15urg_yoW8GFW8pa
        y5uay3AFWkJrn0vF1qy3WkWrykCF1kZFy29r1rAryrJa1rtr4jyr4rCF1UKw15ZrWkGF1f
        ZF4vqwn5KFWDGFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgETBVPy77xtrgAAsk
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If hci_conn_put(conn->parent) reduces conn->parent's reference count to
zero, it can immediately deallocate conn->parent. At the same time,
conn->link->list has its head in conn->parent, causing use-after-free
problems in the latter list_del_rcu(&conn->link->list).

This problem can be easily solved by reordering the two operations,
i.e., first performing the list removal with list_del_rcu and then
decreasing the refcnt with hci_conn_put.

Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
---
 net/bluetooth/hci_conn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 70e1655a9..44d0643fc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1102,12 +1102,12 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->link)
 		return;
 
-	hci_conn_put(conn->parent);
-	conn->parent = NULL;
-
 	list_del_rcu(&conn->link->list);
 	synchronize_rcu();
 
+	hci_conn_put(conn->parent);
+	conn->parent = NULL;
+
 	kfree(conn->link);
 	conn->link = NULL;
 }
-- 
2.40.0

