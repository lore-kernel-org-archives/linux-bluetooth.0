Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 19/47] android/client: Add support for new Android API for PAN HAL
Date: Tue,  4 Nov 2014 10:18:42 +0200
Message-Id: <1415089150-18798-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes parameters order for new API.
---
 android/client/if-pan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/client/if-pan.c b/android/client/if-pan.c
index 6207f6e..c128482 100644
--- a/android/client/if-pan.c
+++ b/android/client/if-pan.c
@@ -40,8 +40,13 @@ SINTMAP(btpan_control_state_t, -1, "(unknown)")
 	DELEMENT(BTPAN_STATE_DISABLED),
 ENDMAP
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static void control_state_cb(btpan_control_state_t state, int local_role,
+					bt_status_t error, const char *ifname)
+#else
 static void control_state_cb(btpan_control_state_t state, bt_status_t error,
 					int local_role, const char *ifname)
+#endif
 {
 	haltest_info("%s: state=%s error=%s local_role=%s ifname=%s\n",
 			__func__, btpan_control_state_t2str(state),
-- 
1.9.1

