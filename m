Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 7/8] Bluetooth: Avoid pooling TX power for LE links
Date: Thu, 8 May 2014 15:32:14 +0200
Message-ID: <1399555935-702-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

TX power for LE links is immutable thus we do not need to query for it
if already have value.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/mgmt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e84adf9..3f6c81a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4726,10 +4726,16 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_req_add(&req, HCI_OP_READ_RSSI, sizeof(req_rssi_cp),
 			    &req_rssi_cp);
 
-		req_txp_cp.handle = cpu_to_le16(conn->handle);
-		req_txp_cp.type = TX_POWER_TYPE_CURRENT;
-		hci_req_add(&req, HCI_OP_READ_TX_POWER_LEVEL,
-			    sizeof(req_txp_cp), &req_txp_cp);
+		/* For LE links TX power is immutable so we don't need to query
+		 * controller again once value is known.
+		 */
+		if (!bdaddr_type_is_le(cp->addr.type) ||
+		    conn->tx_power == HCI_TX_POWER_INVALID) {
+			req_txp_cp.handle = cpu_to_le16(conn->handle);
+			req_txp_cp.type = TX_POWER_TYPE_CURRENT;
+			hci_req_add(&req, HCI_OP_READ_TX_POWER_LEVEL,
+				    sizeof(req_txp_cp), &req_txp_cp);
+		}
 
 		err = hci_req_run(&req, conn_info_query_complete);
 		if (err < 0) {
-- 
1.9.2

