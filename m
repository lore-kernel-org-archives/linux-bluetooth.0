Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix reason code used for rejecting SCO connections
Date: Wed, 24 Sep 2014 13:14:46 +0300
Message-Id: <1411553686-3815-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The core specification defines valid values for the
HCI_Reject_Synchronous_Connection_Request command to be 0x0D-0x0F. So
far the code has been using HCI_ERROR_REMOTE_USER_TERM (0x13) which is
not a valid value and is therefore being rejected by some controllers:

 > HCI Event: Connect Request (0x04) plen 10
	bdaddr 40:6F:2A:6A:E5:E0 class 0x000000 type eSCO
 < HCI Command: Reject Synchronous Connection (0x01|0x002a) plen 7
	bdaddr 40:6F:2A:6A:E5:E0 reason 0x13
	Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
	Reject Synchronous Connection (0x01|0x002a) status 0x12 ncmd 1
	Error: Invalid HCI Command Parameters

This patch introduces a new define for a value from the valid range
(0x0d == Connection Rejected Due To Limited Resources) and uses it
instead for rejecting incoming connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_conn.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3f8547f1c6f8..6e8f24967308 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -385,6 +385,7 @@ enum {
 #define HCI_ERROR_AUTH_FAILURE		0x05
 #define HCI_ERROR_MEMORY_EXCEEDED	0x07
 #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
+#define HCI_ERROR_REJ_LIMITED_RESOURCES	0x0d
 #define HCI_ERROR_REJ_BAD_ADDR		0x0f
 #define HCI_ERROR_REMOTE_USER_TERM	0x13
 #define HCI_ERROR_REMOTE_LOW_RESOURCES	0x14
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 22b253750f78..445829cd363c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -121,7 +121,7 @@ static void hci_reject_sco(struct hci_conn *conn)
 {
 	struct hci_cp_reject_sync_conn_req cp;
 
-	cp.reason = HCI_ERROR_REMOTE_USER_TERM;
+	cp.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
 	bacpy(&cp.bdaddr, &conn->dst);
 
 	hci_send_cmd(conn->hdev, HCI_OP_REJECT_SYNC_CONN_REQ, sizeof(cp), &cp);
-- 
1.9.3

