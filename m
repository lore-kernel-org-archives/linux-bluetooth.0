Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6599CDB483
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 10:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjJRKcz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjJRKcy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 06:32:54 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E74CEA
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 03:32:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E802CC0007;
        Wed, 18 Oct 2023 10:32:48 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     ZhengHan Wang <wzhmmmmm@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v3] Bluetooth: Fix double free in hci_conn_cleanup
Date:   Wed, 18 Oct 2023 12:30:55 +0200
Message-ID: <20231018103248.294565-1-hadess@hadess.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: ZhengHan Wang <wzhmmmmm@gmail.com>

syzbot reports a slab use-after-free in hci_conn_hash_flush [1].
After releasing an object using hci_conn_del_sysfs in the
hci_conn_cleanup function, releasing the same object again
using the hci_dev_put and hci_conn_put functions causes a double free.
Here's a simplified flow:

hci_conn_del_sysfs:
  hci_dev_put
    put_device
      kobject_put
        kref_put
          kobject_release
            kobject_cleanup
              kfree_const
                kfree(name)

hci_dev_put:
  ...
    kfree(name)

hci_conn_put:
  put_device
    ...
      kfree(name)

This patch drop the hci_dev_put and hci_conn_put function
call in hci_conn_cleanup function, because the object is
freed in hci_conn_del_sysfs function.

This patch also fixes the refcounting in hci_conn_add_sysfs() and
hci_conn_del_sysfs() to take into account device_add() failures.

This fixes CVE-2023-28464.

Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]

Signed-off-by: ZhengHan Wang <wzhmmmmm@gmail.com>
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---

Re-sending Luiz' version of ZhengHan Wang's patch as a reply-to snafu
caused v2 of the patch by Luiz to not be applied.

I added the CVE reference, fixed the SoB and add mention of Luiz' changes
in the commit message.

 net/bluetooth/hci_conn.c  |  6 ++----
 net/bluetooth/hci_sysfs.c | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a6f20338db8..236085451931 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -169,13 +169,11 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
 	}
 
-	hci_conn_del_sysfs(conn);
-
 	debugfs_remove_recursive(conn->debugfs);
 
-	hci_dev_put(hdev);
+	hci_conn_del_sysfs(conn);
 
-	hci_conn_put(conn);
+	hci_dev_put(hdev);
 }
 
 static void hci_acl_create_connection(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 15b33579007c..367e32fe30eb 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -35,7 +35,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	conn->dev.type = &bt_link;
 	conn->dev.class = &bt_class;
@@ -48,27 +48,30 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	if (device_is_registered(&conn->dev))
 		return;
 
 	dev_set_name(&conn->dev, "%s:%d", hdev->name, conn->handle);
 
-	if (device_add(&conn->dev) < 0) {
+	if (device_add(&conn->dev) < 0)
 		bt_dev_err(hdev, "failed to register connection device");
-		return;
-	}
-
-	hci_dev_hold(hdev);
 }
 
 void hci_conn_del_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	if (!device_is_registered(&conn->dev))
+	bt_dev_dbg(hdev, "conn %p", conn);
+
+	if (!device_is_registered(&conn->dev)) {
+		/* If device_add() has *not* succeeded, use *only* put_device()
+		 * to drop the reference count.
+		 */
+		put_device(&conn->dev);
 		return;
+	}
 
 	while (1) {
 		struct device *dev;
@@ -80,9 +83,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		put_device(dev);
 	}
 
-	device_del(&conn->dev);
-
-	hci_dev_put(hdev);
+	device_unregister(&conn->dev);
 }
 
 static void bt_host_release(struct device *dev)
-- 
2.41.0

