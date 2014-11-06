Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] android/client: Fix unused warning for gatt client in Android 5
Date: Thu,  6 Nov 2014 17:00:53 +0200
Message-Id: <1415286053-24973-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286053-24973-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <157256773.Taj45B7ett@uw000953>
 <1415286053-24973-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-gatt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 6a09012..5f0eb1c 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -928,7 +928,9 @@ static void unregister_client_p(int argc, const char **argv)
 
 static void scan_p(int argc, const char **argv)
 {
+#if ANDROID_VERSION < PLATFORM_VER(5, 0, 0)
 	int client_if;
+#endif
 	int start = 1;
 
 	RETURN_IF_NULL(if_gatt);
-- 
1.9.1

