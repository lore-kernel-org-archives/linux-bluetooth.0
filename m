Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/2] Bluetooth: Remove unneeded locking
Date: Fri, 27 Jan 2012 19:42:03 -0300
Message-Id: <1327704123-31313-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1327704123-31313-1-git-send-email-andre.guedes@openbossa.org>
References: <1327704123-31313-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We don't need locking hdev in hci_conn_timeout() since it doesn't
access any hdev's shared resources, it basically queues HCI commands.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_conn.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index eae7a53..8ec6fb6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -280,7 +280,6 @@ static void hci_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
 							disc_work.work);
-	struct hci_dev *hdev = conn->hdev;
 	__u8 reason;
 
 	BT_DBG("conn %p state %d", conn, conn->state);
@@ -288,8 +287,6 @@ static void hci_conn_timeout(struct work_struct *work)
 	if (atomic_read(&conn->refcnt))
 		return;
 
-	hci_dev_lock(hdev);
-
 	switch (conn->state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
@@ -309,8 +306,6 @@ static void hci_conn_timeout(struct work_struct *work)
 		conn->state = BT_CLOSED;
 		break;
 	}
-
-	hci_dev_unlock(hdev);
 }
 
 /* Enter sniff mode */
-- 
1.7.8.4

