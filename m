Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEE1C001DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 18:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjHCSQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHCSQc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 14:16:32 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C4D26B0
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 11:16:30 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63cf57c79b5so7877566d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691086589; x=1691691389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYHqPoMcf0KfL9JJufhhWG/TzQIqcnMmxRayQQIU2Gw=;
        b=ZpHN3+j+MUe65cKcxeSqOun+5FOFaE0y1BKrDEDQxH0Sb3wOG9jks2nbbmS6VdLaeN
         6CnNMWNKCiAN2NAXcF6+wy8uJ2a/zpUVUf/rEd+iWln96P2VRk6zgDygc5o1PoO407p4
         ljvcJ0g/v7lOjjFWDJ2A6zLySUS3eJdLeuaVp30SBmWHSnHUVMjGj5GCH4xYgz4A5MJi
         J40pWvKN3W8IwZJvCFsU70owA6SKaFjeQugpxsY5Fdn2ZST+DZKjrT+d2FWqqjeNe+hI
         T4H/bZh3JPfy8ExDgrXQMnbX2nRRJAumO8EwZ5XGVW1oQGzK4jv4T+XnKkesiAt+KhxP
         wD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691086589; x=1691691389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYHqPoMcf0KfL9JJufhhWG/TzQIqcnMmxRayQQIU2Gw=;
        b=Q9iz75OxXMqRuhyLm7qb/G8Cvpma493pce7y7Qc+eIbOXLftGh/C9tKp2c6C1IeUZu
         yqvCq6mbhufaU2apgFasH6N2wOxxp4KnjVSG1Pzj3cU2WBHwIzMp4boANp8IAORL9llG
         UUcAB3LBcquC1FjGxmAqNu0YX74gIjxConhi/ytQ4CpN2yKd0NoaVkqHzl6QMjGy6/B9
         H8Gm7AJszkVzA9Oi6GgbHrf/JO8qzGg91OAMohwpapaseSK+/Zfz8lTtKzoub96aGhs4
         aUiPHZruhvo7eUbZMyUvUHpJVU7svw0dhSM0+/lEUmzqM+gbc9a0yPfq83ZHM0J2HshT
         xTCg==
X-Gm-Message-State: ABy/qLaWN+5jRj6czM2SITQzi/PkHtWpSEcfzmJpmjGqcDsHiF1wtddM
        jrQlhSpUNP8z6/C1YZBQ+gMOMkeQ6HA=
X-Google-Smtp-Source: APBJJlH/egZVrLCQUkVgXnLryBF643VJV44FllkwwmTasdPfI3D6n1q1ydkWXA3E3peUCPYB7TC9OA==
X-Received: by 2002:a0c:e4c5:0:b0:635:dda5:bb8e with SMTP id g5-20020a0ce4c5000000b00635dda5bb8emr22155601qvm.22.1691086589069;
        Thu, 03 Aug 2023 11:16:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id q5-20020a0cf5c5000000b00626362f1bf1sm83358qvm.63.2023.08.03.11.16.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:16:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
Date:   Thu,  3 Aug 2023 11:16:24 -0700
Message-ID: <20230803181624.746299-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803181624.746299-1-luiz.dentz@gmail.com>
References: <20230803181624.746299-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Connections may be cleanup while waiting for the commands to complete so
this attempts to check if the connection handle remains valid in case of
errors that would lead to call hci_conn_failed:

BUG: KASAN: slab-use-after-free in hci_conn_failed+0x1f/0x160
Read of size 8 at addr ffff888001376958 by task kworker/u3:0/52

CPU: 0 PID: 52 Comm: kworker/u3:0 Not tainted
6.5.0-rc1-00527-g2dfe76d58d3a #5615
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x1d/0x70
 print_report+0xce/0x620
 ? __virt_addr_valid+0xd4/0x150
 ? hci_conn_failed+0x1f/0x160
 kasan_report+0xd1/0x100
 ? hci_conn_failed+0x1f/0x160
 hci_conn_failed+0x1f/0x160
 hci_abort_conn_sync+0x237/0x360

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 44 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 420d25cce2b0..f7908044b411 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5385,25 +5385,17 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
-	int err;
+	int err = 0;
+	u16 handle = conn->handle;
 
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		return hci_disconnect_sync(hdev, conn, reason);
+		err = hci_disconnect_sync(hdev, conn, reason);
+		break;
 	case BT_CONNECT:
 		err = hci_connect_cancel_sync(hdev, conn, reason);
-		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync
-		 * or in case of LE it was still scanning so it can be cleanup
-		 * safely.
-		 */
-		if (err) {
-			hci_dev_lock(hdev);
-			hci_conn_failed(conn, err);
-			hci_dev_unlock(hdev);
-		}
-		return err;
+		break;
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
 	case BT_OPEN:
@@ -5413,13 +5405,33 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 			hci_conn_failed(conn, reason);
 			hci_dev_unlock(hdev);
 		}
-		break;
+		return 0;
 	default:
 		conn->state = BT_CLOSED;
-		break;
+		return 0;
 	}
 
-	return 0;
+	/* Cleanup hci_conn object if it cannot be cancelled as it
+	 * likelly means the controller and host stack are out of sync
+	 * or in case of LE it was still scanning so it can be cleanup
+	 * safely.
+	 */
+	if (err) {
+		struct hci_conn *c;
+
+		/* Check if the connection hasn't been cleanup while waiting
+		 * commands to complete.
+		 */
+		c = hci_conn_hash_lookup_handle(hdev, handle);
+		if (!c || c != conn)
+			return 0;
+
+		hci_dev_lock(hdev);
+		hci_conn_failed(conn, err);
+		hci_dev_unlock(hdev);
+	}
+
+	return err;
 }
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
-- 
2.41.0

