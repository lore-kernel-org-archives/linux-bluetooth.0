Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Store source address of HCI connections
Date: Sun, 13 Oct 2013 05:23:59 -0700
Message-Id: <1381667042-46368-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The source addressed was based on the public address of the HCI device,
but with LE connections this not always the case. For example single
mode LE-only controllers would use a static random address. And this
address is configured by userspace.

To not complicate the lookup of what kind of address is in use, store
the correct source address for each HCI connection.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_conn.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 714da9e..0326b16 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -300,6 +300,7 @@ struct hci_conn {
 
 	bdaddr_t	dst;
 	__u8		dst_type;
+	bdaddr_t	src;
 	__u8		src_type;
 	__u16		handle;
 	__u16		state;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d9f7f93..ff04b05 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -381,6 +381,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 		return NULL;
 
 	bacpy(&conn->dst, dst);
+	bacpy(&conn->src, &hdev->bdaddr);
 	conn->hdev  = hdev;
 	conn->type  = type;
 	conn->mode  = HCI_CM_ACTIVE;
@@ -624,10 +625,12 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	else
 		conn->dst_type = ADDR_LE_DEV_RANDOM;
 
-	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+	if (bacmp(&conn->src, BDADDR_ANY)) {
 		conn->src_type = ADDR_LE_DEV_PUBLIC;
-	else
+	} else {
+		bacpy(&conn->src, &hdev->static_addr);
 		conn->src_type = ADDR_LE_DEV_RANDOM;
+	}
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
-- 
1.8.3.1

