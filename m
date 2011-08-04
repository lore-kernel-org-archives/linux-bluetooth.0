Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 3/7] sap: add Connected signal on SimAccess client interface
Date: Thu,  4 Aug 2011 16:39:30 -0300
Message-Id: <1312486774-20350-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1312486774-20350-3-git-send-email-padovan@profusion.mobi>
References: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Connected signal has three possible values: "disconnected", "connecting"
and "connected". It tracks the Bluetooth RFCOMM channel status only,
there isn't relation between this signal and SAP protocol messages.
---
 sap/client.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/sap/client.c b/sap/client.c
index b0ddb5d..4bb8b49 100644
--- a/sap/client.c
+++ b/sap/client.c
@@ -40,6 +40,12 @@
 
 static DBusConnection *connection;
 
+enum {
+	DISCONNECTED = 0,
+	CONNECTING,
+	CONNECTED
+};
+
 struct client {
 	bdaddr_t	sba;		/* Source Bluetooth address */
 	bdaddr_t	dba;		/* Destination Bluetooth address */
@@ -49,6 +55,7 @@ struct client {
 	char		*agent_path;	/* Agent D-Bus path */
 	guint		agent_watch;	/* Agent D-Bus watch id */
 	GIOChannel	*io;		/* BtIO Channel */
+	int		state;
 	DBusMessage	*msg;
 };
 
@@ -67,6 +74,20 @@ static void client_free(struct client *client)
 	g_free(client);
 }
 
+static const char *state2str(int i)
+{
+	switch (i) {
+	case DISCONNECTED:
+		return "disconnected";
+	case CONNECTING:
+		return "connecting";
+	case CONNECTED:
+		return "connected";
+	default:
+		return "";
+	}
+}
+
 static void path_unregister(void *data)
 {
 	struct client *client = data;
@@ -77,10 +98,34 @@ static void path_unregister(void *data)
 	client_free(client);
 }
 
+static void change_state(struct client *client, int new_state)
+{
+	const char *val = state2str(new_state);
+
+	client->state = new_state;
+
+	emit_property_changed(connection, client->path,
+			SAP_INTERFACE, "State",
+			DBUS_TYPE_STRING, &val);
+}
+
+static gboolean rfcomm_io(GIOChannel *io, GIOCondition cond, gpointer data)
+{
+	struct client *client = data;
+
+	info("RFCOMM disconnected");
+
+	change_state(client, DISCONNECTED);
+
+	return FALSE;
+}
+
 static void rfcomm_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
 {
 	struct client *client = data;
 	DBusMessage *reply;
+	GIOCondition cond;
+	int new_state;
 
 	if (gerr) {
 		error("%s", gerr->message);
@@ -89,6 +134,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
 		g_io_channel_unref(client->io);
 		client->io = NULL;
 
+		new_state = DISCONNECTED;
 		goto failed;
 	}
 
@@ -98,10 +144,32 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
 
 	/* TODO: Enable SAP messages forwarding */
 
+	info("RFCOMM connected");
+	new_state = CONNECTED;
+
+	cond = G_IO_NVAL | G_IO_HUP | G_IO_ERR;
+	g_io_add_watch(chan, cond, rfcomm_io, data);
+
 failed:
 	g_dbus_send_message(connection, reply);
 	dbus_message_unref(client->msg);
 	client->msg = NULL;
+
+	change_state(client, new_state);
+}
+
+static void agent_exited(DBusConnection *conn, void *data)
+{
+	struct client *client = data;
+
+	debug("Agent %s exited", client->agent_name);
+
+	g_free(client->agent_name);
+	g_free(client->agent_path);
+
+	client->agent_name = NULL;
+	client->agent_path = NULL;
+	client->agent_watch = 0;
 }
 
 static DBusMessage *client_connect(DBusConnection *conn,
@@ -132,6 +200,7 @@ static DBusMessage *client_connect(DBusConnection *conn,
 	}
 
 	client->msg = dbus_message_ref(msg);
+	change_state(client, CONNECTING);
 
 	return NULL;
 }
@@ -152,18 +221,32 @@ static DBusMessage *client_disconnect(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static void agent_exited(DBusConnection *conn, void *data)
+static DBusMessage *get_properties(DBusConnection *conn,
+		DBusMessage *msg, void *data)
 {
 	struct client *client = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *value;
 
-	DBG("Agent %s exited", client->agent_name);
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
 
-	g_free(client->agent_name);
-	g_free(client->agent_path);
+	dbus_message_iter_init_append(reply, &iter);
 
-	client->agent_name = NULL;
-	client->agent_path = NULL;
-	client->agent_watch = 0;
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	value = state2str(client->state);
+	dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &value);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
 }
 
 static DBusMessage *register_agent(DBusConnection *conn,
@@ -226,6 +309,7 @@ static GDBusMethodTable client_methods[] = {
 		G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	client_disconnect,
 		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetProperties",	"",	"a{sv}", get_properties},
 	{ "RegisterAgent",	"o", "",	register_agent},
 	{ "UnregisterAgent",	"", "",		unregister_agent},
 	{ NULL, NULL, NULL, NULL }
@@ -258,6 +342,7 @@ int sap_client_register(const char *path,
 	bacpy(&client->dba, dba);
 	client->channel = channel;
 	client->path = g_strdup(path);
+	client->state = DISCONNECTED;
 
 	if (!g_dbus_register_interface(connection, path,
 				SAP_INTERFACE, client_methods, client_signals, NULL,
-- 
1.7.6

