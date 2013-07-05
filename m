Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 2/6] btio: Add option for SCO voice setting
Date: Fri,  5 Jul 2013 17:46:43 +0200
Message-Id: <1373039207-20959-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 btio/btio.c |   18 +++++++++++++++---
 btio/btio.h |    1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index cb8860a..032a5fa 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -78,6 +78,7 @@ struct set_opts {
 	uint8_t mode;
 	int flushable;
 	uint32_t priority;
+	uint16_t voice;
 };
 
 struct connect {
@@ -723,9 +724,10 @@ static int sco_connect(int sock, const bdaddr_t *dst)
 	return 0;
 }
 
-static gboolean sco_set(int sock, uint16_t mtu, GError **err)
+static gboolean sco_set(int sock, uint16_t mtu, uint16_t voice, GError **err)
 {
 	struct sco_options sco_opt;
+	struct bt_voice bt_voice;
 	socklen_t len;
 
 	if (!mtu)
@@ -745,6 +747,13 @@ static gboolean sco_set(int sock, uint16_t mtu, GError **err)
 		return FALSE;
 	}
 
+	bt_voice.setting = voice;
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_VOICE, &bt_voice,
+						sizeof(bt_voice)) < 0) {
+		ERROR_FAILED(err, "setsockopt(BT_VOICE)", errno);
+		return FALSE;
+	}
+
 	return TRUE;
 }
 
@@ -832,6 +841,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_PRIORITY:
 			opts->priority = va_arg(args, int);
 			break;
+		case BT_IO_OPT_VOICE:
+			opts->voice = va_arg(args, int);
+			break;
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1310,7 +1322,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	case BT_IO_RFCOMM:
 		return rfcomm_set(sock, opts.sec_level, opts.master, err);
 	case BT_IO_SCO:
-		return sco_set(sock, opts.mtu, err);
+		return sco_set(sock, opts.mtu, opts.voice, err);
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Unknown BtIO type %d", type);
@@ -1377,7 +1389,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		}
 		if (sco_bind(sock, &opts->src, err) < 0)
 			goto failed;
-		if (!sco_set(sock, opts->mtu, err))
+		if (!sco_set(sock, opts->mtu, opts->voice, err))
 			goto failed;
 		break;
 	default:
diff --git a/btio/btio.h b/btio/btio.h
index ac1366b..2dce9f0 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -55,6 +55,7 @@ typedef enum {
 	BT_IO_OPT_MODE,
 	BT_IO_OPT_FLUSHABLE,
 	BT_IO_OPT_PRIORITY,
+	BT_IO_OPT_VOICE,
 } BtIOOption;
 
 typedef enum {
-- 
1.7.9.5

