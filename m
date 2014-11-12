Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/client: Fix help for gatt server commands
Date: Wed, 12 Nov 2014 11:09:19 +0200
Message-Id: <1415783361-11991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-gatt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 5f0eb1c..72f97ba 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1894,7 +1894,11 @@ static void gatts_send_response_p(int argc, const char *argv[])
 static struct method server_methods[] = {
 	GATTS_METHODH(register_server, "[<uuid>]"),
 	GATTS_METHODCH(unregister_server, "<server_if>"),
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	GATTS_METHODCH(connect, "<server_if> <addr> [<is_direct>] [<transport>]"),
+#else
 	GATTS_METHODCH(connect, "<server_if> <addr> [<is_direct>]"),
+#endif
 	GATTS_METHODCH(disconnect, "<server_if> <addr> <conn_id>"),
 	GATTS_METHODCH(add_service, "<server_if> <srvc_id> <num_handles>"),
 	GATTS_METHODCH(add_included_service,
-- 
1.9.1

