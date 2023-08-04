Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E39C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 00:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjHDALa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 20:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHDAL3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 20:11:29 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0284210
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 17:11:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cf8754d95so8630006d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107884; x=1691712684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bSxYb47b3tMEJ98dX1ZqPQ6oX8LUr00D4CqTLz8w+M=;
        b=m4EtReiScMrR1SRNroDbhGFWb9ak8hMWHkbrgudfEF7R8lTckmr2CuJX01AguLiXsL
         aFlANYyg0PR8j5BNGNlnW8F0AKCVc1sUfXKaxaG1yCRvAHCsHmGXeiNrIMkp/A2T0f2v
         GCDFtyFdu7OwmKgTAQqbu5aFe17nRsHcdSz++IMEy6chjD4nGq02l/u9OLJW9iZ0wFE0
         z/wxpWkG0Y1+3bqWQycqjM2PRu29xACDO5eilKzaO1krpbCtGzRE1XA+Dnm+DzQ/ohvo
         iEDdeTXEKHTrSvkSOMOvGFCYLsn5WWCxXZtHXC6qyzSp9fgVLnUfI4qFWBQtM6LzNRk+
         5K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107884; x=1691712684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bSxYb47b3tMEJ98dX1ZqPQ6oX8LUr00D4CqTLz8w+M=;
        b=bNDr8A3UBuLlQ8pIWA7jEK1xsnmSpTUJEDHcca5fCyotaqCXX+yIk7i07pOVpqIVIf
         x8kscPyZM9FRepcwzThv3C/3B3ULUwSvSrmWg9zh7HgJcpha54GOpGtKZ5oA4owRkyJe
         IqPlqWdALa67lbKncAo9TtuFoMEN5usuiPKZKykYvWlSsg5pB+vdUazDfu0W2/TsAahX
         XhEmreCg7IRoZ/HLr/ZhTKSV3CBVB7Ns6FBpX4axR4r7zfefy3jcEeSifsD+hBp6yYa3
         BEC3k5j8ur/ZEbXbWhbjSROa9Zo1dx1BRCmS/uBdFfv2nmNX55J+SD4h4fD+dbqZR6Wc
         k6vg==
X-Gm-Message-State: AOJu0YxAGxQ+ZHbwCyNht2APKpKc2Wjr2KiM9yWnySBDhX8oVlpFvBym
        LlMse2HMchi4ITlB6rCHuZ55om1ezCs=
X-Google-Smtp-Source: AGHT+IG7mx8sYSeKS8JiJGPMlM59E9J+tUTUwwL0UNNNQUxHkIUz4kyVw12gUj3MGBs9l2+Mp9+uHg==
X-Received: by 2002:a0c:f151:0:b0:63c:d901:d5d3 with SMTP id y17-20020a0cf151000000b0063cd901d5d3mr162520qvl.9.1691107883791;
        Thu, 03 Aug 2023 17:11:23 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id y11-20020a0ce04b000000b0063c6c7f4b92sm272448qvk.1.2023.08.03.17.11.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:11:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: hci_conn: Fix modifying handle while aborting
Date:   Thu,  3 Aug 2023 17:11:14 -0700
Message-ID: <20230804001115.907885-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804001115.907885-1-luiz.dentz@gmail.com>
References: <20230804001115.907885-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces hci_conn_set_handle which takes care of verifying the
conditions where the hci_conn handle can be modified, including when
hci_conn_abort has been called and also checks that the handles is
valid as well.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 30 ++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 29 +++++++++++------------------
 3 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8200a6689b39..d2a3a2a9fd7d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1425,6 +1425,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
 void hci_conn_failed(struct hci_conn *conn, u8 status);
+u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
 
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 923bb7e7be2b..13bd2753abbb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1231,6 +1231,36 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 	hci_conn_del(conn);
 }
 
+/* This function requires the caller holds hdev->lock */
+u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	bt_dev_dbg(hdev, "hcon %p handle 0x%4.4x", conn, handle);
+
+	if (conn->handle == handle)
+		return 0;
+
+	if (handle > HCI_CONN_HANDLE_MAX) {
+		bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
+			   handle, HCI_CONN_HANDLE_MAX);
+		return HCI_ERROR_INVALID_PARAMETERS;
+	}
+
+	/* If abort_reason has been sent it means the connection is being
+	 * aborted and the handle shall not be changed.
+	 */
+	if (conn->abort_reason) {
+		bt_dev_err(hdev, "hcon %p abort_reason 0x%2.2x", conn,
+			   conn->abort_reason);
+		return conn->abort_reason;
+	}
+
+	conn->handle = handle;
+
+	return 0;
+}
+
 static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f1fcece29e7d..218da9b0fe8f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3179,13 +3179,9 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!status) {
-		conn->handle = __le16_to_cpu(ev->handle);
-		if (conn->handle > HCI_CONN_HANDLE_MAX) {
-			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
-				   conn->handle, HCI_CONN_HANDLE_MAX);
-			status = HCI_ERROR_INVALID_PARAMETERS;
+		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
+		if (status)
 			goto done;
-		}
 
 		if (conn->type == ACL_LINK) {
 			conn->state = BT_CONFIG;
@@ -3849,11 +3845,9 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 		if (conn->state != BT_BOUND && conn->state != BT_CONNECT)
 			continue;
 
-		conn->handle = __le16_to_cpu(rp->handle[i]);
+		if (hci_conn_set_handle(conn, __le16_to_cpu(rp->handle[i])))
+			continue;
 
-		bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
-			   conn->handle, conn->parent);
-		
 		if (conn->state == BT_CONNECT)
 			pending = true;
 	}
@@ -5039,11 +5033,8 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	switch (status) {
 	case 0x00:
-		conn->handle = __le16_to_cpu(ev->handle);
-		if (conn->handle > HCI_CONN_HANDLE_MAX) {
-			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
-				   conn->handle, HCI_CONN_HANDLE_MAX);
-			status = HCI_ERROR_INVALID_PARAMETERS;
+		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
+		if (status) {
 			conn->state = BT_CLOSED;
 			break;
 		}
@@ -6978,7 +6969,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_create_big_complete *ev = data;
 	struct hci_conn *conn;
-	__u8 bis_idx = 0;
+	__u8 i = 0;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -6996,7 +6987,9 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		    conn->iso_qos.bcast.big != ev->handle)
 			continue;
 
-		conn->handle = __le16_to_cpu(ev->bis_handle[bis_idx++]);
+		if (hci_conn_set_handle(conn,
+					__le16_to_cpu(ev->bis_handle[i++])))
+			continue;
 
 		if (!ev->status) {
 			conn->state = BT_CONNECTED;
@@ -7015,7 +7008,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		rcu_read_lock();
 	}
 
-	if (!ev->status && !bis_idx)
+	if (!ev->status && !i)
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
-- 
2.41.0

