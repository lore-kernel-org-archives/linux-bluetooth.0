Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <vishal.agarwal@stericsson.com>
Subject: [PATCHv3 2/2] Bluetooth: Temporary keys should be retained during connection
Date: Mon, 16 Apr 2012 14:44:44 +0530
Message-ID: <1334567684-14210-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a key is non persistent then it should not be used in future
connections but it should be kept for current connection. And it
should be removed when connecion is removed.

Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    6 ++----
 net/bluetooth/hci_event.c        |    2 ++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8a9abe2..afdea95 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -318,6 +318,7 @@ struct hci_conn {
 
 	__u8		remote_cap;
 	__u8		remote_auth;
+	bool		flush_key;
 
 	unsigned int	sent;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 703c28d..b080ad4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1333,10 +1333,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 
 	mgmt_new_link_key(hdev, key, persistent);
 
-	if (!persistent) {
-		list_del(&key->list);
-		kfree(key);
-	}
+	if (conn)
+		conn->flush_key = !persistent;
 
 	return 0;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bb6d802..5c23548 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1930,6 +1930,8 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	}
 
 	if (ev->status == 0) {
+		if (conn->type == ACL_LINK && conn->flush_key)
+			hci_remove_link_key(hdev, &conn->dst);
 		hci_proto_disconn_cfm(conn, ev->reason);
 		hci_conn_del(conn);
 	}
-- 
1.7.0.4

