Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387043AbiDUVgF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiDUVgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 17:36:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD0C49F9B
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:33:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n8so6593762plh.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4ge2fjTGNbco9PNIIuhtJCHmMwyWdxUxshl86o03s8=;
        b=GPD1FGWfVECzyH4msH1CkOkR9KaDtu4fq9OZGvwVoN91Ro4UgOwzZeQ8k7SjY3molo
         CURUHNMr69OKz/9f+lyG8zuupomTV15xgCFvz9hvtjteYswT928WY7Am29z9gUDkWTJw
         V4MXAUj9CM3XsX33yjPvxaZIofoeUUDh6652W5C4zwoj73N2AoQMWiz4p2FXPJTioW0o
         YpSaOzrO9zYfMOCqYQf7tBnlRx7K6erbUaZ/jDuV64+Qzz2sEs8kcbwiyEYOOi2IqHCO
         14ifkeN630t53jUhL4E63Mxz+Y0gAkmlh+3Rbd2cnJVCjPyw9pjsNK80+3RZBncTP1v6
         FbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4ge2fjTGNbco9PNIIuhtJCHmMwyWdxUxshl86o03s8=;
        b=I/yI409MKrhd3F7gbV5CxKGYBSKjALzgwr1kQH6KrEwdbswuPw/spxwvvNVlrK/P83
         kL0sf9QumbmYs696BtbCxvJz9lpdBMNvlaKcKKSlp48lbPi+Sa8ctUVodLwjpJ5J51Cv
         e/69HfTxSC+hWeCLLt6jdKyHqAmyWYE9FrXWCbLqy6+qxmnU8Wlr/EU9Ttg+tMa7PaMN
         uR+XrFZMFzVVamc6lwMUiyOFAihQpUh23nUYomv/1mHTkxviJXfnhipzphKVPIhusSwi
         7KpskBK+GQhuIFGwyFeu8JVXnGEzETrBu2LvE9cJDGQYiRkZQ+xasXyMfcRtw8AiKieq
         D/kg==
X-Gm-Message-State: AOAM532bJ2NJBd7KuvZ84BiBtpM8fhnLz3UyEDz5x6w9DSc6XimjnUmR
        SDgJq6N29M28TqLSu2r9B0bdW9AtGEI=
X-Google-Smtp-Source: ABdhPJzaC+dltm2rJ/xm0nTQ49rhl+lRNBP0bbqJZV+o2xHMAevkCVGrr9rBr7Vkx8WviboEpLyUkA==
X-Received: by 2002:a17:90a:d901:b0:1cb:97ae:636b with SMTP id c1-20020a17090ad90100b001cb97ae636bmr1757436pjv.60.1650576791567;
        Thu, 21 Apr 2022 14:33:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p42-20020a056a0026ea00b0050ab776f6a2sm60236pfw.103.2022.04.21.14.33.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:33:10 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted
Date:   Thu, 21 Apr 2022 14:33:09 -0700
Message-Id: <20220421213309.3304447-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
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

