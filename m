Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C6FC7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC3WHc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjC3WGW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:06:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375C11668
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:03:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h14so12263765pgj.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680213814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6F8FLEVXSII2jTBWg/LdI/5vXy8cfsxjGzqk1m7Dz5Y=;
        b=oxQYhYMhMaTmvXP8m+Cqy88oo/TiHLG08MdlUcgwcmOMq4A13iaC5i/6TPdc+J4FDl
         thXVdKDcdT54MgQ8Cn7wXthhbIvzELUQVKmjOAgXhNTe2sZSwtNtmBUUuuAvHcyEoh8/
         71WOF5Wjr7QqSoiTCK3I5HreJ0gu3j9Fj3GZ50Dqb4fz63esMzMGJ0YopyeiLReY16ry
         pkJdJtJWk+4IuAf+g/zxB0UimZBMN9/O9tbTpgMlA/rhG9j2VeoCbKpHIWMe6P9urjcI
         9feiOjne0DyN39tB2bamld8amGMeTRCWZJ2HLwVUpxBDrkvZo+EDRJVUVyKa4J8d1ng6
         yg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6F8FLEVXSII2jTBWg/LdI/5vXy8cfsxjGzqk1m7Dz5Y=;
        b=rDQlcBj+BQcHckokjn31ZVKtO3lfzvZwRPHh2BvHKs4dnIglQrVUibG66wgpGIn3Bd
         /9Tpi8w8+l3N1N5V+hOSrCWUcknRVs/nASd0DxdOFWGi1GKspSIqvHSjE0uowfSk4LYV
         T7yz+/z6lAEiemucNFLNQBlPvxOYfB/4Q7zQf8eALdBLw7DFZBLFKyzA7RQdncijuoUM
         bGwC6wCQQc+8aU6tfOBOgUmBhYwyAbLuG7W3ZGhlrOkr5JuxVDxv5mdvRNTJ+Ky8I1Xo
         lYopNUUttyqzX5mrOZXNzVD01Jm+32GSoAmQiNwLYE5kGM77S/ZczuUTycofiarOmBEW
         kO1g==
X-Gm-Message-State: AAQBX9c/Y6iur93vZIq6njbMpbF2vwD7YVq0xah6YBnjPTJRCW+yVnkn
        VhatLfOg2rrZZoJeB0rRmbDvV2mLGu0=
X-Google-Smtp-Source: AKy350ZFiKU579bTHFGAKyu1CrsML7Rs7pxvdJFVQnUXCNxLFdFKc7Ops/eJIoyO49zqoywlnEZvrg==
X-Received: by 2002:a62:1a53:0:b0:622:ec07:c6bc with SMTP id a80-20020a621a53000000b00622ec07c6bcmr22065788pfa.15.1680213814140;
        Thu, 30 Mar 2023 15:03:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id z14-20020aa791ce000000b00571cdbd0771sm333790pfa.102.2023.03.30.15.03.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:03:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix double free in hci_conn_cleanup
Date:   Thu, 30 Mar 2023 15:03:30 -0700
Message-Id: <20230330220332.1035910-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]

Signed-off-by: ZhengHan Wang <wzhmmmmm@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  |  6 ++----
 net/bluetooth/hci_sysfs.c | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e4aee5950c36..00d1e7201a44 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -168,13 +168,11 @@ static void hci_conn_cleanup(struct hci_conn *conn)
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
 
 static void le_scan_cleanup(struct work_struct *work)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 08542dfc2dc5..633b82d54272 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -33,7 +33,7 @@ void hci_conn_init_sysfs(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("conn %p", conn);
+	bt_dev_dbg(hdev, "conn %p", conn);
 
 	conn->dev.type = &bt_link;
 	conn->dev.class = bt_class;
@@ -46,27 +46,30 @@ void hci_conn_add_sysfs(struct hci_conn *conn)
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
@@ -78,9 +81,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		put_device(dev);
 	}
 
-	device_del(&conn->dev);
-
-	hci_dev_put(hdev);
+	device_unregister(&conn->dev);
 }
 
 static void bt_host_release(struct device *dev)
-- 
2.39.2

