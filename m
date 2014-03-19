Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC] android/client: Add AVRCP register_notification_rsp support
Date: Wed, 19 Mar 2014 14:50:16 +0200
Message-Id: <1395233416-10951-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Input for this call doesn't require all parameters of structure
to be filled at the same time. Input data depepnds on event_id
and type. Implemented this api support based on
android/hal_avrcp.c:register_notification_rsp.
---
 android/client/if-rc.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index 31efc29..89f63dc 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -54,6 +54,20 @@ SINTMAP(btrc_status_t, -1, "(unknown)")
 	DELEMENT(BTRC_STS_NO_ERROR),
 ENDMAP
 
+SINTMAP(btrc_event_id_t, -1, "(unknown)")
+	DELEMENT(BTRC_EVT_PLAY_STATUS_CHANGED),
+	DELEMENT(BTRC_EVT_TRACK_CHANGE),
+	DELEMENT(BTRC_EVT_TRACK_REACHED_END),
+	DELEMENT(BTRC_EVT_TRACK_REACHED_START),
+	DELEMENT(BTRC_EVT_PLAY_POS_CHANGED),
+	DELEMENT(BTRC_EVT_APP_SETTINGS_CHANGED),
+ENDMAP
+
+SINTMAP(btrc_notification_type_t, -1, "(unknown)")
+	DELEMENT(BTRC_NOTIFICATION_TYPE_INTERIM),
+	DELEMENT(BTRC_NOTIFICATION_TYPE_CHANGED),
+ENDMAP
+
 static char last_addr[MAX_ADDR_STR_LEN];
 
 static void remote_features_cb(bt_bdaddr_t *bd_addr,
@@ -294,6 +308,74 @@ static void set_player_app_value_rsp_p(int argc, const char **argv)
 	EXEC(if_rc->set_player_app_value_rsp, rsp_status);
 }
 
+/* register_notification_rsp */
+
+static void register_notification_rsp_c(int argc, const char **argv,
+					enum_func *enum_func, void **user)
+{
+	if (argc == 3) {
+		*user = TYPE_ENUM(btrc_event_id_t);
+		*enum_func = enum_defines;
+	}
+
+	if (argc == 4) {
+		*user = TYPE_ENUM(btrc_notification_type_t);
+		*enum_func = enum_defines;
+	}
+}
+
+static void register_notification_rsp_p(int argc, const char **argv)
+{
+	btrc_event_id_t event_id;
+	btrc_notification_type_t type;
+	btrc_register_notification_t reg;
+	uint8_t len, i;
+
+	RETURN_IF_NULL(if_rc);
+
+	memset(&reg, 0, sizeof(reg));
+	event_id = str2btrc_event_id_t(argv[2]);
+	type = str2btrc_notification_type_t(argv[3]);
+
+	switch (event_id) {
+	case BTRC_EVT_PLAY_STATUS_CHANGED:
+		reg.play_status = str2btrc_play_status_t(argv[4]);
+		break;
+
+	case BTRC_EVT_TRACK_CHANGE:
+		len = strlen(argv[4]) / 2;
+		for (i = 0; i < len; i++)
+			sscanf((char *) &(argv[5])[i * 2], "%hhx",
+						&(reg.track + 1)[i]);
+		break;
+
+	case BTRC_EVT_TRACK_REACHED_END:
+	case BTRC_EVT_TRACK_REACHED_START:
+		break;
+
+	case BTRC_EVT_PLAY_POS_CHANGED:
+		reg.song_pos = (uint8_t) atoi(argv[4]);
+		break;
+
+	case BTRC_EVT_APP_SETTINGS_CHANGED:
+		reg.player_setting.num_attr = (uint8_t) atoi(argv[4]);
+
+		len = strlen(argv[5]) / 2;
+		for (i = 0; i < len; i++)
+			sscanf((char *) &(argv[5])[i * 2], "%hhx",
+				&(reg.player_setting.attr_ids + 1)[i]);
+
+		len = strlen(argv[9]) / 2;
+		for (i = 0; i < len; i++)
+			sscanf((char *) &(argv[6])[i * 2], "%hhx",
+				&(reg.player_setting.attr_values + 1)[i]);
+
+		break;
+	}
+
+	EXEC(if_rc->register_notification_rsp, event_id, type, &reg);
+}
+
 /* cleanup */
 
 static void cleanup_p(int argc, const char **argv)
@@ -311,6 +393,15 @@ static struct method methods[] = {
 	STD_METHODCH(get_element_attr_rsp, "<num_attr> <attrs_id> <value>"),
 	STD_METHODCH(set_player_app_value_rsp, "<rsp_status>"),
 	STD_METHODCH(set_volume, "<volume>"),
+	STD_METHODCH(register_notification_rsp,
+			"<event_id> <type> <respective_data...>\n"
+			"BTRC_EVT_PLAY_STATUS_CHANGED <type> <play_status>\n"
+			"BTRC_EVT_TRACK_CHANGE <type> <track>\n"
+			"BTRC_EVT_TRACK_REACHED_END <type>\n"
+			"BTRC_EVT_TRACK_REACHED_START <type>\n"
+			"BTRC_EVT_PLAY_POS_CHANGED <type> <song_pos>\n"
+			"BTRC_EVT_APP_SETTINGS_CHANGED <type> "
+				"<num_attr> <attr_ids> <attr_values>\n"),
 	STD_METHOD(cleanup),
 	END_METHOD
 };
-- 
1.8.3.2

