Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>
Subject: [PATCH 1/4] Bluetooth: Change bit logic in pkt_type for SCO links
Date: Tue, 14 Jun 2011 15:57:04 +0200
Message-ID: <1308059827-15095-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change pkt_type to store packet type bitmask in standard on/off logic rather
than as specified in BT specification. This will make handling of pkt_type
easier. Conversion to BT logic is now done just prior to packing into HCI
command.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/hci_conn.c  |    8 ++++----
 net/bluetooth/hci_event.c |    3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2f5ae53..e203622 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -174,7 +174,8 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	conn->attempt++;
 
 	cp.handle   = cpu_to_le16(handle);
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
+	/* Bits for EDR packets have inverted logic in BT spec. */
+	cp.pkt_type = cpu_to_le16(conn->pkt_type ^ EDR_ESCO_MASK);
 
 	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
@@ -362,13 +363,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
-			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
-					(hdev->esco_type & EDR_ESCO_MASK);
+			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK);
 		else
 			conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
 		break;
 	case ESCO_LINK:
-		conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
+		conn->pkt_type = hdev->esco_type;
 		break;
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2c5e8..2f0d3ab 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2420,8 +2420,7 @@ static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_bu
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
 		if (conn->out && conn->attempt < 2) {
-			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
-					(hdev->esco_type & EDR_ESCO_MASK);
+			conn->pkt_type = hdev->esco_type & SCO_ESCO_MASK;
 			hci_setup_sync(conn, conn->link->handle);
 			goto unlock;
 		}
-- 
1.7.5.4

