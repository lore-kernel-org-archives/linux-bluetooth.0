Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 8/8] Bluetooth: Initialize some hci_conn fields earlier
Date: Fri, 15 Feb 2013 20:27:08 -0300
Message-Id: <1360970828-24004-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves some hci_conn fields initialization to hci_connect_le.
There is no reason we initialize them later at hci_le_create_connection.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 29192e0..93b594b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -36,11 +36,6 @@ static void hci_le_create_connection(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_conn cp;
 
-	conn->state = BT_CONNECT;
-	conn->out = true;
-	conn->link_mode |= HCI_LM_MASTER;
-	conn->sec_level = BT_SECURITY_LOW;
-
 	memset(&cp, 0, sizeof(cp));
 	cp.scan_interval = __constant_cpu_to_le16(0x0060);
 	cp.scan_window = __constant_cpu_to_le16(0x0030);
@@ -537,6 +532,9 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 		le->dst_type = bdaddr_to_le(dst_type);
 		le->state = BT_CONNECT;
+		le->out = true;
+		le->link_mode |= HCI_LM_MASTER;
+		le->sec_level = BT_SECURITY_LOW;
 
 		hci_conn_set_le_state(le, HCI_CONN_LE_SCAN);
 	}
-- 
1.8.1.2

