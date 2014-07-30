Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Rename HCI_PAIRABLE to HCI_BONDABLE
Date: Wed, 30 Jul 2014 09:22:22 +0300
Message-Id: <1406701344-23842-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI_PAIRABLE flag isn't actually controlling whether we're pairable
but whether we're bondable. Therefore, rename it accordingly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 2 +-
 net/bluetooth/hci_core.c    | 4 ++--
 net/bluetooth/hci_event.c   | 4 ++--
 net/bluetooth/mgmt.c        | 8 ++++----
 net/bluetooth/smp.c         | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e3fd926df13f..3f8547f1c6f8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -167,7 +167,7 @@ enum {
 	HCI_AUTO_OFF,
 	HCI_RFKILLED,
 	HCI_MGMT,
-	HCI_PAIRABLE,
+	HCI_BONDABLE,
 	HCI_SERVICE_CACHE,
 	HCI_KEEP_DEBUG_KEYS,
 	HCI_USE_DEBUG_KEYS,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 61bd1a8c5849..32b96f1aaf42 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2521,14 +2521,14 @@ int hci_dev_open(__u16 dev)
 	flush_workqueue(hdev->req_workqueue);
 
 	/* For controllers not using the management interface and that
-	 * are brought up using legacy ioctl, set the HCI_PAIRABLE bit
+	 * are brought up using legacy ioctl, set the HCI_BONDABLE bit
 	 * so that pairing works for them. Once the management interface
 	 * is in use this bit will be cleared again and userspace has
 	 * to explicitly enable it.
 	 */
 	if (!test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
 	    !test_bit(HCI_MGMT, &hdev->dev_flags))
-		set_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		set_bit(HCI_BONDABLE, &hdev->dev_flags);
 
 	err = hci_dev_do_open(hdev);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 623501ddd1b8..c43cee4fcffd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3119,7 +3119,7 @@ static void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_drop(conn);
 	}
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags) &&
+	if (!test_bit(HCI_BONDABLE, &hdev->dev_flags) &&
 	    !test_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags)) {
 		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 			     sizeof(ev->bdaddr), &ev->bdaddr);
@@ -3652,7 +3652,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Allow pairing if we're pairable, the initiators of the
 	 * pairing or if the remote is not requesting bonding.
 	 */
-	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags) ||
+	if (test_bit(HCI_BONDABLE, &hdev->dev_flags) ||
 	    test_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags) ||
 	    (conn->remote_auth & ~0x01) == HCI_AT_NO_BONDING) {
 		struct hci_cp_io_capability_reply cp;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0b15b7618beb..edb1a62054c9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -603,7 +603,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_DISCOVERABLE;
 
-	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags))
+	if (test_bit(HCI_BONDABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_PAIRABLE;
 
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
@@ -1152,7 +1152,7 @@ static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 	 * for mgmt we require user-space to explicitly enable
 	 * it
 	 */
-	clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
+	clear_bit(HCI_BONDABLE, &hdev->dev_flags);
 }
 
 static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
@@ -1946,9 +1946,9 @@ static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (cp->val)
-		changed = !test_and_set_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		changed = !test_and_set_bit(HCI_BONDABLE, &hdev->dev_flags);
 	else
-		changed = test_and_clear_bit(HCI_PAIRABLE, &hdev->dev_flags);
+		changed = test_and_clear_bit(HCI_BONDABLE, &hdev->dev_flags);
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_PAIRABLE, hdev);
 	if (err < 0)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index eaa8e7482bb4..fd3294300803 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -307,7 +307,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	struct hci_dev *hdev = hcon->hdev;
 	u8 local_dist = 0, remote_dist = 0;
 
-	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags)) {
+	if (test_bit(HCI_BONDABLE, &conn->hcon->hdev->dev_flags)) {
 		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		remote_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		authreq |= SMP_AUTH_BONDING;
@@ -704,7 +704,7 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!smp)
 		return SMP_UNSPECIFIED;
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags) &&
+	if (!test_bit(HCI_BONDABLE, &hdev->dev_flags) &&
 	    (req->auth_req & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
@@ -930,7 +930,7 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!smp)
 		return SMP_UNSPECIFIED;
 
-	if (!test_bit(HCI_PAIRABLE, &hcon->hdev->dev_flags) &&
+	if (!test_bit(HCI_BONDABLE, &hcon->hdev->dev_flags) &&
 	    (rp->auth_req & SMP_AUTH_BONDING))
 		return SMP_PAIRING_NOTSUPP;
 
-- 
1.9.3

