Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/2] android: Enable AV interface
Date: Thu, 24 Oct 2013 10:10:39 +0300
Message-Id: <1382598639-6920-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382598639-6920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Include av_interface to get_interface function.
---
 android/hal-bluetooth.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index d988778..52c7c68 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -310,6 +310,9 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_PAN_ID))
 		return bt_get_pan_interface();
 
+	if (!strcmp(profile_id, BT_PROFILE_ADVANCED_AUDIO_ID))
+		return bt_get_av_interface();
+
 	return NULL;
 }
 
-- 
1.7.10.4

