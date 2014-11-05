Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android/client: Add support for new API for gatt server connect()
Date: Wed,  5 Nov 2014 14:41:53 +0200
Message-Id: <1415191313-12810-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415191313-12810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415191313-12810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes number of parameters in gatt server connect() for different Android
API.
---
 android/client/if-gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 6b4ff28..6a09012 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -1594,6 +1594,9 @@ static void gatts_connect_p(int argc, const char *argv[])
 	int server_if;
 	bt_bdaddr_t bd_addr;
 	int is_direct = 1;
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	int transport = 1;
+#endif
 
 	RETURN_IF_NULL(if_gatt);
 	VERIFY_SERVER_IF(2, server_if);
@@ -1603,7 +1606,16 @@ static void gatts_connect_p(int argc, const char *argv[])
 	if (argc > 4)
 		is_direct = atoi(argv[4]);
 
+#if ANDROID_VERSION < PLATFORM_VER(5, 0, 0)
 	EXEC(if_gatt->server->connect, server_if, &bd_addr, is_direct);
+#else
+	/* transport */
+	if (argc > 5)
+		transport = atoi(argv[5]);
+
+	EXEC(if_gatt->server->connect, server_if, &bd_addr, is_direct,
+								transport);
+#endif
 }
 
 /* disconnect */
-- 
1.9.1

