Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFAC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 20:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjEBUP6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjEBUP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 16:15:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545691BE5
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 13:15:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab13da70a3so7856915ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683058537; x=1685650537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgeP9iViJu3wZuagkzymDfMYkLiOzZ5zvhKcpAeRDdU=;
        b=YXMoYfbJIJQadFkk0/NrNCQcMZbihyXUBJGHXs8jqNv99Wud4KJBtaz5+WHyyQLFJc
         LjpLR5X63sAXJ+2gujnyN+BbEjD5V0n1Q44JHqEl1b/pfyhrbU5QbwxfshjhkXD1JqWR
         uAjJxsMoujOmqr5HwJuGbgDGlye8dfIX++/fRFSJxb6eDDioEni2V+pH84xh6ub3Osnn
         XYygBfxFgfdWIC7aGN0vlVEgEcPBSTWP8PEd/PN+yXmXYsVXfNaZsUUiI3jYEybcxGjU
         M41RoALc+Jfjo4jGnPzQgbE7rL7pLykiTv9HGxk5n3GqYG0emdnTeVvlOAQb0R4eeAhk
         aQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058537; x=1685650537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgeP9iViJu3wZuagkzymDfMYkLiOzZ5zvhKcpAeRDdU=;
        b=ZPT4Z5pXCjMQIqBihZdDMbP1SfdzyTnLp1G9ADh6R3cKOYZpNWsmyJsVXxyJr4RO0j
         TgOKLKUqBOLY0pfxxqHjssRfd3B9OdwOp8bN4PusNHjB7YR/veEME2S8Oc8hMnNii1QS
         2Ggv0noE4X+KIoiSq8Jnh4SzTsszWvAs0Hx8tDryR/pEuu7zvi/wxOdO4gj5I8O3erlC
         ZjBLalH0ansIzM9zoGJFccn7U4niOuZ0KBRcX2AP4WYOa9fjOSlJtXustkYc23eJbCMw
         ubQo0zBXcRlVy9MIBip0ruVr+fSgJBZJkwHmO513oXtsIK5x/3Hlk303OJY4nvUF9fWx
         Zf1g==
X-Gm-Message-State: AC+VfDwR5E1DnQm0htXYs7zC5UUA5P700E/h4BPgQD6ndyOuez17lSp/
        lzNQV1ojurhZJE000eWx9aFgr5V3Z8M=
X-Google-Smtp-Source: ACHHUZ6h6S+dfhUaKfvtZykdQ/Q0nfLK1ekAYnZQFrH2awNWHYXnIRe6g6GivxFxDrjJt1uCEUktWw==
X-Received: by 2002:a17:902:ce05:b0:1a9:2ae4:6c1e with SMTP id k5-20020a170902ce0500b001a92ae46c1emr18884327plg.4.1683058537419;
        Tue, 02 May 2023 13:15:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0019cb6222691sm20133364plo.133.2023.05.02.13.15.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:15:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
Date:   Tue,  2 May 2023 13:15:31 -0700
Message-Id: <20230502201534.1500462-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

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
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 640b951bf40a..70e1655a9df6 100644
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

