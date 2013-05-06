Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 08/13] dbus: Add state property to org.bluez.Service1
Date: Mon,  6 May 2013 10:43:25 +0200
Message-Id: <1367829810-8262-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a property representing the current state of the service, which
currently uses a simplified subset of the internal state.
---
 src/service.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/src/service.c b/src/service.c
index 9487c1a..fed8460 100644
--- a/src/service.c
+++ b/src/service.c
@@ -92,10 +92,27 @@ static const char *state2str(btd_service_state_t state)
 	return NULL;
 }
 
+static const char *state2dbus(btd_service_state_t state)
+{
+	switch (state) {
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+		return NULL;
+	case BTD_SERVICE_STATE_DISCONNECTED:
+	case BTD_SERVICE_STATE_CONNECTING:
+	case BTD_SERVICE_STATE_DISCONNECTING:
+		return "disconnected";
+	case BTD_SERVICE_STATE_CONNECTED:
+		return "connected";
+	}
+
+	return NULL;
+}
+
 static void change_state(struct btd_service *service, btd_service_state_t state,
 									int err)
 {
 	btd_service_state_t old = service->state;
+	DBusConnection *dbus_conn = btd_get_dbus_connection();
 	char addr[18];
 	GSList *l;
 
@@ -113,6 +130,11 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 					addr, service->profile->name,
 					state2str(old), state2str(state), err);
 
+	if (state != BTD_SERVICE_STATE_UNAVAILABLE &&
+					state2dbus(old) != state2dbus(state))
+		g_dbus_emit_property_changed(dbus_conn, service->path,
+						SERVICE_INTERFACE, "State");
+
 	for (l = state_callbacks; l != NULL; l = g_slist_next(l)) {
 		struct service_state_callback *cb = l->data;
 
@@ -370,9 +392,23 @@ static gboolean service_get_uuid(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean service_get_state(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_service *service = data;
+	const char *str;
+
+	str = state2dbus(service->state);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable service_properties[] = {
 	{ "Device", "o", service_get_device },
 	{ "UUID", "s", service_get_uuid },
+	{ "State", "s", service_get_state },
 	{ }
 };
 
-- 
1.8.1.4

