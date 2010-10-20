Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, <suraj@atheros.com>, Waldemar
 Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 3/4] Sim Access Profile Server
Date: Wed, 20 Oct 2010 14:11:20 +0200
Message-ID: <1287576681-12669-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1287576681-12669-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1287576681-12669-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Add a Sim Access Server to the SAP plugin and a framework for the dummy
sap driver as well.
---
 Makefile.am     |    3 +-
 sap/sap-dummy.c |   85 ++++
 sap/sap.h       |  187 +++++++
 sap/server.c    | 1476 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 1745 insertions(+), 6 deletions(-)
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap.h

diff --git a/Makefile.am b/Makefile.am
index 4c91469..0facbe2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -146,7 +146,8 @@ if SAPPLUGIN
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
index 0000000..e04660f
--- /dev/null
+++ b/sap/sap-dummy.c
@@ -0,0 +1,85 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
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
+void sap_transfer_apdu_req(void *sap_device, sap_parameter *param)
+{
+	sap_transfer_apdu_rsp(sap_device, SAP_RESULT_OK, NULL, 0);
+}
+
+void sap_transfer_atr_req(void * sap_device)
+{
+	uint8_t atr[] = {0x3b, 0x9a, 0x96, 0x00, 0x92, 0x01, 0x98, 0x93, 0x17,
+			 0x00, 0x02, 0x28, 0x03, 0x00};
+
+	sap_transfer_atr_rsp(sap_device, SAP_RESULT_OK, atr, 0x0E);
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
+void sap_transfer_card_reader_status_req(void * sap_device)
+{
+	sap_transfer_card_reader_status_rsp(sap_device, SAP_RESULT_OK,
+						ICC_READER_CARD_POWERED_ON);
+}
+
+void sap_set_transport_protocol_req(void * sap_device,sap_parameter * param)
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
index 0000000..a9189fc
--- /dev/null
+++ b/sap/sap.h
@@ -0,0 +1,187 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  Author: Marek Skowron <marek.skowron@tieto.com> for ST-Ericsson.
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
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
+ #define SAP_VERSION 0x0101
+
+/* Connection Status - SAP v1.1 section 5.2.2 */
+typedef enum {
+	SAP_STATUS_OK 				= 0x00,
+	SAP_STATUS_CONNECTION_FAILED		= 0x01,
+	SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED	= 0x02,
+	SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL	= 0x03,
+	SAP_STATUS_OK_ONGOING_CALL		= 0x04
+} sap_status_t;
+
+/* Disconnection Type - SAP v1.1 section 5.2.3 */
+typedef enum {
+	SAP_DISCONNECTION_TYPE_GRACEFUL  = 0x00,
+	SAP_DISCONNECTION_TYPE_IMMEDIATE = 0x01,
+	SAP_DISCONNECTION_TYPE_CLIENT    = 0xFF
+} sap_disconnection_type_t;
+
+/* Result codes - SAP v1.1 section 5.2.4 */
+typedef enum {
+	SAP_RESULT_OK 			= 0x00,
+	SAP_RESULT_ERROR_NO_REASON	= 0x01,
+	SAP_RESULT_ERROR_NOT_ACCESSIBLE	= 0x02,
+	SAP_RESULT_ERROR_POWERED_OFF	= 0x03,
+	SAP_RESULT_ERROR_CARD_REMOVED	= 0x04,
+	SAP_RESULT_ERROR_POWERED_ON	= 0x05,
+	SAP_RESULT_ERROR_NO_DATA	= 0x06,
+	SAP_RESULT_NOT_SUPPORTED	= 0x07
+} sap_result_t;
+
+/* Status Change - SAP v1.1 section 5.2.8 */
+typedef enum {
+	SAP_STATUS_CHANGE_UNKNOWN_ERROR	= 0x00,
+	SAP_STATUS_CHANGE_CARD_RESET	= 0x01,
+	SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE = 0x02,
+	SAP_STATUS_CHANGE_CARD_REMOVED	= 0x03,
+	SAP_STATUS_CHANGE_CARD_INSERTED	= 0x04,
+	SAP_STATUS_CHANGE_CARD_RECOVERED = 0x05
+} sap_status_change_t;
+
+/* Message format - SAP v1.1 section 5.1 */
+typedef struct {
+	uint8_t id;
+	uint8_t reserved;
+	uint16_t len;
+	uint8_t val[0];
+	/*
+	 * Padding bytes 0-3 bytes
+	 */
+} __attribute__ ((packed)) sap_parameter;
+
+typedef struct {
+	uint8_t id;
+	uint8_t nparam;
+	uint16_t reserved;
+	sap_parameter param[0];
+} __attribute__ ((packed)) sap_message;
+
+
+typedef enum {
+	ICC_READER_UNSPECIFIED_ERROR, /* No further information available */
+	ICC_READER_NOT_PRESENT,       /* Card Reader removed or not present */
+	ICC_READER_BUSY,              /* Card Reader in use */
+	ICC_READER_CARD_POWERED_ON,   /* Card in reader and is powered on */
+	ICC_READER_DEACTIVATED,       /* Card Reader deactivated */
+	ICC_READER_CARD_POWERED_OFF,  /* Card in reader, but powered off */
+	ICC_READER_NO_CARD,           /* No card in reader */
+	ICC_READER_LAST
+} icc_reader_status_t;
+
+
+#define SAP_BUF_SIZE		512
+
+#define SAP_MSG_HEADER_SIZE	4
+
+typedef enum {
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
+	SAP_SET_TRANSPORT_PROTOCOL_RESP	= 0x14,
+} sap_protocol;
+
+/* Parameters Ids - SAP 1.1 section 5.2 */
+#define SAP_PARAM_ID_MAX_MSG_SIZE             0x00
+#define SAP_PARAM_ID_MAX_MSG_SIZE_LEN         0x02
+
+#define SAP_PARAM_ID_CONN_STATUS            0x01
+#define SAP_PARAM_ID_CONN_STATUS_LEN        0x01
+
+#define SAP_PARAM_ID_RESULT_CODE            0x02
+#define SAP_PARAM_ID_RESULT_CODE_LEN        0x01
+
+#define SAP_PARAM_ID_DISCONNECT_IND         0x03
+#define SAP_PARAM_ID_DISCONNECT_IND_LEN     0x01
+
+#define SAP_PARAM_ID_COMMAND_APDU           0x04
+#define SAP_PARAM_ID_RESPONSE_APDU          0x05
+#define SAP_PARAM_ID_ATR                    0x06
+
+#define SAP_PARAM_ID_CARD_READER_STATUS     0x07
+#define SAP_PARAM_ID_CARD_READER_STATUS_LEN 0x01
+
+#define SAP_PARAM_ID_STATUS_CHANGE          0x08
+#define SAP_PARAM_ID_STATUS_CHANGE_LEN      0x01
+
+#define SAP_PARAM_ID_TRANSPORT_PROTOCOL     0x09
+#define SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN 0x01
+
+#define SAP_PARAM_ID_COMMAND_APDU7816       0x10
+
+/* Transport Protocol - SAP v1.1 section 5.2.9 */
+#define SAP_TRANSPORT_PROTOCOL_T0           0x00
+#define SAP_TRANSPORT_PROTOCOL_T1           0x01
+
+/*SAP driver init and exit routines. Implemented by sap-*.c */
+int sap_init(void);
+void sap_exit(void);
+
+/* SAP requests implemented by sap-*.c */
+void sap_connect_req(void *sap_device, uint16_t maxmsgsize);
+void sap_disconnect_req(void *sap_device, uint8_t linkloss);
+void sap_transfer_apdu_req(void *sap_device, sap_parameter *param);
+void sap_transfer_atr_req(void *sap_device);
+void sap_power_sim_off_req(void *sap_device);
+void sap_power_sim_on_req(void *sap_device);
+void sap_reset_sim_req(void *sap_device);
+void sap_transfer_card_reader_status_req(void *sap_device);
+void sap_set_transport_protocol_req(void *sap_device, sap_parameter *param);
+
+/*SAP responses to SAP requests. Implemented by server.c */
+int sap_connect_rsp(void *sap_device, sap_status_t status, uint16_t maxmsgsize);
+int sap_disconnect_rsp(void *sap_device);
+int sap_transfer_apdu_rsp(void *sap_device, sap_result_t result, uint8_t *sap_apdu_resp, uint16_t length);
+int sap_transfer_atr_rsp(void *sap_device, sap_result_t result, uint8_t *sap_atr, uint16_t length);
+int sap_power_sim_off_rsp(void *sap_device, sap_result_t result);
+int sap_power_sim_on_rsp(void *sap_device, sap_result_t result);
+int sap_reset_sim_rsp(void *sap_device, sap_result_t result);
+int sap_transfer_card_reader_status_rsp(void *sap_device, sap_result_t result, icc_reader_status_t status);
+int sap_error_rsp(void *sap_device);
+int sap_transport_protocol_rsp(void *sap_device, sap_result_t result);
+
+/* Event indication. Implemented by server.c*/
+int sap_status_ind(void *sap_device, sap_status_change_t status_change);
+
diff --git a/sap/server.c b/sap/server.c
index 2728778..5683e66 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -2,7 +2,9 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
  *
+ *  Author: Marek Skowron <marek.skowron@tieto.com> for ST-Ericsson.
  *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson.
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -19,30 +21,1494 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include "bluetooth.h"
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
+
+#include "adapter.h"
+#include "btio.h"
+#include "sdpd.h"
 #include "log.h"
+#include "error.h"
+#include "dbus-common.h"
 
+#include "sap.h"
 #include "server.h"
 
+#define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
+#define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
+#define SAP_SERVER_CHANNEL	8
+#define SAP_BUF_SIZE		512
+
+#define PADDING4(x) (4 - (x & 0x03))
+#define PARAMETER_SIZE(x) (sizeof(sap_parameter) + x + PADDING4(x))
+
+#define SAP_NO_REQ 0xFF
+
+#define SAP_TIMER_GRACEFUL_DISCONNECT 30
+#define SAP_TIMER_NO_ACTIVITY 30
+
+typedef enum {
+	SAP_STATE_DISCONNECTED,
+	SAP_STATE_CONNECT_IN_PROGRESS,
+	SAP_STATE_CONNECTED,
+	SAP_STATE_GRACEFUL_DISCONNECT,
+	SAP_STATE_IMMEDIATE_DISCONNECT,
+	SAP_STATE_CLIENT_DISCONNECT
+} sap_state_t;
+
+struct sap_server {
+	bdaddr_t src;
+	char *path;
+	gboolean enable;
+	uint32_t record_id;
+	GIOChannel *listen_io;
+	GIOChannel *io;  /* Connected client channel.*/
+	sap_state_t state;
+	uint8_t processing_req;
+	guint timer_id;
+};
+
+static DBusConnection *connection = NULL;
+
+static void connect_req(void *data, sap_parameter *param);
+static int disconnect_req(void *data, sap_disconnection_type_t disc_type);
+static void transfer_apdu_req(void *data, sap_parameter *param);
+static void transfer_atr_req(void *data);
+static void power_sim_off_req(void *data);
+static void power_sim_on_req(void *data);
+static void reset_sim_req(void *data);
+static void transfer_card_reader_status_req(void *data);
+static void set_transport_protocol_req(void *data, sap_parameter *param);
+static int disconnect_ind(void *sap_device, sap_disconnection_type_t type);
+
+static gsize add_result_parameter(sap_result_t result, sap_parameter *param);
+
+static int is_power_sim_off_req_allowed(uint8_t processing_req);
+static int is_reset_sim_req_allowed(uint8_t processing_req);
+
+static int check_msg(sap_message *msg);
+
+static void start_guard_timer(struct sap_server *server, guint interval);
+static void stop_guard_timer(struct sap_server *server);
+static gboolean guard_timeout(gpointer data);
+
+static gsize add_result_parameter(sap_result_t result, sap_parameter *param)
+{
+	param->id = SAP_PARAM_ID_RESULT_CODE;
+	param->len = htons(SAP_PARAM_ID_RESULT_CODE_LEN);
+	*param->val = (uint8_t) result;
+	return PARAMETER_SIZE(SAP_PARAM_ID_RESULT_CODE_LEN);
+}
+
+
+static inline int is_power_sim_off_req_allowed(uint8_t processing_req)
+{
+	switch(processing_req) {
+	case SAP_NO_REQ:
+	case SAP_TRANSFER_APDU_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_POWER_SIM_ON_REQ:
+	case SAP_RESET_SIM_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static inline int is_reset_sim_req_allowed(uint8_t processing_req)
+{
+	switch(processing_req) {
+	case SAP_NO_REQ:
+	case SAP_TRANSFER_APDU_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int check_msg(sap_message *msg)
+{
+	if(!msg)
+		return -EFAULT;
+
+	switch(msg->id) {
+	case SAP_CONNECT_REQ:
+		if (msg->nparam == 0x01 &&
+				msg->param->id == SAP_PARAM_ID_MAX_MSG_SIZE &&
+				ntohs(msg->param->len) == SAP_PARAM_ID_MAX_MSG_SIZE_LEN)
+			return 0;
+		break;
+	case SAP_TRANSFER_APDU_REQ:
+		if (msg->nparam == 0x01 &&
+				(msg->param->id == SAP_PARAM_ID_COMMAND_APDU ||
+				msg->param->id == SAP_PARAM_ID_COMMAND_APDU7816) &&
+				msg->param->len != 0x00)
+			return 0;
+		break;
+	case SAP_SET_TRANSPORT_PROTOCOL_REQ:
+		if (msg->nparam == 0x01 &&
+				msg->param->id == SAP_PARAM_ID_TRANSPORT_PROTOCOL &&
+				ntohs(msg->param->len) == SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN &&
+				(*msg->param->val  == SAP_TRANSPORT_PROTOCOL_T0 ||
+				*msg->param->val == SAP_TRANSPORT_PROTOCOL_T1))
+			return 0;
+		break;
+	case SAP_DISCONNECT_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_POWER_SIM_OFF_REQ:
+	case SAP_POWER_SIM_ON_REQ:
+	case SAP_RESET_SIM_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		if (msg->nparam == 0x00)
+			return 0;
+		break;
+	}
+
+	error("Invalid message");
+	return -EBADMSG;
+}
+
+
+static void start_guard_timer(struct sap_server *server, guint interval)
+{
+	if(!server)
+		return;
+
+	if (!server->timer_id)
+		server->timer_id = g_timeout_add_seconds(interval,
+							guard_timeout, server);
+	else
+		error("Timer is already active.");
+}
+
+static void stop_guard_timer(struct sap_server *server)
+{
+	if (server && server->timer_id) {
+		g_source_remove(server->timer_id);
+		server->timer_id = 0;
+	}
+}
+
+static gboolean guard_timeout(gpointer data)
+{
+	struct sap_server *server = data;
+
+	if (!server)
+		return FALSE;
+
+	DBG("guard_timeout: state: %x pr %x", server->state,
+					server->processing_req);
+
+	server->timer_id = 0;
+
+	switch(server->state) {
+	case SAP_STATE_DISCONNECTED:
+		/* Client opened RFCOMM channel but didn't send CONNECT_REQ,
+		 * in fixed time or client disconnected SAP connection but
+		 * didn't closed RFCOMM channel in fixed time.*/
+		if (server->io)
+			g_io_channel_shutdown(server->io, TRUE, NULL);
+		break;
+	case SAP_STATE_GRACEFUL_DISCONNECT:
+		/* Client didn't disconnect SAP connection in fixed time,
+		 * so close SAP connection immediately. */
+		disconnect_req(server, SAP_DISCONNECTION_TYPE_IMMEDIATE);
+		break;
+	default:
+		error("guard_timeout: Unexpected state.");
+		break;
+	}
+
+	return FALSE;
+}
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
+static int send_message(struct sap_server *server, gchar *buf, gssize size)
+{
+	gsize written = 0;
+	GError *gerr = NULL;
+	GIOStatus gstatus;
+
+	if(!server || !buf)
+		return -1;
+
+	DBG("send_message: size=%x",(unsigned int)size);
+
+	gstatus = g_io_channel_write_chars(server->io, buf, size, &written, &gerr);
+
+	if (gstatus != G_IO_STATUS_NORMAL) {
+		if (gerr)
+			g_error_free(gerr);
+
+		error("send_message:write error (%d)", gstatus);
+		return -1;
+	}
+	if(written != (gsize)size) {
+		error("send_message:write error. written %d size %d", written, size);
+	}
+	DBG("send_message: written=%x",(unsigned int)written);
+	return 0;
+}
+
+static void connect_req(void *data, sap_parameter *param)
+{
+	struct sap_server *server = data;
+	uint16_t maxmsgsize, *val;
+
+	if(!server || !param)
+		goto error_rsp;
+
+	if (server->state != SAP_STATE_DISCONNECTED)
+		goto error_rsp;
+
+	stop_guard_timer(server);
+
+	val = (uint16_t *) &param->val;
+	maxmsgsize = ntohs(*val);
+
+	DBG("Connect MaxMsgSize: 0x%04X(%d)", maxmsgsize, maxmsgsize);
+
+	server->state = SAP_STATE_CONNECT_IN_PROGRESS;
+
+	if (maxmsgsize <= SAP_BUF_SIZE){
+		server->processing_req = SAP_CONNECT_REQ;
+		sap_connect_req(server, maxmsgsize);
+	}else{
+		sap_connect_rsp(server, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
+								SAP_BUF_SIZE);
+	}
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(data);
+}
+
+static int disconnect_req(void *data, sap_disconnection_type_t disc_type)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("disconnect_req: type 0x%x state %d", disc_type, server->state);
+
+	switch(disc_type) {
+	case SAP_DISCONNECTION_TYPE_GRACEFUL:
+
+		if (server->state == SAP_STATE_DISCONNECTED ||
+				server->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			goto error_req;
+
+		if (server->state == SAP_STATE_CONNECTED) {
+			server->state = SAP_STATE_GRACEFUL_DISCONNECT;
+			server->processing_req = SAP_NO_REQ;
+			disconnect_ind(server, disc_type);
+
+			/* Start guard timer - timer will disconnect connection
+			 * if client doesn't do it. */
+			start_guard_timer(server, SAP_TIMER_GRACEFUL_DISCONNECT);
+
+			return 0;
+		}
+		/* Disconnection is ongoing - do nothing. */
+		return 0;
+
+	case SAP_DISCONNECTION_TYPE_IMMEDIATE:
+
+		if (server->state == SAP_STATE_DISCONNECTED ||
+				server->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			goto error_req;
+
+		if (server->state == SAP_STATE_CONNECTED ||
+				server->state == SAP_STATE_GRACEFUL_DISCONNECT) {
+			server->state = SAP_STATE_IMMEDIATE_DISCONNECT;
+			server->processing_req = SAP_NO_REQ;
+
+			stop_guard_timer(server);
+
+			disconnect_ind(server, disc_type);
+			sap_disconnect_req(server, 0);
+
+			return 0;
+		}
+		/* Disconnection is ongoing - do nothing. */
+		return 0;
+
+	case SAP_DISCONNECTION_TYPE_CLIENT:
+
+		if (server->state != SAP_STATE_CONNECTED &&
+				server->state != SAP_STATE_GRACEFUL_DISCONNECT)
+			goto error_rsp;
+
+		server->state = SAP_STATE_CLIENT_DISCONNECT;
+		server->processing_req = SAP_NO_REQ;
+
+		stop_guard_timer(server);
+
+		sap_disconnect_req(server, 0);
+
+		return 0;
+
+	default:
+		error("Unknown disconnection type (type %x).", disc_type);
+		return -EINVAL;
+	}
+
+error_rsp:
+	sap_error_rsp(server);
+error_req:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	return -EPERM;
+}
+
+static void transfer_apdu_req(void * data, sap_parameter * param)
+{
+	struct sap_server *server = data;
+
+	if(!server || !param)
+		goto error_rsp;
+
+	param->len = ntohs(param->len);
+
+	DBG("transfer_apdu_req: data %p state %d", data, server->state);
+	DBG("transfer_apdu_req: apdu param id %d  val %s len %d ",
+					param->id, param->val, param->len);
+
+	if (server->state != SAP_STATE_CONNECTED &&
+			server->state != SAP_STATE_GRACEFUL_DISCONNECT)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_TRANSFER_APDU_REQ;
+	sap_transfer_apdu_req(server, param);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+
+static void transfer_atr_req(void * data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("transfer_atr_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_TRANSFER_ATR_REQ;
+	sap_transfer_atr_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+
+static void power_sim_off_req(void *data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("power_sim_off_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (!is_power_sim_off_req_allowed(server->processing_req))
+		goto error_rsp;
+
+	server->processing_req = SAP_POWER_SIM_OFF_REQ;
+	sap_power_sim_off_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void power_sim_on_req(void *data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("power_sim_on_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_POWER_SIM_ON_REQ;
+	sap_power_sim_on_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void reset_sim_req(void *data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("reset_sim_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (!is_reset_sim_req_allowed(server->processing_req))
+		goto error_rsp;
+
+	server->processing_req = SAP_RESET_SIM_REQ;
+	sap_reset_sim_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void transfer_card_reader_status_req(void * data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("transfer_card_reader_status_req: data %p state %d",
+							data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_TRANSFER_CARD_READER_STATUS_REQ;
+	sap_transfer_card_reader_status_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void set_transport_protocol_req(void *data, sap_parameter *param)
+{
+	struct sap_server *server = data;
+
+	if(!server || !param)
+		goto error_rsp;
+
+	DBG("set_transport_protocol_req: data %p state %d param %p",
+						data, server->state, param);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_SET_TRANSPORT_PROTOCOL_REQ;
+	sap_set_transport_protocol_req(server, param);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static int disconnect_ind(void *sap_device, sap_disconnection_type_t type)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE];
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("disconnect_ind: data %p state %d disc_type %d",
+						server, server->state, type);
+
+	if (server->state != SAP_STATE_GRACEFUL_DISCONNECT &&
+			server->state != SAP_STATE_IMMEDIATE_DISCONNECT)
+		goto error_ind;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_DISCONNECT_IND;
+	msg->nparam = 0x01;
+
+	/* Add disconnection type. */
+	param->id  = SAP_PARAM_ID_DISCONNECT_IND;
+	param->len = htons(SAP_PARAM_ID_DISCONNECT_IND_LEN);
+	*param->val = (uint8_t) type;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_DISCONNECT_IND_LEN);
+
+	return send_message(sap_device, buf, size);
+
+error_ind:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	return -EPERM;
+}
+
+int sap_connect_rsp(void *sap_device, sap_status_t status, uint16_t maxmsgsize)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE];
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_connect_rsp: state %x pr %x status %x", server->state,
+					server->processing_req, status);
+
+	if (server->state != SAP_STATE_CONNECT_IN_PROGRESS) {
+		return -EPERM;
+	}
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_CONNECT_RESP;
+	msg->nparam = 0x01;
+
+	/* Add connection status */
+	param->id = SAP_PARAM_ID_CONN_STATUS;
+	param->len = htons(SAP_PARAM_ID_CONN_STATUS_LEN);
+	*param->val = (uint8_t)status;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_CONN_STATUS_LEN);
+
+	/* Add MaxMsgSize */
+	if (maxmsgsize && (status == SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED ||
+			status == SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL)) {
+		uint16_t *len;
+		msg->nparam++;
+		/* Skip the first param */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_MAX_MSG_SIZE;
+		param->len = htons(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
+		len = (uint16_t *) &param->val;
+		*len = htons(maxmsgsize);
+		size += PARAMETER_SIZE(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
+	}
+
+	if (status == SAP_STATUS_OK) {
+		gboolean connected = TRUE;
+		emit_property_changed(connection, server->path, SAP_SERVER_INTERFACE,
+			"Connected", DBUS_TYPE_BOOLEAN, &connected);
+
+		server->state = SAP_STATE_CONNECTED;
+	} else {
+		server->state = SAP_STATE_DISCONNECTED;
+
+		/* Timer will shutdown channel if client doesn't send
+		 * CONNECT_REQ or doesn't shutdown channel itself.*/
+		start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_disconnect_rsp(void *sap_device)
+{
+	struct sap_server *server = sap_device;
+	sap_message msg = {0};
+
+	if(!server)
+		return -1;
+
+	DBG("sap_disconnect_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	switch(server->state) {
+	case SAP_STATE_CLIENT_DISCONNECT:
+		msg.id = SAP_DISCONNECT_RESP;
+
+		server->state = SAP_STATE_DISCONNECTED;
+		server->processing_req = SAP_NO_REQ;
+
+		/* Timer will close channel if client doesn't do it.*/
+		start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
+
+		return send_message(sap_device, (gchar *) &msg, sizeof(msg));
+
+	case SAP_STATE_IMMEDIATE_DISCONNECT:
+		server->state = SAP_STATE_DISCONNECTED;
+		server->processing_req = SAP_NO_REQ;
+
+		if (server->io)
+			g_io_channel_shutdown(server->io, TRUE, NULL);
+		return 0;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int sap_transfer_apdu_rsp(void *sap_device, sap_result_t result, uint8_t *apdu,
+								uint16_t length)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transfer_apdu_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_TRANSFER_APDU_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	if (result == SAP_RESULT_OK && (!apdu || (apdu && length == 0x00)))
+		return -EINVAL;
+
+	msg->id = SAP_TRANSFER_APDU_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add APDU response. */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		/* Skipping the first param. */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_RESPONSE_APDU;
+		param->len = htons(length);
+
+		size += PARAMETER_SIZE(length);
+		if (size > SAP_BUF_SIZE)
+			return -EOVERFLOW;
+
+		memcpy(param->val, apdu, length);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_transfer_atr_rsp(void *sap_device, sap_result_t result, uint8_t *atr,
+								uint16_t length)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE]= {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transfer_atr_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_TRANSFER_ATR_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	if (result == SAP_RESULT_OK && (!atr || (atr && length == 0x00)))
+		return -EINVAL;
+
+	msg->id = SAP_TRANSFER_ATR_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add ATR response */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		/* Skip the first param */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_ATR;
+		param->len = htons(length);
+
+		size += PARAMETER_SIZE(length);
+		if (size > SAP_BUF_SIZE)
+			return -EOVERFLOW;
+
+		memcpy(param->val, atr, length);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_power_sim_off_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_power_sim_off_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_POWER_SIM_OFF_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_POWER_SIM_OFF_RESP;
+
+	/* Add result code.*/
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_power_sim_on_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_power_sim_on_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_POWER_SIM_ON_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_POWER_SIM_ON_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_reset_sim_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_reset_sim_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_RESET_SIM_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_RESET_SIM_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_transfer_card_reader_status_rsp(void *sap_device, sap_result_t result,
+						icc_reader_status_t status)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transfer_card_reader_status_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_TRANSFER_CARD_READER_STATUS_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_TRANSFER_CARD_READER_STATUS_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add card reader status. */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		/* Skipp the first param. */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_CARD_READER_STATUS;
+		param->len = htons(SAP_PARAM_ID_CARD_READER_STATUS_LEN);
+		*param->val = (uint8_t) status;
+		size += PARAMETER_SIZE(SAP_PARAM_ID_CARD_READER_STATUS_LEN);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_transport_protocol_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transport_protocol_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_SET_TRANSPORT_PROTOCOL_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_SET_TRANSPORT_PROTOCOL_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_error_rsp(void *sap_device)
+{
+	sap_message msg;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.id = SAP_ERROR_RESP;
+
+	return send_message(sap_device, (gchar *) &msg, sizeof(msg));
+}
+
+int sap_status_ind(void *sap_device, sap_status_change_t status_change)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_status_ind: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->state != SAP_STATE_CONNECTED &&
+			server->state != SAP_STATE_GRACEFUL_DISCONNECT)
+		/*Don't propagate status indication if client is not connected */
+		return 0;
+
+	msg->id = SAP_STATUS_IND;
+	msg->nparam = 0x01;
+
+	/* Add status change. */
+	param->id  = SAP_PARAM_ID_STATUS_CHANGE;
+	param->len = htons(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+	*param->val = (uint8_t) status_change;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+
+	return send_message(sap_device, buf, size);
+}
+
+static int handle_cmd(void *data, gchar *buf, gsize size)
+{
+	sap_message *msg = (sap_message *) buf;
+
+	if (size < sizeof(sap_message))
+		goto error_rsp;
+
+	if (msg->nparam != 0 &&
+			size < (sizeof(sap_message) + sizeof(sap_parameter) + 4))
+		goto error_rsp;
+
+	if (check_msg(msg) < 0)
+		goto error_rsp;
+
+	switch(msg->id) {
+		case SAP_CONNECT_REQ:
+			DBG("SAP Connect.");
+			connect_req(data, msg->param);
+			return 0;
+		case SAP_DISCONNECT_REQ:
+			DBG("SAP Disconnect.");
+			disconnect_req(data, SAP_DISCONNECTION_TYPE_CLIENT);
+			return 0;
+		case SAP_TRANSFER_APDU_REQ:
+			DBG("SAP Transfer APDU.");
+			transfer_apdu_req(data, msg->param);
+			return 0;
+		case SAP_TRANSFER_ATR_REQ:
+			DBG("SAP Transfer ATR.");
+			transfer_atr_req(data);
+			return 0;
+		case SAP_POWER_SIM_OFF_REQ:
+			DBG("SAP SIM off.");
+			power_sim_off_req(data);
+			return 0;
+		case SAP_POWER_SIM_ON_REQ:
+			DBG("SAP SIM on.");
+			power_sim_on_req(data);
+			return 0;
+		case SAP_RESET_SIM_REQ:
+			DBG("SAP SIM reset.");
+			reset_sim_req(data);
+			return 0;
+		case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+			DBG("SAP reader status.");
+			transfer_card_reader_status_req(data);
+			return 0;
+		case SAP_SET_TRANSPORT_PROTOCOL_REQ:
+			DBG("SAP set proto request.");
+			set_transport_protocol_req(data, msg->param);
+			return 0;
+		default:
+			DBG("SAP unknown message.");
+			break;
+	}
+
+error_rsp:
+	DBG("SAP ERROR RSP");
+	sap_error_rsp(data);
+	return -EBADMSG;
+}
+
+static gboolean sap_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
+{
+	gchar buf[SAP_BUF_SIZE];
+	gsize bytes_read = 0;
+	GError *gerr = NULL;
+	GIOStatus gstatus;
+
+	if (cond & G_IO_NVAL){
+		DBG("ERR (G_IO_NVAL) on rfcomm socket.");
+		return FALSE;
+	}
+
+	if (cond & G_IO_ERR) {
+		DBG("ERR (G_IO_ERR) on rfcomm socket.");
+		return FALSE;
+	}
+
+	if (cond & G_IO_HUP ) {
+		DBG("HUP on rfcomm socket.");
+		return FALSE;
+	}
+
+	gstatus = g_io_channel_read_chars(chan, buf, sizeof(buf) - 1,
+				&bytes_read, &gerr);
+
+	if (gstatus != G_IO_STATUS_NORMAL) {
+		if(gerr)
+			g_error_free(gerr);
+		return TRUE;
+	}
+
+	if (handle_cmd(data, buf, bytes_read) < 0) {
+		error("Invalid SAP message.");
+	}
+
+	return TRUE;
+}
+
+static void sap_io_destroy(void *data)
+{
+	struct sap_server *server = data;
+
+	if (server && server->io) {
+		gboolean connected = FALSE;
+
+		stop_guard_timer(server);
+
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+
+		server->io = NULL;
+
+		if (server->state != SAP_STATE_CONNECT_IN_PROGRESS)
+			emit_property_changed(connection, server->path,
+				SAP_SERVER_INTERFACE,"Connected",
+				DBUS_TYPE_BOOLEAN, &connected);
+
+		if (server->state == SAP_STATE_CONNECT_IN_PROGRESS ||
+					server->state == SAP_STATE_CONNECTED ||
+					server->state == SAP_STATE_GRACEFUL_DISCONNECT){
+				sap_disconnect_req(NULL, 1);
+			}
+
+		server->state = SAP_STATE_DISCONNECTED;
+	}
+}
+
+static void sap_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		return;
+
+	/* Timer will shutdown the channel in case of lack of client activity */
+	start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
+
+	g_io_add_watch_full(chan, G_PRIORITY_DEFAULT,
+			G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
+			(GIOFunc) sap_io_cb, server, sap_io_destroy);
+}
+
+static void connect_auth_cb(DBusError *derr, void *data)
+{
+	struct sap_server *server = data;
+	GError *gerr = NULL;
+
+	if(!server || !server->io)
+		return;
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		goto drop;
+	}
+
+	if (!bt_io_accept(server->io, sap_connect_cb, server, NULL, &gerr)) {
+		error("bt_io_accept: %s", gerr->message);
+		g_error_free(gerr);
+		goto drop;
+	}
+	return;
+
+drop:
+	g_io_channel_shutdown(server->io, TRUE, NULL);
+	g_io_channel_unref(server->io);
+	server->io = NULL;
+}
+
+static void connect_confirm_cb(GIOChannel *chan, gpointer data)
+{
+	struct sap_server *server = data;
+	GError *gerr = NULL;
+	bdaddr_t src, dst;
+	int err;
+
+	if(!chan || !server)
+		return;
+
+	if (server->io)
+		goto drop;
+
+	bt_io_get(chan, BT_IO_RFCOMM, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		goto drop;
+	}
+
+	server->io = g_io_channel_ref(chan);
+
+	err = btd_request_authorization(&src, &dst, SAP_UUID, connect_auth_cb, server);
+
+	if (err < 0) {
+		DBG("Authorization denied: %s", strerror(err));
+		goto drop;
+	}
+
+	DBG("SAP incoming connection (sock %d) authorization.", g_io_channel_unix_get_fd(chan));
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+	if (server->io && server->io == chan) {
+		g_io_channel_unref(server->io);
+		server->io = NULL;
+	}
+}
+
+
+
+static inline DBusMessage *message_failed(DBusMessage *msg,
+					const char *description)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+				"%s", description);
+}
+
+static DBusMessage *enable(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	sdp_record_t *record = NULL;
+	GIOChannel *io = NULL;
+	GError *gerr = NULL;
+
+	if (!server)
+		return message_failed(msg, "Server internal error.");
+
+	if (server->enable)
+		return message_failed(msg, "Server already enabled.");
+
+	record = create_sap_record(SAP_SERVER_CHANNEL);
+	if (!record)
+		return message_failed(msg, "Can't create SDP record for SAP.");
+
+	if (add_record_to_server(&server->src, record) < 0) {
+		sdp_record_free(record);
+		return message_failed(msg, "SDP record registration failed.");
+	}
+
+	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, server, NULL, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &server->src,
+			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
+			BT_IO_OPT_MASTER, TRUE,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		g_error_free(gerr);
+		sdp_record_free(record);
+		return message_failed(msg, "Listen rfcomm channel failed.");
+	}
+
+	DBG("Listen socket %x", g_io_channel_unix_get_fd(io));
+
+	server->enable = TRUE;
+	server->record_id = record->handle;
+	server->listen_io = io;
+
+	emit_property_changed(connection, server->path, SAP_SERVER_INTERFACE,
+				"Enabled", DBUS_TYPE_BOOLEAN, &server->enable);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *disable(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	DBusMessage *reply = NULL;
+
+	if(!server)
+		return message_failed(msg, "Server internal error.");
+
+	if (!server->enable)
+		return message_failed(msg, "Server already disabled.");
+
+	if (server->state != SAP_STATE_DISCONNECTED)
+		return message_failed(msg, "Ongoing connection exists.");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	remove_record_from_server(server->record_id);
+
+	if (server->listen_io) {
+		g_io_channel_shutdown(server->listen_io, TRUE, NULL);
+		g_io_channel_unref(server->listen_io);
+		server->listen_io = NULL;
+	}
+
+	server->enable = FALSE;
+
+	emit_property_changed(connection, server->path, SAP_SERVER_INTERFACE,
+				"Enabled", DBUS_TYPE_BOOLEAN, &server->enable);
+
+	return reply;
+}
+
+static DBusMessage *get_properties(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t connected;
+
+	if(!server)
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
+	dict_append_entry(&dict, "Enabled", DBUS_TYPE_BOOLEAN, &server->enable);
+
+	connected = (server->state == SAP_STATE_CONNECTED ||
+			server->state == SAP_STATE_GRACEFUL_DISCONNECT);
+	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	dbus_bool_t disc_type;
+	sap_disconnection_type_t sap_disc_type;
+
+	if (!server)
+		return message_failed(msg, "Server internal error.");
+
+	if (!server->enable)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+				".Failed",
+				"Server already disabled");
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &disc_type,
+						DBUS_TYPE_INVALID) == FALSE)
+		return NULL;
+
+	sap_disc_type = disc_type ? SAP_DISCONNECTION_TYPE_GRACEFUL :
+				SAP_DISCONNECTION_TYPE_IMMEDIATE;
+	if (disconnect_req(server, sap_disc_type) < 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+				".Failed",
+				"There is no active connection");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable server_methods[] = {
+	{ "Enable","","", enable },
+	{ "Disable","","", disable },
+	{ "GetProperties","","a{sv}",get_properties },
+	{ "Disconnect","b","", disconnect },
+	{ }
+};
+
+static GDBusSignalTable server_signals[] = {
+	{ "PropertyChanged",		"sv"},
+	{ }
+};
+
+static void server_free(struct sap_server *server)
+{
+	DBG("[%s::%s]", __FILE__, __FUNCTION__);
+
+	if (!server)
+		return;
+
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
+	struct sap_server *server;
+
+	if(sap_init() < 0) {
+		error("Sap driver initialization failed.");
+		return -1;
+	}
+
+	server = g_new0(struct sap_server, 1);
+
+	if (!server) {
+		sap_exit();
+		return -ENOMEM;
+	}
+
+	server->enable = FALSE;
+
+	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
+				server_methods, server_signals, NULL,
+				server, destroy_sap_interface)) {
+		error("D-Bus failed to register %s interface",
+						SAP_SERVER_INTERFACE);
+		server_free(server);
+		sap_exit();
+		return -1;
+	}
+
+	server->path = g_strdup(path);
+	bacpy(&server->src, src);
+
 	return 0;
 }
 
 int sap_server_unregister(const char *path)
 {
-	DBG("Unregister SAP server.");
+	g_dbus_unregister_interface(connection, path, SAP_SERVER_INTERFACE);
+	sap_exit();
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
1.7.0.4
