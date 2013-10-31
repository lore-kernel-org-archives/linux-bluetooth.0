Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/haltest: Fix bug when building for Android 4.2.2
Date: Thu, 31 Oct 2013 10:37:20 +0200
Message-Id: <1383208640-6644-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383208640-6644-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383208640-6644-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since I started to use system Android headers instead of local this
bug was found.
---
 android/client/if-bt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index cbb828b..f1410f7 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -679,10 +679,10 @@ static void get_profile_interface_c(int argc, const char **argv,
 		BT_PROFILE_SOCKETS_ID,
 		BT_PROFILE_HIDHOST_ID,
 		BT_PROFILE_PAN_ID,
-#if PLATFORM_SDK_VERSION >= 18
+#if PLATFORM_SDK_VERSION > 17
 		BT_PROFILE_GATT_ID,
-#endif
 		BT_PROFILE_AV_RC_ID,
+#endif
 		NULL
 	};
 
-- 
1.7.10.4

