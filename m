Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 6/6] bt tool: add cmd 'adapter'
Date: Mon,  8 Oct 2012 06:49:57 +0800
Message-Id: <1349650197-18751-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
References: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

'bt adapter' sets adapter properties Powered, Name, Pairable,
PairableTimeout, Discoverable, DiscoverableTimeout.
---
 client/main.c | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 178 insertions(+), 7 deletions(-)

diff --git a/client/main.c b/client/main.c
index aeb47e4..115d7ed 100644
--- a/client/main.c
+++ b/client/main.c
@@ -74,6 +74,12 @@ struct cmd_struct {
 	GSourceFunc	fn;
 };
 
+struct subcmd_methods {
+	const char	*subcmd;
+	const char	*dbus_name;
+	int		dbus_type;
+};
+
 struct find_adapter_cb_data {
 	GSourceFunc		fn;
 	struct cmd_param	*param;
@@ -94,15 +100,22 @@ static void show_help()
 	printf("usage: %s [-i interface] <command> [<args>]\n"
 	"\n"
 	"options:\n"
-	"	-i <hci dev>, --interface <hci dev>	HCI device\n"
-	"	--help					This help\n"
-	"	--version				Version\n"
+	"	-i <dev>, --interface <dev>	HCI device\n"
+	"	--help				This help\n"
+	"	--version			Version\n"
 	"\n"
 	"commands:\n"
-	"	discover				Scan for devices\n"
-	"	pair <device address>			Start pairing\n"
-	"	agent					Run BlueZ agent\n"
-	"	remove					Remove a paired device\n"
+	"	discove				Scan for devices\n"
+	"	pair <device address>		Start pairing\n"
+	"	agent				Run BlueZ agent\n"
+	"	remove				Remove a paired device\n"
+	"	adapter\n"
+	"		powered			Set adapter's powered state\n"
+	"		name			Set adapter's name\n"
+	"		discoverable		Set adapter's discoverable state\n"
+	"		discoverabletimeout	Set adapter's discoverable timeout\n"
+	"		pairable		Set adapter's pairable state\n"
+	"		pairabletimeout		Set adapter's pairable timeout\n"
 							"\n", program_name);
 
 	if(mainloop != NULL)
@@ -283,6 +296,67 @@ static gboolean send_with_reply_and_set_notify(DBusMessage *msg,
 	return TRUE;
 }
 
+static void bluetooth_property_append_basic(DBusMessageIter *iter,
+					const char *key, int type, void *val)
+{
+	DBusMessageIter value;
+	const char *signature;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &key);
+
+	switch (type) {
+	case DBUS_TYPE_BOOLEAN:
+		signature = DBUS_TYPE_BOOLEAN_AS_STRING;
+		break;
+	case DBUS_TYPE_STRING:
+		signature = DBUS_TYPE_STRING_AS_STRING;
+		break;
+	case DBUS_TYPE_UINT32:
+		signature = DBUS_TYPE_UINT32_AS_STRING;
+		break;
+	default:
+		signature = DBUS_TYPE_VARIANT_AS_STRING;
+		break;
+	}
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+							signature, &value);
+	dbus_message_iter_append_basic(&value, type, val);
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static gboolean bluetooth_append_args(DBusMessage *msg,
+					struct subcmd_methods *m, char *param)
+{
+	DBusMessageIter iter;
+	unsigned int value;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	switch (m->dbus_type) {
+	case DBUS_TYPE_STRING:
+		bluetooth_property_append_basic(&iter, m->dbus_name,
+							m->dbus_type, &param);
+	case DBUS_TYPE_UINT32:
+		value = atol(param);
+		bluetooth_property_append_basic(&iter, m->dbus_name,
+						m->dbus_type, &value);
+	case DBUS_TYPE_BOOLEAN:
+		if (g_str_equal(param, "yes"))
+			value = TRUE;
+		else if (g_str_equal(param, "no"))
+			value = FALSE;
+		else
+			return FALSE;
+
+		bluetooth_property_append_basic(&iter, m->dbus_name,
+						m->dbus_type, &value);
+		break;
+	}
+
+	return TRUE;
+}
+
 static DBusMessage *agent_request_confirmation(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -829,6 +903,42 @@ static void find_device_reply(DBusPendingCall *pending, void *user_data)
 	dbus_pending_call_unref(pending);
 }
 
+static void set_property_reply(DBusPendingCall *pending, void *user_data)
+{
+	DBusMessage *reply;
+	DBusError err;
+
+	if (!pending)
+		return;
+
+	dbus_pending_call_ref(pending);
+
+	reply = dbus_pending_call_steal_reply(pending);
+	if (!reply) {
+		ERR("Failed to find SetProperty() reply");
+		exit(1);
+	}
+
+	dbus_error_init(&err);
+	if (!dbus_message_get_args(reply, &err, DBUS_TYPE_INVALID)) {
+		if (dbus_error_is_set(&err)) {
+			ERR("Failed to set property: %s", err.message);
+			dbus_error_free(&err);
+		}
+		exit(1);
+	}
+
+	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR) {
+		ERR("SetProperty() failed");
+		exit(1);
+	}
+
+	dbus_message_unref(reply);
+	dbus_pending_call_unref(pending);
+
+	g_main_loop_quit(mainloop);
+}
+
 /* Listen for Bluetooth devices broadcasting their availability, then display
  * the results */
 static gboolean cmd_discover(gpointer data)
@@ -964,6 +1074,66 @@ static gboolean cmd_remove(gpointer data)
 	return retval;
 }
 
+static struct subcmd_methods adapter_m[] = {
+	{ "powered",		 "Powered",		DBUS_TYPE_BOOLEAN},
+	{ "name",                "Name",		DBUS_TYPE_STRING},
+	{ "discoverable",        "Discoverable",	DBUS_TYPE_BOOLEAN},
+	{ "discoverabletimeout", "DiscoverableTimeout",	DBUS_TYPE_UINT32},
+	{ "pairable",	         "Pairable",		DBUS_TYPE_BOOLEAN},
+	{ "pairabletimeout",     "PairableTimeout",	DBUS_TYPE_UINT32},
+	{  NULL,                 NULL,                  DBUS_TYPE_INVALID},
+};
+
+static gboolean cmd_adapter(gpointer data)
+{
+	struct cmd_param *p = data;
+	char *subcmd, *param;
+	struct subcmd_methods *m;
+	DBusMessage *msg;
+	int i;
+
+	subcmd = p->argv[0];
+	p->argc--;
+	if (!subcmd) {
+		ERR("%s: missing command paramenter", program_name);
+		show_help();
+		exit(1);
+	}
+
+	param = p->argv[1];
+
+	for (i = 0; i < ARRAY_SIZE(adapter_m); i++) {
+		m = adapter_m+i;
+		if (!m->subcmd) {
+			ERR("%s: command not found", program_name);
+			show_help();
+			exit(1);
+		}
+
+		if (g_str_equal(m->subcmd, subcmd))
+			break;
+	}
+
+	if (!(msg = create_method_call(p->path, BLUEZ_ADAPTER, "SetProperty")))
+		return FALSE;
+
+	if (!bluetooth_append_args(msg, m, param)) {
+		ERR("%s: parameter not understood", program_name);
+		show_help();
+		exit(1);
+	}
+
+	if (!send_with_reply_and_set_notify(msg, set_property_reply, NULL,
+									NULL)) {
+		ERR("Not enough memory for message send");
+		return FALSE;
+	}
+
+	dbus_message_unref(msg);
+
+	return FALSE;
+}
+
 static void run_func(const char *adapter_path, GSourceFunc fn,
 							struct cmd_param *param)
 {
@@ -1096,6 +1266,7 @@ static struct cmd_struct commands[] = {
 	{ "pair", cmd_pair},
 	{ "agent", cmd_agent},
 	{ "remove", cmd_remove},
+	{ "adapter", cmd_adapter},
 };
 
 /* Returns FALSE in case the command could not be parsed. Any failures during
-- 
1.7.11.4

