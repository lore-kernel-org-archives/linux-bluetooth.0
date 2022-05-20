Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F68C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352913AbiETShS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352929AbiETShQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 14:37:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3106620E
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 11:37:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y199so8423568pfb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5uFVZfx3Yq4qswI1QmeoBn2aetKWGS/wSaKxIfc98rc=;
        b=Cmn16T3PSycAByRlAuFO5xbzl3UBFevSHdW4u9vLE1FYtFrf209QBmvbJ4dMWxVysi
         yo6jIBpvsvOxqyZwGLtz34wbDfwM783lVWe8lTw1fK1kiZ/HDO/JgIFg077m+fFL0dyJ
         j5+Y5hybOtjlZ0FUNpPzqnE8lTNW600qvXTNMDufkm7n93CZ6I7LzwIrTsce8/iD/SKV
         7ZehbvN7glcAJmgb3XlL2oaEyawVMHSOKeJjz5ftrT/LKeD0nrIUDD/qfUrZljugyYKG
         F3LbfTdSOAqu7iDe8vWk9KdDp9X2LZA6IWPprqkmTM6h31+UrX2aZPkQMTa4UrO9YC1s
         kDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5uFVZfx3Yq4qswI1QmeoBn2aetKWGS/wSaKxIfc98rc=;
        b=gvrqvLYAtexbd/Q0tXWd26gFse4i6lTcdROSXaq75CO1QzUBviYa3r4cNxD2owyQrX
         l8DhAV8e/ezX2xIje4jGZri9O0aOhxQGRkta6YrB+0iwmKhriCrYaMaDC94HlLqqeoZw
         Om9OhO68wYIOAUAyp6Q9PM3M4ixItMgN6QTwnIgqiklth80Zywgto7R7WsNHr04VeoI0
         GTpC4GUwFgJPDLdWIMBT7xr6KzqOpJUnb5NmnMrbVwKnLcm8qjkU2xF8WPn77loRaerl
         7kRBvpjEltRXG2gHrSZFwa+hTszDesjMDjUF4JXUSpxSahmMtw5rcWKHXqzObkz1UkSc
         SMew==
X-Gm-Message-State: AOAM531zvO45uey7msoVJRavZoiE19uWDgLlVKCqymV2g+QFxHurRARD
        dbBAVei0L8Z6XhpV79RBwuBD7z0IaJo=
X-Google-Smtp-Source: ABdhPJw+Q4gdOSXNnuKZOP60LGJ1sravnw5zZFt4mjiOPXYl1OOiOBwveoGJYy55VV1kOxgg29NWFw==
X-Received: by 2002:a63:e614:0:b0:3f6:3479:6673 with SMTP id g20-20020a63e614000000b003f634796673mr8775381pgh.528.1653071834543;
        Fri, 20 May 2022 11:37:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78702000000b0050dc76281fcsm2097319pfo.214.2022.05.20.11.37.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:37:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH-stable] Bluetooth: hci_conn: Fix hci_connect_le_sync
Date:   Fri, 20 May 2022 11:37:13 -0700
Message-Id: <20220520183713.2641513-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The handling of connection failures shall be handled by the request
completion callback as already done by hci_cs_le_create_conn, also make
sure to use hci_conn_failed instead of hci_le_conn_failed as the later
don't actually call hci_conn_del to cleanup.

Link: https://github.com/bluez/bluez/issues/340
Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 5 +++--
 net/bluetooth/hci_event.c | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 882a7df13005..ac06c9724c7f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -943,10 +943,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_err(hdev, "request failed to create LE connection: err %d", err);
 
-	if (!conn)
+	/* Check if connection is still pending */
+	if (conn != hci_lookup_le_connect(hdev))
 		goto done;
 
-	hci_le_conn_failed(conn, err);
+	hci_conn_failed(conn, err);
 
 done:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0270e597c285..af17dfb20e01 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		status = HCI_ERROR_INVALID_PARAMETERS;
 	}
 
-	if (status) {
-		hci_conn_failed(conn, status);
+	/* All connection failure handling is taken care of by the
+	 * hci_conn_failed function which is triggered by the HCI
+	 * request completion callbacks used for connecting.
+	 */
+	if (status)
 		goto unlock;
-	}
 
 	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
 		addr_type = BDADDR_LE_PUBLIC;
-- 
2.35.1

