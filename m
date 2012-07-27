Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Remove unneeded code
Date: Fri, 27 Jul 2012 15:10:12 -0300
Message-Id: <1343412616-25641-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
References: <1343412616-25641-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes some unneeded code from hci_cs_le_create_conn.

If the hci_conn is not found, it means this LE connection attempt
was triggered by a thrid-party tool (e.g. hcitool). We should not
create this new hci_conn in LE Create Connection command status
event since it is already properly handled in LE Connection
Complete event.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b13ccc..27064be 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1638,16 +1638,6 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 			hci_proto_connect_cfm(conn, status);
 			hci_conn_del(conn);
 		}
-	} else {
-		if (!conn) {
-			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr);
-			if (conn) {
-				conn->dst_type = cp->peer_addr_type;
-				conn->out = true;
-			} else {
-				BT_ERR("No memory for new connection");
-			}
-		}
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.7.11.2

