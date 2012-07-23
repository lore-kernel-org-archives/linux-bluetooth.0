Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ] btio: Rescue lost errorneous numbers
Date: Mon, 23 Jul 2012 11:36:03 -0300
Message-Id: <1343054163-19119-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Paulo Alcantara <paulo.alcantara@openbossa.org>

The BT_IO_ERROR_* flags are not used for anything else and we just
loosing errorneous numbers set in the sockets that might be more
useful for handling specific errors.

A use case would be disconnect errors that should not allow BlueZ to
enable auto connections since the connection would never be possible in
some cases.

This patch removes BT_IO_ERROR_* flags and use the errors set in the
sockets instead. Now, the errors passed in connect/disconnect callbacks
should contain proper error numbers passed to them.
---
 btio/btio.c |   78 ++++++++++++++++++++++++++++++++++++----------------------
 btio/btio.h |    7 -----
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index e81fb75..f2a9d4b 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -43,7 +43,7 @@
 #endif
 
 #define ERROR_FAILED(gerr, str, err) \
-		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, \
+		g_set_error(gerr, BT_IO_ERROR, err, \
 				str ": %s (%d)", strerror(err), err)
 
 #define DEFAULT_DEFER_TIMEOUT 30
@@ -124,19 +124,29 @@ static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct accept *accept = user_data;
-	GError *err = NULL;
+	GError *gerr = NULL;
 
 	/* If the user aborted this accept attempt */
 	if ((cond & G_IO_NVAL) || check_nval(io))
 		return FALSE;
 
-	if (cond & (G_IO_HUP | G_IO_ERR))
-		g_set_error(&err, BT_IO_ERROR, BT_IO_ERROR_DISCONNECTED,
-				"HUP or ERR on socket");
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		int err, sk_err, sock = g_io_channel_unix_get_fd(io);
+		socklen_t len = sizeof(sk_err);
+
+		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+			err = -errno;
+		else
+			err = -sk_err;
+
+		if (err < 0)
+			g_set_error(&gerr, BT_IO_ERROR, -err,
+					"HUP or ERR on socket");
+	}
 
-	accept->connect(io, err, accept->user_data);
+	accept->connect(io, gerr, accept->user_data);
 
-	g_clear_error(&err);
+	g_clear_error(&gerr);
 
 	return FALSE;
 }
@@ -146,14 +156,15 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 {
 	struct connect *conn = user_data;
 	GError *gerr = NULL;
+	int err, sk_err, sock;
+	socklen_t len = sizeof(sk_err);
 
 	/* If the user aborted this connect attempt */
 	if ((cond & G_IO_NVAL) || check_nval(io))
 		return FALSE;
 
 	if (cond & G_IO_OUT) {
-		int err, sk_err = 0, sock = g_io_channel_unix_get_fd(io);
-		socklen_t len = sizeof(sk_err);
+		sock = g_io_channel_unix_get_fd(io);
 
 		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
 			err = -errno;
@@ -161,17 +172,24 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition cond,
 			err = -sk_err;
 
 		if (err < 0)
-			g_set_error(&gerr, BT_IO_ERROR,
-					BT_IO_ERROR_CONNECT_FAILED, "%s (%d)",
-					strerror(-err), -err);
-	} else if (cond & (G_IO_HUP | G_IO_ERR))
-		g_set_error(&gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
-				"HUP or ERR on socket");
+			g_set_error(&gerr, BT_IO_ERROR, -err, "%s (%d)",
+							strerror(-err), -err);
+	} else if (cond & (G_IO_HUP | G_IO_ERR)) {
+		sock = g_io_channel_unix_get_fd(io);
+
+		if (getsockopt(sock, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+			err = -errno;
+		else
+			err = -sk_err;
+
+		if (err < 0)
+			g_set_error(&gerr, BT_IO_ERROR, -err,
+					"HUP or ERR on socket");
+	}
 
 	conn->connect(io, gerr, conn->user_data);
 
-	if (gerr)
-		g_error_free(gerr);
+	g_clear_error(&gerr);
 
 	return FALSE;
 }
@@ -390,7 +408,7 @@ static gboolean set_sec_level(int sock, BtIOType type, int level, GError **err)
 	int ret;
 
 	if (level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH) {
-		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Valid security level range is %d-%d",
 				BT_SECURITY_LOW, BT_SECURITY_HIGH);
 		return FALSE;
@@ -764,7 +782,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 			opts->priority = va_arg(args, int);
 			break;
 		default:
-			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
 			return FALSE;
 		}
@@ -883,7 +901,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			bacpy(va_arg(args, bdaddr_t *), &dst.l2_bdaddr);
 			break;
 		case BT_IO_OPT_DEST_TYPE:
-			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+			g_set_error(err, BT_IO_ERROR, EINVAL,
 							"Not implemented");
 			return FALSE;
 		case BT_IO_OPT_DEFER_TIMEOUT:
@@ -961,7 +979,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			*(va_arg(args, uint32_t *)) = priority;
 			break;
 		default:
-			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
 			return FALSE;
 		}
@@ -1068,7 +1086,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
 			break;
 		default:
-			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
 			return FALSE;
 		}
@@ -1151,7 +1169,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
 			break;
 		default:
-			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
 			return FALSE;
 		}
@@ -1180,7 +1198,7 @@ static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 		return sco_get(sock, err, opt1, args);
 	}
 
-	g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+	g_set_error(err, BT_IO_ERROR, EINVAL,
 			"Unknown BtIO type %d", type);
 	return FALSE;
 }
@@ -1245,7 +1263,7 @@ gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
 		return sco_set(sock, opts.mtu, err);
 	}
 
-	g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+	g_set_error(err, BT_IO_ERROR, EINVAL,
 			"Unknown BtIO type %d", type);
 	return FALSE;
 }
@@ -1334,7 +1352,7 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 			goto failed;
 		break;
 	default:
-		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Unknown BtIO type %d", type);
 		return NULL;
 	}
@@ -1392,14 +1410,14 @@ GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
 		err = sco_connect(sock, &opts.dst);
 		break;
 	default:
-		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+		g_set_error(gerr, BT_IO_ERROR, EINVAL,
 						"Unknown BtIO type %d", type);
 		return NULL;
 	}
 
 	if (err < 0) {
-		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_CONNECT_FAILED,
-				"connect: %s (%d)", strerror(-err), -err);
+		g_set_error(gerr, BT_IO_ERROR, -err, "connect: %s (%d)",
+							strerror(-err), -err);
 		g_io_channel_unref(io);
 		return NULL;
 	}
@@ -1421,7 +1439,7 @@ GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
 	gboolean ret;
 
 	if (type == BT_IO_L2RAW) {
-		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Server L2CAP RAW sockets not supported");
 		return NULL;
 	}
diff --git a/btio/btio.h b/btio/btio.h
index cf0e070..70b32d6 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -26,13 +26,6 @@
 
 #include <glib.h>
 
-typedef enum {
-	BT_IO_ERROR_DISCONNECTED,
-	BT_IO_ERROR_CONNECT_FAILED,
-	BT_IO_ERROR_FAILED,
-	BT_IO_ERROR_INVALID_ARGS,
-} BtIOError;
-
 #define BT_IO_ERROR bt_io_error_quark()
 
 GQuark bt_io_error_quark(void);
-- 
1.7.8.6

