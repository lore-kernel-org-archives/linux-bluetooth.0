Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/10 v2] neard: Make use of g_dbus_send_message_with_reply
Date: Tue, 20 Aug 2013 16:07:13 +0300
Message-Id: <1377004035-16936-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1377004035-16936-1-git-send-email-luiz.dentz@gmail.com>
References: <1377004035-16936-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces dbus_connection_send_with_reply with
g_dbus_send_message_with_reply which does not alter message order.
---
 plugins/neard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index e4a4d71..ea91c4d 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -158,7 +158,7 @@ static void register_agent(bool append_carrier)
 		dbus_message_append_args(message, DBUS_TYPE_STRING, &carrier,
 							DBUS_TYPE_INVALID);
 
-	if (!dbus_connection_send_with_reply(btd_get_dbus_connection(),
+	if (!g_dbus_send_message_with_reply(btd_get_dbus_connection(),
 							message, &call, -1)) {
 		dbus_message_unref(message);
 		error("D-Bus send failed");
-- 
1.8.3.1

