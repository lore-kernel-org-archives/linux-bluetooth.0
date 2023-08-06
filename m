Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A6FC04A94
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHFUU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjHFUU1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 16:20:27 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D41724
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 13:20:24 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJrRT2lPgz49Q1j;
        Sun,  6 Aug 2023 23:20:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691353221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qQ/2b4L7rBRc5IZPWLOSsKluo1grJKnEq9egpHwLt3Y=;
        b=HcGwAK37K6yT8ar5FAUOTE1bedns7ViHtPAK73Q3Denn2xV8kNmv5k0KsuUFvAcltSGGYY
        5W0bB60HeP9q35W08hIiaXl9JhmCzj0jzkl/uXwlZEhLQNKcrIfHtYdMSZ8TRtQa+REvFB
        EpF2XpsBGWhkHCCFuJx7Z/e9nZQCmpb9IgAUvPdFx6mrXZZNQBlrXlE/8iFnaVZk36qpiY
        Fbsfr3QD+fEkTmy+Uv3IcFO8EhQVxar7Jicy9TSMKECqTigMEfgpErSYn8xmCEHRalHh5G
        7OmcciraNp1V+mh1kJ0XmR0H+0pTO9FOkomvDPMWotn49U02X0SA8lFK2oT5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691353221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qQ/2b4L7rBRc5IZPWLOSsKluo1grJKnEq9egpHwLt3Y=;
        b=baBgQKvFycUPzHetiI1Q7XADm31JganrbEA75xDd8F67VDujl8QUm4qN7G3jI+mwz7r3Vn
        GJZZlURqe+05BTRnHHREGAqe5M7fBtKuL1fbZ0u9S2JKJ6hxUcKI9Q7FsXK0wZbSTKKWcx
        j4Fgd+17F1hZzs7d2lUH15f7fyD+rgXTPZL3jbdH2EfrAnPdQ8RWDl/mjaOToewZ/gTwZ1
        xlW/Oo5CGwj6G2FFMF2IAtgCNchDgGvmqW55KCzn7QotK9CMk9WT8sdn/SQD9J8O8+NGN+
        8BgmQkmyRvqBXAPpMVgWDO19/96BHjHYoCmTjcjJuuzUDoRIDrm1vtAt0MEZJw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691353221; a=rsa-sha256;
        cv=none;
        b=vRWqIWUBHJewV9BSfHRnHH455g47KFpEEmmMywDKhho8g+Nne2UJZLJI2oZR+txZhz7Sa/
        eSdK8X/hZVqhGTepYsBYgF1bvYbrukdamXJFuyXCea0eCr8qLFbfg9UACnqiddjWi9rumS
        CtrtyP5lQmfEup4BQ5KzqBbn+VTDSidXzmYSZuiPHGMavZaMUZOpjXEKTl2rBWSxsi+69W
        /ZY7wCwOz+WYZhG15KDlTygOSETRgbD4C+UTsjDU0sSuu6atxjdE13+uwMPaDJpGg2wzx0
        l64kOupjy07/t6NS1IPsxCljPHyX6goUPT3MAplRA/wNm1EiXsePEUjpQ1hK2w==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 1/4] Bluetooth: hci_sync: fix canceling LE scanning / CIS create conn state
Date:   Sun,  6 Aug 2023 23:18:37 +0300
Message-ID: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
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

Notes:
    v2: no change

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

