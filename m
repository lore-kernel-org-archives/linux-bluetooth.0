Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/client: Fix argc count
Date: Wed, 12 Nov 2014 17:14:26 +0200
Message-Id: <1415805269-6838-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-hf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index 26c0139..269e029 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -386,7 +386,7 @@ static void init_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_hf);
 
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
-	if (argc < 2)
+	if (argc <= 2)
 		max_hf_clients = 1;
 	else
 		max_hf_clients = atoi(argv[2]);
-- 
1.9.1

