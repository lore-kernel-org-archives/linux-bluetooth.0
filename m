Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH] Fix managing dbus filters depending on BT state
Date: Mon, 22 Nov 2010 11:56:22 +0100
Message-Id: <1290423382-5493-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously even if BT was disabled, bluetoothd would handle some dbus
singals (mostly connected with HFP). Now filters are added when
BT is enabled and removed when BT is disabled.
---
 audio/manager.c          |    4 ++--
 audio/telephony-dummy.c  |   10 ++++++++++
 audio/telephony-maemo5.c |   10 ++++++++++
 audio/telephony-maemo6.c |   10 ++++++++++
 audio/telephony-ofono.c  |   10 ++++++++++
 audio/telephony.h        |    1 +
 src/adapter.c            |    5 +++++
 7 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 816c807..2fc7bf1 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1178,7 +1178,7 @@ proceed:
 		btd_register_adapter_driver(&media_server_driver);
 
 	if (enabled.headset) {
-		telephony_init();
+		telephony_set_state(1);
 		btd_register_adapter_driver(&headset_server_driver);
 	}
 
@@ -1220,7 +1220,7 @@ void audio_manager_exit(void)
 
 	if (enabled.headset) {
 		btd_unregister_adapter_driver(&headset_server_driver);
-		telephony_exit();
+		telephony_set_state(0);
 	}
 
 	if (enabled.gateway)
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 06cb798..ef7c5fa 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -57,6 +57,8 @@ static gboolean events_enabled = FALSE;
  */
 static int response_and_hold = -1;
 
+static int telephony_state = 0;
+
 static struct indicator dummy_indicators[] =
 {
 	{ "battchg",	"0-5",	5,	TRUE },
@@ -411,8 +413,16 @@ static GDBusSignalTable dummy_signals[] = {
 	{ }
 };
 
+int telephony_set_state(int state)
+{
+	telephony_state = state;
+}
+
 int telephony_init(void)
 {
+	if (telephony_state == 0)
+		return;
+
 	uint32_t features = AG_FEATURE_REJECT_A_CALL |
 				AG_FEATURE_ENHANCED_CALL_STATUS |
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 4d0134c..1dd5449 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -222,6 +222,8 @@ static char *last_dialed_number = NULL;
 /* Timer for tracking call creation requests */
 static guint create_request_timer = 0;
 
+static int telephony_state = 0;
+
 static struct indicator maemo_indicators[] =
 {
 	{ "battchg",	"0-5",	5,	TRUE },
@@ -2044,8 +2046,16 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
+int telephony_set_state(int state)
+{
+	telephony_state = state;
+}
+
 int telephony_init(void)
 {
+	if (telephony_state == 0)
+		return;
+
 	const char *battery_cap = "battery";
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
 				AG_FEATURE_INBAND_RINGTONE |
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 72c8e36..916dcb8 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -181,6 +181,8 @@ static char *last_dialed_number = NULL;
 /* Timer for tracking call creation requests */
 static guint create_request_timer = 0;
 
+static int telephony_state = 0;
+
 static struct indicator maemo_indicators[] =
 {
 	{ "battchg",	"0-5",	5,	TRUE },
@@ -1937,8 +1939,16 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
+int telephony_set_state(int state)
+{
+	telephony_state = state;
+}
+
 int telephony_init(void)
 {
+	if (telephony_state == 0)
+		return;
+
 	const char *battery_cap = "battery";
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
 				AG_FEATURE_INBAND_RINGTONE |
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 693207c..fe3ae19 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -96,6 +96,8 @@ static gboolean events_enabled = FALSE;
  */
 static int response_and_hold = -1;
 
+static int telephony_state = 0;
+
 static struct indicator ofono_indicators[] =
 {
 	{ "battchg",	"0-5",	5,	TRUE },
@@ -1062,8 +1064,16 @@ done:
 	dbus_message_unref(reply);
 }
 
+int telephony_set_state(int state)
+{
+	telephony_state = state;
+}
+
 int telephony_init(void)
 {
+	if (telephony_state == 0)
+		return;
+
 	const char *battery_cap = "battery";
 	int ret;
 
diff --git a/audio/telephony.h b/audio/telephony.h
index 5343e8c..9b80e56 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -232,5 +232,6 @@ static inline int telephony_get_indicator(const struct indicator *indicators,
 	return -ENOENT;
 }
 
+int telephony_set_active(int state);
 int telephony_init(void);
 void telephony_exit(void);
diff --git a/src/adapter.c b/src/adapter.c
index 6b4a354..8ed2040 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -57,6 +57,7 @@
 #include "glib-helper.h"
 #include "agent.h"
 #include "storage.h"
+#include "../audio/telephony.h"
 
 #define IO_CAPABILITY_DISPLAYONLY	0x00
 #define IO_CAPABILITY_DISPLAYYESNO	0x01
@@ -2404,6 +2405,8 @@ int adapter_start(struct btd_adapter *adapter)
 
 	err = adapter_up(adapter, mode);
 
+	telephony_init();
+
 	info("Adapter %s has been enabled", adapter->path);
 
 	return err;
@@ -2533,6 +2536,8 @@ int adapter_stop(struct btd_adapter *adapter)
 
 	call_adapter_powered_callbacks(adapter, FALSE);
 
+	telephony_exit();
+
 	info("Adapter %s has been disabled", adapter->path);
 
 	set_mode_complete(adapter);
-- 
1.7.0.4

