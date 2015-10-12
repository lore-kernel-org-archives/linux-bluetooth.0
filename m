Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1] Bluetooth: fix bad hci_conn cleanup
Date: Mon, 12 Oct 2015 16:34:05 -0700
Message-Id: <1444692845-6527-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When connecting to remote device that uses RPA, first we start scan,
to find current address of this device. Inside hci_connect_le_scan
hci_conn_add is called. If we find device with matching RPA, and start
connecting, hci_conn that was returned from this call is reused, and
destroyed at end of connection by calling hci_conn_del. If we don't
find device with matching RPA, and scan timeouts, or is canceled, we
also have to call hci_conn_del, which is not happening right now. That
is leaving module refcount in bad state.

This patch adds hci_conn_del_from_disc_work method, that is same as
hci_conn_del, except that it doesn't cancel disc_work (because it's
called from it, and that would cause stalled worker). It also adds call
to this new method from hci_connect_le_scan_remove.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_conn.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2ebcaaa..d8a995a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,6 +35,8 @@
 #include "smp.h"
 #include "a2mp.h"
 
+static int hci_conn_del_from_disc_work(struct hci_conn *conn);
+
 struct sco_param {
 	u16 pkt_type;
 	u16 max_latency;
@@ -104,7 +106,10 @@ static void hci_connect_le_scan_remove(struct hci_conn *conn)
 {
 	hci_connect_le_scan_cleanup(conn);
 
-	hci_conn_hash_del(conn->hdev, conn);
+	/* hci_connect_le_scan_remove is only called from disc_work. Make sure
+	 * we don't try to cancel synchronously this work when deleting conn.
+	 */
+	hci_conn_del_from_disc_work(conn);
 }
 
 static void hci_acl_create_connection(struct hci_conn *conn)
@@ -550,13 +555,11 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return conn;
 }
 
-int hci_conn_del(struct hci_conn *conn)
+static int hci_conn_del_from_disc_work(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
-
-	cancel_delayed_work_sync(&conn->disc_work);
 	cancel_delayed_work_sync(&conn->auto_accept_work);
 	cancel_delayed_work_sync(&conn->idle_work);
 
@@ -607,6 +610,16 @@ int hci_conn_del(struct hci_conn *conn)
 	return 0;
 }
 
+int hci_conn_del(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
+
+	cancel_delayed_work_sync(&conn->disc_work);
+	return hci_conn_del_from_disc_work(conn);
+}
+
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 {
 	int use_src = bacmp(src, BDADDR_ANY);
-- 
2.5.0

