Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [PATCH obexd] tools: Fix test-client error message put/get typo
Date: Tue, 12 Jun 2012 03:37:37 +0200
Message-Id: <1339465057-1562-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/test-client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/test-client.c b/tools/test-client.c
index a28d43c..81a2be0 100644
--- a/tools/test-client.c
+++ b/tools/test-client.c
@@ -181,7 +181,7 @@ static void cmd_get(int argc, char **argv)
 						G_OBEX_HDR_NAME, argv[1],
 						G_OBEX_HDR_INVALID);
 	if (err != NULL) {
-		g_printerr("put failed: %s\n", err->message);
+		g_printerr("get failed: %s\n", err->message);
 		g_error_free(err);
 		close(data->fd);
 		g_free(data);
-- 
1.7.8.4

