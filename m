Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/client: Fix help for gatt client commands
Date: Wed, 12 Nov 2014 11:09:20 +0200
Message-Id: <1415783361-11991-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415783361-11991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415783361-11991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-gatt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 72f97ba..301262b 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1503,8 +1503,13 @@ static void test_command_p(int argc, const char **argv)
 static struct method client_methods[] = {
 	STD_METHODH(register_client, "[<uuid>]"),
 	STD_METHODCH(unregister_client, "<client_if>"),
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	STD_METHODCH(scan, "[1|0]"),
+	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>] [<transport]"),
+#else
 	STD_METHODCH(scan, "<client_if> [1|0]"),
 	STD_METHODCH(connect, "<client_if> <addr> [<is_direct>]"),
+#endif
 	STD_METHODCH(disconnect, "<client_if> <addr> <conn_id>"),
 	STD_METHODCH(refresh, "<client_if> <addr>"),
 	STD_METHODCH(search_service, "<conn_id> [<uuid>]"),
-- 
1.9.1

