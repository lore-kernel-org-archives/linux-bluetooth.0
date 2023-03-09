Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5416C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Mar 2023 09:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCIJfR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCIJfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 04:35:15 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B6FC8881
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 01:35:14 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id h8so1333630plf.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 01:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678354513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hH6w8aDTHHGmr5ss4kp7zLJEI+UrSruaARLEvYxT/Ns=;
        b=WuKJHElAnv28wPvaveH+UDDboXCr6pi8mcUMNaoiI29lMnv8Dl861Ptw8ulzGyQW1K
         lfx4Sc5+8RhTycwpIwE43UqRY2rTzhA7mT/kdxEguGbZAnlXWeXQcZWSKbUtSQ4c7RvN
         8OBCFvcydnI1w2pFwjnJ7gXs+bx3b7os8ptn388AMIjZ2DmLQbKuQjqvuwqvMvb5iE8s
         AuyDgX9Vl+GMvgVxVDjhzo6QRcHsBG6jIsma7stlzsAFZt/fVpdEf6qO+2sBi7SVbc5L
         lLzYpbA9Je5/WsUNjq8ny+six8/EBRUbZKC7lNxML2cmDq6iiT3vvgMbxfSUhZuq8+XR
         S/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hH6w8aDTHHGmr5ss4kp7zLJEI+UrSruaARLEvYxT/Ns=;
        b=M6+nU2vpa3lyGmFOEc9rZDUZ7vZAMCXXnpCHaavwexTFnhKkVFLE8x3MbreVeJgy3r
         sXpIkDGi0qTMTX6hk6Pgyq+ksHYMZS2FA4TIY5kT5j81UlkNg54mQ52xywmvhhwl3ZCh
         Rk8CR/beLkQO3sPD73exFeFeFhIphV+/Dta4B/RWfg5y2DlvbL11ruIBf49PMu83be6w
         E0fcjBJqla6u/qxhFs8mebmBc8OrxHLRxZBTCbgQWsdiiJLS6mlmCOt/SgLUJ73tQUgm
         C/V0yFbSvIFGC/xZIBdOw8vNYPZkaMWPXT5e07NhJ6bArQA1HhGiKRFB54ZbOetHf1C6
         DsEQ==
X-Gm-Message-State: AO0yUKW2OGoOPNwA1QPcuLO8O6krs5bxwpYaEV/r8BskxAZLDDVyXoJG
        aVdC6yr1x6qrphk1Oi5hdUL9Ng4vWYA88oLGdY72TA==
X-Google-Smtp-Source: AK7set8RjCBq3K551HPm3a9UFJX/QCX6Z33YM9lYfSEEcwUHVSXzWzj3m7h2kj7kXYxJPBKnY0f0LQ==
X-Received: by 2002:a17:902:c948:b0:19a:a4f3:6d4c with SMTP id i8-20020a170902c94800b0019aa4f36d4cmr25144186pla.67.1678354513556;
        Thu, 09 Mar 2023 01:35:13 -0800 (PST)
Received: from ideal-drum-1.localdomain (23.105.204.76.16clouds.com. [23.105.204.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001898ee9f723sm11302564plh.2.2023.03.09.01.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:35:12 -0800 (PST)
From:   ZhengHan Wang <wzhmmmmm@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ZhengHan Wang <wzhmmmmm@gmail.com>
Subject: [PATCH] Bluetooth: Fix double free in hci_conn_cleanup
Date:   Thu,  9 Mar 2023 17:34:42 +0800
Message-Id: <20230309093442.74618-1-wzhmmmmm@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
---
 net/bluetooth/hci_conn.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index acf563fbdfd9..a0ccbef34bc2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -152,10 +152,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	hci_conn_del_sysfs(conn);
 
 	debugfs_remove_recursive(conn->debugfs);
-
-	hci_dev_put(hdev);
-
-	hci_conn_put(conn);
 }
 
 static void le_scan_cleanup(struct work_struct *work)
-- 
2.25.1

