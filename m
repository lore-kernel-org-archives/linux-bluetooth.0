Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] android/handsfree: Add support for new API for at_response
Date: Wed,  5 Nov 2014 16:38:52 +0200
Message-Id: <1415198333-7775-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

at_response has new parameter bdaddr in new Android API.
---
 android/hal-handsfree.c | 21 ++++++++++++++++++++-
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 294d1e9..99485d6 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -595,7 +595,8 @@ static bt_status_t formatted_at_response(const char *rsp)
 }
 #endif
 
-static bt_status_t at_response(bthf_at_response_t response, int error)
+static bt_status_t at_response_real(bthf_at_response_t response, int error,
+							bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_handsfree_at_response cmd;
 
@@ -604,6 +605,11 @@ static bt_status_t at_response(bthf_at_response_t response, int error)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	if (bd_addr)
+		memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	memset(&cmd, 0, sizeof(cmd));
+
 	cmd.response = response;
 	cmd.error = error;
 
@@ -612,6 +618,19 @@ static bt_status_t at_response(bthf_at_response_t response, int error)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t at_response(bthf_at_response_t response, int error,
+							bt_bdaddr_t *bd_addr)
+{
+	return at_response_real(response, error, bd_addr);
+}
+#else
+static bt_status_t at_response(bthf_at_response_t response, int error)
+{
+	return at_response_real(response, error, NULL);
+}
+#endif
+
 static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 					bthf_call_state_t state,
 					bthf_call_mode_t mode,
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 44cfe23..1352950 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -917,6 +917,7 @@ Commands and responses:
 
 		Command parameters: Response code (1 octet)
 		                    Error code (1 octet)
+		                    Remote address (6 octets)
 		Response parameters: <none>
 
 		Valid response codes: 0x00 = ERROR
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5c5ed22..4b3d8b8 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -568,6 +568,7 @@ struct hal_cmd_handsfree_formatted_at_response {
 struct hal_cmd_handsfree_at_response {
 	uint8_t response;
 	uint8_t error;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_HANDSFREE_CALL_DIRECTION_OUTGOING	0x00
diff --git a/android/handsfree.c b/android/handsfree.c
index 15753bb..c8dfc8f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2160,11 +2160,14 @@ static void handle_at_resp(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_at_response *cmd = buf;
 	struct hf_device *dev;
+	bdaddr_t bdaddr;
 	uint8_t status;
 
 	DBG("");
 
-	dev = find_default_device();
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	dev = find_device(&bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto done;
-- 
1.9.1

