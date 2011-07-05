Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 05/12] Add ATT disconnect callback
Date: Tue,  5 Jul 2011 10:56:01 -0300
Message-Id: <1309874168-32716-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attio.h  |    4 +++-
 src/device.c |   36 +++++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/src/attio.h b/src/attio.h
index 7935dcd..16e2873 100644
--- a/src/attio.h
+++ b/src/attio.h
@@ -23,9 +23,11 @@
  */
 
 typedef void (*attio_connect_cb) (GAttrib *attrib, gpointer user_data);
+typedef void (*attio_disconnect_cb) (gpointer user_data);
 
 guint btd_device_add_attio_callback(struct btd_device *device,
-						attio_connect_cb func,
+						attio_connect_cb cfunc,
+						attio_disconnect_cb dcfunc,
 						gpointer user_data);
 
 gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id);
diff --git a/src/device.c b/src/device.c
index eeeb25f..20248ed 100644
--- a/src/device.c
+++ b/src/device.c
@@ -108,7 +108,8 @@ struct browse_req {
 
 struct attio_data {
 	guint id;
-	attio_connect_cb func;
+	attio_connect_cb cfunc;
+	attio_disconnect_cb dcfunc;
 	gpointer user_data;
 };
 
@@ -1590,6 +1591,23 @@ static void store_services(struct btd_device *device)
 	g_free(str);
 }
 
+static void attio_disconnected(gpointer data, gpointer user_data)
+{
+	struct attio_data *attio = data;
+
+	if (attio->dcfunc)
+		attio->dcfunc(attio->user_data);
+}
+
+static void attrib_destroyed(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+
+	device->attrib = NULL;
+
+	g_slist_foreach(device->attios, attio_disconnected, NULL);
+}
+
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
@@ -1619,6 +1637,12 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	g_slist_free(uuids);
 
+	if (device->attios) {
+		device->attrib = g_attrib_ref(req->attrib);
+		g_attrib_set_destroy_function(device->attrib, attrib_destroyed,
+								device);
+	}
+
 	create_device_reply(device, req);
 
 	store_services(device);
@@ -2461,7 +2485,8 @@ void device_set_class(struct btd_device *device, uint32_t value)
 }
 
 guint btd_device_add_attio_callback(struct btd_device *device,
-						attio_connect_cb func,
+						attio_connect_cb cfunc,
+						attio_disconnect_cb dcfunc,
 						gpointer user_data)
 {
 	struct attio_data *attio;
@@ -2471,13 +2496,14 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 
 	attio = g_new0(struct attio_data, 1);
 	attio->id = ++attio_id;
-	attio->func = func;
+	attio->cfunc = cfunc;
+	attio->dcfunc = dcfunc;
 	attio->user_data = user_data;
 
 	device->attios = g_slist_append(device->attios, attio);
 
-	if (device->attrib && func)
-		func(device->attrib, user_data);
+	if (device->attrib && cfunc)
+		cfunc(device->attrib, user_data);
 
 	return attio->id;
 }
-- 
1.7.6

