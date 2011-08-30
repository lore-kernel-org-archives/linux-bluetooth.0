Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
CC: David Herrmann <dh.herrmann@googlemail.com>
Date: Tue, 30 Aug 2011 11:53:35 -0400
Subject: [PATCH] Bluetooth: hidp: safely acquire hci connection
Message-ID: <1314719615.2232.24.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Claim device lock to safely enumerate hci connection list and bump
hci connection proxy device ref count simultaneously.

This patch incorporates David Herrmann's fix to prevent adding an
HID device when the hci connection no longer exists.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hidp/core.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index e02c6a2..f6db935 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -97,8 +97,6 @@ static void __hidp_link_session(struct hidp_session *session)
 {
 	__module_get(THIS_MODULE);
 	list_add(&session->list, &hidp_session_list);
-
-	hci_conn_hold_device(session->conn);
 }
 
 static void __hidp_unlink_session(struct hidp_session *session)
@@ -763,24 +761,26 @@ static int hidp_session(void *arg)
 	return 0;
 }
 
-static struct device *hidp_get_device(struct hidp_session *session)
+static struct hci_conn *hidp_find_connection(struct hidp_session *session)
 {
 	bdaddr_t *src = &bt_sk(session->ctrl_sock->sk)->src;
 	bdaddr_t *dst = &bt_sk(session->ctrl_sock->sk)->dst;
-	struct device *device = NULL;
+	struct hci_conn *conn;
 	struct hci_dev *hdev;
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
 		return NULL;
 
-	session->conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-	if (session->conn)
-		device = &session->conn->dev;
+	hci_dev_lock_bh(hdev);
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
+	if (conn)
+		hci_conn_hold_device(conn);
+	hci_dev_unlock_bh(hdev);
 
 	hci_dev_put(hdev);
 
-	return device;
+	return conn;
 }
 
 static int hidp_setup_input(struct hidp_session *session,
@@ -830,7 +830,7 @@ static int hidp_setup_input(struct hidp_session *session,
 		input->relbit[0] |= BIT_MASK(REL_WHEEL);
 	}
 
-	input->dev.parent = hidp_get_device(session);
+	input->dev.parent = &session->conn->dev;
 
 	input->event = hidp_input_event;
 
@@ -934,7 +934,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	strncpy(hid->phys, batostr(&bt_sk(session->ctrl_sock->sk)->src), 64);
 	strncpy(hid->uniq, batostr(&bt_sk(session->ctrl_sock->sk)->dst), 64);
 
-	hid->dev.parent = hidp_get_device(session);
+	hid->dev.parent = &session->conn->dev;
 	hid->ll_driver = &hidp_hid_driver;
 
 	hid->hid_get_raw_report = hidp_get_raw_report;
@@ -975,6 +975,10 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 		goto failed;
 	}
 
+	session->conn = hidp_find_connection(session);
+	if (!session->conn)
+		goto failed;
+
 	bacpy(&session->bdaddr, &bt_sk(ctrl_sock->sk)->dst);
 
 	session->ctrl_mtu = min_t(uint, l2cap_pi(ctrl_sock->sk)->chan->omtu,
@@ -1000,6 +1004,8 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 	session->flags   = req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
 	session->idle_to = req->idle_to;
 
+	__hidp_link_session(session);
+
 	if (req->rd_size > 0) {
 		err = hidp_setup_hid(session, req);
 		if (err && err != -ENODEV)
@@ -1012,8 +1018,6 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 			goto purge;
 	}
 
-	__hidp_link_session(session);
-
 	hidp_set_timer(session);
 
 	if (session->hid) {
@@ -1062,8 +1066,6 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 unlink:
 	hidp_del_timer(session);
 
-	__hidp_unlink_session(session);
-
 	if (session->input) {
 		input_unregister_device(session->input);
 		session->input = NULL;
@@ -1076,6 +1078,8 @@ unlink:
 	session->rd_data = NULL;
 
 purge:
+	__hidp_unlink_session(session);
+
 	skb_queue_purge(&session->ctrl_transmit);
 	skb_queue_purge(&session->intr_transmit);
 
-- 
1.7.4.1

