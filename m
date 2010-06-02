Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 26/32] Implement connect data channel callback
Date: Wed,  2 Jun 2010 15:19:22 +0200
Message-Id: <1275484768-25838-27-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
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
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-26-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c       |   68 +++++++++++++++++++++++++++++++++++++++++++++++----
 health/hdp_types.h |    5 ++++
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index a38cbe0..1d626d7 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -107,6 +107,13 @@ static struct hdp_link *find_health_link(struct hdp_adapter *adapter,
 	return NULL;
 }
 
+static int hdp_supp_fts_mdepcmp(gconstpointer ft, gconstpointer mdepid)
+{
+	const struct hdp_supp_fts *fts = ft;
+
+	return bcmp(&fts->mdepid, mdepid, sizeof(uint8_t));
+}
+
 static int hdp_instance_idcmp(gconstpointer instance, gconstpointer p)
 {
 	const struct hdp_instance *hdpi = instance;
@@ -379,19 +386,65 @@ static void hdp_mcap_mdl_closed_cb(struct mcap_mdl *mdl, void *data)
 	debug("TODO: Incomplete callback, mdl closed");
 }
 
-static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mdl *mdl, void *data)
+static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mdl *mdl, void *data)
 {
 	/* struct hdp_link *hdpl = data; */
 	debug("TODO: Incomplete callback, mdl connection request");
 	return MCAP_REQUEST_NOT_SUPPORTED;
 }
 
-static uint8_t hdp_mcap_mdl_reconn_req_cb(struct mcap_mcl *mcl,
-					  uint8_t mdepid, uint16_t mdlid,
-					  uint8_t *conf, void *data)
+static uint8_t hdp_mcap_mdl_conn_req_cb(struct mcap_mcl *mcl, uint8_t mdepid,
+				uint16_t mdlid, uint8_t *conf, void *data)
 {
-	debug("TODO: Incomplete callback, mdl reconnection request");
-	return MCAP_REQUEST_NOT_SUPPORTED;
+	struct hdp_link *hdpl = data;
+	struct hdp_supp_fts *f;
+	struct hdp_dc *dc;
+	uint8_t new_conf;
+	GSList *l;
+
+	l = g_slist_find_custom(hdpl->hdpi->config->supp_fts, &mdepid,
+							hdp_supp_fts_mdepcmp);
+	if (!l)
+		return MCAP_INVALID_MDEP;
+	f = l->data;
+
+	/* Check if is the first dc if so,
+	 * only reliable configuration is allowed */
+	switch(*conf) {
+		case HDP_NO_PREFERENCE_DC:
+			if (f->role == HDP_SINK)
+				return MCAP_CONFIGURATION_REJECTED;
+			else
+				new_conf = HDP_RELIABLE_DC;
+			break;
+		case HDP_STREAMING_DC:
+			if (g_slist_length(hdpl->channels) == 0)
+				return MCAP_CONFIGURATION_REJECTED;
+		case HDP_RELIABLE_DC:
+			if (f->role == HDP_SOURCE)
+				return MCAP_CONFIGURATION_REJECTED;
+			new_conf = *conf;
+			break;
+		default:
+			/* Special case defined in HDP spec 3.4. When an invalid
+			 * configuration is received we need close the MCL when
+			 * we are still processing the callback. When MCL is
+			 * closed in a callback the returned value won't be
+			 * proccesed in MCAP */
+			/* TODO: Send MCL disconnection to agent */
+			g_dbus_unregister_interface(hdpl->hdpi->adapter->conn,
+						hdpl->path, HEALTH_LINK);
+			return MCAP_CONFIGURATION_REJECTED; /* not processed */
+	}
+	*conf = new_conf;
+
+	dc = g_new0(struct hdp_dc, 1);
+	dc->hdpl = hdpl;
+	dc->conf = *conf;
+	dc->mdlid = mdlid;
+
+	hdpl->ndc = dc;
+	return MCAP_SUCCESS;
 }
 
 static void health_link_free(struct hdp_link *hdpl)
@@ -406,6 +459,9 @@ static void health_link_free(struct hdp_link *hdpl)
 	if (hdpl->path)
 		g_free(hdpl->path);
 
+	if (hdpl->ndc)
+		g_free(hdpl->ndc);
+
 	hdpl->hdpi->hlink = g_slist_remove(hdpl->hdpi->hlink, hdpl);
 	g_free(hdpl);
 }
diff --git a/health/hdp_types.h b/health/hdp_types.h
index 6d41e2b..abbfbf3 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -46,6 +46,10 @@
 #define HEALTH_DEVICE			"org.bluez.HealthDevice"
 #define HEALTH_LINK			"org.bluez.HealthLink"
 
+#define HDP_NO_PREFERENCE_DC	0x00
+#define HDP_RELIABLE_DC		0x01
+#define HDP_STREAMING_DC	0x02
+
 typedef enum {
 	HDP_DIC_PARSE_ERROR,
 	HDP_DIC_ENTRY_PARSE_ERROR,
@@ -113,6 +117,7 @@ struct hdp_link {
 	GSList			*channels;	/* Data channels */
 	char			*path;		/* HDP link path */
 	uint32_t		id;		/* Health link id */
+	struct hdp_dc		*ndc;		/* Data channel negotiated */
 };
 
 struct hdp_dc {
-- 
1.6.3.3

