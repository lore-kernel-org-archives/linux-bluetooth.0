Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 02/16] Add MCAP instance management
Date: Wed, 28 Jul 2010 10:00:11 +0200
Message-Id: <1280304015-9230-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304015-9230-2-git-send-email-sancane@gmail.com>
References: <1280304015-9230-1-git-send-email-sancane@gmail.com>
 <1280304015-9230-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am            |    2 +-
 health/mcap.c          |  153 +++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap.h          |    4 +
 health/mcap_internal.h |   52 ++++++++++++++++
 health/mcap_lib.h      |   30 +++++++++
 5 files changed, 237 insertions(+), 4 deletions(-)
 create mode 100644 health/mcap_internal.h

diff --git a/Makefile.am b/Makefile.am
index 0781643..c8bd62a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -170,7 +170,7 @@ builtin_sources += plugins/service.c
 endif
 
 if MCAP
-mcap_sources += health/mcap_lib.h 	\
+mcap_sources += health/mcap_lib.h health/mcap_internal.h \
 		health/mcap.h health/mcap.c
 endif
 
diff --git a/health/mcap.c b/health/mcap.c
index c17546b..54e6355 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -33,6 +33,30 @@
 
 #include "mcap.h"
 #include "mcap_lib.h"
+#include "mcap_internal.h"
+
+#define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
+
+
+static void mcap_mcl_shutdown(struct mcap_mcl *mcl)
+{
+	/* TODO: implement mcap_mcl_shutdown */
+}
+
+void mcap_mcl_unref(struct mcap_mcl *mcl)
+{
+	/* TODO: implement mcap_mcl_unref */
+}
+
+static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	/* TODO: implement confirm_dc_event_cb */
+}
+
+static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	/* TODO: implement confirm_mcl_event_cb */
+}
 
 struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 					BtIOSecLevel sec,
@@ -45,11 +69,134 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 					gpointer user_data,
 					GError **gerr)
 {
-	/* TODO: Create mcap_create_instance */
-	return NULL;
+	struct mcap_instance *ms;
+
+	if (sec < BT_IO_SEC_MEDIUM) {
+		g_set_error(gerr, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+				"Security level can't be minor of %d",
+				BT_IO_SEC_MEDIUM);
+		return NULL;
+	}
+
+	if (!(mcl_connected && mcl_reconnected &&
+			mcl_disconnected && mcl_uncached)) {
+		g_set_error(gerr, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+				"The callbacks can't be null");
+		return NULL;
+	}
+
+	ms = g_new0(struct mcap_instance, 1);
+
+	adapter_get_address(btd_adapter, &ms->src);
+
+	ms->sec = sec;
+	ms->mcl_connected_cb = mcl_connected;
+	ms->mcl_reconnected_cb = mcl_reconnected;
+	ms->mcl_disconnected_cb = mcl_disconnected;
+	ms->mcl_uncached_cb = mcl_uncached;
+	ms->user_data = user_data;
+
+	/* Listen incoming connections in control channel */
+	ms->ccio = bt_io_listen(BT_IO_L2CAP, NULL, confirm_mcl_event_cb, ms,
+				NULL, gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
+				BT_IO_OPT_PSM, ccpsm,
+				BT_IO_OPT_MTU, MCAP_CC_MTU,
+				BT_IO_OPT_SEC_LEVEL, sec,
+				BT_IO_OPT_INVALID);
+	if (!ms->ccio) {
+		error("%s", (*gerr)->message);
+		g_free(ms);
+		return NULL;
+	}
+
+	/* Listen incoming connections in data channels */
+	ms->dcio = bt_io_listen(BT_IO_L2CAP, NULL, confirm_dc_event_cb, ms,
+				NULL, gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
+				BT_IO_OPT_PSM, dcpsm,
+				BT_IO_OPT_MTU, MCAP_DC_MTU,
+				BT_IO_OPT_SEC_LEVEL, sec,
+				BT_IO_OPT_INVALID);
+	if (!ms->dcio) {
+		g_io_channel_shutdown(ms->ccio, TRUE, NULL);
+		g_io_channel_unref(ms->ccio);
+		ms->ccio = NULL;
+		error("%s", (*gerr)->message);
+		g_free(ms);
+		return NULL;
+	}
+	/* Initialize random seed to generate mdlids for this instance */
+	srand(time(NULL));
+	return ms;
 }
 
 void mcap_release_instance(struct mcap_instance *mi)
 {
-	/* TODO: Create mcap_release_instance */
+	GSList *l;
+
+	if (!mi)
+		return;
+
+	if (mi->ccio) {
+		g_io_channel_shutdown(mi->ccio, TRUE, NULL);
+		g_io_channel_unref(mi->ccio);
+		mi->ccio = NULL;
+	}
+
+	if (mi->dcio) {
+		g_io_channel_shutdown(mi->dcio, TRUE, NULL);
+		g_io_channel_unref(mi->dcio);
+		mi->dcio = NULL;
+	}
+
+	for (l = mi->mcls; l; l = l->next) {
+		mcap_mcl_shutdown(l->data);
+		mcap_mcl_unref(l->data);
+	}
+	g_slist_free(mi->mcls);
+	mi->mcls = NULL;
+
+	for (l = mi->cached; l; l = l->next)
+		mcap_mcl_unref(l->data);
+	g_slist_free(mi->cached);
+	mi->cached = NULL;
+
+	g_free(mi);
+}
+
+uint16_t mcap_get_ctrl_psm(struct mcap_instance *mi, GError **err)
+{
+	uint16_t lpsm;
+
+	if (!(mi && mi->ccio)) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+			"Invalid MCAP instance");
+		return 0;
+	}
+
+	bt_io_get(mi->ccio, BT_IO_L2CAP, err,
+			BT_IO_OPT_PSM, &lpsm,
+			BT_IO_OPT_INVALID);
+	if (*err)
+		return 0;
+	return lpsm;
+}
+
+uint16_t mcap_get_data_psm(struct mcap_instance *mi, GError **err)
+{
+	uint16_t lpsm;
+
+	if (!(mi && mi->dcio)) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+			"Invalid MCAP instance");
+		return 0;
+	}
+
+	bt_io_get(mi->dcio, BT_IO_L2CAP, err,
+			BT_IO_OPT_PSM, &lpsm,
+			BT_IO_OPT_INVALID);
+	if (*err)
+		return 0;
+	return lpsm;
 }
diff --git a/health/mcap.h b/health/mcap.h
index c1167fa..139b562 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -31,6 +31,10 @@
 extern "C" {
 #endif
 
+/* maximum transmission unit for channels */
+#define MCAP_CC_MTU	48
+#define MCAP_DC_MTU	L2CAP_DEFAULT_MTU
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/health/mcap_internal.h b/health/mcap_internal.h
new file mode 100644
index 0000000..ed4ed58
--- /dev/null
+++ b/health/mcap_internal.h
@@ -0,0 +1,52 @@
+/*
+ *
+ *  MCAP for BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *
+ *  Authors:
+ *  Santiago Carot-Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MCAP_INTERNAL_H
+#define __MCAP_INTERNAL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct mcap_instance {
+	bdaddr_t		src;			/* Source address */
+	GIOChannel		*ccio;			/* Control Channel IO */
+	GIOChannel		*dcio;			/* Data Channel IO */
+	GSList			*mcls;			/* MCAP instance list */
+	GSList			*cached;		/* List with all cached MCLs (MAX_CACHED macro) */
+	BtIOSecLevel		sec;			/* Security level */
+	mcap_mcl_event_cb	mcl_connected_cb;	/* New MCL connected */
+	mcap_mcl_event_cb	mcl_reconnected_cb;	/* Old MCL has been reconnected */
+	mcap_mcl_event_cb	mcl_disconnected_cb;	/* MCL disconnected */
+	mcap_mcl_event_cb	mcl_uncached_cb;	/* MCL has been removed from MCAP cache */
+	gpointer		user_data;		/* Data to be provided in callbacks */
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MCAP_INTERNAL_H */
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index 714610e..81d8b14 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -35,11 +35,38 @@ extern "C" {
 #include "btio.h"
 #include <bluetooth/l2cap.h>
 
+typedef enum {
+/* MCAP Error Response Codes */
+	MCAP_ERROR_INVALID_OP_CODE = 1,
+	MCAP_ERROR_INVALID_PARAM_VALUE,
+	MCAP_ERROR_INVALID_MDEP,
+	MCAP_ERROR_MDEP_BUSY,
+	MCAP_ERROR_INVALID_MDL,
+	MCAP_ERROR_MDL_BUSY,
+	MCAP_ERROR_INVALID_OPERATION,
+	MCAP_ERROR_RESOURCE_UNAVAILABLE,
+	MCAP_ERROR_UNSPECIFIED_ERROR,
+	MCAP_ERROR_REQUEST_NOT_SUPPORTED,
+	MCAP_ERROR_CONFIGURATION_REJECTED,
+/* MCAP Internal Errors */
+	MCAP_ERROR_INVALID_ARGS,
+	MCAP_ERROR_ALREADY_EXISTS,
+	MCAP_ERROR_REQ_IGNORED,
+	MCAP_ERROR_MCL_CLOSED,
+	MCAP_ERROR_FAILED
+} McapError;
+
 struct mcap_instance;
 struct mcap_mcl;
 
+/************ Callbacks ************/
+
+/* mcl callbacks */
+
 typedef void (* mcap_mcl_event_cb) (struct mcap_mcl *mcl, gpointer data);
 
+/************ Operations ************/
+
 /* MCAP main operations */
 
 struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
@@ -54,6 +81,9 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 
 void mcap_release_instance(struct mcap_instance *mi);
 
+uint16_t mcap_get_ctrl_psm(struct mcap_instance *mi, GError **err);
+uint16_t mcap_get_data_psm(struct mcap_instance *mi, GError **err);
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.6.3.3

