Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/client: Add support for new API for gatt scan()
Date: Wed,  5 Nov 2014 14:41:51 +0200
Message-Id: <1415191313-12810-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415191313-12810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415191313-12810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes number of parameters in gatt scan()
---
 android/client/if-gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index d593022..64429e4 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -933,6 +933,7 @@ static void scan_p(int argc, const char **argv)
 
 	RETURN_IF_NULL(if_gatt);
 
+#if ANDROID_VERSION < PLATFORM_VER(5, 0, 0)
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
-- 
1.9.1

