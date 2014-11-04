Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 13/47] android/gatt: Add support for new API
Date: Tue,  4 Nov 2014 10:18:36 +0200
Message-Id: <1415089150-18798-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In new Android API client_if parameter is removed.
---
 android/gatt.c     | 14 ++++++++------
 android/hal-gatt.c |  8 ++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b3dd6d3..5a531d9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1730,15 +1730,17 @@ static void handle_client_scan(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_scan *cmd = buf;
 	uint8_t status;
-	void *registered;
 
 	DBG("new state %d", cmd->start);
 
-	registered = find_app_by_id(cmd->client_if);
-	if (!registered) {
-		error("gatt: Client not registered");
-		status = HAL_STATUS_FAILED;
-		goto reply;
+	if (cmd->client_if != 0) {
+		void *registered = find_app_by_id(cmd->client_if);
+
+		if (!registered) {
+			error("gatt: Client not registered");
+			status = HAL_STATUS_FAILED;
+			goto reply;
+		}
 	}
 
 	/* Turn off scan */
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index c563fe9..d0e9184 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -595,14 +595,22 @@ static bt_status_t unregister_client(int client_if)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static bt_status_t scan(bool start)
+#else
 static bt_status_t scan(int client_if, bool start)
+#endif
 {
 	struct hal_cmd_gatt_client_scan cmd;
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	cmd.client_if = 0;
+#else
 	cmd.client_if = client_if;
+#endif
 	cmd.start = start;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SCAN,
-- 
1.9.1

