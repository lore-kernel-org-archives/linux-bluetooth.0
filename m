Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/2] btio: Replace g_set_error by ERROR_FAILED macro
Date: Thu, 26 Jul 2012 11:11:08 -0300
Message-Id: <1343311869-5179-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the calls of g_set_error function by the local
defined macro "ERROR_FAILED".
---
 btio/btio.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index f2a9d4b..792123f 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -140,8 +140,7 @@ static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
 			err = -sk_err;
 
 		if (err < 0)
-			g_set_error(&gerr, BT_IO_ERROR, -err,
-					"HUP or ERR on socket");
+			ERROR_FAILED(&gerr, "HUP or ERR on socket", -err);
 	}
 
 	accept->connect(io, gerr, accept->user_data);
@@ -172,8 +171,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 			err = -sk_err;
 
 		if (err < 0)
-			g_set_error(&gerr, BT_IO_ERROR, -err, "%s (%d)",
-							strerror(-err), -err);
+			ERROR_FAILED(&gerr, "connect", -err);
 	} else if (cond & (G_IO_HUP | G_IO_ERR)) {
 		sock = g_io_channel_unix_get_fd(io);
 
@@ -183,8 +181,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 			err = -sk_err;
 
 		if (err < 0)
-			g_set_error(&gerr, BT_IO_ERROR, -err,
-					"HUP or ERR on socket");
+			ERROR_FAILED(&gerr, "HUP or ERR on socket", -err);
 	}
 
 	conn->connect(io, gerr, conn->user_data);
@@ -901,8 +898,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			bacpy(va_arg(args, bdaddr_t *), &dst.l2_bdaddr);
 			break;
 		case BT_IO_OPT_DEST_TYPE:
-			g_set_error(err, BT_IO_ERROR, EINVAL,
-							"Not implemented");
+			ERROR_FAILED(err, "Not implemented", EINVAL);
 			return FALSE;
 		case BT_IO_OPT_DEFER_TIMEOUT:
 			len = sizeof(int);
@@ -1416,8 +1412,7 @@ GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
 	}
 
 	if (err < 0) {
-		g_set_error(gerr, BT_IO_ERROR, -err, "connect: %s (%d)",
-							strerror(-err), -err);
+		ERROR_FAILED(gerr, "connect", -err);
 		g_io_channel_unref(io);
 		return NULL;
 	}
@@ -1439,8 +1434,8 @@ GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
 	gboolean ret;
 
 	if (type == BT_IO_L2RAW) {
-		g_set_error(err, BT_IO_ERROR, EINVAL,
-				"Server L2CAP RAW sockets not supported");
+		ERROR_FAILED(err, "Server L2CAP RAW sockets not supported",
+								EINVAL);
 		return NULL;
 	}
 
-- 
1.7.8.6

