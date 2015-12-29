Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	dh.herrmann@gmail.com,
	tedd.an@intel.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] bluetooth:hicp:Fix error handling in the function hidp_connection_del
Date: Tue, 29 Dec 2015 15:55:49 -0500
Message-Id: <1451422549-22071-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error handling in the function hidp_connection_del to
properly check if the internal call to hidp_send_ctrl_message has
failed by returning a error code and if so immediately return this
error code to the caller of hidp_connection_del to signal that a
failed call has occurred that needs to be handled by this function's
caller.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/hidp/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index f1a117f..13aa6d0 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1360,6 +1360,7 @@ int hidp_connection_del(struct hidp_conndel_req *req)
 {
 	u32 valid_flags = BIT(HIDP_VIRTUAL_CABLE_UNPLUG);
 	struct hidp_session *session;
+	int err;
 
 	if (req->flags & ~valid_flags)
 		return -EINVAL;
@@ -1368,14 +1369,16 @@ int hidp_connection_del(struct hidp_conndel_req *req)
 	if (!session)
 		return -ENOENT;
 
-	if (req->flags & BIT(HIDP_VIRTUAL_CABLE_UNPLUG))
-		hidp_send_ctrl_message(session,
-				       HIDP_TRANS_HID_CONTROL |
-				         HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
-				       NULL, 0);
-	else
+	if (req->flags & BIT(HIDP_VIRTUAL_CABLE_UNPLUG)) {
+		err = hidp_send_ctrl_message(session,
+					     HIDP_TRANS_HID_CONTROL |
+					     HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
+					     NULL, 0);
+		if (err)
+			return err;
+	} else {
 		l2cap_unregister_user(session->conn, &session->user);
-
+	}
 	hidp_session_put(session);
 
 	return 0;
-- 
2.1.4
