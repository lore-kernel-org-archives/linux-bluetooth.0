Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A82C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 20:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392562AbiDUUuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349411AbiDUUuM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 16:50:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476F4E3BC
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:47:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q22so6635626iod.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=267Ne7qjKfH3ZLxWnpNQiwtfl6tIxRuiIbjwtvzm2jo=;
        b=Z+fdU0nKO0LmLx2V9qeoK1X+R1gCrtg7q4wdSffhQaeVKTKeLXvKTlZ9tD8CerThpW
         J0ZXOKY5tEFF1ZMBQq5VPu6ZJ2K0AOhvt5Yzc+fXmRq8blT4xoyNfQx1MWIM7Z9jccM6
         W7LRKiF4D85HlMFZNWBRrTBuwXm/NFmSCIrw9e8qDMfFB7azD7WqoxbD6bMeMLJzkH8W
         cPFiReCCKpPOkoeTdELkOIY7k/1gZ3HP6yAK8ECbSM+cWX7R8VV/jin8nWLZaseJxFyt
         Q/nOjdGMfnanO7GvPotY9qWNuYKR4w+tVQCMKU2ZbYdh1e8jE+hg9BUuv58RZ+xeODgs
         PYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=267Ne7qjKfH3ZLxWnpNQiwtfl6tIxRuiIbjwtvzm2jo=;
        b=17KkuEqpFedp6KLXfhWQzFkT5zdB2xQNpSpG+ja7EzuaAozzBwwYGu3J2PSehqhccy
         SQO3hVB/+sLbYgoNNonZc2w4tZHfR9XK/gz5lWSyqjb44s7xkJika1PGg1PoY8sreib7
         4Tucllbed41Bx/exaiyH161Ybtw5pGFTaR6sT+878xXAEQDzvXJk9Ob0l0NkZgkLQJJC
         m7xE87C7sM3c28TPlEXxPAPlik1+ZPUnea408vqUg2YOTaf/uDpDEf+WIxRCqJLtyxcL
         RAQdaWqWTOTsP+DL+3XsFiqcEMd0WgJmE1q4wdcXqr0sWLzJ1qn35yyY+cx81x4kOSjd
         v6dw==
X-Gm-Message-State: AOAM5324OZbgTSpuQlwA8NXH1JETLfmLFk+OsY9HgfAdSSZO/eH99yVe
        Buq7vSROhVH/hZa8SyjSvEdnb7+NEJo=
X-Google-Smtp-Source: ABdhPJw40Vc9QtVHB4iRkTA1xfsyn8VEeiZZCwrCEuiTXzOjC+mhN76EsttpoR9ADaOpm7Zks0EeSg==
X-Received: by 2002:a02:b783:0:b0:326:8035:ef7f with SMTP id f3-20020a02b783000000b003268035ef7fmr689875jam.87.1650574037553;
        Thu, 21 Apr 2022 13:47:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s21-20020a6bd315000000b006573987c4fcsm80281iob.3.2022.04.21.13.47.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:47:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Fix checking for invalid handle on error status
Date:   Thu, 21 Apr 2022 13:47:14 -0700
Message-Id: <20220421204715.3268714-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit d5ebaa7c5f6f6 introduces checks for handle range
(e.g HCI_CONN_HANDLE_MAX) but controllers like Intel AX200 don't seem
to respect the valid range in case of error status:

> HCI Event: Connect Complete (0x03) plen 11
        Status: Page Timeout (0x04)
        Handle: 65535
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
[1644965.827560] Bluetooth: hci0: Ignoring HCI_Connection_Complete for
invalid handle

When the above happens it prevents to cleanup the connections since
the stack would attempt to cancel the connection which is no longer in
progress causing the following trace:

< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
= bluetoothd: src/profile.c:record_cb() Unable to get Hands-Free Voice
	gateway SDP record: Connection timed out
> HCI Event: Command Complete (0x0e) plen 10
      Create Connection Cancel (0x01|0x0008) ncmd 1
        Status: Unknown Connection Identifier (0x02)
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)
< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
        Address: 94:DB:56:XX:XX:XX (Sony Home Entertainment&
	Sound Products Inc)

Fixes: d5ebaa7c5f6f6 ("Bluetooth: hci_event: Ignore multiple conn complete events")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Check if handle is valid just before assigning it to hci_conn object and
in case it is invalid reset the status to HCI_ERROR_INVALID_PARAMETERS(0x12)
so it can be passed to the likes of hci_connect_cfm and then is translated to
EINVAL by bt_to_errno.

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 44 ++++++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8bb81ea4d286..62a9bb022aed 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -587,6 +587,7 @@ enum {
 #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
 #define HCI_ERROR_REJ_LIMITED_RESOURCES	0x0d
 #define HCI_ERROR_REJ_BAD_ADDR		0x0f
+#define HCI_ERROR_INVALID_PARAMETERS	0x12
 #define HCI_ERROR_REMOTE_USER_TERM	0x13
 #define HCI_ERROR_REMOTE_LOW_RESOURCES	0x14
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaabfae19cc..a658aa4c7306 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3068,11 +3068,6 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_conn_complete *ev = data;
 	struct hci_conn *conn;
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for invalid handle");
-		return;
-	}
-
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	hci_dev_lock(hdev);
@@ -3124,6 +3119,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	if (!ev->status) {
 		conn->handle = __le16_to_cpu(ev->handle);
+		if (conn->handle > HCI_CONN_HANDLE_MAX) {
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x",
+				   conn->handle);
+			ev->status = HCI_ERROR_INVALID_PARAMETERS;
+			goto done;
+		}
 
 		if (conn->type == ACL_LINK) {
 			conn->state = BT_CONFIG;
@@ -3164,17 +3165,17 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
 				     &cp);
 		}
-	} else {
-		conn->state = BT_CLOSED;
-		if (conn->type == ACL_LINK)
-			mgmt_connect_failed(hdev, &conn->dst, conn->type,
-					    conn->dst_type, ev->status);
 	}
 
 	if (conn->type == ACL_LINK)
 		hci_sco_setup(conn, ev->status);
 
+done:
 	if (ev->status) {
+		conn->state = BT_CLOSED;
+		if (conn->type == ACL_LINK)
+			mgmt_connect_failed(hdev, &conn->dst, conn->type,
+					    conn->dst_type, ev->status);
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_del(conn);
 	} else if (ev->link_type == SCO_LINK) {
@@ -4690,11 +4691,6 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
-	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete for invalid handle");
-		return;
-	}
-
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
 	hci_dev_lock(hdev);
@@ -4732,6 +4728,14 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	switch (ev->status) {
 	case 0x00:
 		conn->handle = __le16_to_cpu(ev->handle);
+		if (conn->handle > HCI_CONN_HANDLE_MAX) {
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x",
+				   conn->handle);
+			ev->status = HCI_ERROR_INVALID_PARAMETERS;
+			conn->state = BT_CLOSED;
+			break;
+		}
+
 		conn->state  = BT_CONNECTED;
 		conn->type   = ev->link_type;
 
@@ -5527,11 +5531,6 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	struct smp_irk *irk;
 	u8 addr_type;
 
-	if (handle > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Ignoring HCI_LE_Connection_Complete for invalid handle");
-		return;
-	}
-
 	hci_dev_lock(hdev);
 
 	/* All controllers implicitly stop advertising in the event of a
@@ -5603,6 +5602,11 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type, NULL);
 
+	if (handle > HCI_CONN_HANDLE_MAX) {
+		bt_dev_err(hdev, "Invalid handle: 0x%4.4x", conn->handle);
+		status = HCI_ERROR_INVALID_PARAMETERS;
+	}
+
 	if (status) {
 		hci_le_conn_failed(conn, status);
 		goto unlock;
-- 
2.35.1

