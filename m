Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 05/12] Bluetooth: Stop scanning on LE connection
Date: Fri,  6 Dec 2013 19:05:42 -0300
Message-Id: <1386367549-29136-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
References: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some LE controllers don't support scanning and creating a connection
at the same time. So we should always stop scanning in order to
establish the connection.

Since we may prematurely stop the discovery procedure in favor of
the connection establishment, we should also cancel hdev->le_scan_
disable delayed work and set the discovery state to DISCOVERY_STOPPED.

This change does a small improvement since it is not mandatory the
user stops scanning before connecting anymore. Moreover, this change
is required by upcoming LE auto connection mechanism in order to work
properly with controllers that don't support background scanning and
connection establishment at the same time.

In future, we might want to do a small optimization by checking if
controller is able to scan and connect at the same time. For now,
we want the simplest approach so we always stop scanning (even if
the controller is able to carry out both operations).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b5c3ebff..750a39d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -518,8 +518,17 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
 {
 	struct hci_conn *conn;
 
-	if (status == 0)
+	if (status == 0) {
+		/* If the discovery procedure was running, we prematurely
+		 * stopped it. So we have to change the discovery state.
+		 */
+		if (hdev->discovery.state == DISCOVERY_FINDING) {
+			cancel_delayed_work(&hdev->le_scan_disable);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		}
+
 		return;
+	}
 
 	BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
 	       status);
@@ -552,6 +561,18 @@ static int hci_create_le_conn(struct hci_conn *conn)
 
 	hci_req_init(&req, hdev);
 
+	/* If controller is scanning, we stop it since some controllers are
+	 * not able to scan and connect at the same time.
+	 */
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
+		struct hci_cp_le_set_scan_enable enable_cp;
+
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		enable_cp.enable = LE_SCAN_DISABLE;
+		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+			    &enable_cp);
+	}
+
 	memset(&cp, 0, sizeof(cp));
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
-- 
1.8.4.2

