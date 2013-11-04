Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] android: Add support for handling get properties commands
Date: Mon, 4 Nov 2013 16:34:23 +0100
Message-ID: <1383579265-24614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When this commands is received all properties shall be reported to HAL.
---
 android/adapter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 81b61c1..78c301c 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1118,6 +1118,19 @@ static bool get_property(void *buf, uint16_t len)
 	}
 }
 
+static void get_properties(void)
+{
+	send_adapter_address();
+	get_name();
+	get_uuids();
+	get_class();
+	get_type();
+	get_service();
+	get_scan_mode();
+	get_devices();
+	get_disc_timeout();
+}
+
 static bool start_discovery(void)
 {
 	struct mgmt_cp_start_discovery cp;
@@ -1502,6 +1515,10 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 			goto error;
 
 		break;
+	case HAL_OP_GET_ADAPTER_PROPS:
+		get_properties();
+
+		break;
 	case HAL_OP_GET_ADAPTER_PROP:
 		if (!get_property(buf, len))
 			goto error;
-- 
1.8.4.1

