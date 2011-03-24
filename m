Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix error message when getting SCO connection handle
Date: Thu, 24 Mar 2011 14:09:52 +0200
Message-Id: <1300968593-25442-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Error message should indicate the transport correctly which is SCO
not RFCOMM.
---
 btio/btio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d8439e0..3f5b69a 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1020,14 +1020,14 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			break;
 		case BT_IO_OPT_HANDLE:
 			if (sco_get_info(sock, &handle, dev_class) < 0) {
-				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
+				ERROR_FAILED(err, "SCO_CONNINFO", errno);
 				return FALSE;
 			}
 			*(va_arg(args, uint16_t *)) = handle;
 			break;
 		case BT_IO_OPT_CLASS:
 			if (sco_get_info(sock, &handle, dev_class) < 0) {
-				ERROR_FAILED(err, "RFCOMM_CONNINFO", errno);
+				ERROR_FAILED(err, "SCO_CONNINFO", errno);
 				return FALSE;
 			}
 			memcpy(va_arg(args, uint8_t *), dev_class, 3);
-- 
1.7.1

