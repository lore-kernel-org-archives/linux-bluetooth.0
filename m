Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd] client: fix possible glib assertion failure
Date: Thu, 26 Jan 2012 16:33:44 +0100
Message-Id: <1327592024-1644-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

In case of error there might be no io channel to shutdown.
---
 client/bluetooth.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/client/bluetooth.c b/client/bluetooth.c
index 3441d4b..558c408 100644
--- a/client/bluetooth.c
+++ b/client/bluetooth.c
@@ -269,9 +269,11 @@ static void search_callback(uint8_t type, uint16_t status,
 	}
 
 failed:
-	g_io_channel_shutdown(session->io, TRUE, NULL);
-	g_io_channel_unref(session->io);
-	session->io = NULL;
+	if (session->io != NULL) {
+		g_io_channel_shutdown(session->io, TRUE, NULL);
+		g_io_channel_unref(session->io);
+		session->io = NULL;
+	}
 
 	g_set_error(&gerr, OBC_BT_ERROR, -EIO,
 					"Unable to find service record");
-- 
1.7.6.5

