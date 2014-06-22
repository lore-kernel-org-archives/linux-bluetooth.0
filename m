Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 6/6] anrdroid/client/health: Cache fd and close on channel disconnection
Date: Sun, 22 Jun 2014 14:59:01 +0300
Message-Id: <1403438341-14321-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403438341-14321-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403438341-14321-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Cache fd and close them on channel disconnect or destroy notification.
When running PTS tests it is expecting to close all data channels before
exiting test case.
---
 android/client/if-hl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 557a205..5940526 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -17,6 +17,7 @@
 
 #include<stdio.h>
 #include<ctype.h>
+#include<unistd.h>
 
 #include<hardware/bluetooth.h>
 #include<hardware/bt_hl.h>
@@ -52,6 +53,7 @@ SINTMAP(bthl_channel_state_t, -1, "(unknown)")
 ENDMAP
 
 const bthl_interface_t *if_hl = NULL;
+static int fd_list[256] = {-1};
 
 static void app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
 {
@@ -69,6 +71,13 @@ static void channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
 			"channel_id=%d channel_state=%s fd=%d\n", __func__,
 			app_id, bt_bdaddr_t2str(bd_addr, addr), mdep_cfg_index,
 			channel_id, bthl_channel_state_t2str(state), fd);
+
+	if (state == BTHL_CONN_STATE_CONNECTED)
+		fd_list[channel_id] = fd;
+
+	if (state == BTHL_CONN_STATE_DISCONNECTED ||
+			state == BTHL_CONN_STATE_DESTROYED)
+		close(fd_list[channel_id]);
 }
 
 static bthl_callbacks_t hl_cbacks = {
-- 
1.9.1

