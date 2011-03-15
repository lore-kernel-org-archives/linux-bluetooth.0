Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v4 2/6] Sim Access Profile Server
Date: Tue, 15 Mar 2011 17:43:17 +0100
Message-ID: <1300207401-23438-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1300207401-23438-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1300207401-23438-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a Sim Access Server to the SAP plugin and a framework for the dummy
sap driver as well.

	* add the server register and unregister rutines
	* add server listening socket setup
	* add SAP DBus API
	* add prototypes for SAP protocol implementation
	* add skeleton of dummy SIM driver
---
 Makefile.am     |    3 +-
 sap/sap-dummy.c |   85 ++++++++
 sap/sap.h       |  186 +++++++++++++++++
 sap/server.c    |  612 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 878 insertions(+), 8 deletions(-)
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap.h

diff --git a/Makefile.am b/Makefile.am
index 140916a..d4d2de9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -147,7 +147,8 @@ if SAPPLUGIN
 builtin_modules += sap
 builtin_sources += sap/main.c \
 			sap/manager.h sap/manager.c \
-			sap/server.h sap/server.c
+			sap/server.h sap/server.c \
+			sap/sap.h sap/sap-dummy.c
 endif
 
 if INPUTPLUGIN
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
new file mode 100644
index 0000000..b433ba3
--- /dev/null
+++ b/sap/sap-dummy.c
@@ -0,0 +1,85 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
+ *          for ST-Ericsson
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
+ */
+
+#include "log.h"
+#include "sap.h"
+
+void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
+{
+	sap_connect_rsp(sap_device, SAP_STATUS_OK, maxmsgsize);
+	sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
+}
+
+void sap_disconnect_req(void *sap_device, uint8_t linkloss)
+{
+	sap_disconnect_rsp(sap_device);
+}
+
+void sap_transfer_apdu_req(void *sap_device, struct sap_parameter *param)
+{
+	sap_transfer_apdu_rsp(sap_device, SAP_RESULT_OK, NULL, 0);
+}
+
+void sap_transfer_atr_req(void *sap_device)
+{
+	sap_transfer_atr_rsp(sap_device, SAP_RESULT_OK, NULL, 0);
+}
+
+void sap_power_sim_off_req(void *sap_device)
+{
+	sap_power_sim_off_rsp(sap_device, SAP_RESULT_OK);
+}
+
+void sap_power_sim_on_req(void *sap_device)
+{
+	sap_power_sim_on_rsp(sap_device, SAP_RESULT_OK);
+}
+
+void sap_reset_sim_req(void *sap_device)
+{
+	sap_reset_sim_rsp(sap_device, SAP_RESULT_OK);
+	sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
+}
+
+void sap_transfer_card_reader_status_req(void *sap_device)
+{
+	sap_transfer_card_reader_status_rsp(sap_device, SAP_RESULT_OK,
+						ICC_READER_CARD_POWERED_ON);
+}
+
+void sap_set_transport_protocol_req(void *sap_device,
+					struct sap_parameter *param)
+{
+	sap_transport_protocol_rsp(sap_device, SAP_RESULT_NOT_SUPPORTED);
+}
+
+int sap_init(void)
+{
+	DBG("SAP driver init.");
+	return 0;
+}
+
+void sap_exit(void)
+{
+	DBG("SAP driver exit.");
+}
diff --git a/sap/sap.h b/sap/sap.h
new file mode 100644
index 0000000..bd0f06d
--- /dev/null
+++ b/sap/sap.h
@@ -0,0 +1,186 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Instituto Nokia de Tecnologia - INdT
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *
+ *  Author: Marek Skowron <marek.skowron@tieto.com> for ST-Ericsson.
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
+ *          for ST-Ericsson.
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
+ */
+
+#include <stdint.h>
+#include <glib.h>
+
+#define SAP_VERSION 0x0101
+
+/* Connection Status - SAP v1.1 section 5.2.2 */
+enum sap_status {
+	SAP_STATUS_OK				= 0x00,
+	SAP_STATUS_CONNECTION_FAILED		= 0x01,
+	SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED	= 0x02,
+	SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL	= 0x03,
+	SAP_STATUS_OK_ONGOING_CALL		= 0x04
+};
+
+/* Disconnection Type - SAP v1.1 section 5.2.3 */
+enum sap_disconnection_type {
+	SAP_DISCONNECTION_TYPE_GRACEFUL		= 0x00,
+	SAP_DISCONNECTION_TYPE_IMMEDIATE	= 0x01,
+	SAP_DISCONNECTION_TYPE_CLIENT		= 0xFF
+};
+
+/* Result codes - SAP v1.1 section 5.2.4 */
+enum sap_result {
+	SAP_RESULT_OK			= 0x00,
+	SAP_RESULT_ERROR_NO_REASON	= 0x01,
+	SAP_RESULT_ERROR_NOT_ACCESSIBLE	= 0x02,
+	SAP_RESULT_ERROR_POWERED_OFF	= 0x03,
+	SAP_RESULT_ERROR_CARD_REMOVED	= 0x04,
+	SAP_RESULT_ERROR_POWERED_ON	= 0x05,
+	SAP_RESULT_ERROR_NO_DATA	= 0x06,
+	SAP_RESULT_NOT_SUPPORTED	= 0x07
+};
+
+/* Status Change - SAP v1.1 section 5.2.8 */
+enum sap_status_change {
+	SAP_STATUS_CHANGE_UNKNOWN_ERROR		= 0x00,
+	SAP_STATUS_CHANGE_CARD_RESET		= 0x01,
+	SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE	= 0x02,
+	SAP_STATUS_CHANGE_CARD_REMOVED		= 0x03,
+	SAP_STATUS_CHANGE_CARD_INSERTED		= 0x04,
+	SAP_STATUS_CHANGE_CARD_RECOVERED	= 0x05
+};
+
+/* Message format - SAP v1.1 section 5.1 */
+struct sap_parameter {
+	uint8_t id;
+	uint8_t reserved;
+	uint16_t len;
+	uint8_t val[0];
+	/*
+	 * Padding bytes 0-3 bytes
+	 */
+} __attribute__((packed));
+
+struct sap_message {
+	uint8_t id;
+	uint8_t nparam;
+	uint16_t reserved;
+	struct sap_parameter param[0];
+} __attribute__((packed));
+
+enum {
+	ICC_READER_UNSPECIFIED_ERROR, /* No further information available */
+	ICC_READER_NOT_PRESENT,       /* Card Reader removed or not present */
+	ICC_READER_BUSY,              /* Card Reader in use */
+	ICC_READER_CARD_POWERED_ON,   /* Card in reader and is powered on */
+	ICC_READER_DEACTIVATED,       /* Card Reader deactivated */
+	ICC_READER_CARD_POWERED_OFF,  /* Card in reader, but powered off */
+	ICC_READER_NO_CARD,           /* No card in reader */
+	ICC_READER_LAST
+};
+
+#define SAP_BUF_SIZE		512
+#define SAP_MSG_HEADER_SIZE	4
+
+enum sap_protocol {
+	SAP_CONNECT_REQ		= 0x00,
+	SAP_CONNECT_RESP	= 0x01,
+	SAP_DISCONNECT_REQ	= 0x02,
+	SAP_DISCONNECT_RESP	= 0x03,
+	SAP_DISCONNECT_IND	= 0x04,
+	SAP_TRANSFER_APDU_REQ	= 0x05,
+	SAP_TRANSFER_APDU_RESP	= 0x06,
+	SAP_TRANSFER_ATR_REQ	= 0x07,
+	SAP_TRANSFER_ATR_RESP	= 0x08,
+	SAP_POWER_SIM_OFF_REQ	= 0x09,
+	SAP_POWER_SIM_OFF_RESP	= 0x0A,
+	SAP_POWER_SIM_ON_REQ	= 0x0B,
+	SAP_POWER_SIM_ON_RESP	= 0x0C,
+	SAP_RESET_SIM_REQ	= 0x0D,
+	SAP_RESET_SIM_RESP	= 0x0E,
+	SAP_TRANSFER_CARD_READER_STATUS_REQ	= 0x0F,
+	SAP_TRANSFER_CARD_READER_STATUS_RESP	= 0x10,
+	SAP_STATUS_IND	= 0x11,
+	SAP_ERROR_RESP	= 0x12,
+	SAP_SET_TRANSPORT_PROTOCOL_REQ	= 0x13,
+	SAP_SET_TRANSPORT_PROTOCOL_RESP	= 0x14
+};
+
+/* Parameters Ids - SAP 1.1 section 5.2 */
+enum sap_param_id {
+	SAP_PARAM_ID_MAX_MSG_SIZE	= 0x00,
+	SAP_PARAM_ID_CONN_STATUS	= 0x01,
+	SAP_PARAM_ID_RESULT_CODE	= 0x02,
+	SAP_PARAM_ID_DISCONNECT_IND	= 0x03,
+	SAP_PARAM_ID_COMMAND_APDU	= 0x04,
+	SAP_PARAM_ID_COMMAND_APDU7816	= 0x10,
+	SAP_PARAM_ID_RESPONSE_APDU	= 0x05,
+	SAP_PARAM_ID_ATR		= 0x06,
+	SAP_PARAM_ID_CARD_READER_STATUS	= 0x07,
+	SAP_PARAM_ID_STATUS_CHANGE	= 0x08,
+	SAP_PARAM_ID_TRANSPORT_PROTOCOL	= 0x09
+};
+
+#define SAP_PARAM_ID_MAX_MSG_SIZE_LEN		0x02
+#define SAP_PARAM_ID_CONN_STATUS_LEN		0x01
+#define SAP_PARAM_ID_RESULT_CODE_LEN		0x01
+#define SAP_PARAM_ID_DISCONNECT_IND_LEN		0x01
+#define SAP_PARAM_ID_CARD_READER_STATUS_LEN	0x01
+#define SAP_PARAM_ID_STATUS_CHANGE_LEN		0x01
+#define SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN	0x01
+
+/* Transport Protocol - SAP v1.1 section 5.2.9 */
+enum sap_transport_protocol {
+	SAP_TRANSPORT_PROTOCOL_T0 = 0x00,
+	SAP_TRANSPORT_PROTOCOL_T1 = 0x01
+};
+
+/*SAP driver init and exit routines. Implemented by sap-*.c */
+int sap_init(void);
+void sap_exit(void);
+
+/* SAP requests implemented by sap-*.c */
+void sap_connect_req(void *sap_device, uint16_t maxmsgsize);
+void sap_disconnect_req(void *sap_device, uint8_t linkloss);
+void sap_transfer_apdu_req(void *sap_device, struct sap_parameter *param);
+void sap_transfer_atr_req(void *sap_device);
+void sap_power_sim_off_req(void *sap_device);
+void sap_power_sim_on_req(void *sap_device);
+void sap_reset_sim_req(void *sap_device);
+void sap_transfer_card_reader_status_req(void *sap_device);
+void sap_set_transport_protocol_req(void *sap_device,
+					struct sap_parameter *param);
+
+/*SAP responses to SAP requests. Implemented by server.c */
+int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize);
+int sap_disconnect_rsp(void *sap_device);
+int sap_transfer_apdu_rsp(void *sap_device, uint8_t result,
+				uint8_t *sap_apdu_resp, uint16_t length);
+int sap_transfer_atr_rsp(void *sap_device, uint8_t result,
+				uint8_t *sap_atr, uint16_t length);
+int sap_power_sim_off_rsp(void *sap_device, uint8_t result);
+int sap_power_sim_on_rsp(void *sap_device, uint8_t result);
+int sap_reset_sim_rsp(void *sap_device, uint8_t result);
+int sap_transfer_card_reader_status_rsp(void *sap_device, uint8_t result,
+						uint8_t status);
+int sap_error_rsp(void *sap_device);
+int sap_transport_protocol_rsp(void *sap_device, uint8_t result);
+
+/* Event indication. Implemented by server.c*/
+int sap_status_ind(void *sap_device, uint8_t status_change);
diff --git a/sap/server.c b/sap/server.c
index 64af3f9..923ae20 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1,9 +1,13 @@
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
+ *  Copyright (C) 2010 Instituto Nokia de Tecnologia - INdT
  *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2011 Tieto Poland
  *
- *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson.
+ *  Author: Marek Skowron <marek.skowron@tieto.com> for ST-Ericsson.
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
+ *          for ST-Ericsson.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -20,30 +24,624 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "bluetooth.h"
-#include "log.h"
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <glib.h>
+#include <netinet/in.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
+#include "adapter.h"
+#include "btio.h"
+#include "sdpd.h"
+#include "log.h"
+#include "error.h"
+#include "dbus-common.h"
+#include "sap.h"
 #include "server.h"
 
+#define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
+#define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
+#define SAP_SERVER_CHANNEL	8
+#define SAP_BUF_SIZE		512
+
+enum {
+	SAP_STATE_DISCONNECTED,
+	SAP_STATE_CONNECTED,
+};
+
+struct sap_connection {
+	GIOChannel *io;
+	uint32_t state;
+};
+
+struct sap_server {
+	bdaddr_t src;
+	char *path;
+	uint32_t record_id;
+	GIOChannel *listen_io;
+	struct sap_connection *conn;
+};
+
+static DBusConnection *connection;
+static struct sap_server *server;
+
+static sdp_record_t *create_sap_record(uint8_t channel)
+{
+	sdp_list_t *apseq, *aproto, *profiles, *proto[2], *root, *svclass_id;
+	uuid_t sap_uuid, gt_uuid, root_uuid, l2cap, rfcomm;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	sdp_data_t *ch;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+	sdp_list_free(root, NULL);
+
+	sdp_uuid16_create(&sap_uuid, SAP_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &sap_uuid);
+	sdp_uuid16_create(&gt_uuid, GENERIC_TELEPHONY_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &gt_uuid);
+
+	sdp_set_service_classes(record, svclass_id);
+	sdp_list_free(svclass_id, NULL);
+
+	sdp_uuid16_create(&profile.uuid, SAP_PROFILE_ID);
+	profile.version = SAP_VERSION;
+	profiles = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, profiles);
+	sdp_list_free(profiles, NULL);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm);
+	ch = sdp_data_alloc(SDP_UINT8, &channel);
+	proto[1] = sdp_list_append(proto[1], ch);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "SIM Access Server",
+			NULL, NULL);
+
+	sdp_data_free(ch);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto, NULL);
+
+	return record;
+}
+
+static void connect_req(struct sap_connection *conn,
+					struct sap_parameter *param)
+{
+	DBG("SAP_CONNECT_REQUEST");
+}
+
+static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
+{
+	DBG("SAP_DISCONNECT_REQUEST");
+	return 0;
+}
+
+static void transfer_apdu_req(struct sap_connection *conn,
+					struct sap_parameter *param)
+{
+	DBG("SAP_APDU_REQUEST");
+}
+
+static void transfer_atr_req(struct sap_connection *conn)
+{
+	DBG("SAP_ATR_REQUEST");
+}
+
+static void power_sim_off_req(struct sap_connection *conn)
+{
+	DBG("SAP_SIM_OFF_REQUEST");
+}
+
+static void power_sim_on_req(struct sap_connection *conn)
+{
+	DBG("SAP_SIM_ON_REQUEST");
+}
+
+static void reset_sim_req(struct sap_connection *conn)
+{
+	DBG("SAP_RESET_SIM_REQUEST");
+}
+
+static void transfer_card_reader_status_req(struct sap_connection *conn)
+{
+	DBG("SAP_TRANSFER_CARD_READER_STATUS_REQUEST");
+}
+
+static void set_transport_protocol_req(struct sap_connection *conn,
+					struct sap_parameter *param)
+{
+	DBG("SAP_SET_TRANSPORT_PROTOCOL_REQUEST");
+}
+
+int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
+{
+	return 0;
+}
+
+int sap_disconnect_rsp(void *sap_device)
+{
+	return 0;
+}
+
+int sap_transfer_apdu_rsp(void *sap_device, uint8_t result, uint8_t *apdu,
+					uint16_t length)
+{
+	return 0;
+}
+
+int sap_transfer_atr_rsp(void *sap_device, uint8_t result, uint8_t *atr,
+					uint16_t length)
+{
+	return 0;
+}
+
+int sap_power_sim_off_rsp(void *sap_device, uint8_t result)
+{
+	return 0;
+}
+
+int sap_power_sim_on_rsp(void *sap_device, uint8_t result)
+{
+	return 0;
+}
+
+int sap_reset_sim_rsp(void *sap_device, uint8_t result)
+{
+	return 0;
+}
+
+int sap_transfer_card_reader_status_rsp(void *sap_device, uint8_t result,
+						uint8_t status)
+{
+	return 0;
+}
+
+int sap_transport_protocol_rsp(void *sap_device, uint8_t result)
+{
+	return 0;
+}
+
+int sap_error_rsp(void *sap_device)
+{
+	return 0;
+}
+
+int sap_status_ind(void *sap_device, uint8_t status_change)
+{
+	return 0;
+}
+
+static int handle_cmd(void *data, void *buf, size_t size)
+{
+	struct sap_message *msg = buf;
+	struct sap_connection *conn = data;
+
+	if (!conn)
+		return -EINVAL;
+
+	if (size < sizeof(struct sap_message))
+		return -EINVAL;
+
+	if (msg->nparam != 0 && size < (sizeof(struct sap_message) +
+			sizeof(struct sap_parameter) + 4))
+		return -EBADMSG;
+
+	switch (msg->id) {
+	case SAP_CONNECT_REQ:
+		connect_req(conn, msg->param);
+		return 0;
+	case SAP_DISCONNECT_REQ:
+		disconnect_req(conn, SAP_DISCONNECTION_TYPE_CLIENT);
+		return 0;
+	case SAP_TRANSFER_APDU_REQ:
+		transfer_apdu_req(conn, msg->param);
+		return 0;
+	case SAP_TRANSFER_ATR_REQ:
+		transfer_atr_req(conn);
+		return 0;
+	case SAP_POWER_SIM_OFF_REQ:
+	power_sim_off_req(conn);
+		return 0;
+	case SAP_POWER_SIM_ON_REQ:
+		power_sim_on_req(conn);
+		return 0;
+	case SAP_RESET_SIM_REQ:
+		reset_sim_req(conn);
+		return 0;
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		transfer_card_reader_status_req(conn);
+		return 0;
+	case SAP_SET_TRANSPORT_PROTOCOL_REQ:
+		set_transport_protocol_req(conn, msg->param);
+		return 0;
+	default:
+		DBG("SAP unknown message.");
+		return -ENOMSG;
+	}
+
+	return -1;
+}
+
+static void sap_conn_remove(struct sap_connection *conn)
+{
+	DBG("conn %p", conn);
+
+	if (!conn)
+		return;
+
+	if (conn->io) {
+		g_io_channel_shutdown(conn->io, TRUE, NULL);
+		g_io_channel_unref(conn->io);
+	}
+
+	conn->io = NULL;
+	g_free(conn);
+	server->conn = NULL;
+}
+
+static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
+{
+	char buf[SAP_BUF_SIZE];
+	size_t bytes_read = 0;
+	GError *gerr = NULL;
+	GIOStatus gstatus;
+
+	DBG("io %p", io);
+
+	if (cond & G_IO_NVAL) {
+		DBG("ERR (G_IO_NVAL) on rfcomm socket.");
+		return FALSE;
+	}
+
+	if (cond & G_IO_ERR) {
+		DBG("ERR (G_IO_ERR) on rfcomm socket.");
+		return FALSE;
+	}
+
+	if (cond & G_IO_HUP) {
+		DBG("HUP on rfcomm socket.");
+		return FALSE;
+	}
+
+	gstatus = g_io_channel_read_chars(io, buf, sizeof(buf) - 1,
+				&bytes_read, &gerr);
+
+	if (gstatus != G_IO_STATUS_NORMAL) {
+		if (gerr)
+			g_error_free(gerr);
+
+		return TRUE;
+	}
+
+	if (handle_cmd(data, buf, bytes_read) < 0)
+		error("Invalid SAP message.");
+
+	return TRUE;
+}
+
+static void sap_io_destroy(void *data)
+{
+	struct sap_connection *conn = data;
+
+	DBG("conn %p", conn);
+
+	if (conn && conn->io) {
+		conn->io = NULL;
+		sap_conn_remove(conn);
+	}
+}
+
+static void sap_connect_cb(GIOChannel *io, GError *gerr, gpointer data)
+{
+	struct sap_connection *conn = data;
+
+	DBG("io %p gerr %p data %p ", io, gerr, data);
+
+	if (!conn)
+		return;
+
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			sap_io_cb, conn, sap_io_destroy);
+}
+
+static void connect_auth_cb(DBusError *derr, void *data)
+{
+	struct sap_connection *conn = data;
+	GError *gerr = NULL;
+
+	DBG("derr %p data %p ", derr, data);
+
+	if (!conn)
+		return;
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		sap_conn_remove(conn);
+		return;
+	}
+
+	if (!bt_io_accept(conn->io, sap_connect_cb, conn, NULL, &gerr)) {
+		error("bt_io_accept: %s", gerr->message);
+		g_error_free(gerr);
+		sap_conn_remove(conn);
+		return;
+	}
+
+	DBG("Client has been authorized.");
+}
+
+static void connect_confirm_cb(GIOChannel *io, gpointer data)
+{
+	struct sap_connection *conn = server->conn;
+	GError *gerr = NULL;
+	bdaddr_t src, dst;
+	int err;
+
+	DBG("io %p data %p ", io, data);
+
+	if (!io)
+		return;
+
+	if (conn) {
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	conn = g_try_new0(struct sap_connection, 1);
+	if (!conn) {
+		error("Can't allocate memory for incomming SAP connection.");
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	g_io_channel_set_encoding(io, NULL, NULL);
+	g_io_channel_set_buffered(io, FALSE);
+
+	server->conn = conn;
+	conn->io = g_io_channel_ref(io);
+	conn->state = SAP_STATE_DISCONNECTED;
+
+	bt_io_get(io, BT_IO_RFCOMM, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		sap_conn_remove(conn);
+		return;
+	}
+
+	err = btd_request_authorization(&src, &dst, SAP_UUID,
+					connect_auth_cb, conn);
+
+	if (err < 0) {
+		DBG("Authorization denied: %d %s", err,  strerror(err));
+		sap_conn_remove(conn);
+		return;
+	}
+
+	DBG("SAP incoming connection (sock %d) authorization.",
+				g_io_channel_unix_get_fd(io));
+}
+
+static inline DBusMessage *message_failed(DBusMessage *msg,
+					const char *description)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+				"%s", description);
+}
+
+static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct sap_server *server = data;
+
+	DBG("server %p", server);
+
+	if (!server)
+		return message_failed(msg, "Server internal error.");
+
+	DBG("conn %p", server->conn);
+
+	if (!server->conn)
+		return message_failed(msg, "Client already disconnected");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *get_properties(DBusConnection *c,
+				DBusMessage *msg, void *data)
+{
+	struct sap_connection *conn = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t connected;
+
+	if (!conn)
+		return message_failed(msg, "Server internal error.");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	connected = (conn->state == SAP_STATE_CONNECTED);
+	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable server_methods[] = {
+	{"GetProperties", "", "a{sv}", get_properties},
+	{"Disconnect", "", "", disconnect},
+	{ }
+};
+
+static GDBusSignalTable server_signals[] = {
+	{ "PropertyChanged", "sv"},
+	{ }
+};
+
+static void server_free(struct sap_server *server)
+{
+	if (!server)
+		return;
+
+	sap_conn_remove(server->conn);
+	g_free(server->path);
+	g_free(server);
+}
+
+static void destroy_sap_interface(void *data)
+{
+	struct sap_server *server = data;
+
+	DBG("Unregistered interface %s on path %s",
+			SAP_SERVER_INTERFACE, server->path);
+
+	server_free(server);
+}
+
 int sap_server_register(const char *path, bdaddr_t *src)
 {
-	DBG("Register SAP server.");
+	sdp_record_t *record = NULL;
+	GError *gerr = NULL;
+	GIOChannel *io;
+
+	if (sap_init() < 0) {
+		error("Sap driver initialization failed.");
+		return -1;
+	}
+
+	server = g_try_new0(struct sap_server, 1);
+	if (!server) {
+		sap_exit();
+		return -ENOMEM;
+	}
+
+	bacpy(&server->src, src);
+	server->path = g_strdup(path);
+
+	record = create_sap_record(SAP_SERVER_CHANNEL);
+	if (!record) {
+		error("Creating SAP SDP record failed.");
+		goto sdp_err;
+	}
+
+	if (add_record_to_server(&server->src, record) < 0) {
+		error("Adding SAP SDP record to the SDP server failed.");
+		sdp_record_free(record);
+		goto sdp_err;
+	}
+
+	server->record_id = record->handle;
+
+	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, server,
+			NULL, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &server->src,
+			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
+			BT_IO_OPT_MASTER, TRUE,
+			BT_IO_OPT_INVALID);
+
+	if (!io) {
+		error("Can't listen at channel %d.", SAP_SERVER_CHANNEL);
+		g_error_free(gerr);
+		goto server_err;
+	}
+
+	DBG("Listen socket 0x%02x", g_io_channel_unix_get_fd(io));
+
+	server->listen_io = io;
+	server->conn = NULL;
+
+	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
+				server_methods, server_signals, NULL,
+				server, destroy_sap_interface)) {
+		error("D-Bus failed to register %s interface",
+						SAP_SERVER_INTERFACE);
+		goto server_err;
+	}
+
 	return 0;
+
+server_err:
+	remove_record_from_server(server->record_id);
+sdp_err:
+	server_free(server);
+	server = NULL;
+	sap_exit();
+
+	return -1;
 }
 
 int sap_server_unregister(const char *path)
 {
-	DBG("Unregister SAP server.");
+	if (!server)
+		return -EINVAL;
+
+	remove_record_from_server(server->record_id);
+
+	if (server->conn)
+		sap_conn_remove(server->conn);
+
+	if (server->listen_io) {
+		g_io_channel_shutdown(server->listen_io, TRUE, NULL);
+		g_io_channel_unref(server->listen_io);
+		server->listen_io = NULL;
+	}
+
+	g_dbus_unregister_interface(connection, path, SAP_SERVER_INTERFACE);
+
+	server_free(server);
+	server = NULL;
+	sap_exit();
+
 	return 0;
 }
 
 int sap_server_init(DBusConnection *conn)
 {
-	DBG("Init SAP server.");
+	connection = dbus_connection_ref(conn);
 	return 0;
 }
 
 void sap_server_exit(void)
 {
-	DBG("Exit SAP server.");
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
-- 
1.7.1

