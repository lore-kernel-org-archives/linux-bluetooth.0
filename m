Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  2/2] tools: Fix Invalid return
Date: Thu, 01 Oct 2015 17:19:00 +0530
Message-id: <1443700140-3905-2-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1443700140-3905-1-git-send-email-bharat.panda@samsung.com>
References: <1443700140-3905-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return DBUS_HANDLER_RESULT_HANDLED instead of
DBUS_HANDLER_RESULT_NOT_YET_HANDLED for player message handle.
---
 tools/mpris-proxy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 693055e..2a5cbae 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -205,6 +205,7 @@ static void append_container(DBusMessageIter *base, DBusMessageIter *iter,
 	case DBUS_TYPE_ARRAY:
 	case DBUS_TYPE_VARIANT:
 		sig = dbus_message_iter_get_signature(&iter_sub);
+		printf("signature: %s\n", sig);
 		break;
 	default:
 		sig = NULL;
@@ -406,7 +407,7 @@ static DBusHandlerResult player_message(DBusConnection *conn,
 done:
 	dbus_message_unref(copy);
 
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
 static struct player *find_player_by_bus_name(const char *name)
-- 
1.9.1

