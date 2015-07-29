Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 5/6] Bluetooth: timeout handling in new connect procedure
Date: Wed, 29 Jul 2015 17:17:41 +0200
Message-Id: <1438183062-3265-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1438183062-3265-1-git-send-email-jpawlowski@google.com>
References: <1438183062-3265-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, when trying to connect to already paired device that just
rotated its RPA MAC address, old address would be used and connection
would fail. In order to fix that, kernel must scan and receive
advertisement with fresh RPA before connecting.

This patch makes sure that when new procedure is in use, and we're stuck
in scan phase because no advertisement was received and timeout happened,
or app decided to close socket, scan whitelist gets properly cleaned up.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_conn.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 43ecb52..5be0566 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -370,8 +370,12 @@ static void hci_conn_timeout(struct work_struct *work)
 		if (conn->out) {
 			if (conn->type == ACL_LINK)
 				hci_acl_create_connection_cancel(conn);
-			else if (conn->type == LE_LINK)
-				hci_le_create_connection_cancel(conn);
+			else if (conn->type == LE_LINK) {
+				if (test_bit(HCI_CONN_SCANNING, &conn->flags))
+					hci_connect_le_scan_remove(conn);
+				else
+					hci_le_create_connection_cancel(conn);
+			}
 		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
 			hci_reject_sco(conn);
 		}
-- 
2.1.4

