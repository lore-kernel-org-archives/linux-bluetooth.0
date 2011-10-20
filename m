Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Audio: add adapter to telephony_init/_exit
Date: Thu, 20 Oct 2011 15:52:17 +0200
Message-Id: <1319118738-20131-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
References: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/manager.c          |    4 ++--
 audio/telephony-dummy.c  |    4 ++--
 audio/telephony-maemo5.c |    4 ++--
 audio/telephony-maemo6.c |    4 ++--
 audio/telephony-ofono.c  |    4 ++--
 audio/telephony.h        |    4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 7ec0311..993c064 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -881,7 +881,7 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 		/* telephony driver already initialized*/
 		if (telephony == TRUE)
 			return;
-		telephony_init();
+		telephony_init(adapter);
 		telephony = TRUE;
 		return;
 	}
@@ -897,7 +897,7 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 			return;
 	}
 
-	telephony_exit();
+	telephony_exit(adapter);
 	telephony = FALSE;
 }
 
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 657e2d3..ae1d5f0 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -396,7 +396,7 @@ static GDBusSignalTable dummy_signals[] = {
 	{ }
 };
 
-int telephony_init(void)
+int telephony_init(void *adapter)
 {
 	uint32_t features = AG_FEATURE_REJECT_A_CALL |
 				AG_FEATURE_ENHANCED_CALL_STATUS |
@@ -421,7 +421,7 @@ int telephony_init(void)
 	return 0;
 }
 
-void telephony_exit(void)
+void telephony_exit(void *adapter)
 {
 	DBG("");
 
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 51c0985..bb5b1e5 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -2029,7 +2029,7 @@ static DBusHandlerResult signal_filter(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-int telephony_init(void)
+int telephony_init(void *adapter)
 {
 	const char *battery_cap = "battery";
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
@@ -2090,7 +2090,7 @@ int telephony_init(void)
 	return 0;
 }
 
-void telephony_exit(void)
+void telephony_exit(void *adapter)
 {
 	g_slist_foreach(calls, (GFunc) csd_call_free, NULL);
 	g_slist_free(calls);
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index cd6856d..d496dbe 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -2110,7 +2110,7 @@ done:
 	remove_pending(call);
 }
 
-int telephony_init(void)
+int telephony_init(void *adapter)
 {
 	const char *battery_cap = "battery";
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
@@ -2166,7 +2166,7 @@ static void remove_watch(gpointer data)
 	g_dbus_remove_watch(connection, GPOINTER_TO_UINT(data));
 }
 
-void telephony_exit(void)
+void telephony_exit(void *adapter)
 {
 	DBG("");
 
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 4cb4aa5..9ea9874 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -1546,7 +1546,7 @@ static void handle_service_disconnect(DBusConnection *conn, void *user_data)
 		modem_removed(modem_obj_path);
 }
 
-int telephony_init(void)
+int telephony_init(void *adapter)
 {
 	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
 				AG_FEATURE_INBAND_RINGTONE |
@@ -1616,7 +1616,7 @@ static void pending_free(void *data)
 	dbus_pending_call_unref(call);
 }
 
-void telephony_exit(void)
+void telephony_exit(void *adapter)
 {
 	DBG("");
 
diff --git a/audio/telephony.h b/audio/telephony.h
index ecd6d09..64a8bd8 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -85,5 +85,5 @@ struct TelephonyDBusTable {
 
 struct TelephonyDBusTable *telephony_dbus_table(void);
 
-int telephony_init(void);
-void telephony_exit(void);
+int telephony_init(void *adapter);
+void telephony_exit(void *adapter);
-- 
1.7.1

