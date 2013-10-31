Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/14] android: Set default IO capability on daemon start
Date: Thu, 31 Oct 2013 02:55:45 +0000
Message-Id: <1383188154-22905-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no HAL function for setting IO capabilities so this is
hardcoded to DisplayYesNo as Android devices usually have screen
and input.
---
 android/adapter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index d55a070..d730dde 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -34,6 +34,9 @@
 #include "utils.h"
 #include "adapter.h"
 
+/* Default to DisplayYesNo */
+#define DEFAULT_IO_CAPABILITY 0x01
+
 static GIOChannel *notification_io = NULL;
 
 struct bt_adapter {
@@ -358,6 +361,19 @@ static bool set_mode(uint16_t opcode, uint8_t mode)
 	return false;
 }
 
+static void set_io_capability(void)
+{
+	struct mgmt_cp_set_io_capability cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.io_capability = DEFAULT_IO_CAPABILITY;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_IO_CAPABILITY,
+				adapter->index, sizeof(cp), &cp,
+				NULL, NULL, NULL) == 0)
+		error("Failed to set IO capability");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -399,6 +415,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 
 	load_link_keys(NULL);
 
+	set_io_capability();
 	set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
 	return;
-- 
1.8.4.rc3

