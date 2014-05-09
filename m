Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 5/6] Bluetooth: Avoid pooling TX power for LE links
Date: Fri,  9 May 2014 21:35:32 +0200
Message-Id: <1399664133-2892-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399664133-2892-1-git-send-email-andrzej.kaczmarek@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

TX power for LE links is immutable thus we do not need to query for it
if already have value.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/mgmt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a7f45d2..cac2edf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4756,10 +4756,16 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		hci_req_init(&req, hdev);
 
-		req_txp_cp.handle = cpu_to_le16(conn->handle);
-		req_txp_cp.type = 0x00;
-		hci_req_add(&req, HCI_OP_READ_TX_POWER_LEVEL,
-			    sizeof(req_txp_cp), &req_txp_cp);
+		/* For LE links TX power is immutable so we don't need to query
+		 * controller again once value is known.
+		 */
+		if (!bdaddr_type_is_le(cp->addr.type) ||
+		    conn->tx_power == HCI_TX_POWER_INVALID) {
+			req_txp_cp.handle = cpu_to_le16(conn->handle);
+			req_txp_cp.type = 0x00;
+			hci_req_add(&req, HCI_OP_READ_TX_POWER_LEVEL,
+				    sizeof(req_txp_cp), &req_txp_cp);
+		}
 
 		req_rssi_cp.handle = cpu_to_le16(conn->handle);
 		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
-- 
1.9.2
