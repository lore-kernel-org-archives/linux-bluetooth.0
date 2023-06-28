Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EAEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 19:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjF1TVa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjF1TVW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 15:21:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757EC1FF7
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:21:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b7fef01fe4so2940355ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980080; x=1690572080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mk/SD3P5eFjusQffuHxjenSdv+5pnTFFVM9aV8xV4PI=;
        b=ZwBvPQb478akj49vp9SZ83RdgyqWuqOjsSAGpwjGTkEW02wEu0FbTgGDqwg4ae4o9J
         dJhR8DTuEP+/iafzVTdmvIc5RiY0uwJjsYPYO0t89a2TEq0B2lAUkvE/77OiNhjsLOkM
         iqnaSfOd47qs92JeXNoDWBQVcJcguR9gbZxKBqTXmDtoLsW/bT7OmmSXyOLyxj8J6jnH
         L0IBwnquTrjECcR0Y5+mBja3upwtOI4PDCHLAfvCc5FrYGBFaeFrSKFT23u/egLrA1nD
         OdBYl7vi06u+v++2wQAG3iqNN3H9N4L0VR3P0TMTYKKjBvu8Ncf9znAE/cHzEHv76rJJ
         2neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980080; x=1690572080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk/SD3P5eFjusQffuHxjenSdv+5pnTFFVM9aV8xV4PI=;
        b=fkj2DbRRlxGIp/xQ1vrpTpR8TNRRVt6Z34D8iOe5vqzEcP06m9CDTsJhEGVQq53iFL
         nG0u43gcO7e8QjWkvaeQw3CFnyRIIJQiNtrYAWTMFU3l6eSVgkyEzgF32T+hmjKgeRGn
         hhqTK//PfppVnzCT5p9QbSnBoybeP6vglvfvuwA2El0j3q2O3yhc8cd/AgAPKoSR0EO1
         /cWNFieMSHdM57QDFwAwhGghaX/rh5GbyhBX/ImsYlpHdyAVjA6SS6U4Ma8+Tp4xX1az
         mkSLQ30i+xyHpq06Gsja4XKyufDv9QU/l/RWgaXxmaW7jeIMPb2LZWkxzgNezdZhJGlg
         SwfA==
X-Gm-Message-State: AC+VfDwwHi39jZCplvFkbvCa7FgVXWSPnV1YvhPjqwu77YWit6wTtMUC
        WyvhYCnJk2XscXnIuDwkg/3ZgB81k9o=
X-Google-Smtp-Source: ACHHUZ7XxxRU1Z1b8Bwv4ioMr9h7zXzFS+IdfNZ6MdnBZoUS+SmX6lm7VYhd8WprAiGCsb8ZPBYu0Q==
X-Received: by 2002:a17:902:7b89:b0:1b7:e671:8b15 with SMTP id w9-20020a1709027b8900b001b7e6718b15mr7841449pll.22.1687980080054;
        Wed, 28 Jun 2023 12:21:20 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902b59300b001b04c2023e3sm7968004pls.218.2023.06.28.12.21.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:21:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: hci_conn: Always allocate unique handles
Date:   Wed, 28 Jun 2023 12:21:14 -0700
Message-Id: <20230628192114.2773581-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628192114.2773581-1-luiz.dentz@gmail.com>
References: <20230628192114.2773581-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to always allocate a unique handle for connections so they
can be properly aborted by the likes of hci_abort_conn, so this uses the
invalid range as a pool of unset handles that way if userspace is trying
to create multiple connections at once each will be given a unique
handle which will be considered unset.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 25 ++++++++++++++++++++++---
 net/bluetooth/hci_event.c        |  6 +++---
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 094ca3aca15e..c0ca3f869c92 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -321,8 +321,8 @@ struct adv_monitor {
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
-#define HCI_CONN_HANDLE_UNSET		0xffff
 #define HCI_CONN_HANDLE_MAX		0x0eff
+#define HCI_CONN_HANDLE_UNSET(_handle)	(_handle > HCI_CONN_HANDLE_MAX)
 
 /* Min encryption key size to match with SMP */
 #define HCI_MIN_ENC_KEY_SIZE		7
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 88f18f375684..3de50985c2cf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -932,6 +932,25 @@ static void cis_cleanup(struct hci_conn *conn)
 	hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
 }
 
+static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+	u16 handle = HCI_CONN_HANDLE_MAX + 1;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		/* Find the first unused handle */
+		if (handle == 0xffff || c->handle != handle)
+			break;
+		handle++;
+	}
+	rcu_read_unlock();
+
+	return handle;
+}
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role)
 {
@@ -945,7 +964,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	bacpy(&conn->dst, dst);
 	bacpy(&conn->src, &hdev->bdaddr);
-	conn->handle = HCI_CONN_HANDLE_UNSET;
+	conn->handle = hci_conn_hash_alloc_unset(hdev);
 	conn->hdev  = hdev;
 	conn->type  = type;
 	conn->role  = role;
@@ -1057,7 +1076,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
 			 */
 			if ((child->type == SCO_LINK ||
 			     child->type == ESCO_LINK) &&
-			    child->handle == HCI_CONN_HANDLE_UNSET)
+			    HCI_CONN_HANDLE_UNSET(child->handle))
 				hci_conn_del(child);
 		}
 
@@ -1931,7 +1950,7 @@ int hci_conn_check_create_cis(struct hci_conn *conn)
 		return -EINVAL;
 
 	if (!conn->parent || conn->parent->state != BT_CONNECTED ||
-	    conn->state != BT_CONNECT || conn->handle == HCI_CONN_HANDLE_UNSET)
+	    conn->state != BT_CONNECT || HCI_CONN_HANDLE_UNSET(conn->handle))
 		return 1;
 
 	return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 77cbf13037b3..0b4415e79989 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3173,7 +3173,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	 * As the connection handle is set here for the first time, it indicates
 	 * whether the connection is already set up.
 	 */
-	if (conn->handle != HCI_CONN_HANDLE_UNSET) {
+	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
 		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for existing connection");
 		goto unlock;
 	}
@@ -5032,7 +5032,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	 * As the connection handle is set here for the first time, it indicates
 	 * whether the connection is already set up.
 	 */
-	if (conn->handle != HCI_CONN_HANDLE_UNSET) {
+	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
 		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete event for existing connection");
 		goto unlock;
 	}
@@ -5896,7 +5896,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 * As the connection handle is set here for the first time, it indicates
 	 * whether the connection is already set up.
 	 */
-	if (conn->handle != HCI_CONN_HANDLE_UNSET) {
+	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
 		bt_dev_err(hdev, "Ignoring HCI_Connection_Complete for existing connection");
 		goto unlock;
 	}
-- 
2.40.1

