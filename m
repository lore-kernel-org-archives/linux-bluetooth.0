Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BAEE77371
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Sep 2023 12:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjI3Mxq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Sep 2023 08:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjI3Mxp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Sep 2023 08:53:45 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F96E6
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 05:53:43 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RyRwh2l9kzyXv;
        Sat, 30 Sep 2023 15:53:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696078420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/AMsXO9IMyLMxzv4Xz4AhWb5QaTAdBihj6zISEM8lVk=;
        b=iionRygwcN/sp3O8e4Lpir+z3zyKdiNvSQyxku8ophR+kOGlQqiROCybC0SBp+GORHZSTD
        5WwgUzDIr4WUycNpBzj+IUBcA3I+LN3IrlSKyaqe0lVCIaz0wUG/WFaj8dbmiu2bhDNT2o
        XCcfdSNhp6YAByNzDPaRlirO2/BtFBM=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696078420; a=rsa-sha256; cv=none;
        b=Ixbw3tXqKJOMR/XS2wG3R1i5HJxPb+EPCBXWh3DEz6C3F4DZEB/OwzZV7DcoQxGYjRSuZv
        999+ok0y70sTnQ5uWZcS7lNbNO/5QcM5iiupaROHidY5ekqALzpqYa4N1kptu5BGUht9Wd
        VRLe/EOYcBPY/VrrSGRrqMXzTV/zqyo=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696078420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/AMsXO9IMyLMxzv4Xz4AhWb5QaTAdBihj6zISEM8lVk=;
        b=jsY263zxdi7NpCV/QRs6l3OwiKVANsa8dwvnGUxcnUVTix3x78nrbQurSAaSIO4rt1666X
        hEGMY723/Dlxqvnx0LUKDebgdiYSLwwOt0kgrz7yuZMQAmbPHTZMLIgNr6x/BHKyuZjN8B
        W+fCfhBjVP5R3qmsf9sZBLtq4xNFobc=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: always check if connection is alive before deleting
Date:   Sat, 30 Sep 2023 15:53:32 +0300
Message-ID: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In hci_abort_conn_sync it is possible that conn is deleted concurrently
by something else, also e.g. when waiting for hdev->lock.  This causes
double deletion of the conn, so UAF or conn_hash.list corruption.

Fix by having all code paths check that the connection is still in
conn_hash before deleting it, while holding hdev->lock which prevents
any races.

Log (when powering off while BAP streaming, occurs rarely):
=======================================================================
kernel BUG at lib/list_debug.c:56!
...
 ? __list_del_entry_valid (lib/list_debug.c:56)
 hci_conn_del (net/bluetooth/hci_conn.c:154) bluetooth
 hci_abort_conn_sync (net/bluetooth/hci_sync.c:5415) bluetooth
 ? __pfx_hci_abort_conn_sync+0x10/0x10 [bluetooth]
 ? lock_release+0x1d5/0x3c0
 ? hci_disconnect_all_sync.constprop.0+0xb2/0x230 [bluetooth]
 ? __pfx_lock_release+0x10/0x10
 ? __kmem_cache_free+0x14d/0x2e0
 hci_disconnect_all_sync.constprop.0+0xda/0x230 [bluetooth]
 ? __pfx_hci_disconnect_all_sync.constprop.0+0x10/0x10 [bluetooth]
 ? hci_clear_adv_sync+0x14f/0x170 [bluetooth]
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_set_powered_sync+0x293/0x450 [bluetooth]
=======================================================================

Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: rebased

 net/bluetooth/hci_sync.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3640d73f9595..c6f57af88bfd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5380,6 +5380,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err = 0;
 	u16 handle = conn->handle;
+	bool disconnect = false;
 	struct hci_conn *c;
 
 	switch (conn->state) {
@@ -5395,24 +5396,15 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		break;
 	case BT_OPEN:
 	case BT_BOUND:
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, reason);
-		hci_dev_unlock(hdev);
-		return 0;
+		break;
 	default:
-		hci_dev_lock(hdev);
-		conn->state = BT_CLOSED;
-		hci_disconn_cfm(conn, reason);
-		hci_conn_del(conn);
-		hci_dev_unlock(hdev);
-		return 0;
+		disconnect = true;
+		break;
 	}
 
 	hci_dev_lock(hdev);
 
-	/* Check if the connection hasn't been cleanup while waiting
-	 * commands to complete.
-	 */
+	/* Check if the connection has been cleaned up concurrently */
 	c = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!c || c != conn) {
 		err = 0;
@@ -5424,7 +5416,13 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
-	hci_conn_failed(conn, reason);
+	if (disconnect) {
+		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, reason);
+		hci_conn_del(conn);
+	} else {
+		hci_conn_failed(conn, reason);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.41.0

