Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC58C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGZV0F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGZV0C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:02 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE5269E
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:47 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RB6Q11Gkgzyhc;
        Thu, 27 Jul 2023 00:25:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690406745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cStnu3uRKmISA/8+0oThhWnWzX9S6j2dgsNQupODTH0=;
        b=Cxs1Ml+x+UbjKtpPG1TkGExgmubCzwPcQKRcf3WPnunzmY3WpEqfvN3OoRP2w70LoKbXxF
        UfjX3/WFK4CFk4EgUZcu0eS4p/5jqkArhgAS/hqCHrF4MJPNA6sIqLS4HetccrnatQ/HMC
        mOgVtv7aUg5fU0gV8BnE3V7ywZZuvWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690406745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cStnu3uRKmISA/8+0oThhWnWzX9S6j2dgsNQupODTH0=;
        b=q5ctp2/J7By+6X1Jp0uAins5jCxv7WSSHnWdQcHAhZtHElqaHy1nKC2bPnJ20ONY/T1OWn
        zUGyQqSFhVJWNU2Bq/1zq0afBNMwvhXI2fLiyl9lUKzdCoVT4urFSIwXpC3498x1BHH6oH
        vfdc/jzM2fADAv8DhXsh4MfS+FJ1WZo=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690406745; a=rsa-sha256; cv=none;
        b=EosX0/9lrf+3m2IgynUDxBnIMNKHULhWhBGI+3ISeEHLzsQJsGYvtH2/emagO2hYvLvxfX
        qq8SM1BoOCK0hjWPpPQP5I5jDdP1vfjNiikl/SyuK6EIzjHRpirNHQqkI3mh/wLzgpwuxq
        YWHyewmJc1AugRBIZ+QdP8HNj+eH2Yg=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 1/6] Bluetooth: hci_conn: hci_conn_cleanup is not needed, combine with del
Date:   Thu, 27 Jul 2023 00:25:21 +0300
Message-ID: <30c5e6a7dc62ce209a2b9916fe8b2579d1b27756.1690399379.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690399379.git.pav@iki.fi>
References: <cover.1690399379.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_conn_cleanup is no longer needed, so move the code back to
hci_conn_del to keep the hci_conn teardown in a single place.

This undoes commit b958f9a3e877 ("Bluetooth: Fix reference counting for
LE-scan based connections"), but keeps the current order of cleanup
operations.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 78 +++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cccc2b8b60a8..a71a54a5c8d8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -139,45 +139,6 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 	hci_update_passive_scan(hdev);
 }
 
-static void hci_conn_cleanup(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-
-	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
-		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
-
-	if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
-		hci_remove_link_key(hdev, &conn->dst);
-
-	hci_chan_list_flush(conn);
-
-	hci_conn_hash_del(hdev, conn);
-
-	if (conn->cleanup)
-		conn->cleanup(conn);
-
-	if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
-		switch (conn->setting & SCO_AIRMODE_MASK) {
-		case SCO_AIRMODE_CVSD:
-		case SCO_AIRMODE_TRANSP:
-			if (hdev->notify)
-				hdev->notify(hdev, HCI_NOTIFY_DISABLE_SCO);
-			break;
-		}
-	} else {
-		if (hdev->notify)
-			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
-	}
-
-	hci_conn_del_sysfs(conn);
-
-	debugfs_remove_recursive(conn->debugfs);
-
-	hci_dev_put(hdev);
-
-	hci_conn_put(conn);
-}
-
 static void hci_acl_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -1127,12 +1088,39 @@ void hci_conn_del(struct hci_conn *conn)
 
 	skb_queue_purge(&conn->data_q);
 
-	/* Remove the connection from the list and cleanup its remaining
-	 * state. This is a separate function since for some cases like
-	 * BT_CONNECT_SCAN we *only* want the cleanup part without the
-	 * rest of hci_conn_del.
-	 */
-	hci_conn_cleanup(conn);
+	if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
+		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
+
+	if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+		hci_remove_link_key(hdev, &conn->dst);
+
+	hci_chan_list_flush(conn);
+
+	hci_conn_hash_del(hdev, conn);
+
+	if (conn->cleanup)
+		conn->cleanup(conn);
+
+	if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
+		switch (conn->setting & SCO_AIRMODE_MASK) {
+		case SCO_AIRMODE_CVSD:
+		case SCO_AIRMODE_TRANSP:
+			if (hdev->notify)
+				hdev->notify(hdev, HCI_NOTIFY_DISABLE_SCO);
+			break;
+		}
+	} else {
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
+	}
+
+	hci_conn_del_sysfs(conn);
+
+	debugfs_remove_recursive(conn->debugfs);
+
+	hci_dev_put(hdev);
+
+	hci_conn_put(conn);
 }
 
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
-- 
2.41.0

