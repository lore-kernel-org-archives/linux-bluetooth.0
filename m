Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jos=C3=A9=20Antonio=20Santos=20Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 31/32] Send MCL disconnect callback to agents
Date: Fri,  4 Jun 2010 10:30:24 +0200
Message-Id: <1275640225-4186-32-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275640225-4186-31-git-send-email-santoscadenas@gmail.com>
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
 <1275640225-4186-24-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-25-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-26-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-27-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-28-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-29-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-30-git-send-email-santoscadenas@gmail.com>
 <1275640225-4186-31-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos Cadenas <santoscadenas@gmail.com>

Whenever a MCL is discoinnected we shall notify to agents using
D-Bus callback.
---
 health/hdp.c |   82 +++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 1fc1cb9..6a73e05 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -393,10 +393,46 @@ static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
 	return MCAP_REQUEST_NOT_SUPPORTED;
 }
 
+static void health_link_free(struct hdp_link *hdpl)
+{
+	/*TODO: Release structures related with Data Channels */
+
+	if (hdpl->mcl) {
+		mcap_close_mcl(hdpl->mcl, FALSE);
+		mcap_mcl_unref(hdpl->mcl);
+	}
+
+	if (hdpl->path)
+		g_free(hdpl->path);
+
+	if (hdpl->ndc)
+		g_free(hdpl->ndc);
+
+	g_free(hdpl);
+}
+
+static gboolean agent_mcl_disconnect_msg(struct hdp_link *hdpl)
+{
+	struct hdp_instance *hdpi = hdpl->hdpi;
+	DBusMessage* message;
+
+	message = dbus_message_new_method_call(hdpi->aname, hdpi->apath,
+					HEALTH_AGENT, "LinkDisconnected");
+	if (!message) {
+		error("Couldn't allocate D-Bus message");
+		return FALSE;
+	}
+
+	dbus_message_append_args(message, DBUS_TYPE_OBJECT_PATH, &hdpl->path,
+							DBUS_TYPE_INVALID);
+	return g_dbus_send_message(hdpi->adapter->conn, message);
+}
+
 static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				uint16_t mdlid, uint8_t *conf, void *data)
 {
 	struct hdp_link *hdpl = data;
+	struct hdp_instance *hdpi;
 	struct hdp_supp_fts *f;
 	struct hdp_dc *dc;
 	uint8_t new_conf;
@@ -418,7 +454,7 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 				new_conf = HDP_RELIABLE_DC;
 			break;
 		case HDP_STREAMING_DC:
-			if (g_slist_length(hdpl->channels) == 0)
+			if (!hdpl->channels)
 				return MCAP_CONFIGURATION_REJECTED;
 		case HDP_RELIABLE_DC:
 			if (f->role == HDP_SOURCE)
@@ -427,13 +463,16 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 			break;
 		default:
 			/* Special case defined in HDP spec 3.4. When an invalid
-			 * configuration is received we need close the MCL when
+			 * configuration is received we shall close the MCL when
 			 * we are still processing the callback. When MCL is
 			 * closed in a callback the returned value won't be
 			 * proccesed in MCAP */
-			/* TODO: Send MCL disconnection to agent */
-			g_dbus_unregister_interface(hdpl->hdpi->adapter->conn,
-						hdpl->path, HEALTH_LINK);
+			hdpi = hdpl->hdpi;
+			hdpi->hlink = g_slist_remove(hdpi->hlink, hdpl);
+			agent_mcl_disconnect_msg(hdpl);
+			if (!g_dbus_unregister_interface(hdpi->adapter->conn,
+						hdpl->path, HEALTH_LINK))
+				health_link_free(hdpl);
 			return MCAP_CONFIGURATION_REJECTED; /* not processed */
 	}
 	*conf = new_conf;
@@ -447,25 +486,6 @@ static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
 	return MCAP_SUCCESS;
 }
 
-static void health_link_free(struct hdp_link *hdpl)
-{
-	/*TODO: Release structures related with Data Channels */
-
-	if (hdpl->mcl) {
-		mcap_close_mcl(hdpl->mcl, FALSE);
-		mcap_mcl_unref(hdpl->mcl);
-	}
-
-	if (hdpl->path)
-		g_free(hdpl->path);
-
-	if (hdpl->ndc)
-		g_free(hdpl->ndc);
-
-	hdpl->hdpi->hlink = g_slist_remove(hdpl->hdpi->hlink, hdpl);
-	g_free(hdpl);
-}
-
 static void health_link_path_unregister(void *data)
 {
 	struct hdp_link *hdpl = data;
@@ -696,8 +716,11 @@ static DBusMessage *hdp_disconnect(DBusConnection *conn,
 	if (cache) {
 		mcap_close_mcl(hdpl->mcl, cache);
 		hdpl->closed = TRUE;
-	} else
-		g_dbus_unregister_interface(conn, hdpl->path, HEALTH_LINK);
+	} else {
+		hdpl->hdpi->hlink = g_slist_remove(hdpl->hdpi->hlink, hdpl);
+		if (!g_dbus_unregister_interface(conn, hdpl->path, HEALTH_LINK))
+			health_link_free(hdpl);
+	}
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
@@ -788,7 +811,6 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 	}
 	error("D-Bus send failed");
 	health_link_free(hdpl);
-	dbus_message_unref(message);
 }
 
 static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
@@ -837,8 +859,10 @@ static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
 	hdpl = l->data;
 
 	hdpi->hlink = g_slist_remove(hdpi->hlink, hdpl);
-	g_dbus_unregister_interface(hdpi->adapter->conn, hdpl->path,
-								HEALTH_LINK);
+	agent_mcl_disconnect_msg(hdpl);
+	if (!g_dbus_unregister_interface(hdpi->adapter->conn, hdpl->path,
+								HEALTH_LINK))
+		health_link_free(hdpl);
 }
 
 static DBusMessage *hdp_create_instance(DBusConnection *conn,
-- 
1.6.3.3

