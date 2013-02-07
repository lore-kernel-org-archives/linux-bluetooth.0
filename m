Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/14] neard: Add support for setting power state in RequestOOB reply
Date: Thu, 7 Feb 2013 09:13:58 +0100
Message-ID: <1360224844-12280-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows neard to properly set Bluetooth carrier power state in
handover message.
---
 plugins/neard.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/plugins/neard.c b/plugins/neard.c
index 0418430..0bd376b 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -173,6 +173,19 @@ unregister:
 							AGENT_INTERFACE);
 }
 
+static void add_power_state(DBusMessageIter *dict, struct btd_adapter *adapter)
+{
+	const char *state;
+
+	if (btd_adapter_get_powered(adapter) &&
+			btd_adapter_get_connectable(adapter))
+		state = "active";
+	else
+		state = "inactive";
+
+	dict_append_entry(dict, "State", DBUS_TYPE_STRING, &state);
+}
+
 static DBusMessage *create_request_oob_reply(struct btd_adapter *adapter,
 						const uint8_t *hash,
 						const uint8_t *randomizer,
@@ -208,6 +221,8 @@ static DBusMessage *create_request_oob_reply(struct btd_adapter *adapter,
 
 	dict_append_array(&dict, "EIR", DBUS_TYPE_BYTE, &peir, len);
 
+	add_power_state(&dict, adapter);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
-- 
1.8.1.1

