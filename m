Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/client: Add read_energy_info command
Date: Fri, 21 Nov 2014 12:16:41 +0100
Message-Id: <1416568603-3666-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-bt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 2b9c455..f74a56a 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -397,6 +397,14 @@ static void enable_p(int argc, const char **argv)
 
 	EXEC(if_bluetooth->enable);
 }
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+static void read_energy_info_p(int argc, const char **argv)
+{
+	RETURN_IF_NULL(if_bluetooth);
+
+	EXEC(if_bluetooth->read_energy_info);
+}
+#endif
 
 static void disable_p(int argc, const char **argv)
 {
@@ -878,6 +886,7 @@ static struct method methods[] = {
 	STD_METHOD(cancel_discovery),
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	STD_METHODCH(create_bond, "<addr> [<transport>]"),
+	STD_METHOD(read_energy_info),
 #else
 	STD_METHODCH(create_bond, "<addr>"),
 #endif
-- 
1.9.3

