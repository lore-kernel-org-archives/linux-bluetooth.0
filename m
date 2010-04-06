Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Multi-Channel Adaptation Protocol.
From: Santiago Carot Nemesio <scarot@libresoft.es>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Apr 2010 16:00:33 +0200
Message-ID: <1270562433.8428.40.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for Standard OP. Codes.

Signed-off-by: Santiago Carot-Nemesio <sancane@gmail.com>
Reviewed-by: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
---
 Makefile.am     |   11 +-
 acinclude.m4    |    6 +
 mcap/mcap.c     | 1807 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mcap/mcap.h     |  174 ++++++
 mcap/mcap_lib.h |  137 +++++
 5 files changed, 2134 insertions(+), 1 deletions(-)
 create mode 100644 mcap/mcap.c
 create mode 100644 mcap/mcap.h
 create mode 100644 mcap/mcap_lib.h

diff --git a/Makefile.am b/Makefile.am
index a9046db..3590cdb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -101,6 +101,7 @@ gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/object.c gdbus/watch.c
 builtin_modules =
 builtin_sources =
 builtin_nodist =
+mcap_sources =
 
 if PNATPLUGIN
 builtin_modules += pnat
@@ -168,6 +169,10 @@ builtin_modules += service
 builtin_sources += plugins/service.c
 endif
 
+if MCAP
+mcap_sources += mcap/mcap_lib.h mcap/mcap.h mcap/mcap.c
+endif
+
 builtin_modules += hciops
 builtin_sources += plugins/hciops.c
 
@@ -196,7 +201,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
-			src/dbus-hci.h src/dbus-hci.c
+			src/dbus-hci.h src/dbus-hci.c \
+			$(mcap_sources)
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
@@ -318,6 +324,9 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
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
index 0000000..28c586c
--- /dev/null
+++ b/mcap/mcap.c
@@ -0,0 +1,1807 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Santiago Carot Nemesio <sancane at gmail.com>
+ *  Copyright (C) 2010 Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
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
+#include <gdbus.h>
+#include "adapter.h"
+#include "logging.h"
+#include "btio.h"
+#include "error.h"
+
+#include <netinet/in.h>
+
+#include "mcap.h"
+#include "mcap_lib.h"
+
+//#define STATE2STR(_mcl) state2str(_mcl->state)
+#define MCAP_ERROR mcap_error_quark()
+#define SET_DEFAULT_MCL_CB(__mcl) do {				\
+	__mcl->cb->mdl_connected = default_mdl_connected_cb;	\
+	__mcl->cb->mdl_closed = default_mdl_closed_cb;		\
+	__mcl->cb->mdl_deleted = default_mdl_deleted_cb;	\
+	__mcl->cb->mdl_conn_req = default_mdl_conn_req_cb;	\
+	__mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;	\
+} while(0)
+#define RELEASE_TIMER(__mcl) do {	\
+	g_source_remove(__mcl->tid);	\
+	__mcl->tid = 0;			\
+} while(0)
+
+#define RESPONSE_TIMER 4 /* seconds */
+
+#define MCAP_IS_STD_OPCODE(_oc)	(_oc >= MCAP_ERROR_RSP &&	\
+				 _oc <= MCAP_MD_DELETE_MDL_RSP)
+
+typedef enum {
+	MCL_CONNECTED,
+	MCL_PENDING,
+	MCL_ACTIVE
+} MCLState;
+
+typedef enum {
+	MCL_ACCEPTOR,
+	MCL_INITIATOR,
+} MCLRole;
+
+typedef enum {
+	MCL_AVAILABLE,
+	MCL_WAITING_RSP,
+} MCAPCtrl;
+
+typedef enum {
+	MDL_WAITING,
+	MDL_CONNECTED,
+	MDL_CLOSED
+} MDLState;
+
+struct mcap_mcl_cb {
+	mcap_mdl_event_cb 		mdl_connected;	/* Remote device has created an mdl */
+	mcap_mdl_event_cb 		mdl_closed;	/* Remote device has closed an mdl */
+	mcap_mdl_event_cb 		mdl_deleted;	/* Remote device deleted an mdl */
+	mcap_remote_mdl_conn_req_cb	mdl_conn_req;	/* Remote deive requested create an mdl */
+	mcap_remote_mdl_reconn_req_cb 	mdl_reconn_req;	/* Remote device requested reconnect previus mdl */
+	gpointer			user_data;	/* user data */
+};
+
+struct mcap_session {
+	bdaddr_t		src;		/* Source address */
+	GIOChannel		*ccio;		/* Control Channel IO */
+	GIOChannel		*dcio;		/* Data Channel IO */
+	GSList			*mcls;		/* MCAP session list */
+	BtIOSecLevel		sec;		/* Security level */
+	mcap_mcl_event_cb	mcl_closed_cb;	/* Mcl closed callback */
+	mcap_mcl_event_cb	mcl_created_cb;	/* New Mcl createc callback */
+	gpointer		user_data;	/* User data for callbacks */
+};
+
+struct mcap_mcl {
+	struct mcap_session	*ms;		/* MCAP session where this MCL belongs */
+	bdaddr_t		addr;		/* device address */
+	GIOChannel		*cc;		/* MCAP Control Channel IO */
+	guint			wid;		/* MCL Watcher id */
+	GSList			*mdls;		/* List of Data Channels shorted by mdlid */
+	MCLState		state;		/* mcap state */
+	MCLRole			role;		/* initiator or aceptor of this MCL*/
+	MCAPCtrl		req;		/* Request control flag */
+	void			*priv_data;	/* Temporal data to manage responses */
+	struct mcap_mcl_cb	*cb;		/* MCL callbacks */
+	guint			tid;		/* Timer id for waiting for a resposne */
+	uint8_t			*lcmd;		/* Last command sent */
+	gboolean		sup_opc;	/* The remote device supports opcodes */
+};
+
+struct mcap_mdl {
+	struct mcap_mcl		*mcl;		/* MCAP mcl for this mdl */
+	GIOChannel		*dc;		/* MCAP Data Channel IO */
+	guint			wid;		/* MDL Watcher id */
+	uint16_t		mdlid;		/* MDL id */
+	uint8_t			mdep_id;	/* MCAP Data End Point */
+	MDLState		state;		/* MDL state */
+};
+
+struct connect_mcl {
+	struct mcap_mcl		*mcl;		/* MCL for outgoing connection */
+	mcap_mcl_connect_cb	connect_cb;	/* Connect callback */
+	gpointer		user_data;	/* Callback user data */
+};
+
+typedef union {
+	mcap_mdl_operation_cb 		op;
+	mcap_mdl_operation_conf_cb	op_conf;
+	mcap_mdl_del_cb			del;
+} mcap_cb_type;
+
+struct mcap_mdl_op_cb {
+	struct mcap_mdl		*mdl;		/* MCL for outgoing connection */
+	mcap_cb_type		cb;		/* Operation callback */
+	gpointer		user_data;	/* Callback user data */
+};
+
+static void mcap_notify_error(struct mcap_mcl *mcl, GError *err);
+static int mcap_send_data(int sock, const uint8_t *buf, uint32_t size);
+static int send4B_cmd(struct mcap_mcl *mcl, uint8_t oc,
+					uint8_t rc, uint16_t mdl);
+static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
+					uint16_t mdl, uint8_t param);
+
+/* MCAP finite state machine functions */
+static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, int len);
+static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, int len);
+static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, int len);
+
+static void (*proc_req[])(struct mcap_mcl *mcl, uint8_t *cmd, int len) = {
+	proc_req_connected,
+	proc_req_pending,
+	proc_req_active
+	};
+
+static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl connection");
+}
+static void default_mdl_closed_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl clsoed");
+}
+static void default_mdl_deleted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl deleted");
+}
+static uint8_t default_mdl_conn_req_cb(struct mcap_mcl *mcl,
+						uint8_t mdepid, uint16_t mdlid,
+						uint8_t *conf, gpointer data)
+{
+	debug("MCAP mdl remote connection aborted");
+	/* Due to this callback is not managed this request won't be supported */
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+static uint8_t default_mdl_reconn_req_cb(struct mcap_mdl *mdl,
+						gpointer data)
+{
+	debug("MCAP mdl remote reconnection aborted");
+	/* Due to this callback is not managed this request won't be supported */
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
+GQuark mcap_error_quark(void)
+{
+	return g_quark_from_static_string("mcap-error-quark");
+}
+
+static char *error2str(uint8_t rc)
+{
+	switch (rc) {
+	case MCAP_SUCCESS:
+		return "Success";
+	case MCAP_INVALID_OP_CODE:
+		return "Invalid Op Code";
+	case MCAP_INVALID_PARAM_VALUE:
+		return "Ivalid Parameter Value";
+	case MCAP_INVALID_MDEP:
+		return "Invalid MDEP";
+	case MCAP_MDEP_BUSY:
+		return "MDEP Busy";
+	case MCAP_INVALID_MDL:
+		return "Invalid MDL";
+	case MCAP_MDL_BUSY:
+		return "MDL Busy";
+	case MCAP_INVALID_OPERATION:
+		return "Invalid Operation";
+	case MCAP_RESOURCE_UNAVAILABLE:
+		return "Resource Unavailable";
+	case MCAP_UNESPECIFIED_ERROR:
+		return "Unspecified Error";
+	case MCAP_REQUEST_NOT_SUPPORTED:
+		return "Request Not Supported";
+	case MCAP_CONFIGURATION_REJECTED:
+		return "Configuration Rejected";
+	default:
+		return "Unknown Op Code";
+	}
+}
+
+static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
+{
+	GSList *l;
+	struct mcap_mcl *mcl;
+
+	for (l = list; l; l = l->next) {
+		mcl = l->data;
+
+		if (!bacmp(&mcl->addr, addr))
+			return mcl;
+	}
+
+	return NULL;
+}
+
+static void update_mcl_state(struct mcap_mcl *mcl)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+
+		if (mdl->state == MDL_CONNECTED) {
+			mcl->state = MCL_ACTIVE;
+			return;
+		}
+	}
+
+	mcl->state = MCL_CONNECTED;
+}
+
+static int mcap_send_data(int sock, const uint8_t *buf, uint32_t size)
+{
+	uint32_t sent = 0;
+
+	while (sent < size) {
+		int n = send(sock, buf + sent, size - sent, 0);
+		if (n < 0)
+			return -1;
+		sent += n;
+	}
+	return 0;
+}
+
+static void mcap_send_std_opcode(struct mcap_mcl *mcl, const uint8_t *buf,
+						uint32_t size, GError **err)
+{
+	if (mcl->req != MCL_AVAILABLE) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"Pending request");
+		return;
+	}
+
+	if (!mcl->sup_opc) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+				    "Remote does not support standard opcodes");
+		return;
+	}
+
+	if (mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), buf, size) < 0)
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+				    "Data can't be sent, write error");
+}
+
+static int send4B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
+								uint16_t mdl)
+{
+	uint8_t *rsp;
+	mcap4B_rsp *rsp_err;
+	int sent;
+
+
+	rsp = g_malloc0(sizeof(mcap4B_rsp));
+
+	rsp_err = (mcap4B_rsp *)rsp;
+	rsp_err->op = oc;
+	rsp_err->rc = rc;
+	rsp_err->mdl = htons (mdl);
+
+	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc),
+					rsp,
+					sizeof(mcap4B_rsp));
+	g_free(rsp);
+	return sent;
+}
+
+static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
+						uint16_t mdl, uint8_t param)
+{
+	uint8_t *rsp;
+	mcap5B_rsp *suc;
+	int sent;
+
+	rsp = g_malloc0(sizeof(mcap5B_rsp));
+
+	suc = (mcap5B_rsp *)rsp;
+	suc->op = oc;
+	suc->rc = rc;
+	suc->mdl = htons(mdl);
+	suc->param = param;
+
+	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), rsp,
+							sizeof(mcap5B_rsp));
+	g_free(rsp);
+	return sent;
+}
+
+static uint16_t generate_mdlid(struct mcap_mcl *mcl)
+{
+	uint16_t mdlid = MCAP_MDLID_INITIAL;
+	struct mcap_mdl *mdl;
+	GSList *l;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdlid < mdl->mdlid)
+			break;
+		else
+			mdlid = mdl->mdlid + 1;
+	}
+
+	if (mdlid > MCAP_MDLID_FINAL)
+		return 0;
+
+	return mdlid;
+}
+
+static uint8_t *create_req(uint8_t op, uint16_t mdl_id)
+{
+	uint8_t *req;
+	mcap_md_req *req_cmd;
+
+	req = g_malloc0(sizeof(mcap_md_req));
+
+	req_cmd = (mcap_md_req *)req;
+	req_cmd->op = op;
+	req_cmd->mdl = htons(mdl_id);
+
+	return req;
+}
+
+static uint8_t *create_mdl_req(uint16_t mdl_id, uint8_t mdep, uint8_t conf)
+{
+	uint8_t *req;
+	mcap_md_create_mdl_req *req_mdl;
+
+	req = g_malloc0(sizeof(mcap_md_create_mdl_req));
+
+	req_mdl = (mcap_md_create_mdl_req *)req;
+	req_mdl->op = MCAP_MD_CREATE_MDL_REQ;
+	req_mdl->mdl = htons(mdl_id);
+	req_mdl->mdep = mdep;
+	req_mdl->conf = conf;
+
+	return req;
+}
+
+static gint compare_mdl(gconstpointer a, gconstpointer b)
+{
+	const struct mcap_mdl *mdla = a;
+	const struct mcap_mdl *mdlb = b;
+
+	if (mdla->mdlid == mdlb->mdlid)
+		return 0;
+	else if (mdla->mdlid < mdlb->mdlid)
+		return -1;
+	else
+		return 1;
+}
+
+static gboolean wait_response_timer(gpointer data)
+{
+	struct mcap_mcl *mcl = data;
+	struct mcap_mdl_op_cb *con = mcl->priv_data;
+	struct mcap_mdl *mdl = con->mdl;
+
+	GError *gerr = NULL;
+
+	RELEASE_TIMER(mcl);
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	g_free(mdl);
+
+	mcl->req = MCL_AVAILABLE;
+	update_mcl_state(mcl);
+
+	g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"Timeout waiting response");
+
+	mcap_notify_error(mcl, gerr);
+
+	g_error_free(gerr);
+	mcl->ms->mcl_closed_cb(mcl, mcl->ms->user_data);
+	mcap_close_mcl(mcl);
+	return FALSE;
+}
+
+void mcap_req_mdl_creation(struct mcap_mcl *mcl,
+				uint8_t mdepid,
+				uint8_t conf,
+				GError **err,
+				mcap_mdl_operation_conf_cb connect_cb,
+				gpointer user_data)
+{
+	struct mcap_mdl *mdl;
+	struct mcap_mdl_op_cb *con;
+	uint8_t *cmd = NULL;
+	uint16_t id;
+
+	id = generate_mdlid(mcl);
+	if (!id) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"Not more mdlids available");
+		return;
+	}
+
+	mdl = g_new0(struct mcap_mdl, 1);
+	mdl->mcl = mcl;
+	mdl->mdlid = id;
+	mdl->mdep_id = mdepid;
+	mdl->state = MDL_WAITING;
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.op_conf = connect_cb;
+	con->user_data = user_data;
+
+	cmd = create_mdl_req(id, mdepid, conf);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_create_mdl_req), err);
+	if (*err) {
+		g_free(mdl);
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	mcl->state = MCL_ACTIVE;
+	mcl->req = MCL_WAITING_RSP;
+	mcl->priv_data = con;
+	mcl->lcmd = cmd;
+	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
+}
+
+void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
+				GError **err,
+				mcap_mdl_operation_cb reconnect_cb,
+				gpointer user_data)
+{
+	struct mcap_mdl_op_cb *con;
+	struct mcap_mcl *mcl = mdl->mcl;
+	uint8_t *cmd;
+
+	if (mdl->state != MDL_CLOSED) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"MDL is not closed");
+		return;
+	}
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+
+	cmd = create_req(MCAP_MD_RECONNECT_MDL_REQ, mdl->mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	mdl->state = MDL_WAITING;
+
+	con->mdl = mdl;
+	con->cb.op = reconnect_cb;
+	con->user_data = user_data;
+
+	mcl->lcmd = cmd;
+	mcl->req = MCL_WAITING_RSP;
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
+}
+
+void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
+			mcap_mdl_del_cb delete_cb, gpointer user_data)
+{
+	struct mcap_mcl *mcl= mdl->mcl;
+	struct mcap_mdl_op_cb *con;
+	GSList *l;
+	uint8_t *cmd;
+
+	l = g_slist_find(mcl->mdls, mdl);
+
+	if (!l) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_NOT_FOUND,
+							"Mdl not found");
+		return;
+	}
+
+	if (mdl->state == MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"Not valid petition in this mdl state");
+		return;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.del = delete_cb;
+	con->user_data = user_data;
+
+	cmd = create_req(MCAP_MD_DELETE_MDL_REQ, mdl->mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	mcl->lcmd = cmd;
+	mcl->req = MCL_WAITING_RSP;
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
+}
+
+void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
+			mcap_mdl_del_cb abort_cb, gpointer user_data)
+{
+	struct mcap_mdl_op_cb *con;
+	struct mcap_mcl *mcl = mdl->mcl;
+	uint8_t *cmd;
+
+	if (mdl->state != MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+							"Mdl in invalid state");
+		return;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	cmd = create_req(MCAP_MD_ABORT_MDL_REQ, mdl->mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	con->mdl = mdl;
+	con->cb.del = abort_cb;
+	con->user_data = user_data;
+
+	mcl->lcmd = cmd;
+	mcl->req = MCL_WAITING_RSP;
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
+}
+
+int mcap_mdl_get_fd(struct mcap_mdl *mdl)
+{
+	if (mdl->dc)
+		return g_io_channel_unix_get_fd(mdl->dc);
+	return -1;
+}
+
+static void shutdown_mdl(struct mcap_mdl *mdl)
+{
+	mdl->state = MDL_CLOSED;
+
+	g_source_remove(mdl->wid);
+
+	if (mdl->dc) {
+		g_io_channel_shutdown(mdl->dc, TRUE, NULL);
+		g_io_channel_unref(mdl->dc);
+		mdl->dc = NULL;
+	}
+}
+
+static void mcap_free_mdls(struct mcap_mcl *mcl)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	if (!mcl->mdls)
+		return;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		shutdown_mdl(mdl);
+		g_free(mdl);
+	}
+
+	g_slist_free(mcl->mdls);
+	mcl->mdls = NULL;
+}
+
+static void mcap_mcl_free(struct mcap_mcl *mcl)
+{
+	if (mcl->tid) {
+		RELEASE_TIMER(mcl);
+	}
+
+	if (mcl->cc) {
+		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
+		g_io_channel_unref(mcl->cc);
+		mcl->cc = NULL;
+	}
+	g_source_remove(mcl->wid);
+	if (mcl->lcmd) {
+		g_free(mcl->lcmd);
+		mcl->lcmd = NULL;
+	}
+	if (mcl->priv_data) {
+		g_free(mcl->priv_data);
+		mcl->priv_data = NULL;
+	}
+
+	mcap_free_mdls(mcl);
+
+	if (mcl->cb)
+		g_free(mcl->cb);
+	g_free(mcl);
+}
+
+void mcap_close_mcl(struct mcap_mcl *mcl)
+{
+	if (!mcl)
+		return;
+	mcl->ms->mcls = g_slist_remove(mcl->ms->mcls, mcl);
+	mcap_mcl_free(mcl);
+}
+
+static gboolean parse_set_opts(struct mcap_mcl_cb *mcl_cb, GError **err,
+						McapMclCb cb1, va_list args)
+{
+	McapMclCb cb = cb1;
+	struct mcap_mcl_cb *c;
+
+	c = g_new0(struct mcap_mcl_cb, 1);
+
+	while (cb != MCAP_MDL_CB_INVALID) {
+		switch (cb) {
+		case MCAP_MDL_CB_CONNECTED:
+			c->mdl_connected = va_arg(args,
+				mcap_mdl_event_cb);
+			break;
+		case MCAP_MDL_CB_CLOSED:
+			c->mdl_closed = va_arg(args,
+				mcap_mdl_event_cb);
+			break;
+		case MCAP_MDL_CB_DELETED:
+			c->mdl_deleted = va_arg(args,
+				mcap_mdl_event_cb);
+			break;
+		case MCAP_MDL_CB_REMOTE_CONN_REQ:
+			c->mdl_conn_req = va_arg(args,
+				mcap_remote_mdl_conn_req_cb);
+			break;
+		case MCAP_MDL_CB_REMOTE_RECONN_REQ:
+			c->mdl_reconn_req = va_arg(args,
+				mcap_remote_mdl_reconn_req_cb);
+			break;
+		default:
+			g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+				"Unknown option %d", cb);
+			return FALSE;
+		}
+		cb = va_arg(args, int);
+	}
+
+	/* Set new callbacks set */
+	if (c->mdl_connected)
+		mcl_cb->mdl_connected = c->mdl_connected;
+	if (c->mdl_closed)
+		mcl_cb->mdl_closed = c->mdl_closed;
+	if (c->mdl_deleted)
+		mcl_cb->mdl_deleted = c->mdl_deleted;
+	if (c->mdl_conn_req)
+		mcl_cb->mdl_conn_req = c->mdl_conn_req;
+	if (c->mdl_reconn_req)
+		mcl_cb->mdl_reconn_req = c->mdl_reconn_req;
+
+	g_free(c);
+	return TRUE;
+}
+
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
+					gpointer user_data, McapMclCb cb1, ...)
+{
+	va_list args;
+	gboolean ret;
+
+	va_start(args, cb1);
+	ret = parse_set_opts(mcl->cb, gerr, cb1, args);
+	va_end(args);
+
+	if (!ret)
+		return;
+
+	mcl->cb->user_data = user_data;
+	return;
+}
+
+bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl)
+{
+	return mcl->addr;
+}
+
+static void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	switch (cmd[0]) {
+	case MCAP_MD_SYNC_CAP_REQ:
+		debug("TODO: received MCAP_MD_SYNC_CAP_REQ: %d",
+			MCAP_MD_SYNC_CAP_REQ);
+		break;
+	case MCAP_MD_SYNC_CAP_RSP:
+		debug("TODO: received MCAP_MD_SYNC_CAP_RSP: %d",
+			MCAP_MD_SYNC_CAP_RSP);
+		break;
+	case MCAP_MD_SYNC_SET_REQ:
+		debug("TODO: received MCAP_MD_SYNC_SET_REQ: %d",
+			MCAP_MD_SYNC_SET_REQ);
+		break;
+	case MCAP_MD_SYNC_SET_RSP:
+		debug("TODO: received MCAP_MD_SYNC_SET_RSP: %d",
+			MCAP_MD_SYNC_SET_RSP);
+		break;
+	case MCAP_MD_SYNC_INFO_IND:
+		debug("TODO: received MCAP_MD_SYNC_INFO_IND :%d",
+			MCAP_MD_SYNC_INFO_IND);
+		break;
+        }
+}
+
+static void error_cmd_rsp(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	uint16_t mdlr;
+
+	if ((cmd[0] >= MCAP_ERROR_RSP) && (cmd[0] <= MCAP_MD_DELETE_MDL_RSP)) {
+		/* Standard Op Code request is invalid in current state */
+		error("Invalid cmd received (op code = %d) in state %d",
+							cmd[0],	mcl->state);
+		/* Get mdlid sended to generate appropiate response if it is possible */
+		mdlr = len < sizeof(mcap_md_req) ? MCAP_MDLID_RESERVED :
+						ntohs(((mcap_md_req *)cmd)->mdl);
+		send4B_cmd(mcl, cmd[0]+1, MCAP_INVALID_OPERATION, mdlr);
+	} else {
+		error("Unknown cmd request received (op code = %d) in state %d",
+							cmd[0], mcl->state);
+		send4B_cmd(mcl, MCAP_ERROR_RSP, MCAP_INVALID_OP_CODE,
+							MCAP_MDLID_RESERVED);
+	}
+}
+
+static struct mcap_mdl *get_mdl(struct mcap_mcl *mcl, uint16_t mdlid)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdlid == mdl->mdlid)
+			return mdl;
+	}
+
+	return NULL;
+}
+
+/* Functions used to process request */
+
+static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	mcap_md_create_mdl_req *req;
+	struct mcap_mdl *mdl;
+	uint16_t mdl_id;
+	uint8_t mdep_id;
+	uint8_t cfga, conf;
+	uint8_t rsp;
+
+	if (len != sizeof(mcap_md_create_mdl_req)) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
+				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	req = (mcap_md_create_mdl_req *)cmd;
+
+	mdl_id = ntohs(req->mdl);
+	if ((mdl_id < MCAP_MDLID_INITIAL) || (mdl_id > MCAP_MDLID_FINAL)) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL, mdl_id);
+		return;
+	}
+
+	mdep_id = req->mdep;
+	if (mdep_id > MCAP_MDEPID_FINAL) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDEP, mdl_id);
+		return;
+	}
+
+	cfga = conf = req->conf;
+	/* Callback to upper layer */
+	rsp = mcl->cb->mdl_conn_req(mcl, mdep_id, mdl_id, &conf,
+							mcl->cb->user_data);
+
+	if ((cfga != 0) && (cfga != conf)) {
+		/* Remote device set default configuration but upper profile */
+		/* has changed it. Protocol Error: force closing the MCL by */
+		/* using remote device using UNESPECIFIED_ERROR response*/
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_UNESPECIFIED_ERROR,
+								mdl_id);
+		return;
+	}
+	if (rsp != MCAP_SUCCESS) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id);
+		return;
+	}
+
+	mdl = get_mdl(mcl, mdl_id);
+	if (!mdl) {
+		mdl = g_malloc0(sizeof(struct mcap_mdl));
+		mdl->mcl = mcl;
+		mdl->mdlid = mdl_id;
+	} else if (mdl->state == MDL_CONNECTED) {
+		shutdown_mdl(mdl);
+		mcl->cb->mdl_closed(mdl, mcl->cb->user_data);
+	}
+	mdl->state = MDL_WAITING;
+	mdl->mdep_id = mdep_id;
+	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
+
+	mcl->state = MCL_PENDING;
+	send5B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_SUCCESS, mdl_id, conf);
+}
+
+static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+									int len)
+{
+	mcap_md_req *req;
+	struct mcap_mdl *mdl;
+	uint16_t mdl_id;
+	uint8_t rsp;
+	gboolean close;
+
+	if (len != sizeof(mcap_md_req)) {
+		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
+				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdl_id = ntohs(req->mdl);
+
+	mdl = get_mdl(mcl, mdl_id);
+	if (!mdl) {
+		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
+						MCAP_INVALID_MDL, mdl_id);
+		return;
+	}
+
+	close = mdl->state == MDL_CONNECTED;
+	if (close)
+		shutdown_mdl(mdl);
+
+	/* Callback to upper layer */
+	rsp = mcl->cb->mdl_reconn_req(mdl, mcl->cb->user_data);
+	if (rsp != MCAP_SUCCESS) {
+		if (close)
+			mcl->cb->mdl_closed(mdl, mcl->cb->user_data);
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id);
+		return;
+	}
+	mdl->state = MDL_WAITING;
+	mcl->state = MCL_PENDING;
+	send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id);
+}
+
+static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	mcap_md_req *req;
+	GSList *l;
+	struct mcap_mdl *mdl, *del;
+	uint16_t mdl_id;
+
+	if (len != sizeof(mcap_md_req)) {
+		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
+				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdl_id = ntohs(req->mdl);
+	mcl->state = MCL_CONNECTED;
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if ((mdl_id == mdl->mdlid) && (mdl->state == MDL_WAITING)) {
+			del = mdl;
+			if (mcl->state != MCL_CONNECTED)
+				break;
+			continue;
+		}
+		if ((mdl->state == MDL_CONNECTED) && (mcl->state != MCL_ACTIVE))
+			mcl->state = MCL_ACTIVE;
+
+		if ((del) && (mcl->state == MCL_ACTIVE))
+			break;
+	}
+
+	if (!del) {
+		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL, mdl_id);
+		return;
+	}
+
+	mcl->mdls = g_slist_remove(mcl->mdls, del);
+	g_free(del);
+	send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id);
+}
+/* Functions used to process responses */
+static gboolean check_err_rsp(uint16_t rmdl, uint16_t smdl, uint8_t rc,
+					int rlen, int len, GError **gerr)
+{
+	gboolean close = FALSE;
+	char *msg;
+
+	if (rmdl != smdl) {
+		msg = "MDLID received doesn't match with MDLID sended";
+		close = TRUE;
+		goto fail;
+	}
+
+	if (rc != MCAP_SUCCESS) {
+		msg = error2str(rc);
+		goto fail;
+	}
+
+	if (rlen < len) {
+		msg = "Protocol error";
+		close = TRUE;
+		goto fail;
+	}
+	return FALSE;
+fail:
+	g_set_error(gerr, MCAP_ERROR, MCAP_ERROR_FAILED, "%s", msg);
+	return close;
+}
+
+static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
+							uint8_t *cmd, int len)
+{
+	struct mcap_mdl_op_cb *conn = mcl->priv_data;
+	struct mcap_mdl *mdl = conn->mdl;
+	mcap_mdl_operation_conf_cb connect_cb = conn->cb.op_conf;
+	gpointer user_data = conn->user_data;
+	uint16_t mdlid;
+	mcap5B_rsp *rsp = (mcap5B_rsp *) cmd;
+	mcap_md_create_mdl_req *cmdlast;
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	cmdlast = (mcap_md_create_mdl_req *) mcl->lcmd;
+	mdlid = ntohs(cmdlast->mdl);
+	rsp->mdl = ntohs(rsp->mdl);
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, 0, 0, &gerr);
+
+	if (gerr)
+		goto fail;
+
+	if (len < 5) {
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Protocol error");
+		close = TRUE;
+		goto fail;
+	}
+
+	/* Check if preferences changed */
+	if ((cmdlast->conf != 0x00) && (rsp->param != cmdlast->conf)) {
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Configutation changed");
+		close = TRUE;
+		goto fail;
+	}
+
+	connect_cb(mdl, rsp->param, gerr, user_data);
+	return close;
+fail:
+	connect_cb(NULL, 0, gerr, user_data);
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	g_free(mdl);
+	g_error_free(gerr);
+	return close;
+}
+
+static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
+							uint8_t *cmd, int len)
+{
+	struct mcap_mdl_op_cb *reconn = mcl->priv_data;
+	struct mcap_mdl *mdl = reconn->mdl;
+	mcap_mdl_operation_cb reconn_cb = reconn->cb.op;
+	gpointer user_data = reconn->user_data;
+	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	uint16_t mdlid = ntohs(cmdlast->mdl);
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	rsp->mdl = ntohs(rsp->mdl);
+
+	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, len,
+						sizeof(mcap4B_rsp), &gerr);
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+
+	reconn_cb(mdl, gerr, user_data);
+	if (gerr)
+		g_error_free(gerr);
+
+	return close;
+}
+
+static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
+							uint8_t *cmd, int len)
+{
+	struct mcap_mdl_op_cb *abrt = mcl->priv_data;
+	struct mcap_mdl *mdl = abrt->mdl;
+	mcap_mdl_del_cb abrt_cb = abrt->cb.del;
+	gpointer user_data = abrt->user_data;
+	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	uint16_t mdlid = ntohs(cmdlast->mdl);
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	rsp->mdl = ntohs(rsp->mdl);
+
+	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, len,
+						sizeof(mcap4B_rsp), &gerr);
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+
+	if (gerr) {
+		abrt_cb(gerr, user_data);
+		g_error_free(gerr);
+		return close;
+	}
+
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	g_free(mdl);
+	update_mcl_state(mcl);
+	abrt_cb(gerr, user_data);
+	return close;
+}
+
+static void mcap_delete_mdl(gpointer elem, gpointer user_data)
+{
+	struct mcap_mdl *mdl = elem;
+	gboolean notify = *(gboolean *)user_data;
+	if (mdl->state == MDL_CONNECTED) {
+		debug("MDL %d already connected, closing it", mdl->mdlid);
+		shutdown_mdl(mdl);
+	}
+	if (notify)
+		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
+	g_free(mdl);
+}
+
+static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
+									int len)
+{
+	struct mcap_mdl_op_cb *del = mcl->priv_data;
+	struct mcap_mdl *mdl = del->mdl;
+	mcap_mdl_del_cb deleted_cb = del->cb.del;
+	gpointer user_data = del->user_data;
+	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	uint16_t mdlid = ntohs(cmdlast->mdl);
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+	gboolean notify = FALSE;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	rsp->mdl = ntohs(rsp->mdl);
+
+	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, len,
+						sizeof(mcap4B_rsp), &gerr);
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+	if (gerr) {
+		deleted_cb(gerr, user_data);
+		g_error_free(gerr);
+		return close;
+	}
+
+	if (mdlid == MCAP_ALL_MDLIDS) {
+		g_slist_foreach(mcl->mdls, mcap_delete_mdl, &notify);
+		g_slist_free(mcl->mdls);
+		mcl->mdls = NULL;
+		mcl->state = MCL_CONNECTED;
+		goto end;
+	}
+
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	update_mcl_state(mcl);
+	mcap_delete_mdl(mdl, &notify);
+end:
+	deleted_cb(gerr, user_data);
+	return close;
+}
+
+static void process_md_delete_mdl_req(struct mcap_mcl *mcl, mcap_md_req *req)
+{
+	struct mcap_mdl *mdl, *aux;
+	uint16_t mdlid = ntohs(req->mdl);
+	gboolean notify;
+	GSList *l;
+
+	debug("process MCAP_MD_DELETE_MDL_REQ");
+
+	if (mdlid == MCAP_ALL_MDLIDS) {
+		notify = FALSE;
+		g_slist_foreach(mcl->mdls, mcap_delete_mdl, &notify);
+		g_slist_free(mcl->mdls);
+		mcl->state = MCL_CONNECTED;
+		mcl->mdls = NULL;
+		/* NULL mdl means ALL_MDLS */
+		mcl->cb->mdl_deleted(NULL, mcl->cb->user_data);
+		goto resp;
+	}
+
+	if ((mdlid < MCAP_MDLID_INITIAL) || (mdlid > MCAP_MDLID_FINAL)) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL, mdlid);
+		return;
+	}
+
+	for (l=mcl->mdls, mdl = NULL; l; l = l->next) {
+		aux = l->data;
+		if (aux->mdlid == mdlid) {
+			mdl = aux;
+			break;
+		}
+	}
+
+	if (!mdl) {
+		send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_INVALID_MDL, mdlid);
+		return;
+	}
+
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	update_mcl_state(mcl);
+	notify = TRUE;
+	mcap_delete_mdl(mdl, &notify);
+resp:
+	send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid);
+}
+
+/* Function used to process commands depending of MCL state */
+
+static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	debug("Processing in Connected");
+	switch (cmd[0]) {
+	case MCAP_MD_CREATE_MDL_REQ:
+		process_md_create_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		process_md_reconnect_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_REQ:
+		process_md_delete_mdl_req(mcl, (mcap_md_req *) cmd);
+		break;
+	default:
+		error_cmd_rsp(mcl, cmd, len);
+	}
+}
+
+static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	debug("Processing in Pending");
+	if (cmd[0] == MCAP_MD_ABORT_MDL_REQ)
+		process_md_abort_mdl_req(mcl, cmd, len);
+	else
+		error_cmd_rsp(mcl, cmd, len);
+}
+
+static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	debug("Processing in Active");
+	switch (cmd[0]) {
+	case MCAP_MD_CREATE_MDL_REQ:
+		process_md_create_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		process_md_reconnect_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_REQ:
+		process_md_delete_mdl_req(mcl, (mcap_md_req *) cmd);
+		break;
+	default:
+		error_cmd_rsp(mcl, cmd, len);
+	}
+}
+
+static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
+{
+	struct mcap_mdl_op_cb *con = mcl->priv_data;
+
+	if (!con || !mcl->lcmd)
+		return;
+
+	switch (mcl->lcmd[0]){
+	case MCAP_MD_CREATE_MDL_REQ:
+		con->cb.op_conf(NULL, 0, err, con->user_data);
+		break;
+	case MCAP_MD_ABORT_MDL_REQ:
+	case MCAP_MD_DELETE_MDL_REQ:
+		con->cb.del(err, con->user_data);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		con->cb.op(NULL, err, con->user_data);
+		break;
+	}
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+}
+
+static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	mcap4B_rsp *rsp;
+	GError *err = NULL;
+
+	/* Check if the response matches with the last request */
+	if ((cmd[0] != MCAP_ERROR_RSP) && ((mcl->lcmd[0] + 1) != cmd[0]))
+		goto close_mcl;
+
+	if (len < 4)
+		goto close_mcl;
+	rsp = (mcap4B_rsp *)cmd;
+
+	if (rsp->rc == MCAP_REQUEST_NOT_SUPPORTED) {
+		debug("Remote does not support opcodes");
+		g_set_error(&err, MCAP_ERROR, MCAP_ERROR_FAILED,
+				"Remote does not support this operation");
+		mcap_notify_error(mcl, err);
+		g_error_free(err);
+
+		g_free(mcl->lcmd);
+		mcl->lcmd = NULL;
+		mcl->sup_opc = FALSE;
+		mcl->req = MCL_AVAILABLE;
+		update_mcl_state(mcl);
+		return FALSE;
+	}
+
+	if (rsp->rc == MCAP_UNESPECIFIED_ERROR)
+		goto close_mcl;
+
+	return TRUE;
+close_mcl:
+	g_set_error(&err, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"Protocol error");
+	mcap_notify_error(mcl, err);
+	g_error_free(err);
+	mcl->ms->mcl_closed_cb(mcl, mcl->ms->user_data);
+	mcap_close_mcl(mcl);
+	return FALSE;
+}
+
+static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	gboolean close;
+	RELEASE_TIMER(mcl);
+
+	if (!check_rsp(mcl, cmd, len))
+		return;
+
+	switch (cmd[0]) {
+	case MCAP_ERROR_RSP:
+		debug("received MCAP_ERROR_RSP:%d",MCAP_ERROR_RSP);
+		close = TRUE;
+		break;
+	case MCAP_MD_CREATE_MDL_RSP:
+		close = process_md_create_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_RSP:
+		close = process_md_reconnect_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_ABORT_MDL_RSP:
+		close = process_md_abort_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_RSP:
+		debug("received MCAP_MD_DELETE_MDL_RSP");
+		close = process_md_delete_mdl_rsp(mcl, cmd, len);
+		break;
+	default:
+		debug("Unknown cmd response received (op code = %d)",cmd[0]);
+		close = TRUE;
+		break;
+	}
+
+	if (close) {
+		mcl->ms->mcl_closed_cb(mcl, mcl->ms->user_data);
+		mcap_close_mcl(mcl);
+	}
+}
+
+static void rsend_req(struct mcap_mcl *mcl)
+{
+	uint8_t *cmd = mcl->lcmd;
+	int len;
+
+	if(!cmd)
+		return;
+
+	switch (cmd[0]) {
+	case MCAP_MD_RECONNECT_MDL_REQ:
+	case MCAP_MD_ABORT_MDL_REQ:
+	case MCAP_MD_DELETE_MDL_REQ:
+		len = 3;
+		break;
+	case MCAP_MD_CREATE_MDL_REQ:
+		len = 5;
+		break;
+	default:
+		return;
+	}
+
+	mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), cmd, len);
+}
+
+static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, int len)
+{
+	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) && (cmd[0] <= MCAP_MD_SYNC_INFO_IND)) {
+		proc_sync_cmd(mcl, cmd, len);
+		return;
+	}
+
+	if (!mcl->sup_opc) {
+		/* In case the remote device doesn't work corerctly */
+		error("Remote device does not support opcodes, cmd ignored");
+		return;
+	}
+
+	if (mcl->req == MCL_WAITING_RSP) {
+		if (cmd[0] & 0x01) {
+			/* Request arrived when a response is expected */
+			if (mcl->role == MCL_INITIATOR)
+				/* ignore */
+				return;
+			proc_req[mcl->state](mcl, cmd, len);
+			/* Initiator will ignore our last request => re-send */
+			rsend_req(mcl);
+			return;
+		}
+		proc_response(mcl, cmd, len);
+	} else if (cmd[0] & 0x01) {
+		proc_req[mcl->state](mcl, cmd, len);
+	}
+}
+
+static gboolean mdl_closing_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+
+	struct mcap_mdl *mdl = data;
+	gboolean open;
+
+	debug("Close MDL %d", mdl->mdlid);
+
+	open = (mdl->state == MDL_CONNECTED);
+	shutdown_mdl(mdl);
+
+	update_mcl_state(mdl->mcl);
+
+	if (open)
+		/*Callback to upper layer */
+		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
+
+	return FALSE;
+}
+
+static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
+							gpointer data)
+{
+	struct mcap_mdl_op_cb *con = data;
+	struct mcap_mdl *mdl = con->mdl;
+	mcap_mdl_operation_cb cb = con->cb.op;
+	gpointer user_data = con->user_data;
+
+	g_free(con);
+	debug("mdl connect callback");
+
+	if (conn_err) {
+		debug("ERROR: mdl connect callback");
+		mdl->state = MDL_CLOSED;
+		g_io_channel_unref(mdl->dc);
+		mdl->dc = NULL;
+		cb(mdl, conn_err, user_data);
+		return;
+	}
+
+	mdl->state = MDL_CONNECTED;
+	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) mdl_closing_cb, mdl);
+
+	cb(mdl, conn_err, user_data);
+}
+
+void mcap_mdl_connect(struct mcap_mdl *mdl, BtIOType BtType, uint16_t dcpsm,
+	GError **err, mcap_mdl_operation_cb connect_cb, gpointer user_data)
+{
+	struct mcap_mdl_op_cb *con;
+
+	if (mdl->state != MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+					"MDL has not been negotiated.");
+		return;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.op = connect_cb;
+	con->user_data = user_data;
+
+	/* TODO: Check if BtIOType is ERTM or Streaming before continue */
+
+	mdl->dc = bt_io_connect(BtType, mcap_connect_mdl_cb, con,
+				NULL, err,
+				BT_IO_OPT_SOURCE_BDADDR, &mdl->mcl->ms->src,
+				BT_IO_OPT_DEST_BDADDR, &mdl->mcl->addr,
+				BT_IO_OPT_PSM, dcpsm,
+				BT_IO_OPT_MTU, MCAP_DC_MTU,
+				BT_IO_OPT_SEC_LEVEL, mdl->mcl->ms->sec,
+				BT_IO_OPT_INVALID);
+	if (*err) {
+		debug("MDL Connection error");
+		mdl->state = MDL_CLOSED;
+		g_free(con);
+	}
+}
+
+static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+
+	struct mcap_mcl *mcl = data;
+	int sk, len;
+	uint8_t buf[MCAP_CC_MTU];
+
+	if (cond & G_IO_NVAL) {
+		error("Revise G_IO_NVAL");
+		goto fail;
+	}
+
+	if (cond & (G_IO_ERR | G_IO_HUP))
+		goto fail;
+
+	sk = g_io_channel_unix_get_fd(chan);
+	len = recv(sk, buf, sizeof(buf), 0);
+	if (len < 0)
+		goto fail;
+
+	proc_cmd(mcl, buf, len);
+	return TRUE;
+fail:
+	mcl->ms->mcl_closed_cb(mcl, mcl->ms->user_data);
+	mcap_close_mcl(mcl);
+	return FALSE;
+}
+
+static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
+							gpointer user_data)
+{
+	char dstaddr[18];
+	struct connect_mcl *con = user_data;
+	struct mcap_mcl *aux, *mcl = con->mcl;
+	mcap_mcl_connect_cb connect_cb = con->connect_cb;
+	gpointer data = con->user_data;
+	GError *gerr = NULL;
+
+	g_free(con);
+
+	if (conn_err) {
+		mcap_close_mcl(mcl);
+		connect_cb(NULL, conn_err, data);
+		return;
+	}
+
+	ba2str(&mcl->addr, dstaddr);
+
+	aux = find_mcl(mcl->ms->mcls, &mcl->addr);
+	if (aux) {
+		mcap_close_mcl(mcl);
+		error("MCL error: Device %s is already connected", dstaddr);
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_ALREADY_EXISTS,
+				"MCL %s is already connected", dstaddr);
+		connect_cb(NULL, gerr, data);
+		g_error_free(gerr);
+		return;
+	}
+
+	mcl->state = MCL_CONNECTED;
+	mcl->role = MCL_INITIATOR;
+	mcl->req = MCL_AVAILABLE;
+	mcl->sup_opc = TRUE;
+
+	mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
+	mcl->wid = g_io_add_watch(mcl->cc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) mcl_control_cb, mcl);
+	connect_cb(mcl, gerr, data);
+}
+
+void mcap_create_mcl(struct mcap_session *ms,
+				const bdaddr_t *addr,
+				uint16_t ccpsm,
+				GError **err,
+				mcap_mcl_connect_cb connect_cb,
+				gpointer user_data)
+{
+	struct mcap_mcl *mcl;
+	struct connect_mcl *con;
+
+	mcl = find_mcl(ms->mcls, addr);
+	if (mcl) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_ALREADY_EXISTS,
+					"MCL is already connected.");
+		return;
+	}
+
+	mcl = g_new0(struct mcap_mcl, 1);
+	mcl->ms = ms;
+	bacpy(&mcl->addr, addr);
+
+	con = g_new0(struct connect_mcl, 1);
+	mcl->cb = g_new0(struct mcap_mcl_cb, 1);
+	SET_DEFAULT_MCL_CB(mcl);
+
+	con->mcl = mcl;
+	con->connect_cb = connect_cb;
+	con->user_data = user_data;
+
+	mcl->cc = bt_io_connect(BT_IO_L2CAP, mcap_connect_mcl_cb, con,
+				NULL, err,
+				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
+				BT_IO_OPT_DEST_BDADDR, addr,
+				BT_IO_OPT_PSM, ccpsm,
+				BT_IO_OPT_MTU, MCAP_CC_MTU,
+				BT_IO_OPT_SEC_LEVEL, ms->sec,
+				BT_IO_OPT_INVALID);
+	if (*err) {
+		g_free(con);
+		mcap_close_mcl(mcl);
+	}
+}
+
+static void connect_dc_event_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct mcap_mdl *mdl = user_data;
+	struct mcap_mcl *mcl = mdl->mcl;
+
+	mdl->state = MDL_CONNECTED;
+	mdl->dc = g_io_channel_ref(chan);
+	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) mdl_closing_cb, mdl);
+
+	mcl->state = MCL_ACTIVE;
+	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
+}
+
+static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	struct mcap_session *ms = user_data;
+	struct mcap_mcl *mcl;
+	struct mcap_mdl *mdl;
+	GError *err = NULL;
+	bdaddr_t dst;
+	GSList *l;
+
+	bt_io_get(chan, BT_IO_L2CAP, &err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	mcl = find_mcl(ms->mcls, &dst);
+	if (!mcl || (mcl->state != MCL_PENDING))
+		goto drop;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdl->state == MDL_WAITING) {
+			if (!bt_io_accept(chan, connect_dc_event_cb, mdl, NULL,
+									&err)) {
+				error("MDL accept error %s", err->message);
+				g_error_free(err);
+				goto drop;
+			}
+			return;
+		}
+	}
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
+static void connect_mcl_event_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct mcap_mcl *mcl = user_data;
+
+	if (err) {
+		mcap_mcl_free(mcl);
+		return;
+	}
+	mcl->cb = g_new0(struct mcap_mcl_cb, 1);
+	mcl->state = MCL_CONNECTED;
+	mcl->role = MCL_ACCEPTOR;
+	mcl->req = MCL_AVAILABLE;
+	mcl->cc = g_io_channel_ref(chan);
+	mcl->sup_opc = TRUE;
+
+	SET_DEFAULT_MCL_CB(mcl);
+	debug("MCL created");
+	mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
+
+	mcl->wid = g_io_add_watch(mcl->cc,
+			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			(GIOFunc) mcl_control_cb, mcl);
+
+	/* Callback to report new entry MCL */
+	mcl->ms->mcl_created_cb(mcl, mcl->ms->user_data);
+}
+
+static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	struct mcap_session *ms = user_data;
+	struct mcap_mcl *mcl;
+	bdaddr_t dst;
+	char address[18], srcstr[18];
+	GError *err = NULL;
+
+	bt_io_get(chan, BT_IO_L2CAP, &err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	ba2str(&ms->src, srcstr);
+	mcl = find_mcl(ms->mcls, &dst);
+	if (mcl) {
+		error("Control channel already created with %s on adapter %s",
+				address, srcstr);
+		goto drop;
+	}
+
+	mcl = g_new0(struct mcap_mcl, 1);
+
+	mcl->ms = ms;
+	bacpy(&mcl->addr, &dst);
+
+	if (!bt_io_accept(chan, connect_mcl_event_cb, mcl, NULL, &err)) {
+		error("mcap accpet error: %s", err->message);
+		mcap_mcl_free(mcl);
+		g_error_free(err);
+		goto drop;
+	}
+
+	return;
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
+struct mcap_session *mcap_create_session(struct btd_adapter *btd_adapter,
+					BtIOSecLevel sec,
+					uint16_t ccpsm,
+					uint16_t dcpsm,
+					GError **gerr,
+					mcap_mcl_event_cb mcl_closed,
+					mcap_mcl_event_cb mcl_created,
+					gpointer user_data)
+{
+	struct mcap_session *ms;
+
+	if (sec < BT_IO_SEC_MEDIUM) {
+		g_set_error(gerr, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+				"Security level can't be minor of %d",
+				BT_IO_SEC_MEDIUM);
+		return NULL;
+	}
+
+	if (!(mcl_closed && mcl_created)) {
+		g_set_error(gerr, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+				"The callbacks can't be null");
+		return NULL;
+	}
+
+	ms = g_new0(struct mcap_session, 1);
+
+	adapter_get_address(btd_adapter, &ms->src);
+
+	ms->sec = sec;
+	ms->mcl_closed_cb = mcl_closed;
+	ms->mcl_created_cb = mcl_created;
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
+
+	return ms;
+}
+
+void mcap_close_session(struct mcap_session *ms)
+{
+	GSList *l;
+
+	if (!ms)
+		return;
+
+	if (ms->ccio) {
+		g_io_channel_shutdown(ms->ccio, TRUE, NULL);
+		g_io_channel_unref(ms->ccio);
+		ms->ccio = NULL;
+	}
+
+	if (ms->dcio) {
+		g_io_channel_shutdown(ms->dcio, TRUE, NULL);
+		g_io_channel_unref(ms->dcio);
+		ms->dcio = NULL;
+	}
+
+	for (l = ms->mcls; l; l = l->next)
+		mcap_mcl_free(l->data);
+
+	g_slist_free(ms->mcls);
+	ms->mcls = NULL;
+
+	g_free(ms);
+}
diff --git a/mcap/mcap.h b/mcap/mcap.h
new file mode 100644
index 0000000..7b45d04
--- /dev/null
+++ b/mcap/mcap.h
@@ -0,0 +1,174 @@
+/*
+ *
+ *  MCAP for BlueZ- Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009-2010 Santiago Carot-Nemesio <sancane at gmail.com>
+ *  Copyright (C) 2009-2010 Jose Antonio Santos Cadenas <santoscadenas at gmail.com>
+ *  Copyright (C) 2009-2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
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
+/*RESERVED                              0x09*/
+/*RESERVED                              0x10*/
+
+/* MCAP Clock Sync Op Codes */
+#define MCAP_MD_SYNC_CAP_REQ		0x11
+#define MCAP_MD_SYNC_CAP_RSP		0x12
+#define MCAP_MD_SYNC_SET_REQ		0x13
+#define MCAP_MD_SYNC_SET_RSP            0x14
+#define MCAP_MD_SYNC_INFO_IND		0x15
+/*RESERVED				0x16*/
+/*RESERVED                              0x17*/
+/*RESERVED                              0x18*/
+/*RESERVED                              0x19*/
+/*RESERVED                              0x20*/
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
+#define MCAP_UNESPECIFIED_ERROR		0x09
+#define MCAP_REQUEST_NOT_SUPPORTED	0x0A
+#define MCAP_CONFIGURATION_REJECTED	0x0B
+/*RESERVED				0x0C-0xFF*/
+
+
+/* MDL IDs */
+#define MCAP_MDLID_RESERVED		0x0000
+#define MCAP_MDLID_INITIAL		0x0001
+#define MCAP_MDLID_FINAL		0xFEFF
+/*RESERVED				0xFF00-0xFFFE*/
+#define MCAP_ALL_MDLIDS			0xFFFF
+
+/* MDEP IDs */
+#define MCAP_MDEPID_INITIAL		0x00
+#define MCAP_MDEPID_FINAL		0x7F
+/*RESERVED				0x80-0xFF*/
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
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
new file mode 100644
index 0000000..530f03a
--- /dev/null
+++ b/mcap/mcap_lib.h
@@ -0,0 +1,137 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Santiago Carot Nemesio <sancane at gmail.com>
+ *  Copyright (C) 2010 Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
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
+#include <pthread.h>
+#include <bluetooth/l2cap.h>
+#include "btio.h"
+#include "mcap.h"
+
+typedef enum {
+	MCAP_ERROR_INVALID_ARGS,
+	MCAP_ERROR_MEMORY,
+	MCAP_ERROR_ALREADY_EXISTS,
+	MCAP_ERROR_FAILED,
+	MCAP_ERROR_NOT_FOUND,
+} McapError;
+
+typedef enum {
+	MCAP_MDL_CB_INVALID,
+	MCAP_MDL_CB_CONNECTED,
+	MCAP_MDL_CB_CLOSED,
+	MCAP_MDL_CB_DELETED,
+	MCAP_MDL_CB_REMOTE_CONN_REQ,
+	MCAP_MDL_CB_REMOTE_RECONN_REQ,
+} McapMclCb;
+
+struct mcap_session;
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
+/* Next function should return an MCAP appropiate response code */
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
+int mcap_mdl_get_fd(struct mcap_mdl *mdl);
+
+/* Mcl operations*/
+
+void mcap_create_mcl(struct mcap_session *ms,
+				const bdaddr_t *addr,
+				uint16_t ccpsm,
+				GError **err,
+				mcap_mcl_connect_cb connect_cb,
+				gpointer user_data);
+void mcap_close_mcl(struct mcap_mcl *mcl);
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
+					gpointer user_data, McapMclCb cb1, ...);
+bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl);
+
+/* MCAP main operations */
+
+struct mcap_session *mcap_create_session(struct btd_adapter *btd_adapter,
+					BtIOSecLevel sec, uint16_t ccpsm,
+					uint16_t dcpsm,
+					GError **gerr,
+					mcap_mcl_event_cb mcl_closed,
+					mcap_mcl_event_cb mcl_created,
+					gpointer user_data);
+
+void mcap_close_session(struct mcap_session *ms);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MCAP_LIB_H */
+
-- 
1.6.3.3



