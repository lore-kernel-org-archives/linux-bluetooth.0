Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android: Always set adapter to pairable on init
Date: Fri, 25 Oct 2013 17:15:02 +0200
Message-ID: <1382714103-27689-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
References: <1382714103-27689-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no operation to enable/disable pairable mode in Android HAL.
---
 android/adapter.c | 72 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index a6c5704..eebe45e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -224,6 +224,41 @@ static void load_link_keys(GSList *keys)
 	g_free(cp);
 }
 
+static void set_mode_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		error("Failed to set mode: %s (0x%02x)",
+						mgmt_errstr(status), status);
+		return;
+	}
+
+	/*
+	 * The parameters are identical and also the task that is
+	 * required in both cases. So it is safe to just call the
+	 * event handling functions here.
+	 */
+	new_settings_callback(adapter->index, length, param, NULL);
+}
+
+static bool set_mode(uint16_t opcode, uint8_t mode)
+{
+	struct mgmt_mode cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.val = mode;
+
+	DBG("opcode=0x%x mode=0x%x", opcode, mode);
+
+	if (mgmt_send(adapter->mgmt, opcode, adapter->index, sizeof(cp), &cp,
+					set_mode_complete, NULL, NULL) > 0)
+		return true;
+
+	error("Failed to set mode");
+
+	return false;
+}
+
 static void read_info_complete(uint8_t status, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -265,6 +300,8 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 
 	load_link_keys(NULL);
 
+	set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
+
 	return;
 
 failed:
@@ -287,41 +324,6 @@ void bt_adapter_init(uint16_t index, struct mgmt *mgmt, bt_adapter_ready cb)
 	adapter->ready(-EIO);
 }
 
-static void set_mode_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	if (status != MGMT_STATUS_SUCCESS) {
-		error("Failed to set mode: %s (0x%02x)",
-						mgmt_errstr(status), status);
-		return;
-	}
-
-	/*
-	 * The parameters are identical and also the task that is
-	 * required in both cases. So it is safe to just call the
-	 * event handling functions here.
-	 */
-	new_settings_callback(adapter->index, length, param, NULL);
-}
-
-static bool set_mode(uint16_t opcode, uint8_t mode)
-{
-	struct mgmt_mode cp;
-
-	memset(&cp, 0, sizeof(cp));
-	cp.val = mode;
-
-	DBG("opcode=0x%x mode=0x%x", opcode, mode);
-
-	if (mgmt_send(adapter->mgmt, opcode, adapter->index, sizeof(cp), &cp,
-					set_mode_complete, NULL, NULL) > 0)
-		return true;
-
-	error("Failed to set mode");
-
-	return false;
-}
-
 static bool set_discoverable(uint8_t mode, uint16_t timeout)
 {
 	struct mgmt_cp_set_discoverable cp;
-- 
1.8.4.1

