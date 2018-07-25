Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] adapter: Track pending settings
Date: Wed, 25 Jul 2018 13:20:34 +0300
Message-Id: <20180725102035.19439-3-luiz.dentz@gmail.com>
In-Reply-To: <20180725102035.19439-1-luiz.dentz@gmail.com>
References: <20180725102035.19439-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tracks settings being changed and in case the settings is already
pending considered it to be done.
---
 src/adapter.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index af340fd6e..20c20f9e9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -196,6 +196,7 @@ struct btd_adapter {
 	char *name;			/* controller device name */
 	char *short_name;		/* controller short name */
 	uint32_t supported_settings;	/* controller supported settings */
+	uint32_t pending_settings;	/* pending controller settings */
 	uint32_t current_settings;	/* current controller settings */
 
 	char *path;			/* adapter object path */
@@ -509,8 +510,10 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 	changed_mask = adapter->current_settings ^ settings;
 
 	adapter->current_settings = settings;
+	adapter->pending_settings &= ~changed_mask;
 
 	DBG("Changed settings: 0x%08x", changed_mask);
+	DBG("Pending settings: 0x%08x", adapter->pending_settings);
 
 	if (changed_mask & MGMT_SETTING_POWERED) {
 	        g_dbus_emit_property_changed(dbus_conn, adapter->path,
@@ -596,10 +599,31 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 							uint8_t mode)
 {
 	struct mgmt_mode cp;
+	uint32_t setting = 0;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.val = mode;
 
+	switch (mode) {
+	case MGMT_OP_SET_POWERED:
+		setting = MGMT_SETTING_POWERED;
+		break;
+	case MGMT_OP_SET_CONNECTABLE:
+		setting = MGMT_SETTING_CONNECTABLE;
+		break;
+	case MGMT_OP_SET_FAST_CONNECTABLE:
+		setting = MGMT_SETTING_FAST_CONNECTABLE;
+		break;
+	case MGMT_OP_SET_DISCOVERABLE:
+		setting = MGMT_SETTING_DISCOVERABLE;
+		break;
+	case MGMT_OP_SET_BONDABLE:
+		setting = MGMT_SETTING_DISCOVERABLE;
+		break;
+	}
+
+	adapter->pending_settings |= setting;
+
 	DBG("sending set mode command for index %u", adapter->dev_id);
 
 	if (mgmt_send(adapter->mgmt, opcode,
@@ -2739,13 +2763,15 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 	else
 		current_enable = FALSE;
 
-	if (enable == current_enable) {
+	if (enable == current_enable || adapter->pending_settings & setting) {
 		g_dbus_pending_property_success(id);
 		return;
 	}
 
 	mode = (enable == TRUE) ? 0x01 : 0x00;
 
+	adapter->pending_settings |= setting;
+
 	switch (setting) {
 	case MGMT_SETTING_POWERED:
 		opcode = MGMT_OP_SET_POWERED;
@@ -2798,7 +2824,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 	data->id = id;
 
 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
-				property_set_mode_complete, data, g_free) > 0)
+			property_set_mode_complete, data, g_free) > 0)
 		return;
 
 	g_free(data);
-- 
2.17.1

