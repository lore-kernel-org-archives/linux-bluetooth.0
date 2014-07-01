Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Drop LE connections for blocked devices
Date: Tue,  1 Jul 2014 22:54:15 +0300
Message-Id: <1404244455-15651-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404244455-15651-1-git-send-email-johan.hedberg@gmail.com>
References: <1404244455-15651-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Unlike BR/EDR we cannot reject LE connections of blocked devices but
have to do it as soon as we get a LE Connection Complete event. The
patch adds a blacklist check to the hci_le_conn_complete_evt function
and drops all connections for blocked devices.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b0b760dd66a3..173043ebb1bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4119,6 +4119,12 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		conn->dst_type = irk->addr_type;
 	}
 
+	/* Drop the connection if he device is blocked */
+	if (hci_blacklist_lookup(hdev, &conn->dst, conn->dst_type)) {
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	if (ev->status) {
 		hci_le_conn_failed(conn, ev->status);
 		goto unlock;
-- 
1.9.3

