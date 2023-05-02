Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96686C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 21:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEBVZh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 17:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEBVZg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 17:25:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881DA1734
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 14:25:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so3468016b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683062733; x=1685654733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70Rh+2ZpfORm90qgVv/tSVn6I2FZ1MSGL8nzIsbeT5Y=;
        b=Z9+useJO9jwOsY01+7O0Irpjf0WH81hCihJL1b944/gFubDyorF5OFGCByb1WmRSG0
         /cUWH+BzrOtpdmt0ijDwQ0l8iAE6svAoXit0DN84Sz31rb43pxIGyNM4fUnxcsJbYICG
         lc/h3nP5K0bp2AjL0VJt+rOFdoGPfO2AzC2+htkAEoqZJcVs6IbivJaXs4oKadrxH1M3
         bmp00SJWNTSbtd5CE4ztBaBNE17ooIh0unUyACOjB8YyvAhsjQtOjreCw0DVZDBH9dW2
         gcfinAK1ji6qDwOYrLJaXshMABw0jokWpaLf0NOsH64/GrQlSldFQTec15ltbTK2yKz5
         MVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062733; x=1685654733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70Rh+2ZpfORm90qgVv/tSVn6I2FZ1MSGL8nzIsbeT5Y=;
        b=E94RBu4/GVG1RdSJxtsTgbu904tR032AzGtSiWWcG+13IkvFa0FRKA9kX1A7pdWF/j
         AQ8JxfQpyjx0Txs4cM283puGbJcJVKY6vltJ6sFriowlbUp95dxVh+lyHDLE17sK8Mjd
         NfXQgdxqUxQC7x37nHqpxg+MPbrcY00uARm7hsIeTp/KrJ7Scetz2u4p0WcIU+bA+NJI
         KqMDw+PvhnCAI7Srl7jjbU2ibqnuGQmF9dEf92Ob2aWHwN9xkQ+NfF0G7vWFDLIwa0vg
         Ul6oAZSmOy462NbRCssaW2xcvkJhtBCMMjogSFKiwQ9USL5YAb1yo5cePl1o/lEZjmLH
         VdDw==
X-Gm-Message-State: AC+VfDyVlUi9jU6KjXRVcSvnWxPFXhMjs2rPs5d5zhljH7FXuSHYCJkx
        +J40YGHhff0irl/bOTFPb3y28tXMBHg=
X-Google-Smtp-Source: ACHHUZ7rlKYxiXD44KxoPTKjJesUoZWP0R7nxPTnp29DwJ/VeIjKHGgoCnD1tn07lyjQRCk5lwArVw==
X-Received: by 2002:aa7:8890:0:b0:63b:85a0:142a with SMTP id z16-20020aa78890000000b0063b85a0142amr28384407pfe.3.1683062733086;
        Tue, 02 May 2023 14:25:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0063d3d776910sm22232459pfj.138.2023.05.02.14.25.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:25:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
Date:   Tue,  2 May 2023 14:25:26 -0700
Message-Id: <20230502212527.1662896-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502212527.1662896-1-luiz.dentz@gmail.com>
References: <20230502212527.1662896-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 33 +++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a6c8aee2f256..8baf34639939 100644
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
index 44d0643fc681..ce588359b290 100644
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

