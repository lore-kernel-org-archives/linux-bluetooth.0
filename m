Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] android/hal-gatt: Fix missing check if interface is ready
Date: Mon, 26 May 2014 17:03:44 +0200
Message-Id: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 93dc066..6f0d2c5 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -573,6 +573,9 @@ static bt_status_t register_client(bt_uuid_t *uuid)
 {
 	struct hal_cmd_gatt_client_register cmd;
 
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
 	memcpy(cmd.uuid, uuid, sizeof(*uuid));
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
-- 
1.9.1

