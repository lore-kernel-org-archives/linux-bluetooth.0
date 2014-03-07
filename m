Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/avrcp: Add support to receive volume changed notifications
Date: Fri,  7 Mar 2014 14:15:41 +0200
Message-Id: <1394194543-3095-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
References: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This checks if remote stack supports volume changed notification and
in case it does register to receive notification when volume changes.
---
 android/avrcp.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index 1d211ad..978e6c0 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -700,6 +700,83 @@ static const struct avrcp_control_handler control_handlers[] = {
 		{ },
 };
 
+static gboolean register_notification_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_device *dev = user_data;
+	struct hal_ev_avrcp_volume_changed ev;
+	uint8_t *params;
+
+	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
+		return FALSE;
+
+	if (operands == NULL || operand_count < 7)
+		return FALSE;
+
+	params = &operands[7];
+
+	if (params == NULL || params[0] != AVRCP_EVENT_VOLUME_CHANGED)
+		return FALSE;
+
+	switch (code) {
+	case AVC_CTYPE_INTERIM:
+		ev.type = HAL_AVRCP_EVENT_TYPE_INTERIM;
+		break;
+	case AVC_CTYPE_CHANGED:
+		ev.type = HAL_AVRCP_EVENT_TYPE_CHANGED;
+		break;
+	default:
+		return FALSE;
+	}
+
+	ev.volume = params[1] & 0x7F;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+					HAL_EV_AVRCP_VOLUME_CHANGED,
+					sizeof(ev), &ev);
+
+	if (code == AVC_CTYPE_INTERIM)
+		return TRUE;
+
+	avrcp_register_notification(dev->session, params[0], 0,
+					register_notification_rsp, dev);
+	return FALSE;
+}
+
+static gboolean get_capabilities_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_device *dev = user_data;
+	uint8_t *params;
+	uint8_t count;
+
+	if (operands == NULL || operand_count < 7)
+		return FALSE;
+
+	params = &operands[7];
+
+	if (params == NULL || params[0] != CAP_EVENTS_SUPPORTED)
+		return FALSE;
+
+	for (count = params[1]; count > 0; count--) {
+		uint8_t event = params[1 + count];
+
+		if (event != AVRCP_EVENT_VOLUME_CHANGED)
+			continue;
+
+		avrcp_register_notification(dev->session, event, 0,
+						register_notification_rsp,
+						dev);
+		return FALSE;
+	}
+
+	return FALSE;
+}
+
 static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
 						uint16_t imtu, uint16_t omtu)
 {
@@ -732,6 +809,14 @@ static int avrcp_device_add_session(struct avrcp_device *dev, int fd,
 
 	ev.features |= HAL_AVRCP_FEATURE_METADATA;
 
+	if (dev->version < 0x0104)
+		goto done;
+
+	ev.features |= HAL_AVRCP_FEATURE_ABSOLUTE_VOLUME;
+
+	avrcp_get_capabilities(dev->session, CAP_EVENTS_SUPPORTED,
+						get_capabilities_rsp, dev);
+
 done:
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
 					HAL_EV_AVRCP_REMOTE_FEATURES,
-- 
1.8.5.3

