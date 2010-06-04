Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 23/32] Avoid multiple links with the same device
Date: Fri,  4 Jun 2010 10:30:16 +0200
Message-Id: <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
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
 <1275640225-4186-23-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index d6a8758..ed26fe5 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -117,7 +117,8 @@ static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
 	return -1;
 }
 
-static int hdp_link_mcl_cmp(gconstpointer link, gconstpointer mcl){
+static int hdp_link_mcl_cmp(gconstpointer link, gconstpointer mcl)
+{
 	const struct hdp_link *hdpl = link;
 
 	if (hdpl->mcl == mcl)
@@ -125,6 +126,17 @@ static int hdp_link_mcl_cmp(gconstpointer link, gconstpointer mcl){
 	return -1;
 }
 
+static int hdp_link_addr_cmp(gconstpointer link, gconstpointer addr)
+{
+	const struct hdp_link *hdpl = link;
+	const bdaddr_t *dst;
+        bdaddr_t mcl_addr;
+
+	dst = addr;
+	mcl_addr = mcap_mcl_get_addr(hdpl->mcl);
+	return bacmp(addr, &mcl_addr);
+}
+
 static void set_health_link_path(struct hdp_link *hdpl)
 {
 	char path[MAX_PATH_LENGTH + 1];
@@ -534,12 +546,27 @@ fail:
 	g_dbus_send_message(device->conn, reply);
 }
 
+static struct hdp_link *get_health_link(struct hdp_instance *hdpi,
+						struct hdp_device *device)
+{
+	bdaddr_t dst;
+	GSList *l;
+
+	device_get_address(device->dev, &dst);
+	l = g_slist_find_custom(hdpi->hlink, &dst, hdp_link_addr_cmp);
+	if (l)
+		return l->data;
+	return NULL;
+}
+
 static DBusMessage *hdp_connect(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct hdp_device *device = user_data;
 	struct hdp_connection_cb *cb_data;
 	struct btd_adapter *adapter;
+	struct hdp_instance *hdpi;
+	struct hdp_link *hdpl;
 	bdaddr_t src, dst;
 	uint32_t lid, rid;
 	uuid_t uuid;
@@ -561,9 +588,20 @@ static DBusMessage *hdp_connect(DBusConnection *conn,
 					   ERROR_INTERFACE ".InvalidArguments",
 					   "Invalid local health instance id");
 
+	hdpi = l->data;
+	hdpl = get_health_link(hdpi, device);
+	if (hdpl) {
+		if (hdpl->closed) {
+			DBG("Need a reconection");
+			/* TODO: Reconnect */;
+		} else
+			return g_dbus_create_reply(msg, DBUS_TYPE_OBJECT_PATH,
+						&hdpl->path, DBUS_TYPE_INVALID);
+	}
+
 	cb_data = g_new0(struct hdp_connection_cb, 1);
 	cb_data->device = device;
-	cb_data->hdpi = l->data;
+	cb_data->hdpi = hdpi;
 	cb_data->rem_id = rid;
 	cb_data->msg = dbus_message_ref(msg);
 
-- 
1.6.3.3

