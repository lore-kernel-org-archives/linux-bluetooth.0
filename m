Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCF4C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 06:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjFAGfT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFAGfR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 02:35:17 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614E98
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 23:35:15 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QWxFr3fkkz10Kv;
        Thu,  1 Jun 2023 09:35:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1685601312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+moHLVNvi16naetVhBMjngVC/O1PPSoMHNM+8/hecLM=;
        b=aEsh+kK21orXkAf1NC7pga+MAMJGHSSBHpHRWIjM5KSxoBLc4ZjDuMVGvCzOqGI2VMO11L
        LweDXFI9r2OZsNfsy7iXDXZs271kekjgSpABoEZ+LvBB3T08o7M67TceZu+cagdb7xeIkh
        byJsQltJ1+IwKsqXHBZD6baG+R5gHbw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1685601312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+moHLVNvi16naetVhBMjngVC/O1PPSoMHNM+8/hecLM=;
        b=nfwokQqm4FUy3poFH12GilVnHktuDMbJ3SO9C+ZdCqSJ6CnAd1Ury0Wjo1cmsUQICTOXw/
        30MmA/cD/88ITzMb/avAKRYs7ZgxPYRGX8ZDF7bVLgUH5A18/dsCRlb1Z362MPD65bVg5I
        9EYQa2zW+s16zekBtyLWcFSEInc1ic0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1685601312; a=rsa-sha256; cv=none;
        b=XYY1pWKjmRYUwKsnZQZYvH/T6k9qimsUB5t1fnoBIhmQClq30rWm5rzckTCQibQk7xDe5+
        pE3jS/IuMTYT/YKEyFRW5popXCyoDrpBGDQNYISse/SKdA0+3vhYqZlkybFApQi9gFf7s5
        tgiNhJBJQ2597CgAsk9Ig8TtUPXeVMs=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 3/4] Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
Date:   Thu,  1 Jun 2023 09:34:45 +0300
Message-Id: <bfc91e2fbc562938a1a02f23793ce726bd1ef254.1685565568.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685565568.git.pav@iki.fi>
References: <cover.1685565568.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The order of CIS handle array in Set CIG Parameters response shall match
the order of the CIS_ID array in the command (Core v5.3 Vol 4 Part E Sec
7.8.97).  We send CIS_IDs mainly in the order of increasing CIS_ID (but
with "last" CIS first if it has fixed CIG_ID).  In handling of the
reply, we currently assume this is also the same as the order of
hci_conn in hdev->conn_hash, but that is not true.

Match the correct hci_conn to the correct handle by matching them based
on the CIG+CIS combination.  The CIG+CIS combination shall be unique for
ISO_LINK hci_conn at state >= BT_BOUND, which we maintain in
hci_le_set_cig_params.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: simplify and swap loops

 net/bluetooth/hci_event.c | 59 +++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fe8177512a89..d0ccb8ebdcc9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3804,44 +3804,67 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
 	struct hci_rp_le_set_cig_params *rp = data;
+	struct hci_cp_le_set_cig_params *cp;
 	struct hci_conn *conn;
-	int i = 0;
+	u8 status = rp->status;
+	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
+	if (!cp || rp->num_handles != cp->num_cis || rp->cig_id != cp->cig_id) {
+		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
+		status = HCI_ERROR_UNSPECIFIED;
+	}
+
 	hci_dev_lock(hdev);
 
-	if (rp->status) {
+	if (status) {
 		while ((conn = hci_conn_hash_lookup_cig(hdev, rp->cig_id))) {
 			conn->state = BT_CLOSED;
-			hci_connect_cfm(conn, rp->status);
+			hci_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
 		goto unlock;
 	}
 
+	/* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2553
+	 *
+	 * If the Status return parameter is zero, then the Controller shall
+	 * set the Connection_Handle arrayed return parameter to the connection
+	 * handle(s) corresponding to the CIS configurations specified in
+	 * the CIS_IDs command parameter, in the same order.
+	 */
+
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (conn->type != ISO_LINK ||
-		    conn->iso_qos.ucast.cig != rp->cig_id ||
-		    conn->state == BT_CONNECTED)
-			continue;
+	for (i = 0; i < rp->num_handles; ++i) {
+		list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+			if (conn->type != ISO_LINK ||
+			    !bacmp(&conn->dst, BDADDR_ANY))
+				continue;
+			if (conn->state != BT_BOUND &&
+			    conn->state != BT_CONNECT)
+				continue;
+			if (conn->iso_qos.ucast.cig != rp->cig_id ||
+			    conn->iso_qos.ucast.cis != cp->cis[i].cis_id)
+				continue;
 
-		conn->handle = __le16_to_cpu(rp->handle[i++]);
+			conn->handle = __le16_to_cpu(rp->handle[i]);
 
-		bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
-			   conn->handle, conn->parent);
+			bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p",
+				   conn, conn->handle, conn->parent);
 
-		/* Create CIS if LE is already connected */
-		if (conn->parent && conn->parent->state == BT_CONNECTED) {
-			rcu_read_unlock();
-			hci_le_create_cis(conn);
-			rcu_read_lock();
-		}
+			/* Create CIS if LE is already connected */
+			if (conn->parent &&
+			    conn->parent->state == BT_CONNECTED) {
+				rcu_read_unlock();
+				hci_le_create_cis(conn);
+				rcu_read_lock();
+			}
 
-		if (i == rp->num_handles)
 			break;
+		}
 	}
 
 	rcu_read_unlock();
-- 
2.40.1

