Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix using uninitialized variable when pairing
Date: Thu, 17 Jul 2014 11:56:33 +0300
Message-Id: <1405587393-3058-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Commit 6c53823ae0e10e723131055e1e65dd6a328a228e reshuffled the way the
authentication requirement gets set in the hci_io_capa_request_evt()
function, but at the same time it failed to update an if-statement where
cp.authentication is used before it has been initialized. The correct
value the code should be looking for in this if-statement is
conn->auth_type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8339f729921b..1bd4de7e74fc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3658,7 +3658,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			 * except for the no-bonding case.
 			 */
 			if (conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-			    cp.authentication != HCI_AT_NO_BONDING)
+			    conn->auth_type != HCI_AT_NO_BONDING)
 				conn->auth_type |= 0x01;
 
 			cp.authentication = conn->auth_type;
-- 
1.9.3

