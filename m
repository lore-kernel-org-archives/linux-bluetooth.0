Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1CDC00528
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 23:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjHDXZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 19:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHDXZ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 19:25:26 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683124C2D
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 16:25:25 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79094ee23e0so92848639f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691191524; x=1691796324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KM1O7yOk6OnBpBEePyEEZ6un48YEh8zSh0/OUpUPUU8=;
        b=gVU81bOLoBumHdaTmZ1ChhWDVWhpvO6eLnGx+Oi84YRyug3LUiiwgdAWpcKxfkx6c7
         b2OqG5D6o27/5KbAMYtsY5UujcZmCzITx95UpG5q4dwrj4kRSAQpTfacgrPwCOIWm5Zn
         tT3CBMA5xiGQn9Jl251QfPwcRrGHzPyOZJPU16E6u5qCgsikppnS6HCE3an5hXmiK7Rb
         2sF62U/xdwsE4GXBLBkaKmJWtpKELdxPdBXOmhce4aklbqxbdJRuXqecJFayOdVYNTBU
         hAwcrsvFZbUwsmPFK+l7o9GQz6/eDR35yZQ/guB0aUguWTiRbnqgeJ7eBbUy826G9NxT
         KaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691191524; x=1691796324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KM1O7yOk6OnBpBEePyEEZ6un48YEh8zSh0/OUpUPUU8=;
        b=XGvR5grYOnDR6CR43YNUnDwyP6ORNwMueRjFz/9FXkPU1HTEVMOduUlDcrkWOFpJmE
         49vhCSYEQ9+EI2Sy6lZ9MvQrW55Ojlr94EUVKwuQsRLKrzIOBbz7dFGqkO5WbqcS3Tj5
         r67zmgQNqr+DI+lzsOstHpp4nvcZDsgik2Nz0VhWKpz0/BEGvxhLHkV1dCthsWhLkC3Z
         M67QqWMP1ezWC9DEUQ6HIPUFPOJyjWS+yfkJeOp+BqcByDKimQoVtMq3hHE7d+vzCtwV
         MyCZgIVoG+6v/K3SWo772c/nAOFFcZnSXYhNIALpk5fZnYuPFkvS14KhKnrxsfjWW4qg
         BsFg==
X-Gm-Message-State: AOJu0YxpNNcJRosgVPv5BB98v54xYlWl737hXVpmiQLmwod07jHoJ7rg
        sprXlLu1bZUTHHRIJaRd6LD2js1GtlM=
X-Google-Smtp-Source: AGHT+IG052JuXiSOIHxKDZRXW8uVdyOkn3ypqqXRnHggHWItVbhRHSEjueWERfinlGAQ2NfZS1Lfrw==
X-Received: by 2002:a6b:4010:0:b0:785:ca70:46a2 with SMTP id k16-20020a6b4010000000b00785ca7046a2mr3336993ioa.4.1691191524127;
        Fri, 04 Aug 2023 16:25:24 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id a15-20020a056638018f00b004290f6c15bfsm855044jaq.145.2023.08.04.16.25.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 16:25:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros
Date:   Fri,  4 Aug 2023 16:25:22 -0700
Message-ID: <20230804232522.1151304-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces PTR_UINT/UINT_PTR macros and replace the use of
PTR_ERR/ERR_PTR.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  3 +++
 net/bluetooth/hci_conn.c         | 19 ++++++++++---------
 net/bluetooth/hci_sync.c         |  4 ++--
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index b516a0f4a55b..57eeb07aeb25 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -5,6 +5,9 @@
  * Copyright (C) 2021 Intel Corporation
  */
 
+#define UINT_PTR(_handle)		((void *)((uintptr_t)_handle))
+#define PTR_UINT(_ptr)			((uintptr_t)((void *)_ptr))
+
 typedef int (*hci_cmd_sync_work_func_t)(struct hci_dev *hdev, void *data);
 typedef void (*hci_cmd_sync_work_destroy_t)(struct hci_dev *hdev, void *data,
 					    int err);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ae206eb551f7..4ad6af4e3145 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -872,7 +872,7 @@ static void bis_cleanup(struct hci_conn *conn)
 
 static int remove_cig_sync(struct hci_dev *hdev, void *data)
 {
-	u8 handle = PTR_ERR(data);
+	u8 handle = PTR_UINT(data);
 
 	return hci_le_remove_cig_sync(hdev, handle);
 }
@@ -881,7 +881,8 @@ static int hci_le_remove_cig(struct hci_dev *hdev, u8 handle)
 {
 	bt_dev_dbg(hdev, "handle 0x%2.2x", handle);
 
-	return hci_cmd_sync_queue(hdev, remove_cig_sync, ERR_PTR(handle), NULL);
+	return hci_cmd_sync_queue(hdev, remove_cig_sync, UINT_PTR(handle),
+				  NULL);
 }
 
 static void find_cis(struct hci_conn *conn, void *data)
@@ -1260,7 +1261,7 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
+	u16 handle = PTR_UINT(data);
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!conn)
@@ -1290,7 +1291,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
+	u16 handle = PTR_UINT(data);
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!conn)
@@ -1372,7 +1373,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 
 	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync,
-				 ERR_PTR(conn->handle),
+				 UINT_PTR(conn->handle),
 				 create_le_conn_complete);
 	if (err) {
 		hci_conn_del(conn);
@@ -1736,7 +1737,7 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 
 static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 {
-	u8 cig_id = PTR_ERR(data);
+	u8 cig_id = PTR_UINT(data);
 	struct hci_conn *conn;
 	struct bt_iso_qos *qos;
 	struct iso_cig_params pdu;
@@ -1846,7 +1847,7 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 
 done:
 	if (hci_cmd_sync_queue(hdev, set_cig_params_sync,
-			       ERR_PTR(qos->ucast.cig), NULL) < 0)
+			       UINT_PTR(qos->ucast.cig), NULL) < 0)
 		return false;
 
 	return true;
@@ -2858,7 +2859,7 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
+	u16 handle = PTR_UINT(data);
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!conn)
@@ -2898,6 +2899,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		}
 	}
 
-	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
+	return hci_cmd_sync_queue(hdev, abort_conn_sync, UINT_PTR(conn->handle),
 				  NULL);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41a8e57d8267..5eb30ba21370 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6528,7 +6528,7 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 
 static int _update_adv_data_sync(struct hci_dev *hdev, void *data)
 {
-	u8 instance = PTR_ERR(data);
+	u8 instance = PTR_UINT(data);
 
 	return hci_update_adv_data_sync(hdev, instance);
 }
@@ -6536,5 +6536,5 @@ static int _update_adv_data_sync(struct hci_dev *hdev, void *data)
 int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 {
 	return hci_cmd_sync_queue(hdev, _update_adv_data_sync,
-				  ERR_PTR(instance), NULL);
+				  UINT_PTR(instance), NULL);
 }
-- 
2.41.0

