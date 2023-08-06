Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED64C001B0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 15:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHFP1w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFP1t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 11:27:49 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F066E6
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 08:27:47 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJjxq6THdz49Q3D;
        Sun,  6 Aug 2023 18:27:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691335664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3N0CGa6ode3fZYG87mYm19jTPbKxxmxXuOK3wspRIFA=;
        b=fJUqfizrivaCXPIWvO+5kUu3LJK2BU6puuPUe7mSuNPBQIJVI2xFtWhHFFjT3TeV7edecQ
        PUuTgaEtK7R75MVW4j8RLL/ufxAfiQN/4eKaN5meSBrpxe4O/dkYXfAsdPCQu8KVzjVGNJ
        nhA21BA6HblkR0rgOLb3utEnT1tUy2L60C6PbK1o4dwJ/o9VHL7IwPrjqvVVpPPrGCajsV
        pUzcg/iBdeCDbt9mx2teYMJ2m+UqLWwWAglBkVN/UzeQgPA77WyPFIgEZma4FGBTOoZOFi
        MJ4v9YenjOSM+AezksCcYMmWfMq9OmOy9y66KxO2JJZs0R9ErLUwQUUeuZEHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691335664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3N0CGa6ode3fZYG87mYm19jTPbKxxmxXuOK3wspRIFA=;
        b=MvXc2Vj2IR6NnY+LvTTEohJ1ROFi3vUNtZPnf50Iq71feSZtJqk/nbUijsLUtOlXJVbqMu
        9yYtB2dc/tKT6yRz80wEm0q2mMnx5kydm1Hje2vocb9BPOcpBznza0h5EuQJwC9vXP2fOA
        AR3Y+NlLS6UYvL7jKG+rAgXstApO4J9NVYI7JUlU2elUDrClBLgW674GSB3Iy7HgZzElG3
        ztEZCd+JvPVDfe/7Ns5dDiTA6N7HpF9+AnuLjBoDmgWj9AEImpaMNpFNmfOwC7x5i3TO0q
        bBaUQaRxUCXkYi8f/yixrMAjegRiU24Y7Vuakaw4DidG2tx29hoGncsHejaZ5w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691335664; a=rsa-sha256;
        cv=none;
        b=r9p6bNjCEKO6dY19R2WDLHB/6EBJw7wFL/lL+EQ3eDkOhWrXRFY/Dt1Sf0Ag9RBBGG5ED9
        3DO7K4IMBcnxtbfdTWfshdn6j+sg/v912NPhbsLA5IZ26g2tA6M6aofrJj9yBUgaygh6Zq
        mnPPR3Lnts8n4IH1Dk2DBsz+v+/rbRFJjye1Htt6NuKfwbDNJ5uDA6d/Yhp74FTdWFNWDC
        fhkOo+GA0+HP+11s4QiKuDGBauZoxH9NxNlBkrqQ/hnWlzcmsnKuqnwXwxuq3LP1ipeZHg
        Ac/zpJHyw3hiM9q+GeEID5GKceWiG1g/mw/rf+PGUS7fOWI3BKCuzWA0Vzzs/Q==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/3] Bluetooth: hci_sync: fix canceling LE scanning / CIS create conn state
Date:   Sun,  6 Aug 2023 18:27:37 +0300
Message-ID: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691331800.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In hci_abort_conn_sync, some errors from hci_le_connect_cancel_sync
indicate the connection can be terminated immediately.  However,
hci_abort_conn_sync passes these errors through, making
hci_disconnect_all_sync stop processing in these cases.

Fix by using a separate flag to indicate if canceled connection can be
deleted directly.

Fixes: 0f2efc1d02d5 ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Fixes: dd1f6778b17b ("Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 48 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41a8e57d8267..51ff682f66e0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5253,13 +5253,14 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 }
 
 static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
-				      struct hci_conn *conn, u8 reason)
+				      struct hci_conn *conn, u8 reason,
+				      bool *del)
 {
-	/* Return reason if scanning since the connection shall probably be
-	 * cleanup directly.
-	 */
-	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-		return reason;
+	/* If scanning, connection can be just deleted */
+	if (test_bit(HCI_CONN_SCANNING, &conn->flags)) {
+		*del = true;
+		return 0;
+	}
 
 	if (conn->role == HCI_ROLE_SLAVE ||
 	    test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
@@ -5270,10 +5271,10 @@ static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
 }
 
 static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				   u8 reason)
+				   u8 reason, bool *del)
 {
 	if (conn->type == LE_LINK)
-		return hci_le_connect_cancel_sync(hdev, conn, reason);
+		return hci_le_connect_cancel_sync(hdev, conn, reason, del);
 
 	if (conn->type == ISO_LINK) {
 		/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
@@ -5287,9 +5288,9 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
 			return hci_disconnect_sync(hdev, conn, reason);
 
-		/* CIS with no Create CIS sent have nothing to cancel */
+		/* CIS with no Create CIS sent can be just deleted */
 		if (bacmp(&conn->dst, BDADDR_ANY))
-			return HCI_ERROR_LOCAL_HOST_TERM;
+			*del = true;
 
 		/* There is no way to cancel a BIS without terminating the BIG
 		 * which is done later on connection cleanup.
@@ -5370,6 +5371,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err = 0;
 	u16 handle = conn->handle;
+	bool del = false;
 
 	switch (conn->state) {
 	case BT_CONNECTED:
@@ -5377,17 +5379,15 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_disconnect_sync(hdev, conn, reason);
 		break;
 	case BT_CONNECT:
-		err = hci_connect_cancel_sync(hdev, conn, reason);
+		err = hci_connect_cancel_sync(hdev, conn, reason, &del);
 		break;
 	case BT_CONNECT2:
 		err = hci_reject_conn_sync(hdev, conn, reason);
 		break;
 	case BT_OPEN:
 	case BT_BOUND:
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, reason);
-		hci_dev_unlock(hdev);
-		return 0;
+		del = true;
+		break;
 	default:
 		conn->state = BT_CLOSED;
 		return 0;
@@ -5398,18 +5398,15 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
-	if (err) {
-		struct hci_conn *c;
+	if (err || del) {
+		hci_dev_lock(hdev);
 
 		/* Check if the connection hasn't been cleanup while waiting
 		 * commands to complete.
 		 */
-		c = hci_conn_hash_lookup_handle(hdev, handle);
-		if (!c || c != conn)
-			return 0;
+		if (hci_conn_hash_lookup_handle(hdev, handle) == conn)
+			hci_conn_failed(conn, del ? reason : err);
 
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, err);
 		hci_dev_unlock(hdev);
 	}
 
@@ -6311,8 +6308,11 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 				       conn->conn_timeout, NULL);
 
 done:
-	if (err == -ETIMEDOUT)
-		hci_le_connect_cancel_sync(hdev, conn, 0x00);
+	if (err == -ETIMEDOUT) {
+		bool __maybe_unused del;
+
+		hci_le_connect_cancel_sync(hdev, conn, 0x00, &del);
+	}
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
-- 
2.41.0

