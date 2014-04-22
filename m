Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 11/11] android/client: Add health callbacks support for haltest
Date: Tue, 22 Apr 2014 15:06:10 +0300
Message-Id: <1398168371-29685-12-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hl.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 6b3e341..b9cf374 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -36,12 +36,45 @@ SINTMAP(bthl_channel_type_t, -1, "(unknown)")
 	DELEMENT(BTHL_CHANNEL_TYPE_ANY),
 ENDMAP
 
+SINTMAP(bthl_app_reg_state_t, -1, "(unknown)")
+	DELEMENT(BTHL_APP_REG_STATE_REG_SUCCESS),
+	DELEMENT(BTHL_APP_REG_STATE_REG_FAILED),
+	DELEMENT(BTHL_APP_REG_STATE_DEREG_SUCCESS),
+	DELEMENT(BTHL_APP_REG_STATE_DEREG_FAILED),
+ENDMAP
+
+SINTMAP(bthl_channel_state_t, -1, "(unknown)")
+	DELEMENT(BTHL_CONN_STATE_CONNECTING),
+	DELEMENT(BTHL_CONN_STATE_CONNECTED),
+	DELEMENT(BTHL_CONN_STATE_DISCONNECTING),
+	DELEMENT(BTHL_CONN_STATE_DISCONNECTED),
+	DELEMENT(BTHL_CONN_STATE_DESTROYED),
+ENDMAP
+
 const bthl_interface_t *if_hl = NULL;
 
+static void app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
+{
+	haltest_info("%s: app_id=%d app_reg_state=%s\n", __func__,
+				app_id, bthl_app_reg_state_t2str(state));
+}
+
+static void channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
+				int mdep_cfg_index, int channel_id,
+				bthl_channel_state_t state, int fd)
+{
+	char addr[MAX_ADDR_STR_LEN];
+
+	haltest_info("%s: app_id=%d bd_addr=%s mdep_cfg_index=%d\n"
+			"channel_id=%d channel_state=%s fd=%d\n", __func__,
+			app_id, bt_bdaddr_t2str(bd_addr, addr), mdep_cfg_index,
+			channel_id, bthl_channel_state_t2str(state), fd);
+}
+
 static bthl_callbacks_t hl_cbacks = {
 	.size = sizeof(hl_cbacks),
-	.app_reg_state_cb = NULL,
-	.channel_state_cb = NULL,
+	.app_reg_state_cb = app_reg_state_cb,
+	.channel_state_cb = channel_state_cb,
 };
 
 /* init */
-- 
1.8.3.2

