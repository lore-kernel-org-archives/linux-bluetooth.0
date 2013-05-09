Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 13/26] health: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:43 -0300
Message-Id: <1368073016-28434-13-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/health/hdp.c           |  6 +++---
 profiles/health/hdp_types.h     |  4 +++-
 profiles/health/hdp_util.c      | 10 +++++-----
 profiles/health/mcap_internal.h |  8 +++++---
 profiles/health/mcap_sync.c     | 14 +++++++-------
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 7f24756..5e43682 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -24,8 +24,8 @@
 #include "config.h"
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
-#include <stdint.h>
 #include <stdbool.h>
 #include <sdpd.h>
 #include <unistd.h>
@@ -66,14 +66,14 @@ struct hdp_create_dc {
 	struct hdp_device		*dev;
 	uint8_t				config;
 	uint8_t				mdep;
-	guint				ref;
+	unsigned int				ref;
 	mcap_mdl_operation_cb		cb;
 };
 
 struct hdp_tmp_dc_data {
 	DBusMessage			*msg;
 	struct hdp_channel		*hdp_chann;
-	guint				ref;
+	unsigned int				ref;
 	mcap_mdl_operation_cb		cb;
 };
 
diff --git a/profiles/health/hdp_types.h b/profiles/health/hdp_types.h
index b34b5e0..c730b11 100644
--- a/profiles/health/hdp_types.h
+++ b/profiles/health/hdp_types.h
@@ -23,6 +23,8 @@
 #ifndef __HDP_TYPES_H__
 #define __HDP_TYPES_H__
 
+#include <inttypes.h>
+
 #define MANAGER_PATH		"/org/bluez"
 
 #define HEALTH_MANAGER		"org.bluez.HealthManager1"
@@ -76,7 +78,7 @@ struct hdp_application {
 	char			*description;	/* Options description for SDP record */
 	uint8_t			id;		/* The identification is also the mdepid */
 	char			*oname;		/* Name of the owner application */
-	guint			dbus_watcher;	/* Watch for clients disconnection */
+	unsigned int		dbus_watcher;	/* Watch for clients disconnection */
 	int			ref;		/* Reference counter */
 };
 
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index b53f1db..355496e 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -24,7 +24,7 @@
 #include <config.h>
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <stdbool.h>
 
 #include <glib.h>
@@ -874,7 +874,7 @@ gboolean hdp_get_mdep(struct hdp_device *device, struct hdp_application *app,
 	return TRUE;
 }
 
-static gboolean get_prot_desc_entry(sdp_data_t *entry, int type, guint16 *val)
+static gboolean get_prot_desc_entry(sdp_data_t *entry, int type, uint16_t *val)
 {
 	sdp_data_t *iter;
 	int proto;
@@ -902,8 +902,8 @@ static gboolean get_prot_desc_entry(sdp_data_t *entry, int type, guint16 *val)
 	return TRUE;
 }
 
-static gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
-							guint16 *version)
+static gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, uint16_t *psm,
+							uint16_t *version)
 {
 	sdp_data_t *pdl, *p0, *p1;
 
@@ -926,7 +926,7 @@ static gboolean hdp_get_prot_desc_list(const sdp_record_t *rec, guint16 *psm,
 }
 
 static gboolean hdp_get_add_prot_desc_list(const sdp_record_t *rec,
-								guint16 *psm)
+								uint16_t *psm)
 {
 	sdp_data_t *pdl, *p0, *p1;
 
diff --git a/profiles/health/mcap_internal.h b/profiles/health/mcap_internal.h
index 7191b23..016d40f 100644
--- a/profiles/health/mcap_internal.h
+++ b/profiles/health/mcap_internal.h
@@ -27,6 +27,8 @@
 extern "C" {
 #endif
 
+#include <inttypes.h>
+
 typedef enum {
 	MCL_CONNECTED,
 	MCL_PENDING,
@@ -86,14 +88,14 @@ struct mcap_mcl {
 	struct mcap_instance	*mi;		/* MCAP instance where this MCL belongs */
 	bdaddr_t		addr;		/* Device address */
 	GIOChannel		*cc;		/* MCAP Control Channel IO */
-	guint			wid;		/* MCL Watcher id */
+	unsigned int		wid;		/* MCL Watcher id */
 	GSList			*mdls;		/* List of Data Channels shorted by mdlid */
 	MCLState		state;		/* Current MCL State */
 	MCLRole			role;		/* Initiator or acceptor of this MCL */
 	MCAPCtrl		req;		/* Request control flag */
 	struct mcap_mdl_op_cb	*priv_data;	/* Temporal data to manage responses */
 	struct mcap_mdl_cb	*cb;		/* MDL callbacks */
-	guint			tid;		/* Timer id for waiting for a response */
+	unsigned int		tid;		/* Timer id for waiting for a response */
 	uint8_t			*lcmd;		/* Last command sent */
 	int			ref;		/* References counter */
 	uint8_t			ctrl;		/* MCL control flag */
@@ -111,7 +113,7 @@ struct mcap_mcl {
 struct mcap_mdl {
 	struct mcap_mcl		*mcl;		/* MCL where this MDL belongs */
 	GIOChannel		*dc;		/* MCAP Data Channel IO */
-	guint			wid;		/* MDL Watcher id */
+	unsigned int			wid;		/* MDL Watcher id */
 	uint16_t		mdlid;		/* MDL id */
 	uint8_t			mdep_id;	/* MCAP Data End Point */
 	MDLState		state;		/* MDL state */
diff --git a/profiles/health/mcap_sync.c b/profiles/health/mcap_sync.c
index 0d9f17d..15d9d3f 100644
--- a/profiles/health/mcap_sync.c
+++ b/profiles/health/mcap_sync.c
@@ -25,7 +25,7 @@
 #include <config.h>
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <netinet/in.h>
 #include <time.h>
 #include <stdlib.h>
@@ -51,13 +51,13 @@
 struct mcap_csp {
 	uint64_t	base_tmstamp;	/* CSP base timestamp */
 	struct timespec	base_time;	/* CSP base time when timestamp set */
-	guint		local_caps;	/* CSP-Master: have got remote caps */
-	guint		remote_caps;	/* CSP-Slave: remote master got caps */
-	guint		rem_req_acc;	/* CSP-Slave: accuracy required by master */
-	guint		ind_expected;	/* CSP-Master: indication expected */
+	unsigned int	local_caps;	/* CSP-Master: have got remote caps */
+	unsigned int	remote_caps;	/* CSP-Slave: remote master got caps */
+	unsigned int	rem_req_acc;	/* CSP-Slave: accuracy required by master */
+	unsigned int	ind_expected;	/* CSP-Master: indication expected */
 	MCAPCtrl	csp_req;	/* CSP-Master: Request control flag */
-	guint		ind_timer;	/* CSP-Slave: indication timer */
-	guint		set_timer;	/* CSP-Slave: delayed set timer */
+	unsigned int	ind_timer;	/* CSP-Slave: indication timer */
+	unsigned int	set_timer;	/* CSP-Slave: delayed set timer */
 	void		*set_data;	/* CSP-Slave: delayed set data */
 	void		*csp_priv_data;	/* CSP-Master: In-flight request data */
 };
-- 
1.8.2.2

