Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 7/7] build: Add logging system
Date: Tue,  1 Oct 2013 14:58:39 +0200
Message-Id: <1380632319-7701-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
References: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
1.7.9.5

