Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix missing check for FIPS security level
Date: Mon,  2 Jun 2014 10:12:44 +0300
Message-Id: <1401693164-19759-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When checking whether a legacy link key provides at least HIGH security
level we also need to check for FIPS level which is one step above HIGH.
This patch fixes a missing check in the hci_link_key_request_evt()
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6cf9596ff69b..df7895e8fcc8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3077,7 +3077,8 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 
 		if (key->type == HCI_LK_COMBINATION && key->pin_len < 16 &&
-		    conn->pending_sec_level == BT_SECURITY_HIGH) {
+		    (conn->pending_sec_level == BT_SECURITY_HIGH ||
+		     conn->pending_sec_level == BT_SECURITY_FIPS)) {
 			BT_DBG("%s ignoring key unauthenticated for high security",
 			       hdev->name);
 			goto not_found;
-- 
1.9.3

