Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] android/avrcp: Add avrcp_get_capabilities request
Date: Wed, 26 Feb 2014 16:32:14 +0200
Message-Id: <1393425134-12702-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implement avrcp_get_capabilities() request through
avrcp_send_vendordep_req(). avctp_send_req() is not exported so we use
the functions which are exported by AVCTP code.
---
 android/avrcp-lib.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  2 ++
 android/avrcp.c     |  1 +
 3 files changed, 51 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 2e5a565..cf4cdaa 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -50,6 +50,18 @@
 #define AVRCP_STATUS_NO_AVAILABLE_PLAYERS	0x15
 #define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED	0x16
 
+/* Packet types */
+#define AVRCP_PACKET_TYPE_SINGLE		0x00
+#define AVRCP_PACKET_TYPE_START			0x01
+#define AVRCP_PACKET_TYPE_CONTINUING		0x02
+#define AVRCP_PACKET_TYPE_END			0x03
+
+/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
+#define CAP_COMPANY_ID				0x02
+#define CAP_EVENTS_SUPPORTED			0x03
+
+#define AVRCP_GET_CAPABILITIES_PARAM_LENGTH	1
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avrcp_header {
@@ -92,6 +104,13 @@ static inline uint32_t ntoh24(const uint8_t src[3])
 #error "Unknown byte order"
 #endif
 
+static inline void hton24(uint8_t dst[3], uint32_t src)
+{
+	dst[0] = (src >> 16) & 0xff;
+	dst[1] = (src >> 8) & 0xff;
+	dst[2] = src & 0xff;
+}
+
 struct avrcp {
 	struct avctp *conn;
 
@@ -255,3 +274,32 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
 {
 	return avctp_init_uinput(session->conn, name, address);
 }
+
+static int avrcp_send_vendordep_req(struct avrcp *session, uint8_t code,
+					uint8_t subunit, uint8_t *operands,
+					size_t operand_count,
+					avctp_rsp_cb func, void *user_data)
+{
+	return avctp_send_vendordep_req(session->conn, code, subunit, operands,
+						operand_count, func, user_data);
+}
+
+void avrcp_get_capabilities(struct avrcp *session, avctp_rsp_cb func)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_GET_CAPABILITIES_PARAM_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+	uint8_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	hton24(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_CAPABILITIES;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params[0] = CAP_EVENTS_SUPPORTED;
+	pdu->params_len = htons(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avrcp_send_vendordep_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+						buf, length, func, session);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2337429..4f3a632 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -74,3 +74,5 @@ void avrcp_set_passthrough_handlers(struct avrcp *session,
 			void *user_data);
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
+
+void avrcp_get_capabilities(struct avrcp *session, avctp_rsp_cb func);
diff --git a/android/avrcp.c b/android/avrcp.c
index 48444a4..3d39d91 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -36,6 +36,7 @@
 #include "bluetooth.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "avctp.h"
 #include "avrcp-lib.h"
 #include "avrcp.h"
 
-- 
1.8.3.2

