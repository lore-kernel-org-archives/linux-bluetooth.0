Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <vishal.agarwal@stericsson.com>
Subject: [PATCH] Bluetooth: Auth combination keys should be stored permanently
Date: Tue, 17 Apr 2012 17:29:13 +0530
Message-ID: <1334663953-15017-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If either local or remote device auth type is general bonding
(for ex. if local auth type is 0 but remote auth type is 5) then it
will result in link key of type authenticated link key. Which according
to spec should be stored for future use. So in case of key type
HCI_LK_AUTH_COMBINATION true should be return.

Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 net/bluetooth/hci_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c4dc263..e5fcb29 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1250,6 +1250,10 @@ static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03)
 		return true;
 
+	/*If Key type is Authenticated combination key then store it*/
+	if (key_type == HCI_LK_AUTH_COMBINATION)
+		return true;
+
 	/* If none of the above criteria match, then don't store the key
 	 * persistently */
 	return false;
-- 
1.7.0.4

