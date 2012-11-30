Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/8] attrib: Fix possible use after free
Date: Fri, 30 Nov 2012 12:25:00 +0100
Message-ID: <1354274703-15604-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
References: <1354274703-15604-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move io channels unrefs after last use of channels.
---
 src/attrib-server.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 8e20903..1a9bd69 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -127,13 +127,13 @@ static void gatt_server_free(struct gatt_server *server)
 	g_list_free_full(server->database, attrib_free);
 
 	if (server->l2cap_io != NULL) {
-		g_io_channel_unref(server->l2cap_io);
 		g_io_channel_shutdown(server->l2cap_io, FALSE, NULL);
+		g_io_channel_unref(server->l2cap_io);
 	}
 
 	if (server->le_io != NULL) {
-		g_io_channel_unref(server->le_io);
 		g_io_channel_shutdown(server->le_io, FALSE, NULL);
+		g_io_channel_unref(server->le_io);
 	}
 
 	g_slist_free_full(server->clients, (GDestroyNotify) channel_free);
-- 
1.7.9.5

