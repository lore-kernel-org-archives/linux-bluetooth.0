Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79E8C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjC3WCl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjC3WCj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:02:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9CC59CD
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:02:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o11so19492834ple.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680213757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6F8FLEVXSII2jTBWg/LdI/5vXy8cfsxjGzqk1m7Dz5Y=;
        b=KMC0l0YIYtsBPav69blxLsbFxUd4Rd9xDfKaFslDjEbB6rjuM32XsDk1r3nJzs5kLs
         4nwC+ZjT6DrOAjtspf+6uHpGCKaGR0rr0X51C6qh0rd69lhhUNtkeZsspgS+Yd/zB2sV
         QP9RZTIF0FIxkomU8ePwoN8xPTViN42Ta8elYFo0+MgAAvrDeHJdvzEeBJ+z6LsY6VpR
         EzUvJHrZJa1uQ+AJlKRBc5YAXYP9w7XDjaNgmqO4G+0/bLBWfu+MprnpHfar4zsCUzjq
         ijzaYlTZwX5vY93C2W6IksVkZvG7P8Ms7LjkvEb/9N0YsHloGy3Lw2xf7OnYWwxxLuXw
         a10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680213757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6F8FLEVXSII2jTBWg/LdI/5vXy8cfsxjGzqk1m7Dz5Y=;
        b=ZKD+QJXO6la8fxyiOliIPlnfDWSBTobvEo/GwCXTEK4XRFamkFAwMSLhFRyLynWOWB
         Sxo/oxjhYqx2Z0xtTWG4jusGVzAn3pdIiReUcIgsuFYwUGHMZm95KrIpkxLBksa4rOlV
         oUEHq9wqVDVXrSjRs5VLMP+7q5ptKZz6/K+asm/Ils36nc8Ja3fJwV4uvOT1A3gaCN79
         wFux5UvW4pxRNo8MzqKi73LEAYqP4EDzFY0Mgmtl/sFI1DXGQmCNlvXlpWXfWGOl/r9s
         Sbsi5KEx7ANpWYndGgi4V+hwLjaIeifYMSBGK3+5jPHOlnrc/CGgPHrEp4qThbwdpIi/
         +Zaw==
X-Gm-Message-State: AAQBX9eY/af/REfjA+TpVzOCCKp3fmUKt+gbuxLd9gPu2blYHumIDWUr
        8uddvOSemRUzBnlTsnrNFDVoDOS/6uE=
X-Google-Smtp-Source: AKy350aruBxyY0FtgROb6Qaud/7jrBRWX5Spi1oK5rDgxFnOR1iJ9QRKK36WdBPmvFEYjurThDCJmQ==
X-Received: by 2002:a17:902:d411:b0:1a1:c8b3:3fe1 with SMTP id b17-20020a170902d41100b001a1c8b33fe1mr19035627ple.31.1680213757556;
        Thu, 30 Mar 2023 15:02:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709026b0a00b001a21fceff33sm211903plk.48.2023.03.30.15.02.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:02:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix double free in hci_conn_cleanup
Date:   Thu, 30 Mar 2023 15:02:33 -0700
Message-Id: <20230330220235.1035456-1-luiz.dentz@gmail.com>
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

