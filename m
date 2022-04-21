Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiDUVtF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442184AbiDUVtD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 17:49:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C9D49C8A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:46:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so6182586pfb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d4ge2fjTGNbco9PNIIuhtJCHmMwyWdxUxshl86o03s8=;
        b=dF9PiRwfcXHXwlr8qT+AgoGIUc7GR6HAa6vDT+T6/8rDjYNRUOet/Hp6RkRqJTA5qJ
         88v1zUIa3D6NNIANpDM4ZSSO/YM8YSUftFIOjzwYfWlOHjI8TBA+KagAizTwzHHpd1Cl
         M+FqFwH0/djgikEIS63gfHkX+42/+vixddHwm1VRB43anb9nb9B5gDob+/rw8qFCzxJE
         sd6O5U5MWj4vYgHqXrFrC1WWuu7NkfcnUi+ehUbTNbU2vQPs6LnvztDqcBuTz8MwyJKa
         No5+TWiPPvu3Nr2idPpGffsQMSvt/wJp57q+DRP2cd+Ln7bNu92pJ20ReVnJvZeGYDNR
         Teww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4ge2fjTGNbco9PNIIuhtJCHmMwyWdxUxshl86o03s8=;
        b=IHtrstuCL187DON2tCugnNpVExaKV2zjpts1jcoF4xTAMWlCqsbirz/SdVuGeNoZy6
         7ND+2OK4ce9o2PZLntzqkTJ7YtvkVS/8OlOIDuDn+YjHGmsz9tisN5vSjs8EDY5oEMZc
         e310zIkdj0nMwjETZ9Ug5j0N7Xs5dPOQcAdHMdd3vj6/Mzw/R6arIZttMavIdnnTx6cR
         ymKFFxyaGPzuAbDnFkR6g+A77i/YjHwLtSQXWJPgqJQ6BFQU/vvWg4ctxMLkX25zE+3d
         2XFan9OvEiK0InuvWLDDxeXtMWBEewtMv3pFq1F1JviKA8tlueH9arFk+S4dN+89Vvb9
         zdAw==
X-Gm-Message-State: AOAM532nMQfr7h+Fa5X7V65GiveZGPwvHaji0mhZo6FkXZ4gOzt7RBlQ
        f/uO6MwhcL7p70ycqWA7ZaaKfZEtHXs=
X-Google-Smtp-Source: ABdhPJyanxbcSNalkEwnzZnVguIJivCVYyEvnobDE/XYxntvBT0JWayF5dFLYHf6t0hMzXRnBC5EUw==
X-Received: by 2002:a62:d402:0:b0:50a:b621:2e with SMTP id a2-20020a62d402000000b0050ab621002emr1494845pfh.49.1650577571742;
        Thu, 21 Apr 2022 14:46:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mp9-20020a17090b190900b001cd4989feb6sm3812484pjb.2.2022.04.21.14.46.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:46:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted
Date:   Thu, 21 Apr 2022 14:46:07 -0700
Message-Id: <20220421214607.3326277-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421214607.3326277-1-luiz.dentz@gmail.com>
References: <20220421214607.3326277-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to cleanup the hci_conn if it cannot be aborted as
otherwise it would likely result in having the controller and host
stack out of sync with respect to connection handle.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 32 ++++++++++++++++++++++++--------
 net/bluetooth/hci_event.c        | 13 ++++---------
 net/bluetooth/hci_sync.c         | 11 ++++++++++-
 4 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 59815df1272a..64d3a63759a8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1156,7 +1156,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
-void hci_le_conn_failed(struct hci_conn *conn, u8 status);
+void hci_conn_failed(struct hci_conn *conn, u8 status);
 
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cd51bf2a709b..882a7df13005 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -670,7 +670,7 @@ static void le_conn_timeout(struct work_struct *work)
 		/* Disable LE Advertising */
 		le_disable_advertising(hdev);
 		hci_dev_lock(hdev);
-		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
+		hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
 		hci_dev_unlock(hdev);
 		return;
 	}
@@ -873,7 +873,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
 EXPORT_SYMBOL(hci_get_route);
 
 /* This function requires the caller holds hdev->lock */
-void hci_le_conn_failed(struct hci_conn *conn, u8 status)
+static void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn_params *params;
@@ -886,8 +886,6 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 		params->conn = NULL;
 	}
 
-	conn->state = BT_CLOSED;
-
 	/* If the status indicates successful cancellation of
 	 * the attempt (i.e. Unknown Connection Id) there's no point of
 	 * notifying failure since we'll go back to keep trying to
@@ -899,10 +897,6 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 		mgmt_connect_failed(hdev, &conn->dst, conn->type,
 				    conn->dst_type, status);
 
-	hci_connect_cfm(conn, status);
-
-	hci_conn_del(conn);
-
 	/* Since we may have temporarily stopped the background scanning in
 	 * favor of connection establishment, we should restart it.
 	 */
@@ -914,6 +908,28 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	hci_enable_advertising(hdev);
 }
 
+/* This function requires the caller holds hdev->lock */
+void hci_conn_failed(struct hci_conn *conn, u8 status)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	switch (conn->type) {
+	case LE_LINK:
+		hci_le_conn_failed(conn, status);
+		break;
+	case ACL_LINK:
+		mgmt_connect_failed(hdev, &conn->dst, conn->type,
+				    conn->dst_type, status);
+		break;
+	}
+
+	conn->state = BT_CLOSED;
+	hci_connect_cfm(conn, status);
+	hci_conn_del(conn);
+}
+
 static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn = data;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3002df41f16b..ad460f1da4ed 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2834,7 +2834,7 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	/* All connection failure handling is taken care of by the
-	 * hci_le_conn_failed function which is triggered by the HCI
+	 * hci_conn_failed function which is triggered by the HCI
 	 * request completion callbacks used for connecting.
 	 */
 	if (status)
@@ -2859,7 +2859,7 @@ static void hci_cs_le_ext_create_conn(struct hci_dev *hdev, u8 status)
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
 	/* All connection failure handling is taken care of by the
-	 * hci_le_conn_failed function which is triggered by the HCI
+	 * hci_conn_failed function which is triggered by the HCI
 	 * request completion callbacks used for connecting.
 	 */
 	if (status)
@@ -3178,12 +3178,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 done:
 	if (ev->status) {
-		conn->state = BT_CLOSED;
-		if (conn->type == ACL_LINK)
-			mgmt_connect_failed(hdev, &conn->dst, conn->type,
-					    conn->dst_type, ev->status);
-		hci_connect_cfm(conn, ev->status);
-		hci_conn_del(conn);
+		hci_conn_failed(conn, ev->status);
 	} else if (ev->link_type == SCO_LINK) {
 		switch (conn->setting & SCO_AIRMODE_MASK) {
 		case SCO_AIRMODE_CVSD:
@@ -5621,7 +5616,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	}
 
 	if (status) {
-		hci_le_conn_failed(conn, status);
+		hci_conn_failed(conn, status);
 		goto unlock;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2d3b9adbd215..fa95eb2dcffa 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4466,12 +4466,21 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 static int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			       u8 reason)
 {
+	int err;
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
 		return hci_disconnect_sync(hdev, conn, reason);
 	case BT_CONNECT:
-		return hci_connect_cancel_sync(hdev, conn);
+		err = hci_connect_cancel_sync(hdev, conn);
+		/* Cleanup hci_conn object if it cannot be cancelled as it
+		 * likelly means the controller and host stack are out of sync.
+		 */
+		if (err)
+			hci_conn_failed(conn, err);
+
+		return err;
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
 	default:
-- 
2.35.1

