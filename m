Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android: trivial typo fix
Date: Thu, 17 Oct 2013 10:11:38 +0300
Message-Id: <1381993898-30445-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381993898-30445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381993898-30445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-bt.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 7b4e71e..6aadeef 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -568,20 +568,20 @@ static void get_profile_interface_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_bluetooth);
 
 	if (strcmp(BT_PROFILE_HANDSFREE_ID, id) == 0)
-		pif = &dummy; /* TODO: chenge when if_hf is there */
+		pif = &dummy; /* TODO: change when if_hf is there */
 	else if (strcmp(BT_PROFILE_ADVANCED_AUDIO_ID, id) == 0)
-		pif = &dummy; /* TODO: chenge when if_av is there */
+		pif = &dummy; /* TODO: change when if_av is there */
 	else if (strcmp(BT_PROFILE_HEALTH_ID, id) == 0)
-		pif = &dummy; /* TODO: chenge when if_hl is there */
+		pif = &dummy; /* TODO: change when if_hl is there */
 	else if (strcmp(BT_PROFILE_SOCKETS_ID, id) == 0)
-		pif = &dummy; /* TODO: chenge when if_sock is there */
+		pif = &dummy; /* TODO: change when if_sock is there */
 	else if (strcmp(BT_PROFILE_HIDHOST_ID, id) == 0)
-		pif = &dummy; /* TODO: chenge when if_hh is there */
+		pif = &dummy; /* TODO: change when if_hh is there */
 	else if (strcmp(BT_PROFILE_PAN_ID, id) == 0)
-		pif = &dummy; /* TODO: chenge when if_pan is there */
+		pif = &dummy; /* TODO: change when if_pan is there */
 #if PLATFORM_SDK_VERSION > 17
 	else if (strcmp(BT_PROFILE_AV_RC_ID, id) == 0)
-		pif = &dummy; /* TODO: chenge when if_rc is there */
+		pif = &dummy; /* TODO: change when if_rc is there */
 #endif
 	else
 		haltest_error("%s is not correct for get_profile_interface\n",
-- 
1.7.10.4

