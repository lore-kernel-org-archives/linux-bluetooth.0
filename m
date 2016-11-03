Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Petri Gynther <pgynther@google.com>
Subject: [PATCH] input/hog: Remove unused attioid from hog_device
Date: Thu,  3 Nov 2016 13:03:53 -0700
Message-Id: <1478203433-37526-1-git-send-email-pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/hog.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 9836a6c..7d318cd 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -60,7 +60,6 @@
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
 struct hog_device {
-	guint			attioid;
 	struct btd_device	*device;
 	struct bt_hog		*hog;
 };
-- 
2.8.0.rc3.226.g39d4020

