Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 13/14] android/hal-avrcp: Add .set_volume implementation
Date: Wed, 19 Feb 2014 18:58:57 +0200
Message-Id: <1392829138-10346-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index bf3e3dc..f982f48 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -453,6 +453,21 @@ static bt_status_t register_notification_rsp(btrc_event_id_t event_id,
 	}
 }
 
+static bt_status_t set_volume(uint8_t volume)
+{
+	struct hal_cmd_avrcp_set_volume cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.value = volume;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_VOLUME,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -484,6 +499,7 @@ static btrc_interface_t iface = {
 	.get_element_attr_rsp = get_element_attr_rsp,
 	.set_player_app_value_rsp = set_player_app_value_rsp,
 	.register_notification_rsp = register_notification_rsp,
+	.set_volume = set_volume,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

