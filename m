Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 22/32] Initial work for disconnecting health links
Date: Wed,  2 Jun 2010 15:19:18 +0200
Message-Id: <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index cb05324..10621c4 100644
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

