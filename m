Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 1/4] tools/btmgmt: Observe Advertising Added/Removed
Date: Tue, 24 Mar 2015 11:35:08 -0700
Message-Id: <1427222111-15481-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btmgmt now observes Advertising Added/Removed events.
---
 tools/btmgmt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0f7fdc7..ea4eba7 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1068,6 +1068,32 @@ static void local_oob_data_updated(uint16_t index, uint16_t len,
 						ev->type, eir_len);
 }
 
+static void advertising_added(uint16_t index, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_advertising_added *ev = param;
+
+	if (len < sizeof(*ev)) {
+		error("Too small (%u bytes) advertising_added event", len);
+		return;
+	}
+
+	print("hci%u advertising_added: instance %u", index, ev->instance);
+}
+
+static void advertising_removed(uint16_t index, uint16_t len,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_advertising_removed *ev = param;
+
+	if (len < sizeof(*ev)) {
+		error("Too small (%u bytes) advertising_removed event", len);
+		return;
+	}
+
+	print("hci%u advertising_removed: instance %u", index, ev->instance);
+}
+
 static void version_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -3757,6 +3783,10 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 					ext_index_removed, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_LOCAL_OOB_DATA_UPDATED, index,
 					local_oob_data_updated, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADVERTISING_ADDED, index,
+						advertising_added, NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_ADVERTISING_REMOVED, index,
+					advertising_removed, NULL, NULL);
 }
 
 static void cmd_select(struct mgmt *mgmt, uint16_t index,
-- 
2.2.0.rc0.207.ga3a616c

