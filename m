Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 6/7] android/haltest: Implement missing functions from bluetooth HAL
Date: Mon, 30 Dec 2013 23:43:40 +0100
Message-Id: <1388443421-6295-6-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
References: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement functions added in Android 4.3+ to Bluetooth HAL.
---
 android/client/if-bt.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 0cd43db..10b79f1 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -797,6 +797,36 @@ static void dut_mode_configure_p(int argc, const char **argv)
 	EXEC(if_bluetooth->dut_mode_configure, mode);
 }
 
+static void dut_mode_send_p(int argc, const char **argv)
+{
+	haltest_error("not implemented\n");
+}
+
+#if PLATFORM_SDK_VERSION > 17
+static void le_test_mode_p(int argc, const char **argv)
+{
+	haltest_error("not implemented\n");
+}
+#endif
+
+#if PLATFORM_SDK_VERSION > 18
+static void config_hci_snoop_log_p(int argc, const char **argv)
+{
+	uint8_t mode;
+
+	RETURN_IF_NULL(if_bluetooth);
+
+	if (argc <= 2) {
+		haltest_error("No mode specified\n");
+		return;
+	}
+
+	mode = strtol(argv[2], NULL, 0);
+
+	EXEC(if_bluetooth->config_hci_snoop_log, mode);
+}
+#endif
+
 static struct method methods[] = {
 	STD_METHOD(init),
 	STD_METHOD(cleanup),
@@ -820,6 +850,13 @@ static struct method methods[] = {
 	STD_METHODCH(ssp_reply, "<address> <ssp_veriant> 1|0 [<passkey>]"),
 	STD_METHODCH(get_profile_interface, "<profile id>"),
 	STD_METHODH(dut_mode_configure, "<dut mode>"),
+	STD_METHOD(dut_mode_send),
+#if PLATFORM_SDK_VERSION > 17
+	STD_METHOD(le_test_mode),
+#endif
+#if PLATFORM_SDK_VERSION > 18
+	STD_METHODH(config_hci_snoop_log, "<mode>"),
+#endif
 	END_METHOD
 };
 
-- 
1.8.5.2

