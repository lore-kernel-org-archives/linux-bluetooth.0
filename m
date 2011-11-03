Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] btio: add BT_IO_OPT_PRIORITY option
Date: Thu,  3 Nov 2011 17:15:39 +0200
Message-Id: <1320333340-27112-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
References: <1320333340-27112-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_IO_OPT_PRIORITY uses SO_PRIORITY to set the priority of the socket
---
 btio/btio.c |   47 +++++++++++++++++++++++++++++++++++++++++++----
 btio/btio.h |    1 +
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 2cc9082..6db1756 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -64,6 +64,7 @@ struct set_opts {
 	int master;
 	uint8_t mode;
 	int flushable;
+	uint32_t priority;
 };
 
 struct connect {
@@ -502,9 +503,17 @@ static int l2cap_set_flushable(int sock, gboolean flushable)
 	return 0;
 }
 
+static int set_priority(int sock, uint32_t prio)
+{
+	if (setsockopt(sock, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static gboolean l2cap_set(int sock, int sec_level, uint16_t imtu,
 				uint16_t omtu, uint8_t mode, int master,
-				int flushable, GError **err)
+				int flushable, uint32_t priority, GError **err)
 {
 	if (imtu || omtu || mode) {
 		struct l2cap_options l2o;
@@ -542,6 +551,11 @@ static gboolean l2cap_set(int sock, int sec_level, uint16_t imtu,
 		return FALSE;
 	}
 
+	if (priority > 0 && set_priority(sock, priority) < 0) {
+		ERROR_FAILED(err, "set_priority", errno);
+		return FALSE;
+	}
+
 	if (sec_level && !set_sec_level(sock, BT_IO_L2CAP, sec_level, err))
 		return FALSE;
 
@@ -669,6 +683,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	opts->sec_level = BT_IO_SEC_MEDIUM;
 	opts->mode = L2CAP_MODE_BASIC;
 	opts->flushable = -1;
+	opts->priority = 0;
 
 	while (opt != BT_IO_OPT_INVALID) {
 		switch (opt) {
@@ -727,6 +742,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_FLUSHABLE:
 			opts->flushable = va_arg(args, gboolean);
 			break;
+		case BT_IO_OPT_PRIORITY:
+			opts->priority = va_arg(args, int);
+			break;
 		default:
 			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
 					"Unknown option %d", opt);
@@ -797,6 +815,17 @@ static int l2cap_get_flushable(int sock, gboolean *flushable)
 	return 0;
 }
 
+static int get_priority(int sock, uint32_t *prio)
+{
+	socklen_t len;
+
+	len = sizeof(*prio);
+	if (getsockopt(sock, SOL_SOCKET, SO_PRIORITY, prio, &len) < 0)
+		return -errno;
+
+	return 0;
+}
+
 static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 								va_list args)
 {
@@ -808,6 +837,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 	uint16_t handle;
 	socklen_t len;
 	gboolean flushable = FALSE;
+	uint32_t priority;
 
 	len = sizeof(l2o);
 	memset(&l2o, 0, len);
@@ -897,6 +927,13 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			}
 			*(va_arg(args, gboolean *)) = flushable;
 			break;
+		case BT_IO_OPT_PRIORITY:
+			if (get_priority(sock, &priority) < 0) {
+				ERROR_FAILED(err, "get_priority", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint32_t *)) = priority;
+			break;
 		default:
 			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
 					"Unknown option %d", opt);
@@ -1172,7 +1209,8 @@ gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
 	case BT_IO_L2RAW:
 	case BT_IO_L2CAP:
 		return l2cap_set(sock, opts.sec_level, opts.imtu, opts.omtu,
-				opts.mode, opts.master, opts.flushable, err);
+				opts.mode, opts.master, opts.flushable,
+				opts.priority, err);
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.master, err);
 	case BT_IO_SCO:
@@ -1213,7 +1251,7 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 		if (l2cap_bind(sock, &opts->src, server ? opts->psm : 0,
 							opts->cid, err) < 0)
 			goto failed;
-		if (!l2cap_set(sock, opts->sec_level, 0, 0, 0, -1, -1, err))
+		if (!l2cap_set(sock, opts->sec_level, 0, 0, 0, -1, -1, 0, err))
 			goto failed;
 		break;
 	case BT_IO_L2CAP:
@@ -1226,7 +1264,8 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 							opts->cid, err) < 0)
 			goto failed;
 		if (!l2cap_set(sock, opts->sec_level, opts->imtu, opts->omtu,
-				opts->mode, opts->master, opts->flushable, err))
+				opts->mode, opts->master, opts->flushable,
+				opts->priority, err))
 			goto failed;
 		break;
 	case BT_IO_RFCOMM:
diff --git a/btio/btio.h b/btio/btio.h
index c6b736f..c026f8d 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -65,6 +65,7 @@ typedef enum {
 	BT_IO_OPT_CLASS,
 	BT_IO_OPT_MODE,
 	BT_IO_OPT_FLUSHABLE,
+	BT_IO_OPT_PRIORITY
 } BtIOOption;
 
 typedef enum {
-- 
1.7.6.4

