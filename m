Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 21/32] Manage mcap disconnections and reconnections
Date: Wed,  2 Jun 2010 15:19:17 +0200
Message-Id: <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |   58 ++++++++++++++++++++++++++++++++++++++++++---------
 health/hdp_types.h |    5 ++++
 health/hdp_util.c  |   19 ++++++++++++----
 3 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 19ff2f9..cb05324 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -37,10 +37,6 @@
 
 #include "../src/dbus-common.h"
 
-#define HEALTH_MANAGER_INTERFACE	"org.bluez.HealthAdapter"
-#define HEALTH_DEVICE			"org.bluez.HealthDevice"
-#define HEALTH_LINK			"org.bluez.HealthLink"
-
 static GSList *adapters = NULL;
 static GSList *devices = NULL;
 
@@ -102,6 +98,14 @@ static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
 	return -1;
 }
 
+static int hdp_link_mcl_cmp(gconstpointer link, gconstpointer mcl){
+	const struct hdp_link *hdpl = link;
+
+	if (hdpl->mcl == mcl)
+		return 0;
+	return -1;
+}
+
 static void set_health_link_path(struct hdp_link *hdpl)
 {
 	char path[MAX_PATH_LENGTH + 1];
@@ -617,7 +621,7 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 	struct hdp_link *hdpl;
 	GError *err = NULL;
 
-	debug("TODO: implement mcl_connected");
+	debug("mcl_connected");
 	hdpl = create_health_link(hdpi, mcl, &err);
 	if (err)
 		return;
@@ -627,20 +631,52 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
 {
-	/* struct hdp_instance *hdpi = data; */
-	debug("TODO: implement mcl_reconnected");
+	struct hdp_instance *hdpi = data;
+	struct hdp_link *hdpl;
+	GSList *l;
+
+	debug("mcl_reconnected");
+	l = g_slist_find_custom(hdpi->hlink, mcl, hdp_link_mcl_cmp);
+	if (l) {
+		hdpl = l->data;
+		hdpl->closed = FALSE;
+		return;
+	}
+
+	mcl_connected(mcl, data);
 }
 
 static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
 {
-	/* struct hdp_instance *hdpi = data; */
-	debug("TODO: implement mcl_disconnected");
+	struct hdp_instance *hdpi = data;
+	struct hdp_link *hdpl;
+	GSList *l;
+
+	debug("mcl_disconnected");
+	l = g_slist_find_custom(hdpi->hlink, mcl, hdp_link_mcl_cmp);
+	if (!l)
+		return;
+
+	hdpl = l->data;
+	hdpl->closed = TRUE;
 }
 
 static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 {
-	/* struct hdp_instance *hdpi = data; */
-	debug("TODO: implement mcl_uncached");
+	struct hdp_instance *hdpi = data;
+	struct hdp_link *hdpl;
+	GSList *l;
+
+	debug("mcl_uncached");
+	l = g_slist_find_custom(hdpi->hlink, mcl, hdp_link_mcl_cmp);
+	if (!l)
+		return;
+
+	hdpl = l->data;
+
+	hdpi->hlink = g_slist_remove(hdpi->hlink, hdpl);
+	g_dbus_unregister_interface(hdpi->adapter->conn, hdpl->path,
+								HEALTH_LINK);
 }
 
 static DBusMessage *hdp_create_instance(DBusConnection *conn,
diff --git a/health/hdp_types.h b/health/hdp_types.h
index 79419a1..5db8e0d 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -42,6 +42,10 @@
 
 #define HDP_ERROR		g_quark_from_static_string("hdp-error-quark")
 
+#define HEALTH_MANAGER_INTERFACE	"org.bluez.HealthAdapter"
+#define HEALTH_DEVICE			"org.bluez.HealthDevice"
+#define HEALTH_LINK			"org.bluez.HealthLink"
+
 typedef enum {
 	HDP_DIC_PARSE_ERROR,
 	HDP_DIC_ENTRY_PARSE_ERROR,
@@ -105,6 +109,7 @@ struct hdp_instance {
 struct hdp_link {
 	struct hdp_instance	*hdpi;		/* HDP session */
 	struct mcap_mcl 	*mcl;		/* MCAP mcl */
+	gboolean		closed;		/* MCL is closed but cached */
 	GSList			*channels;	/* Data channels */
 	char			*path;		/* HDP link path */
 	uint32_t		id;		/* Health link id */
diff --git a/health/hdp_util.c b/health/hdp_util.c
index c54f55c..72d06df 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -109,15 +109,24 @@ static void free_config(struct hdp_config *config)
 	g_free(config);
 }
 
+static void hdp_link_unregister(gpointer link, gpointer data)
+{
+	struct hdp_link *hdpl = link;
+	struct hdp_instance *hdpi = hdpl->hdpi;
+
+	hdpi->hlink = g_slist_remove(hdpi->hlink, hdpl);
+	g_dbus_unregister_interface(hdpi->adapter->conn, hdpl->path,
+								HEALTH_LINK);
+}
+
 void hdp_instance_free(struct hdp_instance *hdpi)
 {
 	debug("HDP instance %d is deleted", hdpi->id);
 	/* TODO: Complete this part */
-	/*
-	g_slist_foreach(hdpi->devices, hdp_device_unregister, NULL);
-	g_slist_free(hdpi->devices);
-	hdpi->devices = NULL;
-	*/
+
+	g_slist_foreach(hdpi->hlink, hdp_link_unregister, NULL);
+	g_slist_free(hdpi->hlink);
+	hdpi->hlink = NULL;
 
 	if (hdpi->dbus_watcher)
 		g_dbus_remove_watch(hdpi->adapter->conn, hdpi->dbus_watcher);
-- 
1.6.3.3

