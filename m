Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/13] btio: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:29 +0100
Message-Id: <1417541318-24259-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 btio/btio.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/btio/btio.c b/btio/btio.c
index 4ec286c..db731fa 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -875,6 +875,12 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_VOICE:
 			opts->voice = va_arg(args, int);
 			break;
+		case BT_IO_OPT_INVALID:
+		case BT_IO_OPT_KEY_SIZE:
+		case BT_IO_OPT_SOURCE_CHANNEL:
+		case BT_IO_OPT_DEST_CHANNEL:
+		case BT_IO_OPT_HANDLE:
+		case BT_IO_OPT_CLASS:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1141,6 +1147,13 @@ parse_opts:
 			}
 			*(va_arg(args, uint32_t *)) = priority;
 			break;
+		case BT_IO_OPT_INVALID:
+		case BT_IO_OPT_SOURCE_TYPE:
+		case BT_IO_OPT_CHANNEL:
+		case BT_IO_OPT_SOURCE_CHANNEL:
+		case BT_IO_OPT_DEST_CHANNEL:
+		case BT_IO_OPT_MTU:
+		case BT_IO_OPT_VOICE:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1274,6 +1287,19 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 			}
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
 			break;
+		case BT_IO_OPT_SOURCE_TYPE:
+		case BT_IO_OPT_DEST_TYPE:
+		case BT_IO_OPT_KEY_SIZE:
+		case BT_IO_OPT_PSM:
+		case BT_IO_OPT_CID:
+		case BT_IO_OPT_MTU:
+		case BT_IO_OPT_OMTU:
+		case BT_IO_OPT_IMTU:
+		case BT_IO_OPT_MODE:
+		case BT_IO_OPT_FLUSHABLE:
+		case BT_IO_OPT_PRIORITY:
+		case BT_IO_OPT_VOICE:
+		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1359,6 +1385,22 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			}
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
 			break;
+		case BT_IO_OPT_SOURCE_TYPE:
+		case BT_IO_OPT_DEST_TYPE:
+		case BT_IO_OPT_DEFER_TIMEOUT:
+		case BT_IO_OPT_SEC_LEVEL:
+		case BT_IO_OPT_KEY_SIZE:
+		case BT_IO_OPT_CHANNEL:
+		case BT_IO_OPT_SOURCE_CHANNEL:
+		case BT_IO_OPT_DEST_CHANNEL:
+		case BT_IO_OPT_PSM:
+		case BT_IO_OPT_CID:
+		case BT_IO_OPT_MASTER:
+		case BT_IO_OPT_MODE:
+		case BT_IO_OPT_FLUSHABLE:
+		case BT_IO_OPT_PRIORITY:
+		case BT_IO_OPT_VOICE:
+		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1385,6 +1427,7 @@ static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
 		return rfcomm_get(sock, err, opt1, args);
 	case BT_IO_SCO:
 		return sco_get(sock, err, opt1, args);
+	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Unknown BtIO type %d", type);
@@ -1452,6 +1495,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 		return rfcomm_set(sock, opts.sec_level, opts.master, err);
 	case BT_IO_SCO:
 		return sco_set(sock, opts.mtu, opts.voice, err);
+	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Unknown BtIO type %d", type);
@@ -1522,6 +1566,7 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		if (!sco_set(sock, opts->mtu, opts->voice, err))
 			goto failed;
 		break;
+	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Unknown BtIO type %d", opts->type);
@@ -1575,6 +1620,7 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
 	case BT_IO_SCO:
 		err = sco_connect(sock, &opts.dst);
 		break;
+	case BT_IO_INVALID:
 	default:
 		g_set_error(gerr, BT_IO_ERROR, EINVAL,
 					"Unknown BtIO type %d", opts.type);
-- 
1.9.1

