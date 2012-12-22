Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 1/4] hog: Fix message text and level when failing to load suspend plugin
Date: Sat, 22 Dec 2012 12:12:39 -0300
Message-Id: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/hog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index b6ac61d..a9018f5 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -885,7 +885,8 @@ static int hog_init(void)
 
 	err = suspend_init(suspend_callback, resume_callback);
 	if (err < 0)
-		DBG("Suspend: %s(%d)", strerror(-err), -err);
+		error("Loading suspend plugin failed: %s (%d)", strerror(-err),
+									-err);
 	else
 		suspend_supported = TRUE;
 
-- 
1.7.11.7

