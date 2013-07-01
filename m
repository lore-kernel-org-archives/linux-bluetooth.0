Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix simple whitespace vs tab style issue
Date: Mon,  1 Jul 2013 14:14:46 -0700
Message-Id: <1372713286-6486-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 061523e..dc34bfa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -605,7 +605,7 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	 * as supported send it. If not supported assume that the controller
 	 * does not have actual support for stored link keys which makes this
 	 * command redundant anyway.
-         */
+	 */
 	if (hdev->commands[6] & 0x80) {
 		struct hci_cp_delete_stored_link_key cp;
 
-- 
1.8.1.4

