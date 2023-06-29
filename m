Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD39EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 00:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjF2ANY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 20:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjF2ANT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 20:13:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7F5172D
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 17:13:18 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3422d37d316so444545ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 17:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687997597; x=1690589597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipbcG/VgrXXbTsgiY23kfm4/v1m5GZX5PbAY1xEZeMM=;
        b=FaTR51SgTeZ5Aku047dkbGK/ihBimdSyoPeykifoxbFXypgr+xGAJ/SKIQ+VoV+asO
         lIrUquaBeV9c8xUmaG3aprMYAKzuf6IT0xPlMcprxpM4Ydo0uiPxV/VDQwJrTThEf2uw
         4ePSfAPvBDpNl95+qhrdbwOzIs3Yvm0OfR8vK/uMVkJiKZBSYiPj15hrO6cHLEGxE5yU
         WisbZqaPvvTB2Iinv6GYTyrntmQQnNVYM1mujBXRoUGtwUwg+vqFgkV6DyQV1MRNIvIx
         4U30PHROUngc08QhSzyr8vA6vbsYW3ISHm5fPGRTsoJwbtotCNvn5TJuz6o+xXY7oGr8
         2WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687997597; x=1690589597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipbcG/VgrXXbTsgiY23kfm4/v1m5GZX5PbAY1xEZeMM=;
        b=GfJjV+hfU+Nt9iQ8SHDypjtm9Qz9YLTZaeUGmJJGQg9HnKDwuCRk2dBDd3OsVHbc+z
         Pn0WIQ1NvAi6KM3qr1ldahUDSt6vccxuLgX+1kEOCW2cC21ICVp5r7bykaCl5r3Gn8HV
         hp7sWn8FY1GJ/DLDUw6RfUT6H5k93P/F6sZzhst0FTNpxxdjuFHVdBXkZci2NxE4VYJt
         y823LUKLz6linOK3kZSS4MR0M1eCJkFdpdy+Yt+YGx7ppwD384kLWXWRNeAvIUOjb1Kw
         9BIGXNtRxSb2uys/MYkYAPUVO+tRWMnWwtK68jadeW+7lhcgM1mWHnX40smW0Y+5Xbm3
         P1kA==
X-Gm-Message-State: AC+VfDxKmWanwvO7BWwM4G7xUe/NjOj0TvDD6mLB37wNs+0qY2b2t0Tj
        IkXnjXMTDcZ2FL0YXw5J8IP1Ur/zEuk=
X-Google-Smtp-Source: ACHHUZ6uFhixYbMaxpgfRp8XAAUctHdhEAwKCSLz1Xy/LvzVJupUloB9U5NMClMl1pdsBYes1oUPOQ==
X-Received: by 2002:a92:b04:0:b0:345:6ffa:63c7 with SMTP id b4-20020a920b04000000b003456ffa63c7mr12530973ilf.32.1687997596591;
        Wed, 28 Jun 2023 17:13:16 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id h7-20020a92d847000000b003459d60aaeasm3014291ilq.45.2023.06.28.17.13.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 17:13:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/3] Bluetooth: hci_conn: Always allocate unique handles
Date:   Wed, 28 Jun 2023 17:13:10 -0700
Message-Id: <20230629001310.2946122-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629001310.2946122-1-luiz.dentz@gmail.com>
References: <20230629001310.2946122-1-luiz.dentz@gmail.com>
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
index 0b717989cd4f..83858e6b674c 100644
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
 
@@ -1943,7 +1962,7 @@ int hci_conn_check_create_cis(struct hci_conn *conn)
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

