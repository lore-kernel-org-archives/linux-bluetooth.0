Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/13] android/handsfree: Add support for AT+CMER command
Date: Sun,  2 Feb 2014 22:09:24 +0100
Message-Id: <1391375364-27106-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index 02135cb..bf6a575 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -63,6 +63,7 @@ static struct {
 	struct hfp_gw *gw;
 
 	uint32_t features;
+	bool ind_notif_active;
 } device;
 
 static bdaddr_t adapter_addr;
@@ -172,6 +173,30 @@ static bool at_cind(const char *at)
 	return false;
 }
 
+static bool at_cmer(const char *at)
+{
+	unsigned int mode, ind;
+	int ret;
+
+	DBG("");
+
+	ret = sscanf(at, " = %u, %*u, %*u, %u", &mode, &ind);
+	if (ret != 2 || mode != 3 || ind > 1) {
+		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+
+		return false;
+	}
+
+	device.ind_notif_active = ind;
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+	/* TODO Check for 3-way calling support */
+	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED);
+
+	return true;
+}
+
 static const struct {
 	const char *prefix;
 	int prefix_len;
@@ -179,6 +204,7 @@ static const struct {
 } at_cmds[] = {
 	{ "+BRSF", sizeof("+BRSF") - 1, at_brsf },
 	{ "+CIND", sizeof("+CIND") - 1, at_cind },
+	{ "+CMER", sizeof("+CMER") - 1, at_cmer },
 };
 
 static void at_command_handler(const char *command, void *user_data)
-- 
1.8.5.3

