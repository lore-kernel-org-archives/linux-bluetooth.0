Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 07/32] Add watcher to control client disconections to delete hdp instance
Date: Fri,  4 Jun 2010 10:30:00 +0200
Message-Id: <1275640225-4186-8-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
References: <1275640225-4186-1-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-2-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-3-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-4-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-5-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-6-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-7-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |   11 +++++++++++
 health/hdp_types.h |    1 +
 health/hdp_util.c  |    2 ++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 8d90588..31abb4c 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -163,6 +163,15 @@ static void hdp_set_instance_id(struct hdp_instance *hdpi)
 	hdpi->id = adapter->ic++;
 }
 
+static void client_disconnected(DBusConnection *connection, void *user_data)
+{
+	struct hdp_instance *hdpi = user_data;
+	struct hdp_adapter *adapter = hdpi->adapter;
+	DBG("Client disconnected from the bus, deleting hdp instance");
+	adapter->instances = g_slist_remove(adapter->instances, hdpi);
+	hdp_instance_free(hdpi);
+}
+
 static DBusMessage *hdp_create_instance(DBusConnection *conn,
 				      DBusMessage *msg, void *user_data)
 {
@@ -197,6 +206,8 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 	hdpi->apath = g_strdup(path);
 	hdpi->config = config;
 	hdp_set_instance_id(hdpi);
+	hdpi->dbus_watcher = g_dbus_add_disconnect_watch(adapter->conn, name,
+					client_disconnected, hdpi, NULL);
 
 	/* TODO: Create mcap instance */
 
diff --git a/health/hdp_types.h b/health/hdp_types.h
index 171910a..3bab4ea 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -98,6 +98,7 @@ struct hdp_instance {
 	char			*aname;		/* HDP agent name */
 	struct hdp_config	*config;	/* Configuration */
 	uint32_t		sdp_handler;	/* SDP record handler */
+	guint			dbus_watcher;	/* Client D-Bus conn watcher */
 };
 
 struct hdp_device {
diff --git a/health/hdp_util.c b/health/hdp_util.c
index 31a0248..5397f11 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -119,6 +119,8 @@ void hdp_instance_free(struct hdp_instance *hdpi)
 	hdpi->devices = NULL;
 	*/
 
+	if (hdpi->dbus_watcher)
+		g_dbus_remove_watch(hdpi->adapter->conn, hdpi->dbus_watcher);
 	if (hdpi->sdp_handler)
 		remove_record_from_server(hdpi->sdp_handler);
 	/* TODO: stop mcap instance */
-- 
1.6.3.3

