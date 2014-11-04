Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 30/47] android/handsfree: Add support for new API for clcc_response
Date: Tue,  4 Nov 2014 10:18:53 +0200
Message-Id: <1415089150-18798-31-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

clcc_response has new parameter bdaddr in new Android API.
---
 android/hal-handsfree.c | 17 +++++++++++++++++
 android/hal-ipc-api.txt |  1 +
 android/hal-msg.h       |  1 +
 android/handsfree.c     |  5 ++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index e9388b8..f19ca1a 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -590,12 +590,22 @@ static bt_status_t at_response(bthf_at_response_t response, int error)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
+					bthf_call_state_t state,
+					bthf_call_mode_t mode,
+					bthf_call_mpty_type_t mpty,
+					const char *number,
+					bthf_call_addrtype_t type,
+					bt_bdaddr_t *bd_addr)
+#else
 static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 					bthf_call_state_t state,
 					bthf_call_mode_t mode,
 					bthf_call_mpty_type_t mpty,
 					const char *number,
 					bthf_call_addrtype_t type)
+#endif
 {
 	char buf[IPC_MTU];
 	struct hal_cmd_handsfree_clcc_response *cmd = (void *) buf;
@@ -606,6 +616,13 @@ static bt_status_t clcc_response(int index, bthf_call_direction_t dir,
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd->bdaddr, bd_addr, sizeof(cmd->bdaddr));
+#endif
+
 	cmd->index = index;
 	cmd->dir = dir;
 	cmd->state = state;
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index b5d5557..4181d40 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -934,6 +934,7 @@ Commands and responses:
 		                    Call multiparty type (1 octet)
 		                    Call number type (1 octet)
 		                    Call number (string)
+		                    Remote address (6 octets)
 		Response parameters: <none>
 
 		Valid call directions: 0x00 = Outgoing
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4b3d8b8..9b08966 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -592,6 +592,7 @@ struct hal_cmd_handsfree_clcc_response {
 	uint8_t mode;
 	uint8_t mpty;
 	uint8_t type;
+	uint8_t bdaddr[6];
 	uint16_t number_len;
 	uint8_t number[0];
 } __attribute__((packed));
diff --git a/android/handsfree.c b/android/handsfree.c
index 92a341a..ba94011 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2192,6 +2192,7 @@ static void handle_clcc_resp(const void *buf, uint16_t len)
 	const struct hal_cmd_handsfree_clcc_response *cmd = buf;
 	struct hf_device *dev;
 	uint8_t status;
+	bdaddr_t bdaddr;
 	char *number;
 
 	if (len != sizeof(*cmd) + cmd->number_len || (cmd->number_len != 0 &&
@@ -2203,7 +2204,9 @@ static void handle_clcc_resp(const void *buf, uint16_t len)
 
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

