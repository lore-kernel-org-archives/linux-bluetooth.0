Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix build errors
Date: Tue, 29 Oct 2013 14:48:41 +0200
Message-Id: <1383050922-27758-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch fixes following issues when building:

Make links to sco.h and rfcomm.h needed for Android sockets.
...
btio.c:39:30: fatal error: bluetooth/rfcomm.h: No such file or directory
compilation terminated.
...
btio.c:40:27: fatal error: bluetooth/sco.h: No such file or directory
compilation terminated.
...
---
 android/Android.mk |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 28ec465..d8f9d0d 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -52,6 +52,8 @@ lib_headers := \
 	l2cap.h \
 	sdp_lib.h \
 	sdp.h \
+	rfcomm.h \
+	sco.h \
 
 $(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
 
-- 
1.7.10.4

