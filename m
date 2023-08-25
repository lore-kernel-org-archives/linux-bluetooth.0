Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB8C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Aug 2023 22:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjHYV7w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 17:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjHYV7b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 17:59:31 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF01C7
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 14:59:28 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RXYl14QNHz49Py8;
        Sat, 26 Aug 2023 00:59:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1693000766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pj+uNhEfbL15UAf1yV2PB1vMMwHTHuVFgxTJ1y9++xA=;
        b=X71Uj9iiErTkOOuNLx28XiH4ZaEhdWmhQND6MTe7A9qUn6DsR3zLQDsNxp2MEVjwIGkfh4
        O+SUxbzUoPgqo0o7A5CjcCIbA1syDNILSL7fPIMN8xFLa2VtbAM1nZEqLZvQAhcZYQiY2G
        IGwAtXPO1AVrN0ca5C5gb3zBIIPPCmCcfHeNECZywABIDy98YCy7hDv2CLL15DDcWbrVey
        TDxMgAs9oED4EPTDgZOu3ha7ZSl/52YGHOAtZ+bRxxP6xxb4/o6vDrNvlh8Ghjp6b8ifOF
        6e8npZhsCjhVhN3DW8Tgm0QbeiNXm8v4mAXWuQkamQ67pTIaUFmUUA6cWOeySQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1693000766; a=rsa-sha256;
        cv=none;
        b=XjnjlKCqI6T6PQIJVSYYhAA5U+qa32tu1YHeyuRQ556Vb9zdgi1Rm1R9l8Et8Nlbh3pCYN
        Uu+ZnSBqjGI9gWn1401+akUu20NaA3OJff53S2O8g52xbdr4LThnRj6BJXUE6TwmcNe6Wg
        hPMfw/hx19dXjAFAaozUGQ2BvtqkvrUAXR7obq+F0Bar7/l5keV3BGY1qmCcZmHHr20AeN
        GoprJg00cy0MgTexmEvUFP6qQGZNRDhr2O8LZO/GrVLOyWrGA5DJMznjmaswmGrK9fOYX6
        ZB7/jQT26sIyUfVd+dcPCRBKBBpJlNPEPtnNP43GQuNzXs+5GPjrOCTVG6Jf5A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1693000766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pj+uNhEfbL15UAf1yV2PB1vMMwHTHuVFgxTJ1y9++xA=;
        b=oXA03fVw+XhM2MZxeY5y7V4YYdcRgURHMXewp4+ZRwbRI/QK0n2GeaghDAE7EBwHaLry6K
        nrg3hjqxreQ71o0qHdlyTHtFNy2YD1DjDBvRpCtz9LDGPyaaTXMRZDHVkLRJi6FFT0ktM3
        k8nrvIlProMdb7HetOWIK7c3ktGnvG8AH4yjCnireZV13MmiHdwzX5Vmk6v3F4XjZcGNxg
        IRz3vjmFrHA/8E80x8xW02a1Ar5uXNewbFSn9spoB3gt/OX3mi5aux4kII9P71IE1GBXVd
        8f8IceX/HaQVcRXCtPks5eDA9h1diBiwZWZFc1VsnCvk9nGPrHrvosMO2Ph8Zg==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_sync: always check if connection is alive before deleting
Date:   Sat, 26 Aug 2023 00:59:22 +0300
Message-ID: <43b78eefdc31e0ac1b24373ac71ef5a8cbb092f5.1693000169.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In hci_abort_conn_sync it is possible that conn is deleted concurrently
by something else, also e.g. when waiting for hdev->lock.  This causes
double deletion of the conn, so UAF or conn_hash.list corruption.

Fix by checking for all deletions that the connection is still in
conn_hash, while holding hdev->lock which prevents any races.

Also remove bis/pa sync special handling, as it's not really necessary.

Also fixes a busy loop in disconnect_all_sync for non-BIG conns in state
BT_OPEN.

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
Fixes: fbdc4bc47268 ("Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Deleting conns in hci_sync just keeps on giving, this hopefully should
    be the last one on hci_sync side.
    
    I tested 94d9ba9f9888 earlier, but apparently didn't have enough
    good/bad luck to hit this one then.
    
    There might be more in hdev->workqueue side, given that some code paths
    there don't lock properly and assume deletions are serialized. Maybe
    these should be fixed to lock, or move the lookup-handle-then-delete
    part to hdev->workqueue.

 net/bluetooth/hci_sync.c | 41 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a93096c5cbfd..f834c9ff0dfe 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5374,6 +5374,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	int err = 0;
 	u16 handle = conn->handle;
 	struct hci_conn *c;
+	bool disconnect = false;
 
 	WARN_ON(!reason);
 
@@ -5389,40 +5390,16 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	case BT_OPEN:
-		hci_dev_lock(hdev);
-
-		/* Cleanup bis or pa sync connections */
-		if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags) ||
-		    test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->flags)) {
-			hci_conn_failed(conn, reason);
-		} else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
-			   test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
-			conn->state = BT_CLOSED;
-			hci_disconn_cfm(conn, reason);
-			hci_conn_del(conn);
-		}
-
-		hci_dev_unlock(hdev);
-		return 0;
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
@@ -5434,7 +5411,13 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
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

