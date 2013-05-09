Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 23/26] core: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:53 -0300
Message-Id: <1368073016-28434-23-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate and prefer this one
over stdint.h.
---
 src/adapter.c       | 37 ++++++++++++++++++++-----------------
 src/adapter.h       |  5 +++--
 src/agent.c         |  3 ++-
 src/attio.h         |  7 +++++--
 src/attrib-server.c | 30 +++++++++++++++---------------
 src/attrib-server.h |  6 ++++--
 src/device.c        | 38 ++++++++++++++++++++------------------
 src/device.h        |  6 ++++--
 src/main.c          |  7 ++++---
 src/profile.c       |  8 ++++----
 src/rfkill.c        |  4 ++--
 src/sdp-client.c    |  5 +++--
 src/sdpd-server.c   |  3 ++-
 src/shared/hciemu.c | 15 ++++++++-------
 src/shared/mgmt.c   |  5 +++--
 src/shared/tester.c |  7 ++++---
 16 files changed, 103 insertions(+), 83 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b952ea1..a0253f5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
@@ -108,11 +109,11 @@ static GSList *adapter_drivers = NULL;
 struct discovery_client {
 	struct btd_adapter *adapter;
 	char *owner;
-	guint watch;
+	unsigned int watch;
 };
 
 struct service_auth {
-	guint id;
+	unsigned int id;
 	service_auth_cb cb;
 	void *user_data;
 	const char *uuid;
@@ -152,12 +153,12 @@ struct btd_adapter {
 	bool discovery_suspended;	/* discovery has been suspended */
 	GSList *discovery_list;		/* list of discovery clients */
 	GSList *discovery_found;	/* list of found devices */
-	guint discovery_idle_timeout;	/* timeout between discovery runs */
-	guint passive_scan_timeout;	/* timeout between passive scans */
-	guint temp_devices_timeout;	/* timeout for temporary devices */
+	unsigned int discovery_idle_timeout;	/* timeout between discovery runs */
+	unsigned int passive_scan_timeout;	/* timeout between passive scans */
+	unsigned int temp_devices_timeout;	/* timeout for temporary devices */
 
-	guint pairable_timeout_id;	/* pairable timeout id */
-	guint auth_idle_id;		/* Pending authorization dequeue */
+	unsigned int pairable_timeout_id;	/* pairable timeout id */
+	unsigned int auth_idle_id;		/* Pending authorization dequeue */
 	GQueue *auths;			/* Ongoing and pending auths */
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
@@ -176,13 +177,13 @@ struct btd_adapter {
 	struct oob_handler *oob_handler;
 
 	unsigned int load_ltks_id;
-	guint load_ltks_timeout;
+	unsigned int load_ltks_timeout;
 
 	unsigned int confirm_name_id;
-	guint confirm_name_timeout;
+	unsigned int confirm_name_timeout;
 
 	unsigned int pair_device_id;
-	guint pair_device_timeout;
+	unsigned int pair_device_timeout;
 
 	bool is_default;		/* true if adapter is default one */
 };
@@ -1217,7 +1218,8 @@ static void cancel_passive_scanning(struct btd_adapter *adapter)
 	}
 }
 
-static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
+static void trigger_start_discovery(struct btd_adapter *adapter,
+							unsigned int delay);
 
 static void start_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
@@ -1308,7 +1310,8 @@ static gboolean start_discovery_timeout(gpointer user_data)
 	return FALSE;
 }
 
-static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
+static void trigger_start_discovery(struct btd_adapter *adapter,
+							unsigned int delay)
 {
 
 	DBG("");
@@ -4392,7 +4395,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 {
 	struct service_auth *auth;
 	struct btd_device *device;
-	static guint id = 0;
+	static unsigned int id = 0;
 
 	device = adapter_find_device(adapter, dst);
 	if (!device)
@@ -4426,7 +4429,7 @@ static int adapter_authorize(struct btd_adapter *adapter, const bdaddr_t *dst,
 	return auth->id;
 }
 
-guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
+unsigned int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 					const char *uuid, service_auth_cb cb,
 					void *user_data)
 {
@@ -4442,7 +4445,7 @@ guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 	}
 
 	for (l = adapters; l != NULL; l = g_slist_next(l)) {
-		guint id;
+		unsigned int id;
 
 		adapter = l->data;
 
@@ -4454,7 +4457,7 @@ guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 	return 0;
 }
 
-static struct service_auth *find_authorization(guint id)
+static struct service_auth *find_authorization(unsigned int id)
 {
 	GSList *l;
 	GList *l2;
@@ -4473,7 +4476,7 @@ static struct service_auth *find_authorization(guint id)
 	return NULL;
 }
 
-int btd_cancel_authorization(guint id)
+int btd_cancel_authorization(unsigned int id)
 {
 	struct service_auth *auth;
 
diff --git a/src/adapter.h b/src/adapter.h
index 6b6515a..c988e03 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -28,6 +28,7 @@
 #include <bluetooth/hci_lib.h>
 #include <dbus/dbus.h>
 #include <glib.h>
+#include <inttypes.h>
 #include <stdbool.h>
 
 #define MAX_NAME_LENGTH		248
@@ -125,9 +126,9 @@ void adapter_add_profile(struct btd_adapter *adapter, gpointer p);
 void adapter_remove_profile(struct btd_adapter *adapter, gpointer p);
 int btd_register_adapter_driver(struct btd_adapter_driver *driver);
 void btd_unregister_adapter_driver(struct btd_adapter_driver *driver);
-guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
+unsigned int btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 		const char *uuid, service_auth_cb cb, void *user_data);
-int btd_cancel_authorization(guint id);
+int btd_cancel_authorization(unsigned int id);
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
 
diff --git a/src/agent.c b/src/agent.c
index 0fde3ef..b039aa3 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -76,7 +77,7 @@ struct agent {
 	char *path;
 	uint8_t capability;
 	struct agent_request *request;
-	guint watch;
+	unsigned int watch;
 };
 
 struct agent_request {
diff --git a/src/attio.h b/src/attio.h
index 16e2873..d5719c4 100644
--- a/src/attio.h
+++ b/src/attio.h
@@ -22,12 +22,15 @@
  *
  */
 
+#include <inttypes.h>
+
 typedef void (*attio_connect_cb) (GAttrib *attrib, gpointer user_data);
 typedef void (*attio_disconnect_cb) (gpointer user_data);
 
-guint btd_device_add_attio_callback(struct btd_device *device,
+unsigned int btd_device_add_attio_callback(struct btd_device *device,
 						attio_connect_cb cfunc,
 						attio_disconnect_cb dcfunc,
 						gpointer user_data);
 
-gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id);
+gboolean btd_device_remove_attio_callback(struct btd_device *device,
+							unsigned int id);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3610e60..9029793 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -26,8 +26,8 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
-#include <stdint.h>
 #include <stdbool.h>
 #include <string.h>
 #include <unistd.h>
@@ -72,12 +72,12 @@ struct gatt_channel {
 	bdaddr_t src;
 	bdaddr_t dst;
 	GAttrib *attrib;
-	guint mtu;
+	unsigned int mtu;
 	gboolean le;
-	guint id;
+	unsigned int id;
 	gboolean encrypted;
 	struct gatt_server *server;
-	guint cleanup_id;
+	unsigned int cleanup_id;
 	struct btd_device *device;
 };
 
@@ -260,7 +260,7 @@ static struct attribute *find_svc_range(struct gatt_server *server,
 					uint16_t start, uint16_t *end)
 {
 	struct attribute *attrib;
-	guint h = start;
+	unsigned int h = start;
 	GList *l;
 
 	if (end == NULL)
@@ -340,7 +340,7 @@ static struct attribute *attrib_db_add_new(struct gatt_server *server,
 				const uint8_t *value, size_t len)
 {
 	struct attribute *a;
-	guint h = handle;
+	unsigned int h = handle;
 
 	DBG("handle=0x%04x", handle);
 
@@ -787,7 +787,7 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	uint8_t status;
 	GList *l;
 	uint16_t cccval;
-	guint h = handle;
+	unsigned int h = handle;
 
 	l = g_list_find_custom(channel->server->database,
 					GUINT_TO_POINTER(h), handle_cmp);
@@ -824,7 +824,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 	uint8_t status;
 	GList *l;
 	uint16_t cccval;
-	guint h = handle;
+	unsigned int h = handle;
 
 	l = g_list_find_custom(channel->server->database,
 					GUINT_TO_POINTER(h), handle_cmp);
@@ -866,7 +866,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	struct attribute *a;
 	uint8_t status;
 	GList *l;
-	guint h = handle;
+	unsigned int h = handle;
 
 	l = g_list_find_custom(channel->server->database,
 					GUINT_TO_POINTER(h), handle_cmp);
@@ -1098,7 +1098,7 @@ done:
 	g_attrib_send(channel->attrib, 0, opdu, length, NULL, NULL, NULL);
 }
 
-guint attrib_channel_attach(GAttrib *attrib)
+unsigned int attrib_channel_attach(GAttrib *attrib)
 {
 	struct gatt_server *server;
 	struct btd_device *device;
@@ -1106,7 +1106,7 @@ guint attrib_channel_attach(GAttrib *attrib)
 	GIOChannel *io;
 	GError *gerr = NULL;
 	uint16_t cid;
-	guint mtu = 0;
+	unsigned int mtu = 0;
 
 	io = g_attrib_get_channel(attrib);
 
@@ -1179,12 +1179,12 @@ guint attrib_channel_attach(GAttrib *attrib)
 static int channel_id_cmp(gconstpointer data, gconstpointer user_data)
 {
 	const struct gatt_channel *channel = data;
-	guint id = GPOINTER_TO_UINT(user_data);
+	unsigned int id = GPOINTER_TO_UINT(user_data);
 
 	return channel->id - id;
 }
 
-gboolean attrib_channel_detach(GAttrib *attrib, guint id)
+gboolean attrib_channel_detach(GAttrib *attrib, unsigned int id)
 {
 	struct gatt_server *server;
 	struct gatt_channel *channel;
@@ -1512,7 +1512,7 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 	struct attribute *a;
 	GSList *l;
 	GList *dl;
-	guint h = handle;
+	unsigned int h = handle;
 
 	l = g_slist_find_custom(servers, adapter, adapter_cmp);
 	if (l == NULL)
@@ -1551,7 +1551,7 @@ int attrib_db_del(struct btd_adapter *adapter, uint16_t handle)
 	struct attribute *a;
 	GSList *l;
 	GList *dl;
-	guint h = handle;
+	unsigned int h = handle;
 
 	l = g_slist_find_custom(servers, adapter, adapter_cmp);
 	if (l == NULL)
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 2148017..f4e3106 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include <inttypes.h>
+
 uint16_t attrib_db_find_avail(struct btd_adapter *adapter, bt_uuid_t *svc_uuid,
 							uint16_t nitems);
 struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
@@ -37,5 +39,5 @@ int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 uint32_t attrib_create_sdp(struct btd_adapter *adapter, uint16_t handle,
 							const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
-guint attrib_channel_attach(GAttrib *attrib);
-gboolean attrib_channel_detach(GAttrib *attrib, guint id);
+unsigned int attrib_channel_attach(GAttrib *attrib);
+gboolean attrib_channel_detach(GAttrib *attrib, unsigned int id);
diff --git a/src/device.c b/src/device.c
index 14c3e81..01fba20 100644
--- a/src/device.c
+++ b/src/device.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -76,7 +77,7 @@ static DBusConnection *dbus_conn = NULL;
 unsigned service_state_cb_id;
 
 struct btd_disconnect_data {
-	guint id;
+	unsigned int id;
 	disconnect_watch watch;
 	void *user_data;
 	GDestroyNotify destroy;
@@ -84,7 +85,7 @@ struct btd_disconnect_data {
 
 struct bonding_req {
 	DBusMessage *msg;
-	guint listener_id;
+	unsigned int listener_id;
 	struct btd_device *device;
 	struct agent *agent;
 };
@@ -115,7 +116,7 @@ struct browse_req {
 	sdp_list_t *records;
 	int search_uuid;
 	int reconnect_attempt;
-	guint listener_id;
+	unsigned int listener_id;
 };
 
 struct included_search {
@@ -125,7 +126,7 @@ struct included_search {
 };
 
 struct attio_data {
-	guint id;
+	unsigned int id;
 	attio_connect_cb cfunc;
 	attio_disconnect_cb dcfunc;
 	gpointer user_data;
@@ -133,7 +134,7 @@ struct attio_data {
 
 struct svc_callback {
 	unsigned int id;
-	guint idle_id;
+	unsigned int idle_id;
 	struct btd_device *dev;
 	device_svc_cb_t func;
 	void *user_data;
@@ -174,8 +175,8 @@ struct btd_device {
 	GSList		*pending;		/* Pending services */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
-	guint		disconn_timer;
-	guint		discov_timer;
+	unsigned int	disconn_timer;
+	unsigned int	discov_timer;
 	struct browse_req *browse;		/* service discover request */
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
@@ -185,7 +186,7 @@ struct btd_device {
 	GAttrib		*attrib;
 	GSList		*attios;
 	GSList		*attios_offline;
-	guint		attachid;		/* Attrib server attach */
+	unsigned int	attachid;		/* Attrib server attach */
 
 	gboolean	connected;
 
@@ -203,8 +204,8 @@ struct btd_device {
 	int8_t		rssi;
 
 	GIOChannel	*att_io;
-	guint		cleanup_id;
-	guint		store_id;
+	unsigned int	cleanup_id;
+	unsigned int	store_id;
 };
 
 static const uint16_t uuid_list[] = {
@@ -1752,12 +1753,12 @@ void device_remove_connection(struct btd_device *device)
 						DEVICE_INTERFACE, "Connected");
 }
 
-guint device_add_disconnect_watch(struct btd_device *device,
+unsigned int device_add_disconnect_watch(struct btd_device *device,
 				disconnect_watch watch, void *user_data,
 				GDestroyNotify destroy)
 {
 	struct btd_disconnect_data *data;
-	static guint id = 0;
+	static unsigned int id = 0;
 
 	data = g_new0(struct btd_disconnect_data, 1);
 	data->id = ++id;
@@ -1770,7 +1771,7 @@ guint device_add_disconnect_watch(struct btd_device *device,
 	return data->id;
 }
 
-void device_remove_disconnect_watch(struct btd_device *device, guint id)
+void device_remove_disconnect_watch(struct btd_device *device, unsigned int id)
 {
 	GSList *l;
 
@@ -3167,7 +3168,7 @@ static void find_included_services(struct browse_req *req, GSList *services)
 
 }
 
-static void primary_cb(GSList *services, guint8 status, gpointer user_data)
+static void primary_cb(GSList *services, uint8_t status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 
@@ -4275,13 +4276,13 @@ static gboolean notify_attios(gpointer user_data)
 	return FALSE;
 }
 
-guint btd_device_add_attio_callback(struct btd_device *device,
+unsigned int btd_device_add_attio_callback(struct btd_device *device,
 						attio_connect_cb cfunc,
 						attio_disconnect_cb dcfunc,
 						gpointer user_data)
 {
 	struct attio_data *attio;
-	static guint attio_id = 0;
+	static unsigned int attio_id = 0;
 
 	DBG("%p registered ATT connection callback", device);
 
@@ -4308,12 +4309,13 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 static int attio_id_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct attio_data *attio = a;
-	guint id = GPOINTER_TO_UINT(b);
+	unsigned int id = GPOINTER_TO_UINT(b);
 
 	return attio->id - id;
 }
 
-gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
+gboolean btd_device_remove_attio_callback(struct btd_device *device,
+							unsigned int id)
 {
 	struct attio_data *attio;
 	GSList *l;
diff --git a/src/device.h b/src/device.h
index 70e1502..94d2faf 100644
--- a/src/device.h
+++ b/src/device.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include <inttypes.h>
+
 #define DEVICE_INTERFACE	"org.bluez.Device1"
 
 struct btd_device;
@@ -94,10 +96,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
 
-guint device_add_disconnect_watch(struct btd_device *device,
+unsigned int device_add_disconnect_watch(struct btd_device *device,
 				disconnect_watch watch, void *user_data,
 				GDestroyNotify destroy);
-void device_remove_disconnect_watch(struct btd_device *device, guint id);
+void device_remove_disconnect_watch(struct btd_device *device, unsigned int id);
 int device_get_appearance(struct btd_device *device, uint16_t *value);
 void device_set_appearance(struct btd_device *device, uint16_t value);
 
diff --git a/src/main.c b/src/main.c
index dc0478e..280a1bc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -27,6 +27,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -340,10 +341,10 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 	return TRUE;
 }
 
-static guint setup_signalfd(void)
+static unsigned int setup_signalfd(void)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 	sigset_t mask;
 	int fd;
 
@@ -488,7 +489,7 @@ int main(int argc, char *argv[])
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
 	GKeyFile *config;
-	guint signal, watchdog;
+	unsigned int signal, watchdog;
 	const char *watchdog_usec;
 
 	init_defaults();
diff --git a/src/profile.c b/src/profile.c
index 8fd0424..5a3dd06 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -25,8 +25,8 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
-#include <stdint.h>
 #include <stdlib.h>
 #include <errno.h>
 
@@ -560,7 +560,7 @@ struct ext_profile {
 
 	char *remote_uuid;
 
-	guint id;
+	unsigned int id;
 
 	BtIOSecLevel sec_level;
 	bool authorize;
@@ -588,7 +588,7 @@ struct ext_io {
 	struct ext_profile *ext;
 	int proto;
 	GIOChannel *io;
-	guint io_id;
+	unsigned int io_id;
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 	struct btd_service *service;
@@ -602,7 +602,7 @@ struct ext_io {
 	uint16_t psm;
 	uint8_t chan;
 
-	guint auth_id;
+	unsigned int auth_id;
 	unsigned int svc_id;
 	DBusPendingCall *pending;
 };
diff --git a/src/rfkill.c b/src/rfkill.c
index 70588c0..9380a1e 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -25,11 +25,11 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -138,7 +138,7 @@ static gboolean rfkill_event(GIOChannel *chan,
 	return TRUE;
 }
 
-static guint watch = 0;
+static unsigned int watch = 0;
 
 void rfkill_init(void)
 {
diff --git a/src/sdp-client.c b/src/sdp-client.c
index fdf2b01..be1f004 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -26,6 +26,7 @@
 #endif
 
 #include <errno.h>
+#include <inttypes.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -43,7 +44,7 @@ struct cached_sdp_session {
 	bdaddr_t src;
 	bdaddr_t dst;
 	sdp_session_t *session;
-	guint timer;
+	unsigned int timer;
 };
 
 static GSList *cached_sdp_sessions = NULL;
@@ -123,7 +124,7 @@ struct search_context {
 	bt_destroy_t		destroy;
 	gpointer		user_data;
 	uuid_t			uuid;
-	guint			io_id;
+	unsigned int			io_id;
 };
 
 static GSList *context_list = NULL;
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index bc96d3c..88416e3 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -28,6 +28,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
@@ -49,7 +50,7 @@
 #include "log.h"
 #include "sdpd.h"
 
-static guint l2cap_id = 0, unix_id = 0;
+static unsigned int l2cap_id = 0, unix_id = 0;
 
 static int l2cap_sock, unix_sock;
 
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 463ef52..8adaf0a 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -46,9 +47,9 @@ struct hciemu {
 	struct bthost *host_stack;
 	struct btdev *master_dev;
 	struct btdev *client_dev;
-	guint host_source;
-	guint master_source;
-	guint client_source;
+	unsigned int host_source;
+	unsigned int master_source;
+	unsigned int client_source;
 	GList *post_command_hooks;
 	char bdaddr_str[18];
 };
@@ -125,10 +126,10 @@ static gboolean receive_bthost(GIOChannel *channel, GIOCondition condition,
 	return TRUE;
 }
 
-static guint create_source_bthost(int fd, struct bthost *bthost)
+static unsigned int create_source_bthost(int fd, struct bthost *bthost)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 
 	channel = g_io_channel_unix_new(fd);
 
@@ -169,10 +170,10 @@ static gboolean receive_btdev(GIOChannel *channel, GIOCondition condition,
 	return TRUE;
 }
 
-static guint create_source_btdev(int fd, struct btdev *btdev)
+static unsigned int create_source_btdev(int fd, struct btdev *btdev)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 
 	channel = g_io_channel_unix_new(fd);
 
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 2c79886..7beae19 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <string.h>
@@ -44,8 +45,8 @@ struct mgmt {
 	int fd;
 	bool close_on_unref;
 	GIOChannel *io;
-	guint read_watch;
-	guint write_watch;
+	unsigned int read_watch;
+	unsigned int write_watch;
 	GQueue *request_queue;
 	GQueue *reply_queue;
 	GList *pending_list;
diff --git a/src/shared/tester.c b/src/shared/tester.c
index f3edd74..0c84312 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
@@ -675,10 +676,10 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition condition,
 	return TRUE;
 }
 
-static guint setup_signalfd(void)
+static unsigned int setup_signalfd(void)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 	sigset_t mask;
 	int fd;
 
@@ -768,7 +769,7 @@ void tester_init(int *argc, char ***argv)
 
 int tester_run(void)
 {
-	guint signal;
+	unsigned int signal;
 
 	if (!main_loop)
 		return EXIT_FAILURE;
-- 
1.8.2.2

