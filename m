Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] audio/media: Make use of g_dbus_send_message_with_reply
Date: Mon, 19 Aug 2013 17:32:58 +0300
Message-Id: <1376922779-11802-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
References: <1376922779-11802-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces dbus_connection_send_with_reply with
g_dbus_send_message_with_reply which does not alter message order.
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 5a06b99..9c72b8d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -325,7 +325,7 @@ static gboolean media_endpoint_async_call(DBusMessage *msg,
 	request = g_new0(struct endpoint_request, 1);
 
 	/* Timeout should be less than avdtp request timeout (4 seconds) */
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(),
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(),
 						msg, &request->call,
 						REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
-- 
1.8.3.1

