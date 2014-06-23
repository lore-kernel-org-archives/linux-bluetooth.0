Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set default min/max connection interval for LE slaves
Date: Mon, 23 Jun 2014 12:14:51 +0200
Message-Id: <1403518492-14548-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For all incoming LE connections, the minimum and maximum connection
interval is a value that should be copied from the controller default
values. This allows to properly check if the resulting connection
interval of a newly established connection is in the range we are
expecting.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e239435312dc..e1e1ecb4db10 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4026,6 +4026,14 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		conn->init_addr_type = ev->bdaddr_type;
 		bacpy(&conn->init_addr, &ev->bdaddr);
+
+		/* For incoming connections, set the default minimum
+		 * and maximum connection interval. They will be used
+		 * to check if the parameters are in range and if not
+		 * trigger the connection update procedure.
+		 */
+		conn->le_conn_min_interval = hdev->le_conn_min_interval;
+		conn->le_conn_max_interval = hdev->le_conn_max_interval;
 	}
 
 	/* Lookup the identity address from the stored connection
-- 
1.9.3

