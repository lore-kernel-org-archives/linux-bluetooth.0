Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1] Bluetooth: Fix packet type for ESCO Link
Date: Tue, 3 Apr 2012 18:45:07 +0530
Message-ID: <1333458907-28940-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the packet type for ESCO Link which was incorrectly
set for EDR ESCO Packet Types. Anding esco_type with ~EDR_ESCO_MASK
results in loosing information of esco packet type (EDR Packet
types are inverted as per BT Spec) that resulted in wrong calculation
of packet type in hci_setup_sync() API causing the HCI Setup Synchronous
Connection Command to fail.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/hci_conn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 947172b..bff6bc1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 			conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
 		break;
 	case ESCO_LINK:
-		conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
+		conn->pkt_type = hdev->esco_type ^ ~EDR_ESCO_MASK;
 		break;
 	}
 
-- 
1.7.0.4

