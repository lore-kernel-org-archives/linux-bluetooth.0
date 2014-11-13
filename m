Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] android/handsfree: Send phone state to all connected devices
Date: Thu, 13 Nov 2014 16:52:51 +0100
Message-Id: <1415893972-18656-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415893972-18656-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415893972-18656-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 0001eb6..9bb8f43 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -2485,27 +2485,10 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
 	}
 }
 
-static void handle_phone_state_change(const void *buf, uint16_t len)
+static void phone_state_change(void *data, void *user_data)
 {
-	const struct hal_cmd_handsfree_phone_state_change *cmd = buf;
-	struct hf_device *dev;
-	uint8_t status;
-
-	if (len != sizeof(*cmd) + cmd->number_len || (cmd->number_len != 0 &&
-				cmd->number[cmd->number_len - 1] != '\0')) {
-		error("Invalid phone state change command, terminating");
-		raise(SIGTERM);
-		return;
-	}
-
-	DBG("active=%u hold=%u state=%u", cmd->num_active, cmd->num_held,
-								cmd->state);
-
-	dev = find_default_device();
-	if (!dev) {
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
+	struct hf_device *dev = data;
+	struct hal_cmd_handsfree_phone_state_change *cmd = user_data;
 
 	switch (cmd->state) {
 	case HAL_HANDSFREE_CALL_STATE_DIALING:
@@ -2526,14 +2509,38 @@ static void handle_phone_state_change(const void *buf, uint16_t len)
 		DBG("unhandled new state %u (current state %u)", cmd->state,
 							dev->setup_state);
 
-		status = HAL_STATUS_FAILED;
-		goto failed;
+		return;
 	}
 
 	dev->num_active = cmd->num_active;
 	dev->num_held = cmd->num_held;
 	dev->setup_state = cmd->state;
 
+}
+
+static void handle_phone_state_change(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_handsfree_phone_state_change *cmd = buf;
+	uint8_t status;
+
+	if (len != sizeof(*cmd) + cmd->number_len || (cmd->number_len != 0 &&
+				cmd->number[cmd->number_len - 1] != '\0')) {
+		error("Invalid phone state change command, terminating");
+		raise(SIGTERM);
+		return;
+	}
+
+	DBG("active=%u hold=%u state=%u", cmd->num_active, cmd->num_held,
+								cmd->state);
+
+	if (queue_isempty(devices)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	/* Cast cmd to void as queue api needs that */
+	queue_foreach(devices, phone_state_change, (void *) cmd);
+
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-- 
1.8.4

