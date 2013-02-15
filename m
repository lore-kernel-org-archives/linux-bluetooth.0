Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/6] neard: Restrict method calls only to neard process
Date: Fri, 15 Feb 2013 13:09:15 +0100
Message-ID: <1360930159-25658-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360930159-25658-1-git-send-email-szymon.janc@tieto.com>
References: <1360930159-25658-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disallow methods calls from processes other than registered to as
agent.
---
 plugins/neard.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/plugins/neard.c b/plugins/neard.c
index 650ee3e..88a6229 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -637,6 +637,10 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	uint8_t io_cap;
 	int err;
 
+	if (neard_service == NULL ||
+			!g_str_equal(neard_service, dbus_message_get_sender(msg)))
+		return error_reply(msg, EPERM);
+
 	DBG("");
 
 	adapter = btd_adapter_get_default();
@@ -714,6 +718,10 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 	struct btd_device *device;
 	int err;
 
+	if (neard_service == NULL ||
+			!g_str_equal(neard_service, dbus_message_get_sender(msg)))
+		return error_reply(msg, EPERM);
+
 	DBG("");
 
 	adapter = btd_adapter_get_default();
@@ -776,6 +784,10 @@ read_local:
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
+	if (neard_service == NULL ||
+			!g_str_equal(neard_service, dbus_message_get_sender(msg)))
+		return error_reply(msg, EPERM);
+
 	DBG("");
 
 	g_free(neard_service);
-- 
1.8.1.1

