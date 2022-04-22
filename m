Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60024C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiDVV5s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiDVV51 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C725D2AB9EC
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 13:40:04 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x20so6912123qvl.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GfSnqd2JJ3k7CDJOYbTWuP8axl6r8djqgptR6mkFpfg=;
        b=Q+TZphqlkyAgO6X7Q3bSMroXQuZQz+VpvlBHbR2+Nf+3mrYD33om4oTu2VA+0KirmG
         EkiuAYYlBkPN12xVyvB/6VQWjMKCRsDZhHphRtFpSGGPgtZlgq9YvF/oATCdjeSUVNh+
         4jJ2chpJToZ/CIoMGMBLwrbzhkE5HYDRcbo2vOWywdrb2c8zGzpNUg6twKtJeiluuOp3
         eWEPdxWwWH6xV45V52Y7FcSbZpbVYjJzygNspH2CYQY8B8AV6bUpued3DyER4g1zDH7c
         aSPYPR6l/IlrQFNCVytdkRrbAmWFhlt/4NBTWm26V/OFpqhk5PkqkmI6Ji88LV7IJRlQ
         SG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfSnqd2JJ3k7CDJOYbTWuP8axl6r8djqgptR6mkFpfg=;
        b=CnzamH8JhM+oT9bvWiKnLPf+gMHD5fcozeuQba5X3sfSagUQXrC+3pGsyhO8jKwCyZ
         yQHt+LeP1LfPtXpSfL38O6lw+aJ2H1T0f70DoUFen8xV6fNO5rjVHvCnHxeqtyOxZmLI
         YLSdaRyXFmMmoDALy5R85DSIv75WgokUYErfAivcjH/Wh1APBdWrTUsbBOlzeRukuoT4
         hKBpcAetUOx+N+VTrQP2BiPok4+Gn1iXo7MfLpxj5iD26MLOJj0YU3pZ2u3vMypa5j7/
         YpDAYoZZt5wOrlc3KyjOdSlyW1x+xiKp9FvoVQe2zh/m9VnE30ZQeEtoNod5QXsLllcd
         muYA==
X-Gm-Message-State: AOAM53194ULppml1RnpZ9MWggzidVQ5fb3I4ANHq2d9kd/4fs3LNl2xD
        4fITHzxTkMbGXd1YG/LLbg5Kof25qfo=
X-Google-Smtp-Source: ABdhPJzHZQc7RIZWYmv1OhIrMTjlEParAu3OrB5H1d+wD8il1Lzle+nnU4uit0ti+hUfZKi2jHnxRQ==
X-Received: by 2002:a62:1b91:0:b0:50a:64d0:58a2 with SMTP id b139-20020a621b91000000b0050a64d058a2mr6541770pfb.38.1650657502270;
        Fri, 22 Apr 2022 12:58:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a2c4600b001cb78f1e301sm7152116pjm.1.2022.04.22.12.58.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:58:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted
Date:   Fri, 22 Apr 2022 12:58:18 -0700
Message-Id: <20220422195818.3640058-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195818.3640058-1-luiz.dentz@gmail.com>
References: <20220422195818.3640058-1-luiz.dentz@gmail.com>
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
index 5a6c8afc51a0..66451661283c 100644
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
@@ -3179,12 +3179,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 done:
 	if (status) {
-		conn->state = BT_CLOSED;
-		if (conn->type == ACL_LINK)
-			mgmt_connect_failed(hdev, &conn->dst, conn->type,
-					    conn->dst_type, status);
-		hci_connect_cfm(conn, status);
-		hci_conn_del(conn);
+		hci_conn_failed(conn, status);
 	} else if (ev->link_type == SCO_LINK) {
 		switch (conn->setting & SCO_AIRMODE_MASK) {
 		case SCO_AIRMODE_CVSD:
@@ -5623,7 +5618,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
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

