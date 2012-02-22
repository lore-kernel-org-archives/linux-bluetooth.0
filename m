Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix two minor style issues in HCI code
Date: Wed, 22 Feb 2012 12:06:43 +0100
Message-Id: <1329908803-32187-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

WARNING: min() should probably be min_t(__u16, scb->expect, count)
+		len = min(scb->expect, (__u16)count);

WARNING: Statements terminations use 1 semicolon
+	INIT_LIST_HEAD(&conn->chan_list);;

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c |    2 +-
 net/bluetooth/hci_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3c68e60..947172b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -402,7 +402,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	skb_queue_head_init(&conn->data_q);
 
-	INIT_LIST_HEAD(&conn->chan_list);;
+	INIT_LIST_HEAD(&conn->chan_list);
 
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d19949..e1dadee 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1957,7 +1957,7 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 
 	while (count) {
 		scb = (void *) skb->cb;
-		len = min(scb->expect, (__u16)count);
+		len = min_t(__u16, scb->expect, count);
 
 		memcpy(skb_put(skb, len), data, len);
 
-- 
1.7.7.6

