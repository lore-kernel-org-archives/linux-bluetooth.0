Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Drop LE connections for blocked devices
Date: Wed,  2 Jul 2014 09:36:22 +0300
Message-Id: <1404282982-26114-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404282982-26114-1-git-send-email-johan.hedberg@gmail.com>
References: <1404282982-26114-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Unlike BR/EDR we cannot reject LE connections of blocked devices but
have to do it as soon as we get a LE Connection Complete event. The
patch adds a blacklist check to the hci_le_conn_complete_evt function
and drops all connections for blocked devices.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b9d16e0ed661..ed49a065dd67 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4038,6 +4038,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
 	struct smp_irk *irk;
+	u8 addr_type;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -4119,6 +4120,17 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		conn->dst_type = irk->addr_type;
 	}
 
+	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
+		addr_type = BDADDR_LE_PUBLIC;
+	else
+		addr_type = BDADDR_LE_RANDOM;
+
+	/* Drop the connection if he device is blocked */
+	if (hci_blacklist_lookup(hdev, &conn->dst, addr_type)) {
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	if (ev->status) {
 		hci_le_conn_failed(conn, ev->status);
 		goto unlock;
-- 
1.9.3

