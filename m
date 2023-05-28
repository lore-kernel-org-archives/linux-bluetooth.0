Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E39C7EE2F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjE1RoZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjE1RoV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:44:21 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94519A0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:44:19 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3AA98240029
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:44:18 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmHj65fJz6twQ;
        Sun, 28 May 2023 19:44:17 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 5/6] Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
Date:   Sun, 28 May 2023 17:44:13 +0000
Message-Id: <bcae59679f7387e6f5f3e6da79827da4cc341870.1685294131.git.pav@iki.fi>
In-Reply-To: <cover.1685294131.git.pav@iki.fi>
References: <cover.1685294131.git.pav@iki.fi>
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
 net/bluetooth/hci_event.c | 66 +++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d00ef6e3fc45..71d8f1442287 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3804,43 +3804,77 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
 	struct hci_rp_le_set_cig_params *rp = data;
+	struct hci_cp_le_set_cig_params *cp;
 	struct hci_conn *conn;
-	int i = 0;
+	u16 handles[0x1f];
+	int num_handles;
+	u8 status = rp->status;
+	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
+	if (!cp || rp->num_handles != cp->num_cis || rp->cig_id != cp->cig_id ||
+	    rp->num_handles > ARRAY_SIZE(handles)) {
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
+	num_handles = rp->num_handles;
+	for (i = 0; i < rp->num_handles; ++i)
+		handles[i] = __le16_to_cpu(rp->handle[i]);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (conn->type != ISO_LINK ||
-		    conn->iso_qos.ucast.cig != rp->cig_id ||
-		    conn->state == BT_CONNECTED)
+		if (conn->type != ISO_LINK || !bacmp(&conn->dst, BDADDR_ANY) ||
+		    (conn->state != BT_BOUND && conn->state != BT_CONNECT) ||
+		    conn->iso_qos.ucast.cig != rp->cig_id)
 			continue;
 
-		conn->handle = __le16_to_cpu(rp->handle[i++]);
+		for (i = 0; i < rp->num_handles; ++i) {
+			if (handles[i] == HCI_CONN_HANDLE_UNSET)
+				continue;
+			if (conn->iso_qos.ucast.cis != cp->cis[i].cis_id)
+				continue;
 
-		bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
-			   conn->handle, conn->parent);
+			conn->handle = handles[i];
+			handles[i] = HCI_CONN_HANDLE_UNSET;
+			--num_handles;
 
-		/* Create CIS if LE is already connected */
-		if (conn->parent && conn->parent->state == BT_CONNECTED) {
-			rcu_read_unlock();
-			hci_le_create_cis(conn);
-			rcu_read_lock();
+			bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p",
+				   conn, conn->handle, conn->parent);
+
+			/* Create CIS if LE is already connected */
+			if (conn->parent &&
+			    conn->parent->state == BT_CONNECTED) {
+				rcu_read_unlock();
+				hci_le_create_cis(conn);
+				rcu_read_lock();
+			}
+
+			break;
 		}
-
-		if (i == rp->num_handles)
+		if (!num_handles)
 			break;
 	}
 
-- 
2.40.1

