Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/4] core: Add support for included services
Date: Wed, 22 Aug 2012 16:31:55 -0300
Message-Id: <1345663916-29989-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1345663916-29989-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1345663916-29989-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Soon after the primary service discovery is complete, we do a included
services discovery for all found services and add each included service
to the 'services' list so they can be probe()'d as a normal profile.

This will also make these services to appear on the D-Bus object tree.
---
 src/device.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7b44e27..360969c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -106,6 +106,12 @@ struct browse_req {
 	guint listener_id;
 };
 
+struct included_search {
+	struct browse_req *req;
+	GSList *services;
+	GSList *current;
+};
+
 struct attio_data {
 	guint id;
 	attio_connect_cb cfunc;
@@ -1877,21 +1883,10 @@ static void device_unregister_services(struct btd_device *device)
 	device->services = NULL;
 }
 
-static void primary_cb(GSList *services, guint8 status, gpointer user_data)
+static void register_all_services(struct browse_req *req, GSList *services)
 {
-	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
 
-	if (status) {
-		if (req->msg) {
-			DBusMessage *reply;
-			reply = btd_error_failed(req->msg,
-							att_ecode2str(status));
-			g_dbus_send_message(req->conn, reply);
-		}
-		goto done;
-	}
-
 	device_set_temporary(device, FALSE);
 
 	if (device->services)
@@ -1916,11 +1911,99 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	store_services(device);
 
-done:
 	device->browse = NULL;
 	browse_request_free(req);
 }
 
+static int service_by_range_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_primary *prim = a;
+	const struct att_range *range = b;
+
+	return memcmp(&prim->range, range, sizeof(*range));
+}
+
+static void find_included_cb(GSList *includes, uint8_t status,
+						gpointer user_data)
+{
+	struct included_search *search = user_data;
+	struct btd_device *device = search->req->device;
+	struct gatt_primary *prim;
+	GSList *l;
+
+	if (includes == NULL)
+		goto done;
+
+	for (l = includes; l; l = l->next) {
+		struct gatt_included *incl = l->data;
+
+		if (g_slist_find_custom(search->services, &incl->range,
+						service_by_range_cmp))
+			continue;
+
+		prim = g_new0(struct gatt_primary, 1);
+		memcpy(prim->uuid, incl->uuid, sizeof(prim->uuid));
+		memcpy(&prim->range, &incl->range, sizeof(prim->range));
+
+		search->services = g_slist_append(search->services, prim);
+	}
+
+done:
+	search->current = search->current->next;
+	if (search->current == NULL) {
+		register_all_services(search->req, search->services);
+		g_slist_free(search->services);
+		g_free(search);
+		return;
+	}
+
+	prim = search->current->data;
+	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
+					find_included_cb, search);
+}
+
+static void find_included_services(struct browse_req *req, GSList *services)
+{
+	struct btd_device *device = req->device;
+	struct included_search *search;
+	struct gatt_primary *prim;
+
+	if (services == NULL)
+		return;
+
+	search = g_new0(struct included_search, 1);
+	search->req = req;
+	search->services = g_slist_copy(services);
+	search->current = search->services;
+
+	prim = search->current->data;
+	gatt_find_included(device->attrib, prim->range.start, prim->range.end,
+					find_included_cb, search);
+
+}
+
+static void primary_cb(GSList *services, guint8 status, gpointer user_data)
+{
+	struct browse_req *req = user_data;
+
+	if (status) {
+		struct btd_device *device = req->device;
+
+		if (req->msg) {
+			DBusMessage *reply;
+			reply = btd_error_failed(req->msg,
+							att_ecode2str(status));
+			g_dbus_send_message(req->conn, reply);
+		}
+
+		device->browse = NULL;
+		browse_request_free(req);
+		return;
+	}
+
+	find_included_services(req, services);
+}
+
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct att_callbacks *attcb = user_data;
-- 
1.7.11.4

