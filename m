Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 3/4] btio: Add option for SCO socket mode
Date: Wed, 30 Jan 2013 18:03:03 +0100
Message-Id: <1359565384-4656-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1359565384-4656-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359565384-4656-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 btio/btio.c |   11 ++++++++---
 btio/btio.h |    1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index bbf1208..f9afc36 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -77,6 +77,7 @@ struct set_opts {
 	uint8_t mode;
 	int flushable;
 	uint32_t priority;
+	uint8_t sco_mode;
 };
 
 struct connect {
@@ -720,7 +721,7 @@ static int sco_connect(int sock, const bdaddr_t *dst)
 	return 0;
 }
 
-static gboolean sco_set(int sock, uint16_t mtu, GError **err)
+static gboolean sco_set(int sock, uint16_t mtu, uint8_t mode, GError **err)
 {
 	struct sco_options sco_opt;
 	socklen_t len;
@@ -736,6 +737,7 @@ static gboolean sco_set(int sock, uint16_t mtu, GError **err)
 	}
 
 	sco_opt.mtu = mtu;
+	sco_opt.mode = mode;
 	if (setsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt,
 						sizeof(sco_opt)) < 0) {
 		ERROR_FAILED(err, "setsockopt(SCO_OPTIONS)", errno);
@@ -825,6 +827,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_PRIORITY:
 			opts->priority = va_arg(args, int);
 			break;
+		case BT_IO_OPT_SCO_MODE:
+			opts->sco_mode = va_arg(args, int);
+			break;
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1303,7 +1308,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.master, err);
 	case BT_IO_SCO:
-		return sco_set(sock, opts.mtu, err);
+		return sco_set(sock, opts.mtu, opts.sco_mode, err);
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Unknown BtIO type %d", type);
@@ -1370,7 +1375,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		}
 		if (sco_bind(sock, &opts->src, err) < 0)
 			goto failed;
-		if (!sco_set(sock, opts->mtu, err))
+		if (!sco_set(sock, opts->mtu, opts->sco_mode, err))
 			goto failed;
 		break;
 	default:
diff --git a/btio/btio.h b/btio/btio.h
index a6ff5a2..e6ef990 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -54,6 +54,7 @@ typedef enum {
 	BT_IO_OPT_MODE,
 	BT_IO_OPT_FLUSHABLE,
 	BT_IO_OPT_PRIORITY,
+	BT_IO_OPT_SCO_MODE,
 } BtIOOption;
 
 typedef enum {
-- 
1.7.9.5

