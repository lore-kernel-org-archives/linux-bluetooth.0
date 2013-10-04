Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 7/7] build: Add logging system
Date: Fri,  4 Oct 2013 13:54:16 +0300
Message-Id: <1380884056-27808-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

---
 Makefile.android |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.android b/Makefile.android
index e792c10..e161e6d 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -1,8 +1,8 @@
 if ANDROID
 noinst_PROGRAMS += android/bluetoothd
 
-android_bluetoothd_SOURCES = android/main.c
+android_bluetoothd_SOURCES = android/main.c src/log.c
 android_bluetoothd_LDADD = @GLIB_LIBS@
 endif
 
-EXTRA_DIST += android/Android.mk
+EXTRA_DIST += android/Android.mk android/log.c
-- 
1.7.10.4

