Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] add btd_error_agent_not_assigned()
Date: Wed, 15 Dec 2010 19:29:26 -0200
Message-Id: <1292448568-16854-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    3 +--
 src/adapter.c   |    3 +--
 src/error.c     |    6 ++++++
 src/error.h     |    1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 4d38be7..6a095ca 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -367,8 +367,7 @@ static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
 	int err;
 
 	if (!gw->agent)
-		return g_dbus_create_error(msg, ERROR_INTERFACE
-				".Failed", "Agent not assigned");
+		return btd_error_agent_not_assigned(msg);
 
 	err = get_records(au_dev);
 	if (err < 0)
diff --git a/src/adapter.c b/src/adapter.c
index 2ff59a0..73c8a9b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1412,8 +1412,7 @@ static DBusMessage *request_session(DBusConnection *conn,
 	int err;
 
 	if (!adapter->agent)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"No agent registered");
+		return btd_error_agent_not_assigned(msg);
 
 	if (!adapter->mode_sessions)
 		adapter->global_mode = adapter->mode;
diff --git a/src/error.c b/src/error.c
index 3a78628..25f89f6 100644
--- a/src/error.c
+++ b/src/error.c
@@ -115,6 +115,12 @@ DBusMessage *btd_error_no_such_adapter(DBusMessage *msg)
 					"No such adapter");
 }
 
+DBusMessage *btd_error_agent_not_assigned(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".AgentNotAssigned",
+					"Agent Not Assigned");
+}
+
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE
diff --git a/src/error.h b/src/error.h
index faaef0a..0f2eb22 100644
--- a/src/error.h
+++ b/src/error.h
@@ -41,4 +41,5 @@ DBusMessage *btd_error_in_progress(DBusMessage *msg);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
 DBusMessage *btd_error_not_authorized(DBusMessage *msg);
 DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
+DBusMessage *btd_error_agent_not_assigned(DBusMessage *msg);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
-- 
1.7.3.2

