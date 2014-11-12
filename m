Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Fix adding missing BT_PROFILE_AV_RC_CTRL_ID
Date: Wed, 12 Nov 2014 11:05:51 +0200
Message-Id: <1415783151-9920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add BT_PROFILE_AV_RC_CTRL_ID to profile_ids[].
---
 android/client/if-bt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index b0a0f71..f83e148 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -760,6 +760,7 @@ static void get_profile_interface_c(int argc, const char **argv,
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
 		BT_PROFILE_MAP_CLIENT_ID,
+		BT_PROFILE_AV_RC_CTRL_ID,
 #endif
 		NULL
 	};
-- 
1.9.1

