Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/7] Bluetooth: Add new connection states
Date: Fri,  1 Feb 2013 21:44:32 -0300
Message-Id: <1359765878-31409-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
References: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds two new connection states which will be used by
hci_conn to establish LE connections.

BT_SCAN state means the controller is scanning for LE devices. Once
the target device is found, the connection goes to BT_DEV_FOUND
state, and then to BT_CONNECT state.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/bluetooth.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9531bee..add5721 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -126,7 +126,9 @@ enum {
 	BT_CONNECT2,
 	BT_CONFIG,
 	BT_DISCONN,
-	BT_CLOSED
+	BT_CLOSED,
+	BT_SCAN,
+	BT_DEV_FOUND
 };
 
 /* If unused will be removed by compiler */
@@ -151,6 +153,10 @@ static inline const char *state_to_string(int state)
 		return "BT_DISCONN";
 	case BT_CLOSED:
 		return "BT_CLOSED";
+	case BT_SCAN:
+		return "BT_SCAN";
+	case BT_DEV_FOUND:
+		return "BT_DEV_FOUND";
 	}
 
 	return "invalid state";
-- 
1.8.1.1

