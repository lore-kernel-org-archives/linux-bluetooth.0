Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 3/8] Bluetooth: LE connection state machine
Date: Fri, 15 Feb 2013 20:27:03 -0300
Message-Id: <1360970828-24004-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a state machine for carrying out the general
connection establishment procedure described in Core spec.

The state machine should be used as follows: when the kernel
receives a new LE connection attempt, it should go to HCI_CONN_LE_
SCAN state, starting the passive LE scanning. Once the target remote
device is in-range, it should go to HCI_CONN_LE_FOUND, stopping the
ongoing LE scanning. After the LE scanning is disabled, it should go
to HCI_CONN_LE_INITIATE state where the LE connection is created.

This state machine will be used by the LE connection routine in
order to establish LE connections.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 13 +++++++++++++
 net/bluetooth/hci_conn.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 48c28ca..c704737 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -300,6 +300,16 @@ struct hci_dev {
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
 
+/*
+ * States from LE connection establishment state machine.
+ * State 0 is reserved and indicates the state machine is not running.
+ */
+enum {
+	HCI_CONN_LE_SCAN = 1,
+	HCI_CONN_LE_FOUND,
+	HCI_CONN_LE_INITIATE,
+};
+
 struct hci_conn {
 	struct list_head list;
 
@@ -356,6 +366,8 @@ struct hci_conn {
 
 	struct hci_conn	*link;
 
+	atomic_t	le_state;
+
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
@@ -599,6 +611,7 @@ int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
 int hci_conn_change_link_key(struct hci_conn *conn);
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
+void hci_conn_set_le_state(struct hci_conn *conn, int state);
 
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..d54c2a0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -391,6 +391,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 		    (unsigned long) conn);
 
 	atomic_set(&conn->refcnt, 0);
+	atomic_set(&conn->le_state, 0);
 
 	hci_dev_hold(hdev);
 
@@ -1027,3 +1028,28 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
 
 	return hchan;
 }
+
+void hci_conn_set_le_state(struct hci_conn *conn, int state)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("conn %p state %d -> %d", conn, atomic_read(&conn->le_state),
+	       state);
+
+	if (state == atomic_read(&conn->le_state))
+		return;
+
+	switch (state) {
+	case HCI_CONN_LE_SCAN:
+		hci_le_scan(hdev, LE_SCAN_PASSIVE, 0x60, 0x30, 0);
+		break;
+	case HCI_CONN_LE_FOUND:
+		hci_cancel_le_scan(hdev);
+		break;
+	case HCI_CONN_LE_INITIATE:
+		hci_le_create_connection(conn);
+		break;
+	}
+
+	atomic_set(&conn->le_state, state);
+}
-- 
1.8.1.2

