Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] btio: Remove unused bt_io_set function
Date: Thu,  9 Sep 2010 17:43:07 +0800
Message-Id: <1284025388-3831-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284025388-3831-1-git-send-email-zhenhua.zhang@intel.com>
References: <1284025388-3831-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not used by either obex or bluez.
---
 btio/btio.c |   33 ---------------------------------
 btio/btio.h |    3 ---
 2 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 8b273ca..41b698f 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1074,39 +1074,6 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 	return TRUE;
 }
 
-gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
-							BtIOOption opt1, ...)
-{
-	va_list args;
-	gboolean ret;
-	struct set_opts opts;
-	int sock;
-
-	va_start(args, opt1);
-	ret = parse_set_opts(&opts, err, opt1, args);
-	va_end(args);
-
-	if (!ret)
-		return ret;
-
-	sock = g_io_channel_unix_get_fd(io);
-
-	switch (type) {
-	case BT_IO_L2RAW:
-	case BT_IO_L2CAP:
-		return l2cap_set(sock, opts.sec_level, opts.imtu, opts.omtu,
-						opts.mode, opts.master, err);
-	case BT_IO_RFCOMM:
-		return rfcomm_set(sock, opts.sec_level, opts.master, err);
-	case BT_IO_SCO:
-		return sco_set(sock, opts.mtu, err);
-	}
-
-	g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
-			"Unknown BtIO type %d", type);
-	return FALSE;
-}
-
 gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
 							BtIOOption opt1, ...)
 {
diff --git a/btio/btio.h b/btio/btio.h
index 81fda8e..89d3d08 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -77,9 +77,6 @@ typedef void (*BtIOConnect)(GIOChannel *io, GError *err, gpointer user_data);
 gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 					GDestroyNotify destroy, GError **err);
 
-gboolean bt_io_set(GIOChannel *io, BtIOType type, GError **err,
-						BtIOOption opt1, ...);
-
 gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
 						BtIOOption opt1, ...);
 
-- 
1.7.0.4

