Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 08/12] Bluetooth: Re-enable background scan in case of error
Date: Fri,  6 Dec 2013 19:05:45 -0300
Message-Id: <1386367549-29136-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
References: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since we temporarily stop the background scanning in favor of
connection, we should re-enable it in case something goes wrong
with connection establishment. So this patch adds a hci_update_
background_scan() call in create_le_conn_complete() and hci_le_
conn_complete_evt() error flow.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c  | 2 ++
 net/bluetooth/hci_event.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 750a39d..2ca34fa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -548,6 +548,8 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
 
 	hci_conn_del(conn);
 
+	hci_update_background_scan(hdev);
+
 done:
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 60ca708..e4f288a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3522,6 +3522,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_proto_connect_cfm(conn, ev->status);
 		conn->state = BT_CLOSED;
 		hci_conn_del(conn);
+		hci_update_background_scan(hdev);
 		goto unlock;
 	}
 
-- 
1.8.4.2

