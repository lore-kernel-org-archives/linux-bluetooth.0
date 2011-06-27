Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/6] Add system bus connection in obex-client
Date: Tue, 28 Jun 2011 00:39:36 +0300
Message-Id: <1309210781-2674-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection to system bus is added in obex-client. Purpose is to carry
out OBEX transfers within a single adapter's session.
---
 client/session.c |    9 +++++++++
 client/session.h |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/client/session.c b/client/session.c
index 266d00c..4a4922f 100644
--- a/client/session.c
+++ b/client/session.c
@@ -201,6 +201,9 @@ static void session_free(struct session_data *session)
 		dbus_connection_unref(session->conn);
 	}
 
+	if (session->conn_system)
+		dbus_connection_unref(session->conn_system);
+
 	sessions = g_slist_remove(sessions, session);
 
 	g_free(session->callback);
@@ -565,6 +568,12 @@ struct session_data *session_create(const char *source,
 		return NULL;
 	}
 
+	session->conn_system = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (session->conn_system == NULL) {
+		session_free(session);
+		return NULL;
+	}
+
 	if (source == NULL)
 		bacpy(&session->src, BDADDR_ANY);
 	else
diff --git a/client/session.h b/client/session.h
index 6f8a434..554b494 100644
--- a/client/session.h
+++ b/client/session.h
@@ -42,6 +42,7 @@ struct session_data {
 	uuid_t uuid;		/* Bluetooth Service Class */
 	gchar *path;		/* Session path */
 	DBusConnection *conn;
+	DBusConnection *conn_system; /* system bus connection */
 	DBusMessage *msg;
 	GwObex *obex;
 	GIOChannel *io;
-- 
1.7.4.1

