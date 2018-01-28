Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gdbus: Fail to send NULL messages
Date: Sun, 28 Jan 2018 11:50:30 -0200
Message-Id: <20180128135030.18468-2-luiz.dentz@gmail.com>
In-Reply-To: <20180128135030.18468-1-luiz.dentz@gmail.com>
References: <20180128135030.18468-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should make it safe to call g_dbus_send_message with a NULL
message which is more likely to happen now that g_dbus_create_reply
returns NULL when the message is marked with NO_REPLY flag.
---
 gdbus/object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index e572c9f01..617ab5eda 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1502,6 +1502,9 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 {
 	dbus_bool_t result = FALSE;
 
+	if (!message)
+		return FALSE;
+
 	if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_METHOD_CALL)
 		dbus_message_set_no_reply(message, TRUE);
 	else if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_SIGNAL) {
-- 
2.14.3

