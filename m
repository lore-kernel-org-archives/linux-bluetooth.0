Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] btio: Remove SCO/L2RAW related code
Date: Thu, 19 Aug 2010 22:21:11 +0800
Message-Id: <1282227676-15381-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

1. Remove SCO/L2RAW related code since Obex doesn't use at all.
2. Remove header dependence with libbluetooth.
---
 btio/btio.c |  186 +----------------------------------------------------------
 btio/btio.h |    3 +-
 2 files changed, 2 insertions(+), 187 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 42a3bcd..92a5a41 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright (C) 2010  Intel Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -29,13 +30,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/l2cap.h>
-#include <bluetooth/rfcomm.h>
-#include <bluetooth/sco.h>
-#include <bluetooth/hci.h>
-#include <bluetooth/hci_lib.h>
-
 #include <glib.h>
 
 #include "btio.h"
@@ -563,63 +557,6 @@ static gboolean rfcomm_set(int sock, int sec_level, int master, GError **err)
 	return TRUE;
 }
 
-static int sco_bind(int sock, const bdaddr_t *src, GError **err)
-{
-	struct sockaddr_sco addr;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sco_family = AF_BLUETOOTH;
-	bacpy(&addr.sco_bdaddr, src);
-
-	if (bind(sock, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		ERROR_FAILED(err, "sco_bind", errno);
-		return -1;
-	}
-
-	return 0;
-}
-
-static int sco_connect(int sock, const bdaddr_t *dst)
-{
-	struct sockaddr_sco addr;
-	int err;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sco_family = AF_BLUETOOTH;
-	bacpy(&addr.sco_bdaddr, dst);
-
-	err = connect(sock, (struct sockaddr *) &addr, sizeof(addr));
-	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS))
-		return err;
-
-	return 0;
-}
-
-static gboolean sco_set(int sock, uint16_t mtu, GError **err)
-{
-	struct sco_options sco_opt;
-	socklen_t len;
-
-	if (!mtu)
-		return TRUE;
-
-	len = sizeof(sco_opt);
-	memset(&sco_opt, 0, len);
-	if (getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len) < 0) {
-		ERROR_FAILED(err, "getsockopt(SCO_OPTIONS)", errno);
-		return FALSE;
-	}
-
-	sco_opt.mtu = mtu;
-	if (setsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt,
-						sizeof(sco_opt)) < 0) {
-		ERROR_FAILED(err, "setsockopt(SCO_OPTIONS)", errno);
-		return FALSE;
-	}
-
-	return TRUE;
-}
-
 static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 						BtIOOption opt1, va_list args)
 {
@@ -941,89 +878,6 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 	return TRUE;
 }
 
-static int sco_get_info(int sock, uint16_t *handle, uint8_t *dev_class)
-{
-	struct sco_conninfo info;
-	socklen_t len;
-
-	len = sizeof(info);
-	if (getsockopt(sock, SOL_SCO, SCO_CONNINFO, &info, &len) < 0)
-		return -errno;
-
-	if (handle)
-		*handle = info.hci_handle;
-
-	if (dev_class)
-		memcpy(dev_class, info.dev_class, 3);
-
-	return 0;
-}
-
-static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
-{
-	BtIOOption opt = opt1;
-	struct sockaddr_sco src, dst;
-	struct sco_options sco_opt;
-	socklen_t len;
-	uint8_t dev_class[3];
-	uint16_t handle;
-
-	len = sizeof(sco_opt);
-	memset(&sco_opt, 0, len);
-	if (getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len) < 0) {
-		ERROR_FAILED(err, "getsockopt(SCO_OPTIONS)", errno);
-		return FALSE;
-	}
-
-	if (!get_peers(sock, (struct sockaddr *) &src,
-				(struct sockaddr *) &dst, sizeof(src), err))
-		return FALSE;
-
-	while (opt != BT_IO_OPT_INVALID) {
-		switch (opt) {
-		case BT_IO_OPT_SOURCE:
-			ba2str(&src.sco_bdaddr, va_arg(args, char *));
-			break;
-		case BT_IO_OPT_SOURCE_BDADDR:
-			bacpy(va_arg(args, bdaddr_t *), &src.sco_bdaddr);
-			break;
-		case BT_IO_OPT_DEST:
-			ba2str(&dst.sco_bdaddr, va_arg(args, char *));
-			break;
-		case BT_IO_OPT_DEST_BDADDR:
-			bacpy(va_arg(args, bdaddr_t *), &dst.sco_bdaddr);
-			break;
-		case BT_IO_OPT_MTU:
-		case BT_IO_OPT_IMTU:
-		case BT_IO_OPT_OMTU:
-			*(va_arg(args, uint16_t *)) = sco_opt.mtu;
-			break;
-		case BT_IO_OPT_HANDLE:
-			if (sco_get_info(sock, &handle, dev_class) < 0) {
-				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
-				return FALSE;
-			}
-			*(va_arg(args, uint16_t *)) = handle;
-			break;
-		case BT_IO_OPT_CLASS:
-			if (sco_get_info(sock, &handle, dev_class) < 0) {
-				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
-				return FALSE;
-			}
-			memcpy(va_arg(args, uint8_t *), dev_class, 3);
-			break;
-		default:
-			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
-					"Unknown option %d", opt);
-			return FALSE;
-		}
-
-		opt = va_arg(args, int);
-	}
-
-	return TRUE;
-}
-
 static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 						BtIOOption opt1, va_list args)
 {
@@ -1032,13 +886,10 @@ static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 	sock = g_io_channel_unix_get_fd(io);
 
 	switch (type) {
-	case BT_IO_L2RAW:
 	case BT_IO_L2CAP:
 		return l2cap_get(sock, err, opt1, args);
 	case BT_IO_RFCOMM:
 		return rfcomm_get(sock, err, opt1, args);
-	case BT_IO_SCO:
-		return sco_get(sock, err, opt1, args);
 	}
 
 	g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
@@ -1127,18 +978,6 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 	GIOChannel *io;
 
 	switch (type) {
-	case BT_IO_L2RAW:
-		sock = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
-		if (sock < 0) {
-			ERROR_FAILED(err, "socket(RAW, L2CAP)", errno);
-			return NULL;
-		}
-		if (l2cap_bind(sock, &opts->src,
-					server ? opts->psm : 0, err) < 0)
-			goto failed;
-		if (!l2cap_set(sock, opts->sec_level, 0, 0, 0, -1, err))
-			goto failed;
-		break;
 	case BT_IO_L2CAP:
 		sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
 		if (sock < 0) {
@@ -1164,17 +1003,6 @@ static GIOChannel *create_io(BtIOType type, gboolean server,
 		if (!rfcomm_set(sock, opts->sec_level, opts->master, err))
 			goto failed;
 		break;
-	case BT_IO_SCO:
-		sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
-		if (sock < 0) {
-			ERROR_FAILED(err, "socket(SEQPACKET, SCO)", errno);
-			return NULL;
-		}
-		if (sco_bind(sock, &opts->src, err) < 0)
-			goto failed;
-		if (!sco_set(sock, opts->mtu, err))
-			goto failed;
-		break;
 	default:
 		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
 				"Unknown BtIO type %d", type);
@@ -1218,18 +1046,12 @@ GIOChannel *bt_io_connect(BtIOType type, BtIOConnect connect,
 	sock = g_io_channel_unix_get_fd(io);
 
 	switch (type) {
-	case BT_IO_L2RAW:
-		err = l2cap_connect(sock, &opts.dst, 0);
-		break;
 	case BT_IO_L2CAP:
 		err = l2cap_connect(sock, &opts.dst, opts.psm);
 		break;
 	case BT_IO_RFCOMM:
 		err = rfcomm_connect(sock, &opts.dst, opts.channel);
 		break;
-	case BT_IO_SCO:
-		err = sco_connect(sock, &opts.dst);
-		break;
 	default:
 		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
 						"Unknown BtIO type %d", type);
@@ -1259,12 +1081,6 @@ GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
 	int sock;
 	gboolean ret;
 
-	if (type == BT_IO_L2RAW) {
-		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
-				"Server L2CAP RAW sockets not supported");
-		return NULL;
-	}
-
 	va_start(args, opt1);
 	ret = parse_set_opts(&opts, err, opt1, args);
 	va_end(args);
diff --git a/btio/btio.h b/btio/btio.h
index e9dcc9f..591ceee 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright (C) 2010  Intel Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -38,10 +39,8 @@ typedef enum {
 GQuark bt_io_error_quark(void);
 
 typedef enum {
-	BT_IO_L2RAW,
 	BT_IO_L2CAP,
 	BT_IO_RFCOMM,
-	BT_IO_SCO,
 } BtIOType;
 
 typedef enum {
-- 
1.7.0.4

