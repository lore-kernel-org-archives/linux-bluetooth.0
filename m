Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C94C7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjE1Ro0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjE1RoW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:44:22 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1606CA2
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:44:19 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 96C5C240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:44:18 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTmHk1N0Gz6trs;
        Sun, 28 May 2023 19:44:18 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 6/6] Bluetooth: ISO: do not emit new LE Create CIS if previous is pending
Date:   Sun, 28 May 2023 17:44:14 +0000
Message-Id: <a098e48f548a729c202975e3de99086e7f174379.1685294131.git.pav@iki.fi>
In-Reply-To: <cover.1685294131.git.pav@iki.fi>
References: <cover.1685294131.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

LE Create CIS command shall not be sent before all CIS Established
events from its previous invocation have been processed. Currently it is
sent via hci_sync but that only waits for the first event, but there can
be multiple.

Make it wait for all events, and simplify the CIS creation as follows:

Add new flag HCI_CONN_CREATE_CIS, which is set if Create CIS has been
sent for the connection but it is not yet completed.

Make BT_CONNECT state to mean the connection wants Create CIS.

On events after which new Create CIS may need to be sent, send it if
possible and some connections need it. These events are:
hci_connect_cis, iso_connect_cfm, hci_cs_le_create_cis,
hci_le_cis_estabilished_evt.

The Create CIS status/completion events shall queue new Create CIS only
if at least one of the connections transitions away from BT_CONNECT, so
that we don't loop if controller is sending bogus events.

This fixes sending multiple CIS Create for the same CIS in the
"ISO AC 6(i) - Success" BlueZ test case:

< HCI Command: LE Create Co.. (0x08|0x0064) plen 9  #129 [hci0]
        Number of CIS: 2
        CIS Handle: 257
        ACL Handle: 42
        CIS Handle: 258
        ACL Handle: 42
> HCI Event: Command Status (0x0f) plen 4           #130 [hci0]
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 29           #131 [hci0]
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 257
        ...
< HCI Command: LE Setup Is.. (0x08|0x006e) plen 13  #132 [hci0]
        ...
> HCI Event: Command Complete (0x0e) plen 6         #133 [hci0]
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        ...
< HCI Command: LE Create Co.. (0x08|0x0064) plen 5  #134 [hci0]
        Number of CIS: 1
        CIS Handle: 258
        ACL Handle: 42
> HCI Event: Command Status (0x0f) plen 4           #135 [hci0]
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
        Status: ACL Connection Already Exists (0x0b)
> HCI Event: LE Meta Event (0x3e) plen 29           #136 [hci0]
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 258
        ...

Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Fix not waiting for HCI_EVT_LE_CIS_ESTABLISHED")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h |  4 +-
 include/net/bluetooth/hci_sync.h |  2 +-
 net/bluetooth/hci_conn.c         | 74 +++++++++++---------------
 net/bluetooth/hci_event.c        | 27 +++++++---
 net/bluetooth/hci_sync.c         | 90 ++++++++++++++++++++++----------
 net/bluetooth/iso.c              |  2 +-
 6 files changed, 118 insertions(+), 81 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9f37326c1c05..e3d7a18a9c04 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -975,6 +975,7 @@ enum {
 	HCI_CONN_SCANNING,
 	HCI_CONN_AUTH_FAILURE,
 	HCI_CONN_PER_ADV,
+	HCI_CONN_CREATE_CIS,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1324,7 +1325,8 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
-int hci_le_create_cis(struct hci_conn *conn);
+int hci_le_create_cis_pending(struct hci_dev *hdev);
+int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 2495be4d8b82..b516a0f4a55b 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -124,7 +124,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason);
 
 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn);
 
-int hci_le_create_cis_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_le_create_cis_sync(struct hci_dev *hdev);
 
 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e8a4f2825201..086b9e128bf9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1985,59 +1985,47 @@ bool hci_iso_setup_path(struct hci_conn *conn)
 	return true;
 }
 
+int hci_conn_check_create_cis(struct hci_conn *conn)
+{
+	if (conn->type != ISO_LINK || !bacmp(&conn->dst, BDADDR_ANY))
+		return -EINVAL;
+
+	if (!conn->parent || conn->parent->state != BT_CONNECTED ||
+	    conn->state != BT_CONNECT || conn->handle == HCI_CONN_HANDLE_UNSET)
+		return 1;
+
+	return 0;
+}
+
 static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 {
-	return hci_le_create_cis_sync(hdev, data);
+	return hci_le_create_cis_sync(hdev);
 }
 
-int hci_le_create_cis(struct hci_conn *conn)
+int hci_le_create_cis_pending(struct hci_dev *hdev)
 {
-	struct hci_conn *cis;
-	struct hci_link *link, *t;
-	struct hci_dev *hdev = conn->hdev;
-	int err;
+	struct hci_conn *conn;
+	bool pending = false;
 
-	bt_dev_dbg(hdev, "hcon %p", conn);
+	rcu_read_lock();
 
-	switch (conn->type) {
-	case LE_LINK:
-		if (conn->state != BT_CONNECTED || list_empty(&conn->link_list))
-			return -EINVAL;
-
-		cis = NULL;
-
-		/* hci_conn_link uses list_add_tail_rcu so the list is in
-		 * the same order as the connections are requested.
-		 */
-		list_for_each_entry_safe(link, t, &conn->link_list, list) {
-			if (link->conn->state == BT_BOUND) {
-				err = hci_le_create_cis(link->conn);
-				if (err)
-					return err;
-
-				cis = link->conn;
-			}
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags)) {
+			rcu_read_unlock();
+			return -EBUSY;
 		}
 
-		return cis ? 0 : -EINVAL;
-	case ISO_LINK:
-		cis = conn;
-		break;
-	default:
-		return -EINVAL;
+		if (!hci_conn_check_create_cis(conn))
+			pending = true;
 	}
 
-	if (cis->state == BT_CONNECT)
+	rcu_read_unlock();
+
+	if (!pending)
 		return 0;
 
 	/* Queue Create CIS */
-	err = hci_cmd_sync_queue(hdev, hci_create_cis_sync, cis, NULL);
-	if (err)
-		return err;
-
-	cis->state = BT_CONNECT;
-
-	return 0;
+	return hci_cmd_sync_queue(hdev, hci_create_cis_sync, NULL, NULL);
 }
 
 static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
@@ -2273,11 +2261,9 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return NULL;
 	}
 
-	/* If LE is already connected and CIS handle is already set proceed to
-	 * Create CIS immediately.
-	 */
-	if (le->state == BT_CONNECTED && cis->handle != HCI_CONN_HANDLE_UNSET)
-		hci_le_create_cis(cis);
+	cis->state = BT_CONNECT;
+
+	hci_le_create_cis_pending(hdev);
 
 	return cis;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 71d8f1442287..4a9ef9610dc8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3809,6 +3809,7 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	u16 handles[0x1f];
 	int num_handles;
 	u8 status = rp->status;
+	bool pending = false;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
@@ -3864,13 +3865,8 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 			bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p",
 				   conn, conn->handle, conn->parent);
 
-			/* Create CIS if LE is already connected */
-			if (conn->parent &&
-			    conn->parent->state == BT_CONNECTED) {
-				rcu_read_unlock();
-				hci_le_create_cis(conn);
-				rcu_read_lock();
-			}
+			if (conn->state == BT_CONNECT)
+				pending = true;
 
 			break;
 		}
@@ -3881,6 +3877,9 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	rcu_read_unlock();
 
 unlock:
+	if (pending)
+		hci_le_create_cis_pending(hdev);
+
 	hci_dev_unlock(hdev);
 
 	return rp->status;
@@ -4246,6 +4245,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_le_create_cis *cp;
+	bool pending = false;
 	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
@@ -4268,12 +4268,18 @@ static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
 
 		conn = hci_conn_hash_lookup_handle(hdev, handle);
 		if (conn) {
+			if (test_and_clear_bit(HCI_CONN_CREATE_CIS,
+					       &conn->flags))
+				pending = true;
 			conn->state = BT_CLOSED;
 			hci_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
 	}
 
+	if (pending)
+		hci_le_create_cis_pending(hdev);
+
 	hci_dev_unlock(hdev);
 }
 
@@ -6816,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_cis_established *ev = data;
 	struct hci_conn *conn;
+	bool pending = false;
 	u16 handle = __le16_to_cpu(ev->handle);
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
@@ -6837,6 +6844,8 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
+
 	if (conn->role == HCI_ROLE_SLAVE) {
 		__le32 interval;
 
@@ -6862,10 +6871,14 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
+	conn->state = BT_CLOSED;
 	hci_connect_cfm(conn, ev->status);
 	hci_conn_del(conn);
 
 unlock:
+	if (pending)
+		hci_le_create_cis_pending(hdev);
+
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a59695f04c25..dd011ddc1aff 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6170,56 +6170,92 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return err;
 }
 
-int hci_le_create_cis_sync(struct hci_dev *hdev, struct hci_conn *conn)
+int hci_le_create_cis_sync(struct hci_dev *hdev)
 {
 	struct {
 		struct hci_cp_le_create_cis cp;
 		struct hci_cis cis[0x1f];
 	} cmd;
-	u8 cig;
-	struct hci_conn *hcon = conn;
+	struct hci_conn *conn;
+	u8 cig = BT_ISO_QOS_CIG_UNSET;
+
+	/* The spec allows only one pending LE Create CIS command at a time. If
+	 * the command is pending now, don't do anything. We check for pending
+	 * connections after each CIS Established event.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2566:
+	 *
+	 * If the Host issues this command before all the
+	 * HCI_LE_CIS_Established events from the previous use of the
+	 * command have been generated, the Controller shall return the
+	 * error code Command Disallowed (0x0C).
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2567:
+	 *
+	 * When the Controller receives the HCI_LE_Create_CIS command, the
+	 * Controller sends the HCI_Command_Status event to the Host. An
+	 * HCI_LE_CIS_Established event will be generated for each CIS when it
+	 * is established or if it is disconnected or considered lost before
+	 * being established; until all the events are generated, the command
+	 * remains pending.
+	 */
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.cis[0].acl_handle = cpu_to_le16(conn->parent->handle);
-	cmd.cis[0].cis_handle = cpu_to_le16(conn->handle);
-	cmd.cp.num_cis++;
-	cig = conn->iso_qos.ucast.cig;
 
 	hci_dev_lock(hdev);
 
 	rcu_read_lock();
 
+	/* Wait until previous Create CIS has completed */
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (test_bit(HCI_CONN_CREATE_CIS, &conn->flags))
+			goto done;
+	}
+
+	/* Find CIG with all CIS ready */
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		struct hci_conn *link;
+
+		if (hci_conn_check_create_cis(conn))
+			continue;
+
+		cig = conn->iso_qos.ucast.cig;
+
+		list_for_each_entry_rcu(link, &hdev->conn_hash.list, list) {
+			if (hci_conn_check_create_cis(link) > 0 &&
+			    link->iso_qos.ucast.cig == cig &&
+			    link->state != BT_CONNECTED) {
+				cig = BT_ISO_QOS_CIG_UNSET;
+				break;
+			}
+		}
+
+		if (cig != BT_ISO_QOS_CIG_UNSET)
+			break;
+	}
+
+	if (cig == BT_ISO_QOS_CIG_UNSET)
+		goto done;
+
 	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
 		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
 
-		if (conn == hcon || conn->type != ISO_LINK ||
-		    conn->state == BT_CONNECTED ||
+		if (hci_conn_check_create_cis(conn) ||
 		    conn->iso_qos.ucast.cig != cig)
 			continue;
 
-		/* Check if all CIS(s) belonging to a CIG are ready */
-		if (!conn->parent || conn->parent->state != BT_CONNECTED ||
-		    conn->state != BT_CONNECT) {
-			cmd.cp.num_cis = 0;
-			break;
-		}
-
-		/* Group all CIS with state BT_CONNECT since the spec don't
-		 * allow to send them individually:
-		 *
-		 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-		 * page 2566:
-		 *
-		 * If the Host issues this command before all the
-		 * HCI_LE_CIS_Established events from the previous use of the
-		 * command have been generated, the Controller shall return the
-		 * error code Command Disallowed (0x0C).
-		 */
+		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
 		cmd.cp.num_cis++;
+
+		if (cmd.cp.num_cis >= ARRAY_SIZE(cmd.cis))
+			break;
 	}
 
+done:
 	rcu_read_unlock();
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 34d55a85d8f6..c8510aba64fc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1667,7 +1667,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 		}
 
 		/* Create CIS if pending */
-		hci_le_create_cis(hcon);
+		hci_le_create_cis_pending(hcon->hdev);
 		return;
 	}
 
-- 
2.40.1

