Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/17] SAP: Fix missing setting conn->io to NULL after unref
Date: Wed, 6 Jun 2012 15:19:17 +0200
Message-ID: <1338988767-19467-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

conn->io should be set to NULl after unref to avoid calling shutdown
and unref twice.
---
 sap/server.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sap/server.c b/sap/server.c
index f66e23f..c385baa 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -567,6 +567,7 @@ static gboolean guard_timeout(gpointer data)
 		if (conn->io) {
 			g_io_channel_shutdown(conn->io, TRUE, NULL);
 			g_io_channel_unref(conn->io);
+			conn->io = NULL;
 		}
 		break;
 
@@ -686,6 +687,7 @@ int sap_disconnect_rsp(void *sap_device)
 		if (conn->io) {
 			g_io_channel_shutdown(conn->io, TRUE, NULL);
 			g_io_channel_unref(conn->io);
+			conn->io = NULL;
 		}
 
 		return 0;
-- 
on behalf of ST-Ericsson

