Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/3] Fix dbus reply memory leak
Date: Thu, 24 Nov 2011 19:44:34 +0530
Message-id: <1322144076-1913-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-maemo5.c |    8 ++++----
 cups/main.c              |   30 +++++++++++++++++++++++++-----
 test/agent.c             |    2 ++
 test/mpris-player.c      |    6 +++++-
 4 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 23801c0..2832062 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1599,12 +1599,12 @@ static void signal_strength_reply(DBusPendingCall *call, void *user_data)
 		error("Unable to parse signal_strength reply: %s, %s",
 							err.name, err.message);
 		dbus_error_free(&err);
-		return;
+		goto done;
 	}
 
 	if (net_err != 0) {
 		error("get_signal_strength failed with code %d", net_err);
-		return;
+		goto done;
 	}
 
 	update_signal_strength(signals_bar);
@@ -1654,12 +1654,12 @@ static void registration_status_reply(DBusPendingCall *call, void *user_data)
 		error("Unable to parse registration_status_change reply:"
 					" %s, %s", err.name, err.message);
 		dbus_error_free(&err);
-		return;
+		goto done;
 	}
 
 	if (net_err != 0) {
 		error("get_registration_status failed with code %d", net_err);
-		return;
+		goto done;
 	}
 
 	update_registration_status(status, lac, cell_id, operator_code,
diff --git a/cups/main.c b/cups/main.c
index 7f3f4b0..a884c6e 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -348,10 +348,15 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 
 		dbus_message_unref(message);
 
+		if (!adapter_reply)
+			return;
+
 		if (dbus_message_get_args(adapter_reply, NULL,
 					DBUS_TYPE_OBJECT_PATH, &adapter,
-					DBUS_TYPE_INVALID) == FALSE)
+					DBUS_TYPE_INVALID) == FALSE) {
+			dbus_message_unref(adapter_reply);
 			return;
+		}
 	}
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
@@ -386,12 +391,16 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 
 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_OBJECT_PATH, &object_path,
-					DBUS_TYPE_INVALID) == FALSE)
+					DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(reply);
 		return;
+	}
 
 	id = device_get_ieee1284_id(adapter, object_path);
 	add_device_to_list(name, bdaddr, id);
 	g_free(id);
+
+	dbus_message_unref(reply);
 }
 
 static void discovery_completed(void)
@@ -642,10 +651,15 @@ static gboolean print_ieee1284(const char *bdaddr)
 
 	dbus_message_unref(message);
 
+	if (!adapter_reply)
+		return FALSE;
+
 	if (dbus_message_get_args(adapter_reply, NULL,
 			DBUS_TYPE_OBJECT_PATH, &adapter,
-			DBUS_TYPE_INVALID) == FALSE)
+			DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(adapter_reply);
 		return FALSE;
+	}
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
 			"org.bluez.Adapter",
@@ -680,15 +694,21 @@ static gboolean print_ieee1284(const char *bdaddr)
 
 	if (dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_OBJECT_PATH, &object_path,
-					DBUS_TYPE_INVALID) == FALSE)
+					DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(reply);
 		return FALSE;
+	}
 
 	id = device_get_ieee1284_id(adapter, object_path);
-	if (id == NULL)
+	if (id == NULL) {
+		dbus_message_unref(reply);
 		return FALSE;
+	}
 	printf("%s", id);
 	g_free(id);
 
+	dbus_message_unref(reply);
+
 	return TRUE;
 }
 
diff --git a/test/agent.c b/test/agent.c
index ae74074..5cdeeb4 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -504,6 +504,7 @@ static char *get_default_adapter_path(DBusConnection *conn)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
@@ -562,6 +563,7 @@ static char *get_adapter_path(DBusConnection *conn, const char *adapter)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
diff --git a/test/mpris-player.c b/test/mpris-player.c
index a1632f3..a2c4cc6 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -700,6 +700,7 @@ static char *get_default_adapter(DBusConnection *conn)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
@@ -756,6 +757,7 @@ static char *get_adapter(DBusConnection *conn, const char *adapter)
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
+		dbus_message_unref(reply);
 		return NULL;
 	}
 
@@ -802,8 +804,10 @@ static char *get_name_owner(DBusConnection *conn, const char *name)
 
 	if (!dbus_message_get_args(reply, NULL,
 					DBUS_TYPE_STRING, &owner,
-					DBUS_TYPE_INVALID))
+					DBUS_TYPE_INVALID)) {
+		dbus_message_unref(reply);
 		return NULL;
+	}
 
 	owner = g_strdup(owner);
 
-- 
1.7.4.1

