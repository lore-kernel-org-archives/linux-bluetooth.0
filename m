Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13882C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 22:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377530AbiEEWvP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352168AbiEEWvO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 18:51:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F175DA3C
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 15:47:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x23so4780548pff.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kK1F8juaFJvW0vwoaHEhiqRDhbb6xLprQCuD2jOHV7g=;
        b=IoA3FK+vdq3WpyACiruwN5oMWvZIYRDlMrdc9dqwp+WNYDO6oeGsIgUPPgjd+CdAyA
         x3fSLBmGIlxJc2ds02rPcOp6Q+v58jsbqUNILa97FjAhXEXuRdWHoSlPsqtgPlZskJbw
         /uEvzsRFyHn++Ey0Z99cDwCkq3WYECKajuXWSAET66BBjAqNcDzRHIWNl2nQb5tbaIfD
         aJ1n7xUIl4VnzaspEyBoRB1WbPtxMLefkb0JbvrqxpnCz9K36AblVtmQIzpqRAuBviwj
         VV/A4iER7yS/rLvHqPCWFOVxjVredtcO99vfr0jiWC5Y71gOYS3NzKv+GjzBXLBBNs/7
         5S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kK1F8juaFJvW0vwoaHEhiqRDhbb6xLprQCuD2jOHV7g=;
        b=seN2wM6FDzcCBybnlB4GlrUuhlwQaJfurXaJKtzWzOpHvVdgyuIpAww7Q9REdclK56
         V7rMMZGK6KRZXSRYO/9BHkjd0eVsya7mtAi5iF+/dKwySCnDQjCJF84NoDHQFOGFI1np
         rAdAobcvFFmeiYulVXjX5f3fv4oj1CqNkV+7a+jFjYVGiKTFqBmeDQBWfYKUbMcsISbA
         4GGhaiouViplrTvmYkwcWC581UIwf4Em1O+mFsGc5qHR4Gsg3FSUc5IczPUQtPcAOawS
         jOXg9FRdBjCRq0bj+2nSxYTdg0Tejaf4QaqaByl2+t1qgW/9WHZYJeUln1Jsvl7UYVGU
         8dMw==
X-Gm-Message-State: AOAM532/WiFul6sI+w4PUIVCdAi5DX862QsabFjEiD/SgJuM/uTeDr8u
        15yErxiVG9cHnzd4tObWzxt57b8ACy0=
X-Google-Smtp-Source: ABdhPJx3kjYAld1YO5Cei3uOA8uiqMGuHa5Is9Gcc3gWLfR0XgGJK6iZg9tY/7K6wjYOMo7Y8jkycQ==
X-Received: by 2002:a05:6a00:84e:b0:510:5fbc:7738 with SMTP id q14-20020a056a00084e00b005105fbc7738mr291520pfk.86.1651790852417;
        Thu, 05 May 2022 15:47:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0015e8d4eb2aesm129651pld.248.2022.05.05.15.47.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:47:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] btio: Add support for ISO sockets
Date:   Thu,  5 May 2022 15:47:24 -0700
Message-Id: <20220505224727.3369989-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505224727.3369989-1-luiz.dentz@gmail.com>
References: <20220505224727.3369989-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to create objects that map to ISO sockets.
---
 btio/btio.c      | 170 +++++++++++++++++++++++++++++++++++++++++++++++
 btio/btio.h      |   4 +-
 tools/btiotest.c | 110 ++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index f4f53574c..75d17e7aa 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -27,6 +27,7 @@
 #include "lib/l2cap.h"
 #include "lib/rfcomm.h"
 #include "lib/sco.h"
+#include "lib/iso.h"
 
 #include "btio.h"
 
@@ -44,6 +45,7 @@ typedef enum {
 	BT_IO_L2CAP,
 	BT_IO_RFCOMM,
 	BT_IO_SCO,
+	BT_IO_ISO,
 	BT_IO_INVALID,
 } BtIOType;
 
@@ -66,6 +68,7 @@ struct set_opts {
 	int flushable;
 	uint32_t priority;
 	uint16_t voice;
+	struct bt_iso_qos qos;
 };
 
 struct connect {
@@ -123,6 +126,8 @@ static BtIOType bt_io_get_type(GIOChannel *io, GError **gerr)
 		return BT_IO_SCO;
 	case BTPROTO_L2CAP:
 		return BT_IO_L2CAP;
+	case BTPROTO_ISO:
+		return BT_IO_ISO;
 	default:
 		g_set_error(gerr, BT_IO_ERROR, EINVAL,
 					"Unknown BtIO socket type");
@@ -763,6 +768,24 @@ static int sco_bind(int sock, const bdaddr_t *src, GError **err)
 	return 0;
 }
 
+static int iso_bind(int sock, const bdaddr_t *src, uint8_t src_type,
+							GError **err)
+{
+	struct sockaddr_iso addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.iso_family = AF_BLUETOOTH;
+	bacpy(&addr.iso_bdaddr, src);
+	addr.iso_bdaddr_type = src_type;
+
+	if (!bind(sock, (struct sockaddr *) &addr, sizeof(addr)))
+		return 0;
+
+	ERROR_FAILED(err, "iso_bind", errno);
+
+	return -errno;
+}
+
 static int sco_connect(int sock, const bdaddr_t *dst)
 {
 	struct sockaddr_sco addr;
@@ -779,6 +802,23 @@ static int sco_connect(int sock, const bdaddr_t *dst)
 	return 0;
 }
 
+static int iso_connect(int sock, const bdaddr_t *dst, uint8_t dst_type)
+{
+	struct sockaddr_iso addr;
+	int err;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.iso_family = AF_BLUETOOTH;
+	bacpy(&addr.iso_bdaddr, dst);
+	addr.iso_bdaddr_type = dst_type;
+
+	err = connect(sock, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0 && !(errno == EAGAIN || errno == EINPROGRESS))
+		return -errno;
+
+	return 0;
+}
+
 static gboolean sco_set(int sock, uint16_t mtu, uint16_t voice, GError **err)
 {
 	struct sco_options sco_opt;
@@ -817,6 +857,17 @@ voice:
 	return TRUE;
 }
 
+static gboolean iso_set(int sock, struct bt_iso_qos *qos, GError **err)
+{
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_ISO_QOS, qos,
+				sizeof(*qos)) < 0) {
+		ERROR_FAILED(err, "setsockopt(BT_ISO_QOS)", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 						BtIOOption opt1, va_list args)
 {
@@ -894,6 +945,13 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 			break;
 		case BT_IO_OPT_MODE:
 			opts->mode = va_arg(args, int);
+			if (opts->mode == BT_IO_MODE_ISO) {
+				opts->type = BT_IO_ISO;
+				if (opts->src_type == BDADDR_BREDR)
+					opts->src_type = BDADDR_LE_PUBLIC;
+				if (opts->dst_type == BDADDR_BREDR)
+					opts->dst_type = BDADDR_LE_PUBLIC;
+			}
 			break;
 		case BT_IO_OPT_FLUSHABLE:
 			opts->flushable = va_arg(args, gboolean);
@@ -904,6 +962,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_VOICE:
 			opts->voice = va_arg(args, int);
 			break;
+		case BT_IO_OPT_QOS:
+			opts->qos = *va_arg(args, struct bt_iso_qos *);
+			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_KEY_SIZE:
 		case BT_IO_OPT_SOURCE_CHANNEL:
@@ -1227,6 +1288,7 @@ parse_opts:
 		case BT_IO_OPT_DEST_CHANNEL:
 		case BT_IO_OPT_MTU:
 		case BT_IO_OPT_VOICE:
+		case BT_IO_OPT_QOS:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1380,6 +1442,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 		case BT_IO_OPT_FLUSHABLE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
+		case BT_IO_OPT_QOS:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1489,6 +1552,95 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_FLUSHABLE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
+		case BT_IO_OPT_QOS:
+		case BT_IO_OPT_INVALID:
+		default:
+			g_set_error(err, BT_IO_ERROR, EINVAL,
+					"Unknown option %d", opt);
+			return FALSE;
+		}
+
+		opt = va_arg(args, int);
+	}
+
+	return TRUE;
+}
+
+static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
+{
+	BtIOOption opt = opt1;
+	struct sockaddr_iso src, dst;
+	struct bt_iso_qos qos;
+	socklen_t len;
+	uint32_t phy;
+
+	len = sizeof(qos);
+	memset(&qos, 0, len);
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
+		ERROR_FAILED(err, "getsockopt(BT_ISO_QOS)", errno);
+		return FALSE;
+	}
+
+	if (!get_src(sock, &src, sizeof(src), err))
+		return FALSE;
+
+	if (!get_dst(sock, &dst, sizeof(dst), err))
+		return FALSE;
+
+	while (opt != BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_SOURCE:
+			ba2str(&src.iso_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_SOURCE_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &src.iso_bdaddr);
+			break;
+		case BT_IO_OPT_SOURCE_TYPE:
+			*(va_arg(args, uint8_t *)) = src.iso_bdaddr_type;
+			break;
+		case BT_IO_OPT_DEST:
+			ba2str(&dst.iso_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_DEST_BDADDR:
+			bacpy(va_arg(args, bdaddr_t *), &dst.iso_bdaddr);
+			break;
+		case BT_IO_OPT_DEST_TYPE:
+			*(va_arg(args, uint8_t *)) = dst.iso_bdaddr_type;
+			break;
+		case BT_IO_OPT_MTU:
+			*(va_arg(args, uint16_t *)) = qos.out.sdu;
+			break;
+		case BT_IO_OPT_IMTU:
+			*(va_arg(args, uint16_t *)) = qos.in.sdu;
+			break;
+		case BT_IO_OPT_OMTU:
+			*(va_arg(args, uint16_t *)) = qos.out.sdu;
+			break;
+		case BT_IO_OPT_PHY:
+			if (get_phy(sock, &phy) < 0) {
+				ERROR_FAILED(err, "get_phy", errno);
+				return FALSE;
+			}
+			*(va_arg(args, uint32_t *)) = phy;
+			break;
+		case BT_IO_OPT_QOS:
+			*(va_arg(args, struct bt_iso_qos *)) = qos;
+			break;
+		case BT_IO_OPT_HANDLE:
+		case BT_IO_OPT_CLASS:
+		case BT_IO_OPT_DEFER_TIMEOUT:
+		case BT_IO_OPT_SEC_LEVEL:
+		case BT_IO_OPT_KEY_SIZE:
+		case BT_IO_OPT_CHANNEL:
+		case BT_IO_OPT_SOURCE_CHANNEL:
+		case BT_IO_OPT_DEST_CHANNEL:
+		case BT_IO_OPT_PSM:
+		case BT_IO_OPT_CID:
+		case BT_IO_OPT_CENTRAL:
+		case BT_IO_OPT_MODE:
+		case BT_IO_OPT_FLUSHABLE:
+		case BT_IO_OPT_PRIORITY:
+		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1516,6 +1668,8 @@ static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 		return rfcomm_get(sock, err, opt1, args);
 	case BT_IO_SCO:
 		return sco_get(sock, err, opt1, args);
+	case BT_IO_ISO:
+		return iso_get(sock, err, opt1, args);
 	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1584,6 +1738,8 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 		return rfcomm_set(sock, opts.sec_level, opts.central, err);
 	case BT_IO_SCO:
 		return sco_set(sock, opts.mtu, opts.voice, err);
+	case BT_IO_ISO:
+		return iso_set(sock, &opts.qos, err);
 	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1655,6 +1811,17 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		if (!sco_set(sock, opts->mtu, opts->voice, err))
 			goto failed;
 		break;
+	case BT_IO_ISO:
+		sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
+		if (sock < 0) {
+			ERROR_FAILED(err, "socket(SEQPACKET, ISO)", errno);
+			return NULL;
+		}
+		if (iso_bind(sock, &opts->src, opts->src_type, err) < 0)
+			goto failed;
+		if (!iso_set(sock, &opts->qos, err))
+			goto failed;
+		break;
 	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1719,6 +1886,9 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 	case BT_IO_SCO:
 		err = sco_connect(sock, &opts.dst);
 		break;
+	case BT_IO_ISO:
+		err = iso_connect(sock, &opts.dst, opts.dst_type);
+		break;
 	case BT_IO_INVALID:
 	default:
 		g_set_error(gerr, BT_IO_ERROR, EINVAL,
diff --git a/btio/btio.h b/btio/btio.h
index 50a2a4dc0..9636fd467 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -44,6 +44,7 @@ typedef enum {
 	BT_IO_OPT_PRIORITY,
 	BT_IO_OPT_VOICE,
 	BT_IO_OPT_PHY,
+	BT_IO_OPT_QOS,
 } BtIOOption;
 
 typedef enum {
@@ -58,7 +59,8 @@ typedef enum {
 	BT_IO_MODE_ERTM,
 	BT_IO_MODE_STREAMING,
 	BT_IO_MODE_LE_FLOWCTL,
-	BT_IO_MODE_EXT_FLOWCTL
+	BT_IO_MODE_EXT_FLOWCTL,
+	BT_IO_MODE_ISO
 } BtIOMode;
 
 typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
diff --git a/tools/btiotest.c b/tools/btiotest.c
index 70d74ffbe..193e1395b 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -29,6 +29,25 @@
 #define DEFAULT_ACCEPT_TIMEOUT 2
 static int opt_update_sec = 0;
 
+#define DEFAULT_IO_QOS \
+{ \
+	.interval = 10000, \
+	.latency = 10, \
+	.sdu = 40, \
+	.phy = 0x02, \
+	.rtn = 2, \
+}
+
+struct bt_iso_qos qos = {
+	.cig = BT_ISO_QOS_CIG_UNSET,
+	.cis = BT_ISO_QOS_CIG_UNSET,
+	.sca = 0x07,
+	.packing = 0x00,
+	.framing = 0x00,
+	.in = DEFAULT_IO_QOS,
+	.out = DEFAULT_IO_QOS,
+};
+
 struct io_data {
 	guint ref;
 	GIOChannel *io;
@@ -36,6 +55,7 @@ struct io_data {
 	int disconn;
 	int accept;
 	int voice;
+	struct bt_iso_qos *qos;
 };
 
 static void io_data_unref(struct io_data *data)
@@ -67,6 +87,7 @@ static struct io_data *io_data_new(GIOChannel *io, int reject, int disconn,
 	data->reject = reject;
 	data->disconn = disconn;
 	data->accept = accept;
+	data->qos = &qos;
 
 	return io_data_ref(data);
 }
@@ -530,9 +551,88 @@ static void sco_listen(const char *src, gboolean defer, int reject,
 	g_io_channel_unref(sco_srv);
 }
 
+static void iso_connect(const char *src, const char *dst, int disconn)
+{
+	struct io_data *data;
+	GError *err = NULL;
+
+	printf("Connecting ISO to %s\n", dst);
+
+	data = io_data_new(NULL, -1, disconn, -1);
+
+	if (src)
+		data->io = bt_io_connect(connect_cb, data,
+						(GDestroyNotify) io_data_unref,
+						&err,
+						BT_IO_OPT_SOURCE, src,
+						BT_IO_OPT_DEST, dst,
+						BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+						BT_IO_OPT_QOS, data->qos,
+						BT_IO_OPT_INVALID);
+	else
+		data->io = bt_io_connect(connect_cb, data,
+						(GDestroyNotify) io_data_unref,
+						&err,
+						BT_IO_OPT_DEST, dst,
+						BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+						BT_IO_OPT_QOS, data->qos,
+						BT_IO_OPT_INVALID);
+
+	if (!data->io) {
+		printf("Connecting to %s failed: %s\n", dst, err->message);
+		g_error_free(err);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void iso_listen(const char *src, gboolean defer, int reject,
+				int disconn, int accept)
+{
+	struct io_data *data;
+	BtIOConnect conn;
+	BtIOConfirm cfm;
+	GIOChannel *iso_srv;
+	GError *err = NULL;
+
+	printf("Listening for ISO connections\n");
+
+	if (defer) {
+		conn = NULL;
+		cfm = confirm_cb;
+	} else {
+		conn = connect_cb;
+		cfm = NULL;
+	}
+
+	data = io_data_new(NULL, reject, disconn, accept);
+
+	if (src)
+		iso_srv = bt_io_listen(conn, cfm, data,
+					(GDestroyNotify) io_data_unref,
+					&err,
+					BT_IO_OPT_SOURCE, src,
+					BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+					BT_IO_OPT_INVALID);
+	else
+		iso_srv = bt_io_listen(conn, cfm, data,
+					(GDestroyNotify) io_data_unref,
+					&err,
+					BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+					BT_IO_OPT_INVALID);
+
+	if (!iso_srv) {
+		printf("Listening failed: %s\n", err->message);
+		g_error_free(err);
+		exit(EXIT_FAILURE);
+	}
+
+	g_io_channel_unref(iso_srv);
+}
+
 static int opt_channel = -1;
 static int opt_psm = 0;
 static gboolean opt_sco = FALSE;
+static gboolean opt_iso = FALSE;
 static gboolean opt_defer = FALSE;
 static gint opt_voice = 0;
 static char *opt_dev = NULL;
@@ -559,6 +659,8 @@ static GOptionEntry options[] = {
 				"(0 BR/EDR 1 LE Public 2 LE Random" },
 	{ "sco", 's', 0, G_OPTION_ARG_NONE, &opt_sco,
 				"Use SCO" },
+	{ "iso", 'o', 0, G_OPTION_ARG_NONE, &opt_iso,
+				"Use ISO" },
 	{ "defer", 'd', 0, G_OPTION_ARG_NONE, &opt_defer,
 				"Use DEFER_SETUP for incoming connections" },
 	{ "voice", 'V', 0, G_OPTION_ARG_INT, &opt_voice,
@@ -637,6 +739,14 @@ int main(int argc, char *argv[])
 					opt_disconn, opt_accept, opt_voice);
 	}
 
+	if (opt_iso) {
+		if (argc > 1)
+			iso_connect(opt_dev, argv[1], opt_disconn);
+		else
+			iso_listen(opt_dev, opt_defer, opt_reject,
+					opt_disconn, opt_accept);
+	}
+
 	signal(SIGTERM, sig_term);
 	signal(SIGINT, sig_term);
 
-- 
2.35.1

