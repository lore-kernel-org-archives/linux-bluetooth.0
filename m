Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Don't treat connection timeout as a failure
Date: Thu,  3 Dec 2015 12:45:20 +0200
Message-Id: <1449139520-950-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1449139520-950-1-git-send-email-johan.hedberg@gmail.com>
References: <1449139520-950-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're doing background scanning and connection attempts it's
possible we timeout trying to connect and go back to scanning again.
The timeout triggers a HCI_LE_Create_Connection_Cancel which will
trigger a Connection Complete with "Unknown Connection Identifier"
error status. Since we go back to scanning this isn't really a failure
and shouldn't be presented as such to user space through mgmt.

The exception to this is if the connection attempt was due to an
explicit request on an L2CAP socket (indicated by
params->explicit_connect being true). Since the socket will get an
error it's consistent to also notify the failure on mgmt in this case.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 48a7eac6ef71..32575b49f4a0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -668,8 +668,16 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 
 	conn->state = BT_CLOSED;
 
-	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
-			    status);
+	/* If the status indicates successful cancellation of
+	 * the attempt (i.e. Unkown Connection Id) there's no point of
+	 * notifying failure since we'll go back to keep trying to
+	 * connect. The only exception is explicit connect requests
+	 * where a timeout + cancel does indicate an actual failure.
+	 */
+	if (status != HCI_ERROR_UNKNOWN_CONN_ID ||
+	    (params && params->explicit_connect))
+		mgmt_connect_failed(hdev, &conn->dst, conn->type,
+				    conn->dst_type, status);
 
 	hci_connect_cfm(conn, status);
 
-- 
2.5.0

