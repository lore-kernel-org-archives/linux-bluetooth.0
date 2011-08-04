Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 6/7] sap: send file descriptor to the registered agent
Date: Thu,  4 Aug 2011 16:39:33 -0300
Message-Id: <1312486774-20350-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1312486774-20350-6-git-send-email-padovan@profusion.mobi>
References: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-3-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-4-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-5-git-send-email-padovan@profusion.mobi>
 <1312486774-20350-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

When the RFCOMM connection is established properly, the socket value
must be passed to the registered agent using NewConnection method call.
---
 sap/client.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/sap/client.c b/sap/client.c
index 93ba54d..f68b133 100644
--- a/sap/client.c
+++ b/sap/client.c
@@ -73,6 +73,44 @@ static void agent_free(struct agent *agent)
 	g_free(agent);
 }
 
+static gboolean agent_sendfd(struct agent *agent, int fd,
+		DBusPendingCallNotifyFunction notify, void *data)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+
+	msg = dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.SimAccessServerAgent", "NewConnection");
+
+	dbus_message_append_args(msg,
+			DBUS_TYPE_UNIX_FD, &fd,
+			DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(connection, msg, &call, -1) == FALSE)
+		return FALSE;
+
+	dbus_pending_call_set_notify(call, notify, data, NULL);
+	dbus_pending_call_unref(call);
+
+	return TRUE;
+}
+
+static void agent_release(struct agent *agent)
+{
+	DBusMessage *msg;
+
+	if (!agent)
+		return;
+
+	msg = dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.SimAccessServerAgent", "Release");
+
+	dbus_message_set_no_reply(msg, TRUE);
+	g_dbus_send_message(connection, msg);
+
+	g_dbus_remove_watch(connection, agent->watch);
+}
+
 static void client_free(struct client *client)
 {
 	if (client->msg)
@@ -107,6 +145,7 @@ static void path_unregister(void *data)
 	info("Unregistered interface %s on path %s",
 			SAP_INTERFACE, client->path);
 
+	agent_release(client->agent);
 	client_free(client);
 }
 
@@ -155,12 +194,36 @@ static gboolean rfcomm_io(GIOChannel *io, GIOCondition cond, gpointer data)
 	return FALSE;
 }
 
+static void newconnection_reply(DBusPendingCall *call, void *data)
+{
+	struct client *client = data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	if (!client->io) {
+		DBG("RFCOMM disconnected from server before agent reply");
+		return;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		info("Agent reply: file descriptor passed successfuly");
+		return;
+	}
+
+	DBG("Agent reply: %s", derr.message);
+	DBG("Disconnecting from SIM Access server ...");
+
+	dbus_error_free(&derr);
+	disconnect_rfcomm(client);
+}
+
 static void rfcomm_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
 {
 	struct client *client = data;
 	DBusMessage *reply;
 	GIOCondition cond;
-	int new_state;
+	int new_state, fd;
 
 	if (gerr) {
 		error("%s", gerr->message);
@@ -174,17 +237,22 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
 	}
 
 	g_io_channel_set_encoding(chan, NULL, NULL);
-
-	reply = dbus_message_new_method_return(client->msg);
-
-	/* TODO: Enable SAP messages forwarding */
+	fd = g_io_channel_unix_get_fd(chan);
 
 	info("RFCOMM connected");
+
 	new_state = CONNECTED;
 
 	cond = G_IO_NVAL | G_IO_HUP | G_IO_ERR;
 	g_io_add_watch(chan, cond, rfcomm_io, data);
 
+	if (!agent_sendfd(client->agent, fd, newconnection_reply, client)) {
+		reply = btd_error_failed(client->msg,
+						"Can not pass file descriptor");
+		disconnect_rfcomm(client);
+	} else
+		reply = dbus_message_new_method_return(client->msg);
+
 failed:
 	g_dbus_send_message(connection, reply);
 	dbus_message_unref(client->msg);
-- 
1.7.6

