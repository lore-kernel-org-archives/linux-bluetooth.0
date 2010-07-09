Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Set mode options for l2cap sockets in BTIO API
Date: Sat, 10 Jul 2010 00:08:50 +0200
Message-Id: <1278713330-11140-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some profiles like MCAP or HDP need set an specific l2cap configuraton
such as Streming, ERTM or another else. This patch enables BTIO API to
set the mode for l2cap socket options.
---
 src/btio.c |   19 +++++++++++++------
 src/btio.h |    1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/btio.c b/src/btio.c
index cf91de7..93079ae 100644
--- a/src/btio.c
+++ b/src/btio.c
@@ -57,6 +57,7 @@ struct set_opts {
 	uint16_t imtu;
 	uint16_t omtu;
 	int master;
+	uint8_t mode;
 };
 
 struct connect {
@@ -474,10 +475,10 @@ static gboolean get_sec_level(int sock, BtIOType type, int *level,
 	return TRUE;
 }
 
-static gboolean l2cap_set(int sock, int sec_level, uint16_t imtu,
-				uint16_t omtu, int master, GError **err)
+static gboolean l2cap_set(int sock, int sec_level, uint16_t imtu, uint16_t omtu,
+					uint8_t mode, int master, GError **err)
 {
-	if (imtu || omtu) {
+	if (imtu || omtu || mode) {
 		struct l2cap_options l2o;
 		socklen_t len;
 
@@ -493,6 +494,8 @@ static gboolean l2cap_set(int sock, int sec_level, uint16_t imtu,
 			l2o.imtu = imtu;
 		if (omtu)
 			l2o.omtu = omtu;
+		if (mode)
+			l2o.mode = mode;
 
 		if (setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o,
 							sizeof(l2o)) < 0) {
@@ -629,6 +632,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 	opts->defer = DEFAULT_DEFER_TIMEOUT;
 	opts->master = -1;
 	opts->sec_level = BT_IO_SEC_MEDIUM;
+	opts->mode = L2CAP_MODE_BASIC;
 
 	while (opt != BT_IO_OPT_INVALID) {
 		switch (opt) {
@@ -678,6 +682,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_MASTER:
 			opts->master = va_arg(args, gboolean);
 			break;
+		case BT_IO_OPT_MODE:
+			opts->mode = va_arg(args, int);
+			break;
 		default:
 			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
 					"Unknown option %d", opt);
@@ -1088,7 +1095,7 @@ gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
 	case BT_IO_L2RAW:
 	case BT_IO_L2CAP:
 		return l2cap_set(sock, opts.sec_level, opts.imtu, opts.omtu,
-							opts.master, err);
+						opts.mode, opts.master, err);
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.master, err);
 	case BT_IO_SCO:
@@ -1129,7 +1136,7 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 		if (l2cap_bind(sock, &opts->src,
 					server ? opts->psm : 0, err) < 0)
 			goto failed;
-		if (!l2cap_set(sock, opts->sec_level, 0, 0, -1, err))
+		if (!l2cap_set(sock, opts->sec_level, 0, 0, 0, -1, err))
 			goto failed;
 		break;
 	case BT_IO_L2CAP:
@@ -1142,7 +1149,7 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 					server ? opts->psm : 0, err) < 0)
 			goto failed;
 		if (!l2cap_set(sock, opts->sec_level, opts->imtu, opts->omtu,
-							opts->master, err))
+						opts->mode, opts->master, err))
 			goto failed;
 		break;
 	case BT_IO_RFCOMM:
diff --git a/src/btio.h b/src/btio.h
index fa6ff69..81fda8e 100644
--- a/src/btio.h
+++ b/src/btio.h
@@ -60,6 +60,7 @@ typedef enum {
 	BT_IO_OPT_MASTER,
 	BT_IO_OPT_HANDLE,
 	BT_IO_OPT_CLASS,
+	BT_IO_OPT_MODE,
 } BtIOOption;
 
 typedef enum {
-- 
1.6.3.3

