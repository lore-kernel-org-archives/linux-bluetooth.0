Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/12] Bluetooth: Fix connection key type updating for buggy controllers
Date: Thu, 28 Apr 2011 11:29:01 -0700
Message-Id: <1304015344-12238-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

If a controller generates a changed combination key as its first key the
connection key type will not be correctly set. In these situations make
sure the update the connection key type when such a buggy controller is
detected.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 88ed4ff..1531dd7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1083,8 +1083,11 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	 * previous key */
 	if (type == HCI_LK_CHANGED_COMBINATION &&
 					(!conn || conn->remote_auth == 0xff) &&
-					old_key_type == 0xff)
+					old_key_type == 0xff) {
 		type = HCI_LK_COMBINATION;
+		if (conn)
+			conn->key_type = type;
+	}
 
 	if (new_key && !hci_persistent_key(hdev, conn, type, old_key_type)) {
 		list_del(&key->list);
-- 
1.7.4.4

