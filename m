Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] add btd_error_agent_not_available()
Date: Thu, 16 Dec 2010 15:58:07 -0200
Message-Id: <1292522289-15173-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    3 +--
 src/adapter.c   |    3 +--
 src/error.c     |    6 ++++++
 src/error.h     |    1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 655047d..43a4b02 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -369,8 +369,7 @@ static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (!gw->agent)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-				".Failed", "Agent not assigned");
+		return btd_error_agent_not_available(msg);
 
 	err = get_records(au_dev);
 	if (err < 0)
diff --git a/src/adapter.c b/src/adapter.c
index 2ff59a0..a36d2b1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1412,8 +1412,7 @@ static DBusMessage *request_session(DBusConnection *conn,
 	int err;
 
 	if (!adapter->agent)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"No agent registered");
+		return btd_error_agent_not_available(msg);
 
 	if (!adapter->mode_sessions)
 		adapter->global_mode = adapter->mode;
diff --git a/src/error.c b/src/error.c
index 1ee98c8..ebfc614 100644
--- a/src/error.c
+++ b/src/error.c
@@ -97,6 +97,12 @@ DBusMessage *btd_error_no_such_adapter(DBusMessage *msg)
 					"No such adapter");
 }
 
+DBusMessage *btd_error_agent_not_available(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".AgentNotAvailable",
+					"Agent Not Available");
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
diff --git a/src/error.h b/src/error.h
index f346c07..ffd4332 100644
--- a/src/error.h
+++ b/src/error.h
@@ -38,4 +38,5 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
 DBusMessage *btd_error_not_authorized(DBusMessage *msg);
 DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
+DBusMessage *btd_error_agent_not_available(DBusMessage *msg);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
-- 
1.7.3.2

