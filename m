Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/3] android/handsfree: Add dummy configure_wbs() function
Date: Thu,  6 Nov 2014 17:00:52 +0200
Message-Id: <1415286053-24973-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286053-24973-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <157256773.Taj45B7ett@uw000953>
 <1415286053-24973-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In a case Android runs this print debug message.
---
 android/hal-handsfree.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 8b644f3..c2b3fd5 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -828,6 +828,17 @@ static void cleanup(void)
 	hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static bt_status_t configure_wbs(bt_bdaddr_t *bd_addr, bthf_wbs_config_t config)
+{
+	/* TODO: implement */
+
+	DBG("");
+
+	return BT_STATUS_UNSUPPORTED;
+}
+#endif
+
 static bthf_interface_t iface = {
 	.size = sizeof(iface),
 	.init = init,
@@ -845,7 +856,10 @@ static bthf_interface_t iface = {
 	.at_response = at_response,
 	.clcc_response = clcc_response,
 	.phone_state_change = phone_state_change,
-	.cleanup = cleanup
+	.cleanup = cleanup,
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	.configure_wbs = configure_wbs,
+#endif
 };
 
 bthf_interface_t *bt_get_handsfree_interface(void)
-- 
1.9.1

