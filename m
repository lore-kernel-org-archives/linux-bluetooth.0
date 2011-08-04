Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/7] sap: handle agent exit case
Date: Thu,  4 Aug 2011 16:39:31 -0300
Message-Id: <1312486774-20350-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1312486774-20350-4-git-send-email-padovan@profusion.mobi>
References: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-3-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Also create struct agent
---
 sap/client.c |   66 ++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/sap/client.c b/sap/client.c
index 4bb8b49..435a82f 100644
--- a/sap/client.c
+++ b/sap/client.c
@@ -46,19 +46,33 @@ enum {
 	CONNECTED
 };
 
+struct agent {
+	char *name;		/* Bus id */
+	char *path;		/* D-Bus path */
+	guint watch;		/* Disconnect watch */
+};
+
 struct client {
 	bdaddr_t	sba;		/* Source Bluetooth address */
 	bdaddr_t	dba;		/* Destination Bluetooth address */
 	uint8_t		channel;	/* SAP RFCOMM channel */
 	char		*path;		/* Device path */
-	char		*agent_name;	/* Agent bus id	*/
-	char		*agent_path;	/* Agent D-Bus path */
-	guint		agent_watch;	/* Agent D-Bus watch id */
 	GIOChannel	*io;		/* BtIO Channel */
 	int		state;
+	struct agent	*agent;
 	DBusMessage	*msg;
 };
 
+static void agent_free(struct agent *agent)
+{
+	if (!agent)
+		return;
+
+	g_free(agent->name);
+	g_free(agent->path);
+	g_free(agent);
+}
+
 static void client_free(struct client *client)
 {
 	if (client->msg)
@@ -68,9 +82,7 @@ static void client_free(struct client *client)
 		g_io_channel_unref(client->io);
 	}
 
-	g_free(client->agent_name);
-	g_free(client->agent_path);
-	g_free(client->path);
+	agent_free(client->agent);
 	g_free(client);
 }
 
@@ -117,6 +129,11 @@ static gboolean rfcomm_io(GIOChannel *io, GIOCondition cond, gpointer data)
 
 	change_state(client, DISCONNECTED);
 
+	if (client->io) {
+		g_io_channel_unref(client->io);
+		client->io = NULL;
+	}
+
 	return FALSE;
 }
 
@@ -161,15 +178,12 @@ failed:
 static void agent_exited(DBusConnection *conn, void *data)
 {
 	struct client *client = data;
+	struct agent *agent = client->agent;
 
-	debug("Agent %s exited", client->agent_name);
-
-	g_free(client->agent_name);
-	g_free(client->agent_path);
+	DBG("Agent %s exited", agent->name);
 
-	client->agent_name = NULL;
-	client->agent_path = NULL;
-	client->agent_watch = 0;
+	agent_free(agent);
+	client->agent = NULL;
 }
 
 static DBusMessage *client_connect(DBusConnection *conn,
@@ -182,7 +196,7 @@ static DBusMessage *client_connect(DBusConnection *conn,
 	if (client->io)
 		return btd_error_already_connected(msg);
 
-	if (!client->agent_watch)
+	if (!client->agent)
 		return btd_error_agent_not_available(msg);
 
 	client->io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, client,
@@ -253,9 +267,10 @@ static DBusMessage *register_agent(DBusConnection *conn,
 			DBusMessage *msg, void *data)
 {
 	struct client *client = data;
+	struct agent *agent;
 	const char *path, *name;
 
-	if (client->agent_name)
+	if (client->agent)
 		return btd_error_already_exists(msg);
 
 	if (!dbus_message_get_args(msg, NULL,
@@ -264,11 +279,14 @@ static DBusMessage *register_agent(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	name = dbus_message_get_sender(msg);
-	client->agent_name = strdup(name);
-	client->agent_path = strdup(path);
-	client->agent_watch = g_dbus_add_disconnect_watch(conn, name,
+	agent = g_new0(struct agent, 1);
+	agent->name = strdup(name);
+	agent->path = strdup(path);
+	agent->watch = g_dbus_add_disconnect_watch(conn, name,
 			agent_exited, client, NULL);
 
+	client->agent = agent;
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -276,9 +294,10 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 			DBusMessage *msg, void *data)
 {
 	struct client *client = data;
+	struct agent *agent;
 	const char *path;
 
-	if (!client->agent_watch)
+	if (!client->agent)
 		goto done;
 
 	agent = client->agent;
@@ -292,14 +311,11 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	if (strcmp(agent->path, path) != 0)
 		return btd_error_invalid_args(msg);
 
-	g_free(client->agent_name);
-	client->agent_name = NULL;
+	g_dbus_remove_watch(conn, agent->watch);
 
-	g_free(client->agent_path);
-	client->agent_path = NULL;
+	agent_free(agent);
+	client->agent = NULL;
 
-	g_dbus_remove_watch(conn, client->agent_watch);
-	client->agent_watch = 0;
 done:
 	return dbus_message_new_method_return(msg);
 }
-- 
1.7.6

