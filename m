Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 5 Aug 2011 10:51:26 -0400
Subject: [PATCH 1/4] Bluetooth: hidp: Fix session cleanup on failed conn add
Message-ID: <1312555886.2172.11.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Once the session thread is running, cleanup must be
handled by the session thread only.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 net/bluetooth/hidp/core.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 43b4c2d..7e19a01 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1044,8 +1044,12 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 	}
 
 	err = hid_add_device(session->hid);
-	if (err < 0)
-		goto err_add_device;
+	if (err < 0) {
+		atomic_inc(&session->terminate);
+		wake_up_process(session->task);
+		up_write(&hidp_session_sem);
+		return err;
+	}
 
 	if (session->input) {
 		hidp_send_ctrl_message(session,
@@ -1059,12 +1063,6 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 	up_write(&hidp_session_sem);
 	return 0;
 
-err_add_device:
-	hid_destroy_device(session->hid);
-	session->hid = NULL;
-	atomic_inc(&session->terminate);
-	wake_up_process(session->task);
-
 unlink:
 	hidp_del_timer(session);
 
-- 
1.7.4.1

