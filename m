Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 22/32] Initial work for disconnecting health links
Date: Fri,  4 Jun 2010 10:30:15 +0200
Message-Id: <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-9-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-10-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-11-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-12-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-13-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-14-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-15-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-16-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-17-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-18-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-19-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-20-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-21-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-22-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 310f6ff..d6a8758 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -88,6 +88,25 @@ static struct hdp_device *find_device(GSList *devices, struct btd_device *dev)
 	return NULL;
 }
 
+static struct hdp_link *find_health_link(struct hdp_adapter *adapter,
+							const char *link_path)
+{
+	struct hdp_instance *hdpi;
+	struct hdp_link *hdpl;
+	GSList *l, *ll;
+
+	for (l = adapter->instances; l; l = l->next) {
+		hdpi = l->data;
+		for (ll = hdpi->hlink; ll; ll = ll->next) {
+			hdpl = ll->data;
+			if (!strcmp(hdpl->path, link_path))
+				return hdpl;
+		}
+	}
+
+	return NULL;
+}
+
 static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
 {
 	const struct hdp_instance *hdpi = instance;
@@ -562,10 +581,36 @@ static DBusMessage *hdp_connect(DBusConnection *conn,
 				   "Error getting remote information");
 }
 
+static DBusMessage *hdp_disconnect(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct hdp_device *device = user_data;
+	struct hdp_link *hlink;
+	const char *path;
+	const gboolean *del;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_BOOLEAN, &del,
+							DBUS_TYPE_INVALID)){
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+	}
+
+	hlink = find_health_link(device->hdp_adapter, path);
+	if (!hlink)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+						"Health link does not found");
+
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
+							"Not yet implemented");
+}
+
 static GDBusMethodTable device_methods[] = {
 	{ "GetHealthInstances", "", "aa{sv}", get_health_instances,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Connect", "uu", "o", hdp_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Diconnect", "ob", "", hdp_disconnect },
 	{ NULL }
 };
 
-- 
1.6.3.3

