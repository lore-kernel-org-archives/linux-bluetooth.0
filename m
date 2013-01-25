Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools: Fix format string warnings for g_dbus_create_error
Date: Fri, 25 Jan 2013 18:28:10 +0900
Message-id: <1359106090-31381-1-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
References: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes gcc warnings for "format not a string literal and no
format arguments".
---
 tools/mpris-player.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 95ef8ab..aafa142 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -830,7 +830,7 @@ static void player_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, message)) {
 		fprintf(stderr, "error: %s", err.name);
-		reply = g_dbus_create_error(msg, err.name, err.message);
+		reply = g_dbus_create_error(msg, err.name, "%s", err.message);
 		dbus_error_free(&err);
 	} else
 		reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-- 
1.7.10.4

