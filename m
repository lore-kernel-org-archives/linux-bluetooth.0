Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/client: Add hanfsfree configure_wbs() command
Date: Wed, 12 Nov 2014 17:14:29 +0200
Message-Id: <1415805269-6838-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add command configure_wbs() and helpers.
---
 android/client/if-hf.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index c64d412..d24612a 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -105,6 +105,12 @@ SINTMAP(bthf_call_addrtype_t, -1, "(unknown)")
 	DELEMENT(BTHF_CALL_ADDRTYPE_INTERNATIONAL),
 ENDMAP
 
+SINTMAP(bthf_wbs_config_t, -1, "(unknown)")
+	DELEMENT(BTHF_WBS_NONE),
+	DELEMENT(BTHF_WBS_NO),
+	DELEMENT(BTHF_WBS_YES),
+ENDMAP
+
 /* Callbacks */
 
 static char last_addr[MAX_ADDR_STR_LEN];
@@ -902,6 +908,35 @@ static void clcc_response_p(int argc, const char **argv)
 #endif
 }
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void configure_wbs_c(int argc, const char **argv, enum_func *enum_func,
+								void **user)
+{
+	if (argc == 4) {
+		*user = TYPE_ENUM(bthf_wbs_config_t);
+		*enum_func = enum_defines;
+	}
+}
+
+static void configure_wbs_p(int argc, const char **argv)
+{
+	bthf_wbs_config_t wbs;
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_hf);
+
+	if (argc <= 3) {
+		haltest_error("Too few parameters specified\n");
+		return;
+	}
+
+	VERIFY_ADDR_ARG(2, &addr);
+	wbs = str2bthf_wbs_config_t(argv[3]);
+
+	EXEC(if_hf->configure_wbs, &addr, wbs);
+}
+#endif
+
 /* phone state change */
 
 static void phone_state_change_c(int argc, const char **argv,
@@ -990,6 +1025,7 @@ static struct method methods[] = {
 	STD_METHODCH(clcc_response,
 			"<index> <direction> <state> <mode> <mpty> <number> "
 			"<type> <addr>"),
+	STD_METHODCH(configure_wbs, "<addr> <wbs config>"),
 #else
 	STD_METHOD(init),
 	STD_METHOD(start_voice_recognition),
-- 
1.9.1

