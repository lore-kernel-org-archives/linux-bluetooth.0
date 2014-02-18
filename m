Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix wrong identity address during connection failures
Date: Tue, 18 Feb 2014 15:13:43 -0800
Message-Id: <1392765223-21880-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the connection attempt fails, the address information are not
provided in the HCI_LE_Connection_Complete event. So use the original
information from the connection to reconstruct the identity address.

This is important when a connection attempt has been made using the
identity address, but the cached resolvable random address has changed
in the meantime. The failure event needs to use the identity address
and not the resolvable random address.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c  | 13 +++++++++++++
 net/bluetooth/hci_event.c | 12 ++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 40ec37355d6f..a027951d0da5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -623,6 +623,19 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	else
 		dst_type = ADDR_LE_DEV_RANDOM;
 
+	/* When given an identity address with existing identity
+	 * resolving key, the connection needs to be established
+	 * to a resolvable random address.
+	 *
+	 * This uses the cached random resolvable address from
+	 * a previous scan. When no cached address is available,
+	 * try connecting to the identity address instead.
+	 *
+	 * Storing the resolvable random address is required here
+	 * to handle connection failures. The address will later
+	 * be resolved back into the original identity address
+	 * from the connect request.
+	 */
 	irk = hci_find_irk_by_addr(hdev, dst, dst_type);
 	if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
 		dst = &irk->rpa;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 22bfc5c17e7f..7228fa100b1f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3601,8 +3601,16 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
-	/* Track the connection based on the Identity Address from now on */
-	irk = hci_get_irk(hdev, &ev->bdaddr, ev->bdaddr_type);
+	/* Lookup the identity address from the stored connection
+	 * address and address type.
+	 *
+	 * When establishing connections to an identity address, the
+	 * connection procedure will store the resolvable random
+	 * address first. Now if it can be converted back into the
+	 * identity address, start using the identity address from
+	 * now on.
+	 */
+	irk = hci_get_irk(hdev, &conn->dst, conn->dst_type);
 	if (irk) {
 		bacpy(&conn->dst, &irk->bdaddr);
 		conn->dst_type = irk->addr_type;
-- 
1.8.5.3

