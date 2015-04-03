Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hidp: Use BIT(x) instead of (1 << x)
Date: Fri,  3 Apr 2015 11:02:10 -0700
Message-Id: <1428084130-330-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 926a0e8b7136..a05b9dbf14c9 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -908,7 +908,7 @@ static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
 	kref_init(&session->ref);
 	atomic_set(&session->state, HIDP_SESSION_IDLING);
 	init_waitqueue_head(&session->state_queue);
-	session->flags = req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
+	session->flags = req->flags & BIT(HIDP_BLUETOOTH_VENDOR_ID);
 
 	/* connection management */
 	bacpy(&session->bdaddr, bdaddr);
@@ -1366,7 +1366,7 @@ int hidp_connection_del(struct hidp_conndel_req *req)
 	if (!session)
 		return -ENOENT;
 
-	if (req->flags & (1 << HIDP_VIRTUAL_CABLE_UNPLUG))
+	if (req->flags & BIT(HIDP_VIRTUAL_CABLE_UNPLUG))
 		hidp_send_ctrl_message(session,
 				       HIDP_TRANS_HID_CONTROL |
 				         HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
-- 
2.1.0

