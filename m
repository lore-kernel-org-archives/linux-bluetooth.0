Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 03/12] shared/att: Directly close fd on ATT violations.
Date: Mon, 17 Nov 2014 11:22:09 -0800
Message-Id: <1416252138-17477-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1416252138-17477-1-git-send-email-armansito@chromium.org>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The existing code handles ATT protocol request timeouts and invalid
incoming request PDUs by cleaning up the io structure via io_destroy.
This doesn't always work, since this only terminates the connection if
io_set_close_on_destroy has been set. Calling io_destroy to force a
disconnect also has the added side-effect of not invoking the disconnect
callback registered with struct io.

This patch fixes these by calling close directly on the file descriptor
when required by the ATT protocol specification. This both cleans up the
connection regardless of whether or not close_on_unref has been set, and
it triggers the disconnect callback via an EPOLLHUP event.
---
 src/shared/att.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 264cece..d441099 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -416,9 +416,6 @@ static bool timeout_cb(void *user_data)
 	if (!op)
 		return false;
 
-	io_destroy(att->io);
-	att->io = NULL;
-
 	util_debug(att->debug_callback, att->debug_data,
 				"Operation timed out: 0x%02x", op->opcode);
 
@@ -428,6 +425,13 @@ static bool timeout_cb(void *user_data)
 	op->timeout_id = 0;
 	destroy_att_send_op(op);
 
+	/*
+	 * Directly terminate the connection as required by the ATT protocol.
+	 * This should trigger an io disconnect event which will clean up the
+	 * io and notify the upper layer.
+	 */
+	close(att->fd);
+
 	return false;
 }
 
@@ -765,14 +769,15 @@ static bool can_read_data(struct io *io, void *user_data)
 	case ATT_OP_TYPE_REQ:
 		/*
 		 * If a request is currently pending, then the sequential
-		 * protocol was violated. Disconnect the bearer and notify the
-		 * upper-layer.
+		 * protocol was violated. Disconnect the bearer, which will
+		 * promptly notify the upper layer via disconnect handlers.
 		 */
 		if (att->in_req) {
 			util_debug(att->debug_callback, att->debug_data,
 					"Received request while another is "
 					"pending: 0x%02x", opcode);
-			disconnect_cb(att->io, att);
+			close(att->fd);
+
 			return false;
 		}
 
-- 
2.1.0.rc2.206.gedb03e5

