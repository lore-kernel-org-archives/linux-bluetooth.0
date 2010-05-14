Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 01/25] Initial support for MCAP
Date: Fri, 14 May 2010 12:19:28 +0200
Message-Id: <1273832392-18654-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am          |   13 ++++-
 acinclude.m4         |    6 ++
 mcap/mcap.c          |   56 +++++++++++++++++
 mcap/mcap.h          |  165 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mcap/mcap_internal.h |  118 +++++++++++++++++++++++++++++++++++
 mcap/mcap_lib.h      |  163 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 520 insertions(+), 1 deletions(-)
 create mode 100644 mcap/mcap.c
 create mode 100644 mcap/mcap.h
 create mode 100644 mcap/mcap_internal.h
 create mode 100644 mcap/mcap_lib.h

diff --git a/Makefile.am b/Makefile.am
index f991121..0c139a1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -101,6 +101,7 @@ gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/object.c gdbus/watch.c
 builtin_modules =
 builtin_sources =
 builtin_nodist =
+mcap_sources =
 
 if PNATPLUGIN
 builtin_modules += pnat
@@ -168,6 +169,12 @@ builtin_modules += service
 builtin_sources += plugins/service.c
 endif
 
+if MCAP
+mcap_sources += mcap/mcap_internal.h	\
+		mcap/mcap_lib.h		\
+		mcap/mcap.h mcap/mcap.c
+endif
+
 builtin_modules += hciops
 builtin_sources += plugins/hciops.c
 
@@ -196,7 +203,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
-			src/dbus-hci.h src/dbus-hci.c
+			src/dbus-hci.h src/dbus-hci.c \
+			$(mcap_sources)
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
@@ -318,6 +326,9 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus
 
+if MCAP
+INCLUDES += -I$(builddir)/mcap
+endif
 
 pkgconfigdir = $(libdir)/pkgconfig
 
diff --git a/acinclude.m4 b/acinclude.m4
index f7bb047..b512cfb 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -167,6 +167,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	serial_enable=yes
 	network_enable=yes
 	service_enable=yes
+	mcap_enable=no
 	pnat_enable=no
 	tracer_enable=no
 	tools_enable=yes
@@ -215,6 +216,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		service_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(mcap, AC_HELP_STRING([--enable-mcap], [enable mcap support]), [
+			mcap_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(pnat, AC_HELP_STRING([--enable-pnat], [enable pnat plugin]), [
 		pnat_enable=${enableval}
 	])
@@ -325,6 +330,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
+	AM_CONDITIONAL(MCAP, test "${mcap_enable}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(TRACER, test "${tracer_enable}" = "yes")
diff --git a/mcap/mcap.c b/mcap/mcap.c
new file mode 100644
index 0000000..48ea5cf
--- /dev/null
+++ b/mcap/mcap.c
@@ -0,0 +1,56 @@
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
+#include "logging.h"
+#include "btio.h"
+#include "error.h"
+
+#include <netinet/in.h>
+
+#include "mcap.h"
+#include "mcap_lib.h"
+#include "mcap_internal.h"
+
+struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
+					BtIOSecLevel sec,
+					uint16_t ccpsm,
+					uint16_t dcpsm,
+					GError **gerr,
+					mcap_mcl_event_cb mcl_connected,
+					mcap_mcl_event_cb mcl_reconnected,
+					mcap_mcl_event_cb mcl_disconnected,
+					mcap_mcl_event_cb mcl_uncached,
+					gpointer user_data)
+{
+	/* TODO */
+	return NULL;
+}
+
+void mcap_release_instance(struct mcap_instance *ms)
+{
+	/* TODO */
+}
+
diff --git a/mcap/mcap.h b/mcap/mcap.h
new file mode 100644
index 0000000..0299f42
--- /dev/null
+++ b/mcap/mcap.h
@@ -0,0 +1,165 @@
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
+#ifndef __MCAP_H
+#define __MCAP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define MCAP_VERSION	0x0100	/* current version 01.00 */
+
+/* bytes to get MCAP Supported Procedures */
+#define MCAP_SUP_PROC	0x06
+
+/* maximum transmission unit for channels */
+#define MCAP_CC_MTU	48
+#define MCAP_DC_MTU	L2CAP_DEFAULT_MTU
+
+
+/* MCAP Standard Op Codes */
+#define MCAP_ERROR_RSP			0x00
+#define MCAP_MD_CREATE_MDL_REQ		0x01
+#define MCAP_MD_CREATE_MDL_RSP		0x02
+#define MCAP_MD_RECONNECT_MDL_REQ	0x03
+#define MCAP_MD_RECONNECT_MDL_RSP	0x04
+#define MCAP_MD_ABORT_MDL_REQ		0x05
+#define MCAP_MD_ABORT_MDL_RSP		0x06
+#define MCAP_MD_DELETE_MDL_REQ		0x07
+#define MCAP_MD_DELETE_MDL_RSP		0x08
+
+/* MCAP Clock Sync Op Codes */
+#define MCAP_MD_SYNC_CAP_REQ		0x11
+#define MCAP_MD_SYNC_CAP_RSP		0x12
+#define MCAP_MD_SYNC_SET_REQ		0x13
+#define MCAP_MD_SYNC_SET_RSP            0x14
+#define MCAP_MD_SYNC_INFO_IND		0x15
+
+/* MCAP Response codes */
+#define MCAP_SUCCESS			0x00
+#define MCAP_INVALID_OP_CODE		0x01
+#define MCAP_INVALID_PARAM_VALUE	0x02
+#define MCAP_INVALID_MDEP		0x03
+#define MCAP_MDEP_BUSY			0x04
+#define MCAP_INVALID_MDL		0x05
+#define MCAP_MDL_BUSY			0x06
+#define MCAP_INVALID_OPERATION		0x07
+#define MCAP_RESOURCE_UNAVAILABLE	0x08
+#define MCAP_UNSPECIFIED_ERROR		0x09
+#define MCAP_REQUEST_NOT_SUPPORTED	0x0A
+#define MCAP_CONFIGURATION_REJECTED	0x0B
+
+/* MDL IDs */
+#define MCAP_MDLID_RESERVED		0x0000
+#define MCAP_MDLID_INITIAL		0x0001
+#define MCAP_MDLID_FINAL		0xFEFF
+#define MCAP_ALL_MDLIDS			0xFFFF
+
+/* MDEP IDs */
+#define MCAP_MDEPID_INITIAL		0x00
+#define MCAP_MDEPID_FINAL		0x7F
+
+
+/*
+ * MCAP Request Packet Format
+ */
+
+typedef struct {
+	uint8_t         op;
+        uint16_t	mdl;
+	uint8_t		mdep;
+	uint8_t		conf;
+} __attribute__ ((packed)) mcap_md_create_mdl_req;
+
+typedef struct {
+        uint8_t         op;
+        uint16_t        mdl;
+} __attribute__ ((packed)) mcap_md_req;
+
+
+/*
+ * MCAP Response Packet Format
+ */
+
+typedef struct {
+        uint8_t         op;
+        uint8_t         rc;
+	uint16_t        mdl;
+} __attribute__ ((packed)) mcap4B_rsp;
+
+typedef struct {
+        uint8_t         op;
+        uint8_t         rc;
+        uint16_t        mdl;
+        uint8_t         param;
+} __attribute__ ((packed)) mcap5B_rsp;
+
+
+/*
+ * MCAP Clock Synchronization Protocol
+ */
+typedef struct {
+        uint8_t         op;
+        uint16_t        timest;
+} __attribute__ ((packed)) mcap_md_sync_cap_req;
+
+typedef struct {
+        uint8_t         op;
+	uint8_t         rc;
+	uint8_t         btclock;
+        uint16_t        sltime;
+	uint16_t        timestnr;
+	uint16_t        timestna;
+} __attribute__ ((packed)) mcap_md_sync_cap_rsp;
+
+typedef struct {
+        uint8_t         op;
+	uint8_t         timestui;
+        uint32_t        btclock;
+	uint64_t        timestst;
+} __attribute__ ((packed)) mcap_md_sync_set_req;
+
+typedef struct {
+        uint8_t         op;
+	uint8_t         rc;
+        uint32_t        btclock;
+	uint64_t        timestst;
+	uint16_t        timestsa;
+} __attribute__ ((packed)) mcap_md_sync_set_rsp;
+
+typedef struct {
+        uint8_t         op;
+        uint32_t        btclock;
+	uint64_t        timestst;
+	uint16_t        timestsa;
+} __attribute__ ((packed)) mcap_md_sync_info_ind;
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MCAP_H */
diff --git a/mcap/mcap_internal.h b/mcap/mcap_internal.h
new file mode 100644
index 0000000..0c72c7f
--- /dev/null
+++ b/mcap/mcap_internal.h
@@ -0,0 +1,118 @@
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
+typedef enum {
+	MCL_CONNECTED,
+	MCL_PENDING,
+	MCL_ACTIVE,
+	MCL_IDLE
+} MCLState;
+
+typedef enum {
+	MCL_ACCEPTOR,
+	MCL_INITIATOR
+} MCLRole;
+
+typedef enum {
+	MCL_AVAILABLE,
+	MCL_WAITING_RSP
+} MCAPCtrl;
+
+typedef enum {
+	MDL_WAITING,
+	MDL_CONNECTED,
+	MDL_DELETING,
+	MDL_CLOSED
+} MDLState;
+
+struct mcap_mdl_cb {
+	mcap_mdl_event_cb 		mdl_connected;	/* Remote device has created a MDL */
+	mcap_mdl_event_cb 		mdl_closed;	/* Remote device has closed a MDL */
+	mcap_mdl_event_cb 		mdl_deleted;	/* Remote device requested deleting a MDL */
+	mcap_mdl_event_cb		mdl_aborted;	/* Remote device aborted the mdl creation */
+	mcap_remote_mdl_conn_req_cb	mdl_conn_req;	/* Remote device requested creating a MDL */
+	mcap_remote_mdl_reconn_req_cb 	mdl_reconn_req;	/* Remote device requested reconnecting a MDL */
+	gpointer			user_data;	/* User data */
+};
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
+struct mcap_mcl {
+	struct mcap_instance	*ms;		/* MCAP instance where this MCL belongs */
+	bdaddr_t		addr;		/* Device address */
+	GIOChannel		*cc;		/* MCAP Control Channel IO */
+	guint			wid;		/* MCL Watcher id */
+	GSList			*mdls;		/* List of Data Channels shorted by mdlid */
+	MCLState		state;		/* Current MCL State */
+	MCLRole			role;		/* Initiator or acceptor of this MCL */
+	MCAPCtrl		req;		/* Request control flag */
+	void			*priv_data;	/* Temporal data to manage in responses */
+	struct mcap_mdl_cb	*cb;		/* MDL callbacks */
+	guint			tid;		/* Timer id for waiting for a response */
+	uint8_t			*lcmd;		/* Last command sent */
+	guint			ref;		/* References counter */
+	uint8_t			ctrl;		/* MCL control flag */
+};
+
+#define	MCAP_CTRL_CACHED	0x01	/* MCL is cached */
+#define	MCAP_CTRL_STD_OP	0x02	/* Support for standard op codes */
+#define	MCAP_CTRL_SYNC_OP	0x04	/* Support for synchronization commands */
+#define	MCAP_CTRL_CONN		0x08	/* MCL is in connecting process */
+#define	MCAP_CTRL_FREE		0x10	/* MCL is marked as releasable */
+#define	MCAP_CTRL_NOCACHE	0x20	/* MCL is marked as not cacheable */
+
+struct mcap_mdl {
+	struct mcap_mcl		*mcl;		/* MCL where this MDL belongs */
+	GIOChannel		*dc;		/* MCAP Data Channel IO */
+	guint			wid;		/* MDL Watcher id */
+	uint16_t		mdlid;		/* MDL id */
+	uint8_t			mdep_id;	/* MCAP Data End Point */
+	MDLState		state;		/* MDL state */
+};
+
+int mcap_send_data(int sock, const uint8_t *buf, uint32_t size);
+void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+
+#endif /* __MCAP_INTERNAL_H */
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
new file mode 100644
index 0000000..e9ed5e1
--- /dev/null
+++ b/mcap/mcap_lib.h
@@ -0,0 +1,163 @@
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
+#ifndef __MCAP_LIB_H
+#define __MCAP_LIB_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "adapter.h"
+
+#include <bluetooth/l2cap.h>
+#include "btio.h"
+
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
+	MCAP_ERROR_FAILED
+} McapError;
+
+typedef enum {
+	MCAP_MDL_CB_INVALID,
+	MCAP_MDL_CB_CONNECTED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_CLOSED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_DELETED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_ABORTED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_REMOTE_CONN_REQ,	/* mcap_remote_mdl_conn_req_cb */
+	MCAP_MDL_CB_REMOTE_RECONN_REQ	/* mcap_remote_mdl_reconn_req_cb */
+} McapMclCb;
+
+struct mcap_instance;
+struct mcap_mcl;
+struct mcap_mdl;
+
+/************ Callbacks ************/
+
+/* mdl callbacks */
+
+typedef void (* mcap_mdl_event_cb) (struct mcap_mdl *mdl, gpointer data);
+typedef void (* mcap_mdl_operation_conf_cb) (struct mcap_mdl *mdl, uint8_t conf,
+						GError *err, gpointer data);
+typedef void (* mcap_mdl_operation_cb) (struct mcap_mdl *mdl, GError *err,
+						gpointer data);
+typedef void (* mcap_mdl_del_cb) (GError *err, gpointer data);
+
+/* Next function should return an MCAP appropriate response code */
+typedef uint8_t (* mcap_remote_mdl_conn_req_cb) (struct mcap_mcl *mcl,
+						uint8_t mdepid, uint16_t mdlid,
+						uint8_t *conf, gpointer data);
+typedef uint8_t (* mcap_remote_mdl_reconn_req_cb) (struct mcap_mdl *mdl,
+						gpointer data);
+
+/* mcl callbacks */
+
+typedef void (* mcap_mcl_event_cb) (struct mcap_mcl *mcl, gpointer data);
+typedef void (* mcap_mcl_connect_cb) (struct mcap_mcl *mcl, GError *err,
+								gpointer data);
+
+/************ Operations ************/
+
+/* Mdl operations*/
+
+void mcap_req_mdl_creation(struct mcap_mcl *mcl,
+				uint8_t mdepid,
+				uint8_t conf,
+				GError **err,
+				mcap_mdl_operation_conf_cb connect_cb,
+				gpointer user_data);
+void mcap_req_mdl_reconnect(struct mcap_mdl *mdl, GError **err,
+				mcap_mdl_operation_cb reconnect_cb,
+				gpointer user_data);
+void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
+			mcap_mdl_del_cb delete_cb, gpointer user_data);
+void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
+			mcap_mdl_del_cb delete_cb, gpointer user_data);
+void mcap_mdl_connect(struct mcap_mdl *mdl,
+			BtIOType BtType,
+			uint16_t dcpsm,
+			GError **err,
+			mcap_mdl_operation_cb connect_cb,
+			gpointer user_data);
+void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
+			mcap_mdl_del_cb abort_cb, gpointer user_data);
+
+int mcap_mdl_get_fd(struct mcap_mdl *mdl);
+uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl);
+
+/* Mcl operations*/
+
+void mcap_create_mcl(struct mcap_instance *ms,
+				const bdaddr_t *addr,
+				uint16_t ccpsm,
+				GError **err,
+				mcap_mcl_connect_cb connect_cb,
+				gpointer user_data);
+void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache);
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
+					gpointer user_data, McapMclCb cb1, ...);
+bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl);
+
+struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl);
+void mcap_mcl_unref(struct mcap_mcl *mcl);
+
+/* MCAP main operations */
+
+struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
+					BtIOSecLevel sec, uint16_t ccpsm,
+					uint16_t dcpsm,
+					GError **gerr,
+					mcap_mcl_event_cb mcl_connected,
+					mcap_mcl_event_cb mcl_reconnected,
+					mcap_mcl_event_cb mcl_disconnected,
+					mcap_mcl_event_cb mcl_uncached,
+					gpointer user_data);
+
+void mcap_release_instance(struct mcap_instance *ms);
+
+uint16_t mcap_get_ctrl_psm(struct mcap_instance *ms, GError **err);
+uint16_t mcap_get_data_psm(struct mcap_instance *ms, GError **err);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MCAP_LIB_H */
+
-- 
1.6.3.3

