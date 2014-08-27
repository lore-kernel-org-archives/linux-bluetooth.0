Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/avdtp: Constify data in avdtp_service_cap_new
Date: Wed, 27 Aug 2014 15:01:19 +0200
Message-Id: <1409144479-13862-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avdtp.c | 3 ++-
 android/avdtp.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 3985fb3..074ca13 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -2960,7 +2960,8 @@ struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep)
 }
 
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
-							void *data, int length)
+							const void *data,
+							int length)
 {
 	struct avdtp_service_capability *cap;
 
diff --git a/android/avdtp.h b/android/avdtp.h
index 28895ea..d5335e4 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -218,7 +218,8 @@ void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
-							void *data, int size);
+							const void *data,
+							int size);
 
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep);
 
-- 
1.9.1

