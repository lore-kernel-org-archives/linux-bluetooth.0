Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 2/4] btio: Add address type in bt_io_connect
Date: Wed,  4 Apr 2012 17:16:09 -0300
Message-Id: <1333570571-29650-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new BtIO option to allow setting the remote Bluetooth
address type for BLE connections.
---
 btio/btio.c |   20 ++++++++++++++++----
 btio/btio.h |    1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 9781ec4..d553da8 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -51,6 +51,7 @@
 struct set_opts {
 	bdaddr_t src;
 	bdaddr_t dst;
+	uint8_t dst_type;
 	int defer;
 	int sec_level;
 	uint8_t channel;
@@ -280,8 +281,8 @@ static int l2cap_bind(int sock, const bdaddr_t *src, uint16_t psm,
 	return 0;
 }
 
-static int l2cap_connect(int sock, const bdaddr_t *dst,
-					uint16_t psm, uint16_t cid)
+static int l2cap_connect(int sock, const bdaddr_t *dst, uint8_t dst_type,
+						uint16_t psm, uint16_t cid)
 {
 	int err;
 	struct sockaddr_l2 addr;
@@ -294,6 +295,8 @@ static int l2cap_connect(int sock, const bdaddr_t *dst,
 	else
 		addr.l2_psm = htobs(psm);
 
+	addr.l2_bdaddr_type = dst_type;
+
 	err = connect(sock, (struct sockaddr *) &addr, sizeof(addr));
 	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS))
 		return -errno;
@@ -714,6 +717,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_DEST_BDADDR:
 			bacpy(&opts->dst, va_arg(args, const bdaddr_t *));
 			break;
+		case BT_IO_OPT_DEST_TYPE:
+			opts->dst_type = va_arg(args, int);
+			break;
 		case BT_IO_OPT_DEFER_TIMEOUT:
 			opts->defer = va_arg(args, int);
 			break;
@@ -875,6 +881,10 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 		case BT_IO_OPT_DEST_BDADDR:
 			bacpy(va_arg(args, bdaddr_t *), &dst.l2_bdaddr);
 			break;
+		case BT_IO_OPT_DEST_TYPE:
+			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+							"Not implemented");
+			return FALSE;
 		case BT_IO_OPT_DEFER_TIMEOUT:
 			len = sizeof(int);
 			if (getsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP,
@@ -1366,11 +1376,13 @@ GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
 
 	switch (type) {
 	case BT_IO_L2RAW:
-		err = l2cap_connect(sock, &opts.dst, 0, opts.cid);
+		err = l2cap_connect(sock, &opts.dst, opts.dst_type, 0,
+								opts.cid);
 		break;
 	case BT_IO_L2CAP:
 	case BT_IO_L2ERTM:
-		err = l2cap_connect(sock, &opts.dst, opts.psm, opts.cid);
+		err = l2cap_connect(sock, &opts.dst, opts.dst_type,
+							opts.psm, opts.cid);
 		break;
 	case BT_IO_RFCOMM:
 		err = rfcomm_connect(sock, &opts.dst, opts.channel);
diff --git a/btio/btio.h b/btio/btio.h
index 429e8c0..cf0e070 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -51,6 +51,7 @@ typedef enum {
 	BT_IO_OPT_SOURCE_BDADDR,
 	BT_IO_OPT_DEST,
 	BT_IO_OPT_DEST_BDADDR,
+	BT_IO_OPT_DEST_TYPE,
 	BT_IO_OPT_DEFER_TIMEOUT,
 	BT_IO_OPT_SEC_LEVEL,
 	BT_IO_OPT_KEY_SIZE,
-- 
1.7.8.5

