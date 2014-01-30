Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 10/14] Bluetooth: Re-enable background scan in case of error
Date: Thu, 30 Jan 2014 18:22:13 -0300
Message-Id: <1391116937-28217-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since we temporarily stop the background scanning in favor of
connection, we should re-enable it in case something goes wrong
with connection establishment. So this patch adds a hci_update_
background_scan() call in fail_conn_attempt() and hci_le_conn_
complete_evt() error flow.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c  | 2 ++
 net/bluetooth/hci_event.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 573b28d..6bdc349 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -527,6 +527,8 @@ static void le_conn_failed(struct hci_conn *conn, u8 status)
 	hci_proto_connect_cfm(conn, status);
 
 	hci_conn_del(conn);
+
+	hci_update_background_scan(hdev);
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f9633ac..8f4686a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3595,6 +3595,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_proto_connect_cfm(conn, ev->status);
 		conn->state = BT_CLOSED;
 		hci_conn_del(conn);
+		hci_update_background_scan(hdev);
 		goto unlock;
 	}
 
-- 
1.8.5.3

