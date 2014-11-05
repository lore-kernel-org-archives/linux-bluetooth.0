Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] android/handsfree: Add support for new API for cind_response
Date: Wed,  5 Nov 2014 16:38:50 +0200
Message-Id: <1415198333-7775-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415198333-7775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

cind_response has new parameter bdaddr in new Android API.
---
 android/hal-handsfree.c | 29 +++++++++++++++++++++++++++--
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 708d790..642d087 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -504,9 +504,10 @@ static bt_status_t cops_response(const char *cops)
 }
 #endif
 
-static bt_status_t cind_response(int svc, int num_active, int num_held,
+static bt_status_t cind_response_real(int svc, int num_active, int num_held,
 					bthf_call_state_t state, int signal,
-					int roam, int batt_chg)
+					int roam, int batt_chg,
+					bt_bdaddr_t *bd_addr)
 {
 	struct hal_cmd_handsfree_cind_response cmd;
 
@@ -515,6 +516,11 @@ static bt_status_t cind_response(int svc, int num_active, int num_held,
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	memset(&cmd, 0, sizeof(cmd));
+
+	if (bd_addr)
+		memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
 	cmd.svc = svc;
 	cmd.num_active = num_active;
 	cmd.num_held = num_held;
@@ -528,6 +534,25 @@ static bt_status_t cind_response(int svc, int num_active, int num_held,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t cind_response(int svc, int num_active, int num_held,
+					bthf_call_state_t state, int signal,
+					int roam, int batt_chg,
+					bt_bdaddr_t *bd_addr)
+{
+	return cind_response_real(svc, num_active, num_held, state, signal,
+						roam, batt_chg, bd_addr);
+}
+#else
+static bt_status_t cind_response(int svc, int num_active, int num_held,
+					bthf_call_state_t state, int signal,
+					int roam, int batt_chg)
+{
+	return cind_response_real(svc, num_active, num_held, state, signal,
+						roam, batt_chg, NULL);
+}
+#endif
+
 static bt_status_t formatted_at_response(const char *rsp)
 {
 	char buf[IPC_MTU];
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 4128746..4cfb91e 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -892,6 +892,7 @@ Commands and responses:
 		                    Signal strength (1 octet)
 		                    Roaming indicator (1 octet)
 		                    Battery level (1 octet)
+		                    Remote address (6 octets)
 		Response parameters: <none>
 
 		Valid call setup states: 0x00 = Active
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a2f2de4..17e6dee 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -551,6 +551,7 @@ struct hal_cmd_handsfree_cind_response {
 	uint8_t signal;
 	uint8_t roam;
 	uint8_t batt_chg;
+	uint8_t bdaddr[6];
 } __attribute__((packed));
 
 #define HAL_OP_HANDSFREE_FORMATTED_AT_RESPONSE	0x0B
diff --git a/android/handsfree.c b/android/handsfree.c
index 7a61dfc..f34668d 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2081,11 +2081,14 @@ static void handle_cind(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_cind_response *cmd = buf;
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

