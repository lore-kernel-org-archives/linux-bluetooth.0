Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Get mode option for L2CAP sockets
Date: Mon, 18 Oct 2010 15:21:42 +0200
Message-Id: <1287408102-25344-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 btio/btio.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 2f719b1..d8439e0 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -839,6 +839,9 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			}
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
 			break;
+		case BT_IO_OPT_MODE:
+			*(va_arg(args, uint8_t *)) = l2o.mode;
+			break;
 		default:
 			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
 					"Unknown option %d", opt);
-- 
1.7.3.1

