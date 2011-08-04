Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/7] sap: add SAP client agent
Date: Thu,  4 Aug 2011 16:39:29 -0300
Message-Id: <1312486774-20350-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
References: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Introduces SAP client agent registration to handle outgoing SAP
connections. When the RFCOMM connection is established the file
descriptor associated to this connection will be passed to the
registered agent. SAP client plugin should not handle SAP messages, it
act simply as a proxy between the server and the agent. Agents can be oFono
driver or any other aplication interested on manage the remote SIM.
---
 sap/client.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/sap/client.c b/sap/client.c
index 231b4ef..b0ddb5d 100644
--- a/sap/client.c
+++ b/sap/client.c
@@ -45,6 +45,9 @@ struct client {
 	bdaddr_t	dba;		/* Destination Bluetooth address */
 	uint8_t		channel;	/* SAP RFCOMM channel */
 	char		*path;		/* Device path */
+	char		*agent_name;	/* Agent bus id	*/
+	char		*agent_path;	/* Agent D-Bus path */
+	guint		agent_watch;	/* Agent D-Bus watch id */
 	GIOChannel	*io;		/* BtIO Channel */
 	DBusMessage	*msg;
 };
@@ -58,6 +61,8 @@ static void client_free(struct client *client)
 		g_io_channel_unref(client->io);
 	}
 
+	g_free(client->agent_name);
+	g_free(client->agent_path);
 	g_free(client->path);
 	g_free(client);
 }
@@ -109,6 +114,9 @@ static DBusMessage *client_connect(DBusConnection *conn,
 	if (client->io)
 		return btd_error_already_connected(msg);
 
+	if (!client->agent_watch)
+		return btd_error_agent_not_available(msg);
+
 	client->io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, client,
 			NULL, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &client->sba,
@@ -144,11 +152,82 @@ static DBusMessage *client_disconnect(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static void agent_exited(DBusConnection *conn, void *data)
+{
+	struct client *client = data;
+
+	DBG("Agent %s exited", client->agent_name);
+
+	g_free(client->agent_name);
+	g_free(client->agent_path);
+
+	client->agent_name = NULL;
+	client->agent_path = NULL;
+	client->agent_watch = 0;
+}
+
+static DBusMessage *register_agent(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct client *client = data;
+	const char *path, *name;
+
+	if (client->agent_name)
+		return btd_error_already_exists(msg);
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	name = dbus_message_get_sender(msg);
+	client->agent_name = strdup(name);
+	client->agent_path = strdup(path);
+	client->agent_watch = g_dbus_add_disconnect_watch(conn, name,
+			agent_exited, client, NULL);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct client *client = data;
+	const char *path;
+
+	if (!client->agent_watch)
+		goto done;
+
+	agent = client->agent;
+	if (strcmp(agent->name, dbus_message_get_sender(msg)) != 0)
+		return btd_error_not_authorized(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	if (strcmp(agent->path, path) != 0)
+		return btd_error_invalid_args(msg);
+
+	g_free(client->agent_name);
+	client->agent_name = NULL;
+
+	g_free(client->agent_path);
+	client->agent_path = NULL;
+
+	g_dbus_remove_watch(conn, client->agent_watch);
+	client->agent_watch = 0;
+done:
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable client_methods[] = {
 	{ "Connect",		"",	"",	client_connect,
 		G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	client_disconnect,
 		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RegisterAgent",	"o", "",	register_agent},
+	{ "UnregisterAgent",	"", "",		unregister_agent},
 	{ NULL, NULL, NULL, NULL }
 };
 
-- 
1.7.6

