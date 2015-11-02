Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: L2CAP: Fix returning correct LE CoC response codes
Date: Mon,  2 Nov 2015 14:39:15 +0200
Message-Id: <1446467957-19646-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1446467957-19646-1-git-send-email-johan.hedberg@gmail.com>
References: <1446467957-19646-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The core spec defines specific response codes for situations when the
received CID is incorrect. Add the defines for these and return them
as appropriate from the LE Connect Request handler function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 2 ++
 net/bluetooth/l2cap_core.c    | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c98afc08cc26..52899291f401 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -275,6 +275,8 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_AUTHORIZATION	0x0006
 #define L2CAP_CR_BAD_KEY_SIZE	0x0007
 #define L2CAP_CR_ENCRYPTION	0x0008
+#define L2CAP_CR_INVALID_SCID	0x0009
+#define L2CAP_CR_SCID_IN_USE	0x0010
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c65ee200c29..8fd36f59dcde 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5437,9 +5437,16 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	/* Check for valid dynamic CID range */
+	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
+		result = L2CAP_CR_INVALID_SCID;
+		chan = NULL;
+		goto response_unlock;
+	}
+
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(conn, scid)) {
-		result = L2CAP_CR_NO_MEM;
+		result = L2CAP_CR_SCID_IN_USE;
 		chan = NULL;
 		goto response_unlock;
 	}
-- 
2.5.0

