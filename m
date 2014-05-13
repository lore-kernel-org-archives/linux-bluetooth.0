Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 4/5] Bluetooth: Store max TX power level for connection
Date: Tue, 13 May 2014 11:52:30 +0200
Message-ID: <1399974751-7226-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399974751-7226-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399974751-7226-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to store local maximum TX power level for
connection when reply for HCI_Read_Transmit_Power_Level is received.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  1 +
 net/bluetooth/hci_event.c        | 12 +++++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cbbab63..b386bf1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -382,6 +382,7 @@ struct hci_conn {
 	__u16		le_conn_max_interval;
 	__s8		rssi;
 	__s8		tx_power;
+	__s8		max_tx_power;
 	unsigned long	flags;
 
 	unsigned long	conn_info_timestamp;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74b368b..a987e7d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -408,6 +408,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->remote_auth = 0xff;
 	conn->key_type = 0xff;
 	conn->tx_power = HCI_TX_POWER_INVALID;
+	conn->max_tx_power = HCI_TX_POWER_INVALID;
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fa614e3..492d8d5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1282,9 +1282,19 @@ static void hci_cc_read_tx_power(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
-	if (conn && sent->type == 0x00)
+	if (!conn)
+		goto unlock;
+
+	switch (sent->type) {
+	case 0x00:
 		conn->tx_power = rp->tx_power;
+		break;
+	case 0x01:
+		conn->max_tx_power = rp->tx_power;
+		break;
+	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.9.3

