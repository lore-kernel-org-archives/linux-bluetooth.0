Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 20/47] android/client: Add support for new GATT HAL API
Date: Tue,  4 Nov 2014 10:18:43 +0200
Message-Id: <1415089150-18798-21-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Support scan(), client and server connect() commands new API.
---
 android/client/if-gatt.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index d593022..d749922 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -933,6 +933,7 @@ static void scan_p(int argc, const char **argv)
 
 	RETURN_IF_NULL(if_gatt);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	VERIFY_CLIENT_IF(2, client_if);
 
 	/* start */
@@ -940,6 +941,13 @@ static void scan_p(int argc, const char **argv)
 		start = atoi(argv[3]);
 
 	EXEC(if_gatt->client->scan, client_if, start);
+#else
+	/* start */
+	if (argc >= 3)
+		start = atoi(argv[2]);
+
+	EXEC(if_gatt->client->scan, start);
+#endif
 }
 
 /* connect */
@@ -961,6 +969,9 @@ static void connect_p(int argc, const char **argv)
 	int client_if;
 	bt_bdaddr_t bd_addr;
 	int is_direct = 1;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	int transport = 1;
+#endif
 
 	RETURN_IF_NULL(if_gatt);
 	VERIFY_CLIENT_IF(2, client_if);
@@ -970,7 +981,16 @@ static void connect_p(int argc, const char **argv)
 	if (argc > 4)
 		is_direct = atoi(argv[4]);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
 	EXEC(if_gatt->client->connect, client_if, &bd_addr, is_direct);
+#else
+	/* transport */
+	if (argc > 5)
+		transport = atoi(argv[5]);
+
+	EXEC(if_gatt->client->connect, client_if, &bd_addr, is_direct,
+								transport);
+#endif
 }
 
 /* disconnect */
@@ -1574,6 +1594,9 @@ static void gatts_connect_p(int argc, const char *argv[])
 	int server_if;
 	bt_bdaddr_t bd_addr;
 	int is_direct = 1;
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	int transport = 1;
+#endif
 
 	RETURN_IF_NULL(if_gatt);
 	VERIFY_SERVER_IF(2, server_if);
@@ -1583,7 +1606,16 @@ static void gatts_connect_p(int argc, const char *argv[])
 	if (argc > 4)
 		is_direct = atoi(argv[4]);
 
+#if ANDROID_VERSION <= PLATFORM_VER(4, 4, 4)
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

