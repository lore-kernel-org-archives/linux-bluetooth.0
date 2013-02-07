Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/14] neard: Restrict method calls only to neard process
Date: Thu, 7 Feb 2013 09:14:00 +0100
Message-ID: <1360224844-12280-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
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
index 20cfe03..9351ac5 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -637,6 +637,10 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	uint8_t io_cap;
 	int err;
 
+	if (neard_path == NULL ||
+			!g_str_equal(neard_path, dbus_message_get_sender(msg)))
+		return error_reply(msg, EPERM);
+
 	DBG("");
 
 	adapter = btd_adapter_get_default();
@@ -714,6 +718,10 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 	struct btd_device *device;
 	int err;
 
+	if (neard_path == NULL ||
+			!g_str_equal(neard_path, dbus_message_get_sender(msg)))
+		return error_reply(msg, EPERM);
+
 	DBG("");
 
 	adapter = btd_adapter_get_default();
@@ -776,6 +784,10 @@ read_local:
 static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
+	if (neard_path == NULL ||
+			!g_str_equal(neard_path, dbus_message_get_sender(msg)))
+		return error_reply(msg, EPERM);
+
 	DBG("");
 
 	g_free(neard_path);
-- 
1.8.1.1

