Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/2] android: haltest: Enable av interface in test tool
Date: Thu, 24 Oct 2013 10:10:38 +0300
Message-Id: <1382598639-6920-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-bt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 2d9c0b5..f5c84c1 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -803,7 +803,7 @@ static void get_profile_interface_p(int argc, const char **argv)
 	if (strcmp(BT_PROFILE_HANDSFREE_ID, id) == 0)
 		pif = &dummy; /* TODO: change when if_hf is there */
 	else if (strcmp(BT_PROFILE_ADVANCED_AUDIO_ID, id) == 0)
-		pif = &dummy; /* TODO: change when if_av is there */
+		pif = (const void **)&if_av;
 	else if (strcmp(BT_PROFILE_HEALTH_ID, id) == 0)
 		pif = &dummy; /* TODO: change when if_hl is there */
 	else if (strcmp(BT_PROFILE_SOCKETS_ID, id) == 0)
-- 
1.7.10.4

