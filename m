Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use random address if public address is not available
Date: Sun,  6 Oct 2013 01:08:58 -0700
Message-Id: <1381046938-34970-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For single mode LE-only controllers, it is possible that they come
without a public address. If a public address is not available,
then use the random address for connection establishment and
scanning.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c | 4 ++++
 net/bluetooth/mgmt.c     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd3a3f5..16697ae 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -59,6 +59,10 @@ static void hci_le_create_connection(struct hci_conn *conn)
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
+	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
+	else
+		cp.own_address_type = ADDR_LE_DEV_RANDOM;
 	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
 	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f018fed..d488049 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2911,6 +2911,10 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		param_cp.type = LE_SCAN_ACTIVE;
 		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
 		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
+		if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+			param_cp.own_address_type = ADDR_LE_DEV_PUBLIC;
+		else
+			param_cp.own_address_type = ADDR_LE_DEV_RANDOM;
 		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 			    &param_cp);
 
-- 
1.8.3.1

