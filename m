Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Use unresolvable private address for active scanning
Date: Sun, 23 Feb 2014 20:25:54 -0800
Message-Id: <1393215955-3907-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When running active scanning during LE discovery, do not reveal the own
identity to the peer devices. In case LE privacy has been enabled, then
a resolvable private address is used. If the LE privacy option is off,
then use an unresolvable private address.

The public address or static random address is never used in active
scanning anymore. This ensures that scan request are send using a
random address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 18 +++++++++++++++++-
 net/bluetooth/mgmt.c             |  8 ++++++--
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 43b6d1131c4d..b0350c032b26 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1256,7 +1256,8 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 
-int hci_update_random_address(struct hci_request *req, u8 *own_addr_type);
+int hci_update_random_address(struct hci_request *req, bool allow_privacy,
+			      u8 *own_addr_type);
 
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a1efa1c62de8..744b3d49da1a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -563,7 +563,7 @@ static int hci_create_le_conn(struct hci_conn *conn)
 
 	memset(&cp, 0, sizeof(cp));
 
-	err = hci_update_random_address(&req, &own_addr_type);
+	err = hci_update_random_address(&req, false, &own_addr_type);
 	if (err < 0)
 		return err;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 80462a126ebd..e3caad5c1e6e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3332,7 +3332,8 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
-int hci_update_random_address(struct hci_request *req, u8 *own_addr_type)
+int hci_update_random_address(struct hci_request *req, bool allow_privacy,
+			      u8 *own_addr_type)
 {
 	struct hci_dev *hdev = req->hdev;
 	int err;
@@ -3365,6 +3366,21 @@ int hci_update_random_address(struct hci_request *req, u8 *own_addr_type)
 		return 0;
 	}
 
+	/* In case of allowed privacy without resolvable private address,
+	 * use an unresolvable private address. This is useful for active
+	 * scanning and non-connectable advertising.
+	 */
+	if (allow_privacy) {
+		bdaddr_t urpa;
+
+		get_random_bytes(&urpa, 6);
+		urpa.b[5] &= 0x3f;	/* Clear two most significant bits */
+
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &urpa);
+		return 0;
+	}
+
 	/* If forcing static address is in use or there is no public
 	 * address use the static address as random address (but skip
 	 * the HCI command if the current random address is already the
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 37305facf4d6..5d309d4ab527 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -844,7 +844,7 @@ static void enable_advertising(struct hci_request *req)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (hci_update_random_address(req, &own_addr_type) < 0)
+	if (hci_update_random_address(req, false, &own_addr_type) < 0)
 		return;
 
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
@@ -3389,7 +3389,11 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		memset(&param_cp, 0, sizeof(param_cp));
 
-		err = hci_update_random_address(&req, &own_addr_type);
+		/* All active scans will be done with either a resolvable
+		 * private address (when privacy feature has been enabled)
+		 * or unresolvable private address.
+		 */
+		err = hci_update_random_address(&req, true, &own_addr_type);
 		if (err < 0) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_FAILED);
-- 
1.8.5.3

