Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android: Stop mainloop if reading index list failed
Date: Tue, 5 Nov 2013 15:18:48 +0100
Message-ID: <1383661128-25029-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
References: <1383661128-25029-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If reading index list failed mainloop should be stopped since adapter
init guard timer is not yet running.
---
 android/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/android/main.c b/android/main.c
index 4bb5101..72e47f2 100644
--- a/android/main.c
+++ b/android/main.c
@@ -528,12 +528,12 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 	if (status) {
 		error("%s: Failed to read index list: %s (0x%02x)",
 					__func__, mgmt_errstr(status), status);
-		return;
+		goto error;
 	}
 
 	if (length < sizeof(*rp)) {
 		error("%s: Wrong size of read index list response", __func__);
-		return;
+		goto error;
 	}
 
 	num = btohs(rp->num_controllers);
@@ -542,7 +542,7 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 
 	if (num * sizeof(uint16_t) + sizeof(*rp) != length) {
 		error("%s: Incorrect pkt size for index list rsp", __func__);
-		return;
+		goto error;
 	}
 
 	if (adapter_index != MGMT_INDEX_NONE)
@@ -553,13 +553,17 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 						adapter_timeout_handler, NULL);
 		if (adapter_timeout == 0) {
 			error("%s: Failed init timeout", __func__);
-			g_main_loop_quit(event_loop);
+			goto error;
 		}
 		return;
 	}
 
 	adapter_index = btohs(rp->index[0]);
 	bt_adapter_init(adapter_index, mgmt_if, adapter_ready);
+	return;
+
+error:
+	g_main_loop_quit(event_loop);
 }
 
 static void read_commands_complete(uint8_t status, uint16_t length,
-- 
1.8.4.2

