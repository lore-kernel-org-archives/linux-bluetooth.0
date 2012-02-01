Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/3] btio: add L2ERTM type
Date: Tue, 31 Jan 2012 17:25:34 -0800
Message-Id: <1328059536-6379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

L2ERTM type uses L2CAP socket in SOCK_STREAM instead of SOCK_SEQPACKET
---
 btio/btio.c |   17 +++++++++++++++++
 btio/btio.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 825907d..9781ec4 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1161,6 +1161,7 @@ static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 	switch (type) {
 	case BT_IO_L2RAW:
 	case BT_IO_L2CAP:
+	case BT_IO_L2ERTM:
 		return l2cap_get(sock, err, opt1, args);
 	case BT_IO_RFCOMM:
 		return rfcomm_get(sock, err, opt1, args);
@@ -1223,6 +1224,7 @@ gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
 	switch (type) {
 	case BT_IO_L2RAW:
 	case BT_IO_L2CAP:
+	case BT_IO_L2ERTM:
 		return l2cap_set(sock, opts.sec_level, opts.imtu, opts.omtu,
 				opts.mode, opts.master, opts.flushable,
 				opts.priority, err);
@@ -1283,6 +1285,20 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 				opts->priority, err))
 			goto failed;
 		break;
+	case BT_IO_L2ERTM:
+		sock = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_L2CAP);
+		if (sock < 0) {
+			ERROR_FAILED(err, "socket(STREAM, L2CAP)", errno);
+			return NULL;
+		}
+		if (l2cap_bind(sock, &opts->src, server ? opts->psm : 0,
+							opts->cid, err) < 0)
+			goto failed;
+		if (!l2cap_set(sock, opts->sec_level, opts->imtu, opts->omtu,
+				opts->mode, opts->master, opts->flushable,
+				opts->priority, err))
+			goto failed;
+		break;
 	case BT_IO_RFCOMM:
 		sock = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
 		if (sock < 0) {
@@ -1353,6 +1369,7 @@ GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
 		err = l2cap_connect(sock, &opts.dst, 0, opts.cid);
 		break;
 	case BT_IO_L2CAP:
+	case BT_IO_L2ERTM:
 		err = l2cap_connect(sock, &opts.dst, opts.psm, opts.cid);
 		break;
 	case BT_IO_RFCOMM:
diff --git a/btio/btio.h b/btio/btio.h
index 7e3e130..126d5d9 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -40,6 +40,7 @@ GQuark bt_io_error_quark(void);
 typedef enum {
 	BT_IO_L2RAW,
 	BT_IO_L2CAP,
+	BT_IO_L2ERTM,
 	BT_IO_RFCOMM,
 	BT_IO_SCO,
 } BtIOType;
-- 
1.7.7.6

