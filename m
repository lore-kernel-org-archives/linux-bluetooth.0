Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] obexd: Clean up unneeded list in src/obex.c
Message-ID: <1f42874f-efcf-f50c-ef2b-a9b709d93db4@jp.fujitsu.com>
Date: Tue, 23 Jan 2018 18:45:34 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cleans up the sessions list which has been unneeded by commit 8572afb4
("obexd: Make use of transport drivers and some cleanups").
---
 obexd/src/obex.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 308e56d07..a4bae857f 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -54,8 +54,6 @@
 #include "service.h"
 #include "transport.h"
 
-static GSList *sessions = NULL;
-
 typedef struct {
 	uint8_t  version;
 	uint8_t  flags;
@@ -233,8 +231,6 @@ static void os_reset_session(struct obex_session *os)
 
 static void obex_session_free(struct obex_session *os)
 {
-	sessions = g_slist_remove(sessions, os);
-
 	if (os->io) {
 		g_io_channel_shutdown(os->io, TRUE, NULL);
 		g_io_channel_unref(os->io);
@@ -1067,8 +1063,6 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
 	obex_getsockname(os, &os->src);
 	obex_getpeername(os, &os->dst);
 
-	sessions = g_slist_prepend(sessions, os);
-
 	return 0;
 }
 
-- 
2.14.1

