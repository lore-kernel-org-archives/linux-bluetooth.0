Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 5 Aug 2011 10:53:52 -0400
Subject: [PATCH] Bluetooth: cmtp: Fix session cleanup on failed conn add
Message-ID: <1312556032.2172.16.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Once the session thread is running, cleanup must be handled
by the session thread only.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/cmtp/core.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 42cb2f4..521baa4 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -382,16 +382,17 @@ int cmtp_add_connection(struct cmtp_connadd_req *req, struct socket *sock)
 
 	if (!(session->flags & (1 << CMTP_LOOPBACK))) {
 		err = cmtp_attach_device(session);
-		if (err < 0)
-			goto detach;
+		if (err < 0) {
+			atomic_inc(&session->terminate);
+			wake_up_process(session->task);
+			up_write(&cmtp_session_sem);
+			return err;
+		}
 	}
 
 	up_write(&cmtp_session_sem);
 	return 0;
 
-detach:
-	cmtp_detach_device(session);
-
 unlink:
 	__cmtp_unlink_session(session);
 
-- 
1.7.4.1

