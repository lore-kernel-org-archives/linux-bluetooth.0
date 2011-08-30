Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Tue, 30 Aug 2011 09:22:23 -0400
Subject: [PATCH 1/2] Bluetooth: Fix unsafe tx buffer count updates
Message-ID: <1314710543.2232.10.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The tx tasklet and rx tasklet (if not currently running on this cpu)
must be disabled to prevent concurrent access while updating the
tx buffer counts.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hci_conn.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3e0a4b5..38993f6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -359,6 +359,10 @@ int hci_conn_del(struct hci_conn *conn)
 
 	del_timer(&conn->auto_accept_timer);
 
+	tasklet_disable(&hdev->tx_task);
+	if (!in_serving_softirq())
+		tasklet_disable(&hdev->rx_task);
+
 	if (conn->type == ACL_LINK) {
 		struct hci_conn *sco = conn->link;
 		if (sco)
@@ -379,12 +383,12 @@ int hci_conn_del(struct hci_conn *conn)
 		}
 	}
 
-	tasklet_disable(&hdev->tx_task);
-
 	hci_conn_hash_del(hdev, conn);
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
 
+	if (!in_serving_softirq())
+		tasklet_enable(&hdev->rx_task);
 	tasklet_enable(&hdev->tx_task);
 
 	skb_queue_purge(&conn->data_q);
-- 
1.7.4.1

