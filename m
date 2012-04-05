Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v3] Bluetooth: Fix packet type for ESCO Link
Date: Thu, 5 Apr 2012 09:16:34 +0530
Message-ID: <1333597594-21532-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch uses the corect packet type for ESCO Link.
Without this patch esco packet types were anded with ~EDR_ESCO_MASK
resulting in setting bits that are not supported by controller
to 0 which means that corresponding EDR ESCO packet type is
supported(EDR Packet types are inverted as per BT Spec) which might
not be the case.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/hci_conn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 947172b..1060fb6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -396,7 +396,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 			conn->pkt_type = hdev->pkt_type & SCO_PTYPE_MASK;
 		break;
 	case ESCO_LINK:
-		conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
+		conn->pkt_type = hdev->esco_type ^ EDR_ESCO_MASK;
 		break;
 	}
 
-- 
1.7.0.4

