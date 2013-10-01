Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Initialize hci_conn fields in hci_connect_le
Date: Tue,  1 Oct 2013 20:03:50 -0300
Message-Id: <1380668636-30654-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves some hci_conn fields initialization from hci_le_
create_connection() to hci_connect_le(). It makes more sense to
initialize these fields within the function that creates the hci_
conn object.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d2380e0..f473605 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -54,11 +54,6 @@ static void hci_le_create_connection(struct hci_conn *conn)
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
@@ -565,6 +560,11 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 			return ERR_PTR(-ENOMEM);
 
 		le->dst_type = bdaddr_to_le(dst_type);
+		le->state = BT_CONNECT;
+		le->out = true;
+		le->link_mode |= HCI_LM_MASTER;
+		le->sec_level = BT_SECURITY_LOW;
+
 		hci_le_create_connection(le);
 	}
 
-- 
1.8.4

