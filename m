Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Subject: [PATCH BlueZ v3 5/5] tools/btpclient: Add set connectable command
Date: Thu, 28 Dec 2017 14:11:18 +0100
Message-Id: <1514466678-32582-5-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
In-Reply-To: <1514466678-32582-1-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
References: <1514466678-32582-1-git-send-email-kolodziejczyk.grzegorz.wroc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>

This patch adds set connectable command for btp client.
---
 tools/btpclient.c | 64 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 3914238..14b47a6 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -120,6 +120,7 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 	commands |= (1 << BTP_OP_GAP_READ_COTROLLER_INFO);
 	commands |= (1 << BTP_OP_GAP_RESET);
 	commands |= (1 << BTP_OP_GAP_SET_POWERED);
+	commands |= (1 << BTP_OP_GAP_SET_CONNECTABLE);
 	commands |= (1 << BTP_OP_GAP_SET_DISCOVERABLE);
 	commands |= (1 << BTP_OP_GAP_SET_BONDABLE);
 	commands |= (1 << BTP_OP_GAP_START_DISCOVERY);
@@ -335,6 +336,53 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+static void update_current_settings(struct btp_adapter *adapter,
+							uint32_t new_settings)
+{
+	struct btp_new_settings_ev ev;
+
+	adapter->current_settings = new_settings;
+
+	ev.current_settings = L_CPU_TO_LE32(adapter->current_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_NEW_SETTINGS, adapter->index,
+							sizeof(ev), &ev);
+}
+
+static void btp_gap_set_connectable(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_set_connectable_cp *cp = param;
+	uint8_t status = BTP_ERROR_FAIL;
+	uint32_t new_settings;
+
+	if (length < sizeof(*cp))
+		goto failed;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	new_settings = adapter->current_settings;
+
+	if (cp->connectable)
+		new_settings |= 1 << BTP_GAP_SETTING_CONNECTABLE;
+	else
+		new_settings &= ~(1 << BTP_GAP_SETTING_CONNECTABLE);
+
+	update_current_settings(adapter, new_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_CONNECTABLE, index,
+					sizeof(new_settings), &new_settings);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void btp_gap_set_discoverable(uint8_t index, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -672,6 +720,9 @@ static void register_gap_service(void)
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_POWERED,
 					btp_gap_set_powered, NULL, NULL);
 
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_CONNECTABLE,
+					btp_gap_set_connectable, NULL, NULL);
+
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_DISCOVERABLE,
 					btp_gap_set_discoverable, NULL, NULL);
 
@@ -979,19 +1030,6 @@ static void proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
 	}
 }
 
-static void update_current_settings(struct btp_adapter *adapter,
-							uint32_t new_settings)
-{
-	struct btp_new_settings_ev ev;
-
-	adapter->current_settings = new_settings;
-
-	ev.current_settings = L_CPU_TO_LE32(adapter->current_settings);
-
-	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_NEW_SETTINGS, adapter->index,
-							sizeof(ev), &ev);
-}
-
 static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 				struct l_dbus_message *msg, void *user_data)
 {
-- 
2.7.4

