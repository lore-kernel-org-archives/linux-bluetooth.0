Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/avrcp: Add control handlers to avrcp-lib
Date: Wed, 26 Feb 2014 17:14:28 +0200
Message-Id: <1393427669-15337-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393427669-15337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393427669-15337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 23 +++--------------------
 android/avrcp-lib.h | 33 +++++++++++++++++++++++++++++++++
 unit/test-avrcp.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index cf4cdaa..5e5ba31 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -35,31 +35,12 @@
 #include "avctp.h"
 #include "avrcp-lib.h"
 
-/* Company IDs for vendor dependent commands */
-#define IEEEID_BTSIG		0x001958
-
-/* Status codes */
-#define AVRCP_STATUS_INVALID_COMMAND		0x00
-#define AVRCP_STATUS_INVALID_PARAM		0x01
-#define AVRCP_STATUS_PARAM_NOT_FOUND		0x02
-#define AVRCP_STATUS_INTERNAL_ERROR		0x03
-#define AVRCP_STATUS_SUCCESS			0x04
-#define AVRCP_STATUS_OUT_OF_BOUNDS		0x0b
-#define AVRCP_STATUS_INVALID_PLAYER_ID		0x11
-#define AVRCP_STATUS_PLAYER_NOT_BROWSABLE	0x12
-#define AVRCP_STATUS_NO_AVAILABLE_PLAYERS	0x15
-#define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED	0x16
-
 /* Packet types */
 #define AVRCP_PACKET_TYPE_SINGLE		0x00
 #define AVRCP_PACKET_TYPE_START			0x01
 #define AVRCP_PACKET_TYPE_CONTINUING		0x02
 #define AVRCP_PACKET_TYPE_END			0x03
 
-/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
-#define CAP_COMPANY_ID				0x02
-#define CAP_EVENTS_SUPPORTED			0x03
-
 #define AVRCP_GET_CAPABILITIES_PARAM_LENGTH	1
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -104,7 +85,7 @@ static inline uint32_t ntoh24(const uint8_t src[3])
 #error "Unknown byte order"
 #endif
 
-static inline void hton24(uint8_t dst[3], uint32_t src)
+void hton24(uint8_t dst[3], uint32_t src)
 {
 	dst[0] = (src >> 16) & 0xff;
 	dst[1] = (src >> 8) & 0xff;
@@ -121,6 +102,8 @@ struct avrcp {
 	const struct avrcp_passthrough_handler *passthrough_handlers;
 	void *passthrough_data;
 	unsigned int passthrough_id;
+
+	uint16_t supported_events;
 };
 
 void avrcp_shutdown(struct avrcp *session)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 4f3a632..4115e09 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -46,6 +46,37 @@
 #define AVRCP_ADD_TO_NOW_PLAYING	0x90
 #define AVRCP_GENERAL_REJECT		0xA0
 
+/* Notification events */
+#define AVRCP_EVENT_STATUS_CHANGED		0x01
+#define AVRCP_EVENT_TRACK_CHANGED		0x02
+#define AVRCP_EVENT_TRACK_REACHED_END		0x03
+#define AVRCP_EVENT_TRACK_REACHED_START		0x04
+#define AVRCP_EVENT_SETTINGS_CHANGED		0x08
+#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED	0x0a
+#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
+#define AVRCP_EVENT_UIDS_CHANGED		0x0c
+#define AVRCP_EVENT_VOLUME_CHANGED		0x0d
+#define AVRCP_EVENT_LAST			AVRCP_EVENT_VOLUME_CHANGED
+
+/* Status codes */
+#define AVRCP_STATUS_INVALID_COMMAND		0x00
+#define AVRCP_STATUS_INVALID_PARAM		0x01
+#define AVRCP_STATUS_PARAM_NOT_FOUND		0x02
+#define AVRCP_STATUS_INTERNAL_ERROR		0x03
+#define AVRCP_STATUS_SUCCESS			0x04
+#define AVRCP_STATUS_OUT_OF_BOUNDS		0x0b
+#define AVRCP_STATUS_INVALID_PLAYER_ID		0x11
+#define AVRCP_STATUS_PLAYER_NOT_BROWSABLE	0x12
+#define AVRCP_STATUS_NO_AVAILABLE_PLAYERS	0x15
+#define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED	0x16
+
+/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
+#define CAP_COMPANY_ID				0x02
+#define CAP_EVENTS_SUPPORTED			0x03
+
+/* Company IDs for vendor dependent commands */
+#define IEEEID_BTSIG		0x001958
+
 struct avrcp;
 
 struct avrcp_control_handler {
@@ -62,6 +93,8 @@ struct avrcp_passthrough_handler {
 
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
 
+void hton24(uint8_t dst[3], uint32_t src);
+
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 4a92860..dc704fa 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -64,6 +64,11 @@ struct context {
 	const struct test_data *data;
 };
 
+/* Company IDs supported by this device */
+static uint32_t company_ids[] = {
+	IEEEID_BTSIG,
+};
+
 #define data(args...) ((const unsigned char[]) { args })
 
 #define raw_pdu(args...)					\
@@ -285,12 +290,53 @@ static const struct avrcp_passthrough_handler passthrough_handlers[] = {
 		{ },
 };
 
+static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
+				uint8_t transaction, uint16_t *params_len,
+				uint8_t *params, void *user_data)
+{
+	unsigned int i;
+
+	DBG("id %d params_len %d", params[0], *params_len);
+
+	if (*params_len != 1)
+		goto fail;
+
+	switch (params[0]) {
+	case CAP_COMPANY_ID:
+		for (i = 0; i < G_N_ELEMENTS(company_ids); i++)
+			hton24(&params[2 + i * 3], company_ids[i]);
+
+		*params_len = 2 + (3 * G_N_ELEMENTS(company_ids));
+		params[1] = G_N_ELEMENTS(company_ids);
+
+		return AVC_CTYPE_STABLE;
+	case CAP_EVENTS_SUPPORTED:
+		params[1] = 0;
+		*params_len = 2 + params[1];
+
+		return AVC_CTYPE_STABLE;
+	}
+
+fail:
+	*params_len = htons(1);
+	params[0] = AVRCP_STATUS_INVALID_PARAM;
+
+	return AVC_CTYPE_REJECTED;
+}
+
+static const struct avrcp_control_handler control_handlers[] = {
+		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
+					avrcp_handle_get_capabilities },
+		{ },
+};
+
 static void test_server(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
 
 	avrcp_set_passthrough_handlers(context->session, passthrough_handlers,
 								context);
+	avrcp_set_control_handlers(context->session, control_handlers, NULL);
 
 	g_idle_add(send_pdu, context);
 
-- 
1.8.3.2

