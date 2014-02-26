Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 14/17] Bluetooth: Support resolvable private addresses
Date: Wed, 26 Feb 2014 20:21:53 -0300
Message-Id: <1393456916-22701-14-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
References: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only identity addresses are inserted into hdev->pend_le_conns. So,
in order to support resolvable private addresses in auto connection
mechanism, we should resolve the address before checking for pending
connections.

Thus, this patch adds an extra check in check_pending_le_conn() and
updates 'addr' and 'addr_type' variables before hci_pend_le_conn_
lookup().

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 46da8b6..cda92db 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3706,6 +3706,16 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				  u8 addr_type)
 {
 	struct hci_conn *conn;
+	struct smp_irk *irk;
+
+	/* If this is a resolvable address, we should resolve it and then
+	 * update address and address type variables.
+	 */
+	irk = hci_get_irk(hdev, addr, addr_type);
+	if (irk) {
+		addr = &irk->bdaddr;
+		addr_type = irk->addr_type;
+	}
 
 	if (!hci_pend_le_conn_lookup(hdev, addr, addr_type))
 		return;
-- 
1.8.5.4

