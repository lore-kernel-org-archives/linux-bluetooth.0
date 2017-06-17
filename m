Return-Path: <tgagneret@witekio.com>
From: Thomas Gagneret <tgagneret@witekio.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Thomas Gagneret <tgagneret@witekio.com>
Subject: [PATCH] Bluetooth : Fix possible NULL pointer dereference
Date: Sat, 17 Jun 2017 17:45:00 +0200
Message-Id: <20170617154500.15790-1-tgagneret@witekio.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

If we disconnect a device before completing the connection, connection
will no longer be available in connection list, thus conn will be NULL.

Signed-off-by: Thomas Gagneret <tgagneret@witekio.com>
---
 net/bluetooth/hci_conn.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index dc59eae54717..901731c16136 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -723,20 +723,17 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	hci_dev_lock(hdev);
 
 	conn = hci_lookup_le_connect(hdev);
+	if (!conn)
+		goto done;
 
 	if (!status) {
 		hci_connect_le_scan_cleanup(conn);
-		goto done;
+	} else {
+		BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
+			status);
+		hci_le_conn_failed(conn, status);
 	}
 
-	BT_ERR("HCI request failed to create LE connection: status 0x%2.2x",
-	       status);
-
-	if (!conn)
-		goto done;
-
-	hci_le_conn_failed(conn, status);
-
 done:
 	hci_dev_unlock(hdev);
 }
-- 
2.13.1
