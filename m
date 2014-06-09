Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add clarifying comment for conn->auth_type
Date: Mon,  9 Jun 2014 14:41:25 +0300
Message-Id: <1402314085-6155-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When responding to an IO capability request when we're the initiators of
the pairing we will not yet have the remote IO capability information.
Since the conn->auth_type variable is treated as an "absolute"
requirement instead of a hint of what's needed later in the user
confirmation request handler it's important that it doesn't have the
MITM bit set if there's any chance that the remote device doesn't have
the necessary IO capabilities.

This patch adds a clarifying comment so that conn->auth_type is left
untouched in this scenario.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 67a9cf4143ae..6a7ae9b519a2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3531,7 +3531,11 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			cp.authentication = conn->auth_type;
 
 			/* Request MITM protection if our IO caps allow it
-			 * except for the no-bonding case
+			 * except for the no-bonding case.
+			 * conn->auth_type is not updated here since
+			 * that might cause the user confirmation to be
+			 * rejected in case the remote doesn't have the
+			 * IO capabilities for MITM.
 			 */
 			if (conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
 			    cp.authentication != HCI_AT_NO_BONDING)
-- 
1.9.3

