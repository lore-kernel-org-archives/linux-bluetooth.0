Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android/client: Add get_connection_state command
Date: Fri, 21 Nov 2014 12:16:43 +0100
Message-Id: <1416568603-3666-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-bt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4648f99..b518177 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -409,6 +409,20 @@ static void read_energy_info_p(int argc, const char **argv)
 
 	EXEC(if_bluetooth->read_energy_info);
 }
+
+#define get_connection_state_c complete_addr_c
+
+static void get_connection_state_p(int argc, const char **argv)
+{
+	bt_bdaddr_t addr;
+
+	RETURN_IF_NULL(if_bluetooth);
+
+	VERIFY_ADDR_ARG(2, &addr);
+
+	haltest_info("if_bluetooth->get_connection_state : %d\n",
+				if_bluetooth->get_connection_state(&addr));
+}
 #endif
 
 static void disable_p(int argc, const char **argv)
@@ -892,6 +906,7 @@ static struct method methods[] = {
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	STD_METHODCH(create_bond, "<addr> [<transport>]"),
 	STD_METHOD(read_energy_info),
+	STD_METHODCH(get_connection_state, "<addr>"),
 #else
 	STD_METHODCH(create_bond, "<addr>"),
 #endif
-- 
1.9.3

