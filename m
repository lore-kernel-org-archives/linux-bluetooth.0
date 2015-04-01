Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 25/28] android/hog: Add MIN definition
Date: Wed,  1 Apr 2015 18:40:41 +0200
Message-Id: <1427906444-11769-26-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's needed to delete attrib, where the previous definition was.
---
 android/hog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 9276d40..eb9c9d4 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -59,6 +59,10 @@
 #include "android/bas.h"
 #include "android/hog.h"
 
+#ifndef MIN
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#endif
+
 #define HOG_REPORT_TYPE_INPUT	1
 #define HOG_REPORT_TYPE_OUTPUT	2
 #define HOG_REPORT_TYPE_FEATURE	3
-- 
1.9.1

