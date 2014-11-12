Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/client: Add handsfree wbs_cb() callback
Date: Wed, 12 Nov 2014 17:14:27 +0200
Message-Id: <1415805269-6838-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-hf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index 269e029..b0dd13a 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -355,6 +355,14 @@ static void key_pressed_cmd_cb(void)
 }
 #endif
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void wbs_cb(bthf_wbs_config_t wbs, bt_bdaddr_t *bd_addr)
+{
+	haltest_info("%s: bd_addr=%s\n", __func__,
+					bt_bdaddr_t2str(bd_addr, last_addr));
+}
+#endif
+
 static bthf_callbacks_t hf_cbacks = {
 	.size = sizeof(hf_cbacks),
 	.connection_state_cb = connection_state_cb,
@@ -366,6 +374,9 @@ static bthf_callbacks_t hf_cbacks = {
 	.dial_call_cmd_cb = dial_call_cmd_cb,
 	.dtmf_cmd_cb = dtmf_cmd_cb,
 	.nrec_cmd_cb = nrec_cmd_cb,
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	.wbs_cb = wbs_cb,
+#endif
 	.chld_cmd_cb = chld_cmd_cb,
 	.cnum_cmd_cb = cnum_cmd_cb,
 	.cind_cmd_cb = cind_cmd_cb,
-- 
1.9.1

