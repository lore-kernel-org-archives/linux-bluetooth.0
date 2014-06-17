Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/health: trivial: Remove unneeded NULL assignment
Date: Tue, 17 Jun 2014 16:56:07 +0300
Message-Id: <1403013367-8911-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 4a709ef..54da771 100644
--- a/android/health.c
+++ b/android/health.c
@@ -465,7 +465,6 @@ static void free_hdp_list(void *list)
 	sdp_list_t *hdp_list = list;
 
 	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
-	hdp_list = NULL;
 }
 
 static void register_features(void *data, void *user_data)
-- 
1.8.3.2

