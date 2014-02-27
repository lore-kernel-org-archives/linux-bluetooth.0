Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Store source and destination RPAs of a connection
Date: Wed, 26 Feb 2014 21:54:37 -0800
Message-Id: <1393480478-49167-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using resolvable private addresses (RPA) either for local or peer
devices, the RPA in use it needed for the SMP procedures. Either during
initial pairing or re-pairing for security level elevation.

It is important to store the actual used RPAs and not the current one
of the controller or peer. These might change over time, but for the
security procedures that RPA that the connection has been established
with are suppose to be used.

In case the local or peer device is not using RPAs, then the value
BDADDR_ANY will be stored to clearly identity that it is either a
public address, static random or unresolvable random address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         |  7 +++++++
 net/bluetooth/hci_event.c        | 13 +++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 79a75edc62d0..9326437f2295 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -328,8 +328,10 @@ struct hci_conn {
 
 	bdaddr_t	dst;
 	__u8		dst_type;
+	bdaddr_t	dst_rpa;
 	bdaddr_t	src;
 	__u8		src_type;
+	bdaddr_t	src_rpa;
 	__u16		handle;
 	__u16		state;
 	__u8		mode;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7d6f05e3cae8..bf61b9f1af23 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -576,6 +576,13 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	 */
 	conn->src_type = own_addr_type;
 
+	/* Store the current local resolvable random address
+	 * that will be used for connection establishment. It
+	 * will be needed for pairing procedures.
+	 */
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
+		bacpy(&conn->src_rpa, &hdev->rpa);
+
 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cda92db2a9fc..03ebb10c453c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3634,6 +3634,14 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			conn->src_type = ADDR_LE_DEV_RANDOM;
 		}
 
+		/* Store the current local resolvable random address
+		 * that has been used either in advertising or when
+		 * triggering this connection establishment. It will
+		 * be needed for pairing procedures.
+		 */
+		if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
+			bacpy(&conn->src_rpa, &hdev->rpa);
+
 		if (ev->role == LE_CONN_ROLE_MASTER) {
 			conn->out = true;
 			conn->link_mode |= HCI_LM_MASTER;
@@ -3668,9 +3676,14 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * address first. Now if it can be converted back into the
 	 * identity address, start using the identity address from
 	 * now on.
+	 *
+	 * The resolvable random address of the peer is first stored
+	 * in dst_rpa since it might be needed for security level
+	 * upgrade procedures later.
 	 */
 	irk = hci_get_irk(hdev, &conn->dst, conn->dst_type);
 	if (irk) {
+		bacpy(&conn->dst_rpa, &conn->dst);
 		bacpy(&conn->dst, &irk->bdaddr);
 		conn->dst_type = irk->addr_type;
 	}
-- 
1.8.5.3

