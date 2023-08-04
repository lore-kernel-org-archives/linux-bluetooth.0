Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518ADC0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 00:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjHDAL0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 20:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHDALZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 20:11:25 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586D4224
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 17:11:22 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63cf4827630so8588086d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107880; x=1691712680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nk0LqftkGcvUkx2geH25FY/+oHYJHbqC58Qr0CCsDVI=;
        b=OOIf4dgbcv9YUbMmwUGSWKhbxR/IIfLRlc0sXOW7Kv1PCD51K3OF4ak22sIuQIvw5i
         U+UGAEBFGb4ul4qzJBRnACk24lURHV/r8Y4VNVvOMNCuP6r+Y0ZQy9XHxsxtsPB8HL1C
         kgBjgU5d7wQSArlPAGLW+J0WV8fdfszt7qy4vsuaQY4+OMnPVz5fmG453VXUwgVMrq5F
         zQsiO6qwHPeIWyFNfUNnOjKdU9m3B2hUDfNzv55aW8nm30LXsEY2RsMaiRnUMkG67qsO
         E+sLLHxZK17JWf7p4mVHv7YBDj5+YMGlPlibNf2LO3xuJWze1m0o8S/z29pcE/Rj9KhR
         c9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107880; x=1691712680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk0LqftkGcvUkx2geH25FY/+oHYJHbqC58Qr0CCsDVI=;
        b=YcO6/xl8ZLmd8/jPSEZZFcEOOliKKUm9sYkcF9zpCBllCxltuoF2GuA4G6x6/TtQdC
         OLk53nC+VDUsO3bm+XpYerBJJGAiFapXvvAHMfDSZLudIzDVU3SfW3lWCpE9k1XKFU74
         5NuPO1SWXtbFgt5mrq/lhmlwQAxkCreBpfRjwOscXylmqUPgXy4/YyhgMm5MPoeurphf
         zu8ipTDJMBYvuCkrnsAdFhknsWaOqQweWWMx5wUZ653k3qLHRWfpiPnzE+cGzHDmdS+0
         KHCkoxYdAq0zt7YYUMawbvXmnpX4ZCP8VBtcumKiiMvyoH1S8lpn8n4XU9h9KsqzzgME
         5U6g==
X-Gm-Message-State: AOJu0YyzACkPphSEs9bXheGSHNbfSC0hdZfpLFs3ctHTxzaPaX0i8QJr
        im/lUO3K8rPbqg+BRHA3AYvcQ/1tUJM=
X-Google-Smtp-Source: AGHT+IESssMob16uWJmvzXXaPhsD/ZyG9itHojo11q8RzfbHcnDUUbgtSov6XOL8sg9nUPEp9i9rlg==
X-Received: by 2002:a0c:e513:0:b0:62d:eaa8:27e4 with SMTP id l19-20020a0ce513000000b0062deaa827e4mr179045qvm.36.1691107880619;
        Thu, 03 Aug 2023 17:11:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id y11-20020a0ce04b000000b0063c6c7f4b92sm272448qvk.1.2023.08.03.17.11.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:11:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
Date:   Thu,  3 Aug 2023 17:11:12 -0700
Message-ID: <20230804001115.907885-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804001115.907885-1-luiz.dentz@gmail.com>
References: <20230804001115.907885-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c | 45 ++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a9b048d7b419..ec8929e79502 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5389,27 +5389,20 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
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
-		return hci_reject_conn_sync(hdev, conn, reason);
+		err = hci_reject_conn_sync(hdev, conn, reason);
+		break;
 	case BT_OPEN:
 	case BT_BOUND:
 		hci_dev_lock(hdev);
@@ -5418,10 +5411,30 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		return 0;
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

