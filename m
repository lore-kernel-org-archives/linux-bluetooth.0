Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 09/16] health: Get rid of gint
Date: Wed,  1 May 2013 02:12:04 -0300
Message-Id: <1367385131-24034-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 profiles/health/hdp.c           | 10 +++++-----
 profiles/health/hdp_types.h     |  6 +++---
 profiles/health/mcap.c          |  6 +++---
 profiles/health/mcap_internal.h |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index e351219..7f24756 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -211,14 +211,14 @@ static int cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
-static gint cmp_dev_addr(gconstpointer a, gconstpointer dst)
+static int cmp_dev_addr(gconstpointer a, gconstpointer dst)
 {
 	const struct hdp_device *device = a;
 
 	return bacmp(device_get_address(device->dev), dst);
 }
 
-static gint cmp_dev_mcl(gconstpointer a, gconstpointer mcl)
+static int cmp_dev_mcl(gconstpointer a, gconstpointer mcl)
 {
 	const struct hdp_device *device = a;
 
@@ -227,7 +227,7 @@ static gint cmp_dev_mcl(gconstpointer a, gconstpointer mcl)
 	return -1;
 }
 
-static gint cmp_chan_mdlid(gconstpointer a, gconstpointer b)
+static int cmp_chan_mdlid(gconstpointer a, gconstpointer b)
 {
 	const struct hdp_channel *chan = a;
 	const uint16_t *mdlid = b;
@@ -235,7 +235,7 @@ static gint cmp_chan_mdlid(gconstpointer a, gconstpointer b)
 	return chan->mdlid - *mdlid;
 }
 
-static gint cmp_chan_path(gconstpointer a, gconstpointer b)
+static int cmp_chan_path(gconstpointer a, gconstpointer b)
 {
 	const struct hdp_channel *chan = a;
 	const char *path = b;
@@ -243,7 +243,7 @@ static gint cmp_chan_path(gconstpointer a, gconstpointer b)
 	return g_ascii_strcasecmp(chan->path, path);
 }
 
-static gint cmp_chan_mdl(gconstpointer a, gconstpointer mdl)
+static int cmp_chan_mdl(gconstpointer a, gconstpointer mdl)
 {
 	const struct hdp_channel *chan = a;
 
diff --git a/profiles/health/hdp_types.h b/profiles/health/hdp_types.h
index aff16df..b34b5e0 100644
--- a/profiles/health/hdp_types.h
+++ b/profiles/health/hdp_types.h
@@ -77,7 +77,7 @@ struct hdp_application {
 	uint8_t			id;		/* The identification is also the mdepid */
 	char			*oname;		/* Name of the owner application */
 	guint			dbus_watcher;	/* Watch for clients disconnection */
-	gint			ref;		/* Reference counter */
+	int			ref;		/* Reference counter */
 };
 
 struct hdp_adapter {
@@ -98,7 +98,7 @@ struct hdp_device {
 	GSList			*channels;	/* Data Channel list */
 	struct hdp_channel	*ndc;		/* Data channel being negotiated */
 	struct hdp_channel	*fr;		/* First reliable data channel */
-	gint			ref;		/* Reference counting */
+	int			ref;		/* Reference counting */
 };
 
 struct hdp_echo_data;
@@ -114,7 +114,7 @@ struct hdp_channel {
 	uint16_t		imtu;		/* Channel incoming MTU */
 	uint16_t		omtu;		/* Channel outgoing MTU */
 	struct hdp_echo_data	*edata;		/* private data used by echo channels */
-	gint			ref;		/* Reference counter */
+	int			ref;		/* Reference counter */
 };
 
 #endif /* __HDP_TYPES_H__ */
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index f08a7fa..6d821f3 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -253,7 +253,7 @@ static void free_mdl(struct mcap_mdl *mdl)
 	g_free(mdl);
 }
 
-static gint cmp_mdl_state(gconstpointer a, gconstpointer b)
+static int cmp_mdl_state(gconstpointer a, gconstpointer b)
 {
 	const struct mcap_mdl *mdl = a;
 	const MDLState *st = b;
@@ -433,7 +433,7 @@ static mcap_md_create_mdl_req *create_mdl_req(uint16_t mdl_id, uint8_t mdep,
 	return req_mdl;
 }
 
-static gint compare_mdl(gconstpointer a, gconstpointer b)
+static int compare_mdl(gconstpointer a, gconstpointer b)
 {
 	const struct mcap_mdl *mdla = a;
 	const struct mcap_mdl *mdlb = b;
@@ -1274,7 +1274,7 @@ static gboolean check_err_rsp(struct mcap_mcl *mcl, mcap_rsp *rsp,
 				uint32_t rlen, uint32_t len, GError **gerr)
 {
 	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
-	gint err = MCAP_ERROR_FAILED;
+	int err = MCAP_ERROR_FAILED;
 	gboolean close = FALSE;
 	char *msg;
 
diff --git a/profiles/health/mcap_internal.h b/profiles/health/mcap_internal.h
index 7b044ef..7191b23 100644
--- a/profiles/health/mcap_internal.h
+++ b/profiles/health/mcap_internal.h
@@ -74,7 +74,7 @@ struct mcap_instance {
 	mcap_mcl_event_cb	mcl_uncached_cb;	/* MCL has been removed from MCAP cache */
 	mcap_info_ind_event_cb	mcl_sync_infoind_cb;	/* (CSP Master) Received info indication */
 	gpointer		user_data;		/* Data to be provided in callbacks */
-	gint			ref;			/* Reference counter */
+	int			ref;			/* Reference counter */
 
 	gboolean		csp_enabled;		/* CSP: functionality enabled */
 };
@@ -95,7 +95,7 @@ struct mcap_mcl {
 	struct mcap_mdl_cb	*cb;		/* MDL callbacks */
 	guint			tid;		/* Timer id for waiting for a response */
 	uint8_t			*lcmd;		/* Last command sent */
-	gint			ref;		/* References counter */
+	int			ref;		/* References counter */
 	uint8_t			ctrl;		/* MCL control flag */
 	uint16_t		next_mdl;	/* id used to create next MDL */
 	struct mcap_csp		*csp;		/* CSP control structure */
@@ -115,7 +115,7 @@ struct mcap_mdl {
 	uint16_t		mdlid;		/* MDL id */
 	uint8_t			mdep_id;	/* MCAP Data End Point */
 	MDLState		state;		/* MDL state */
-	gint			ref;		/* References counter */
+	int			ref;		/* References counter */
 };
 
 struct sync_info_ind_data {
-- 
1.8.2.2

