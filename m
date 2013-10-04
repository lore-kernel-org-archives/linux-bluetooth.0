Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 4/7] build: Add BlueZ Android daemon
Date: Fri,  4 Oct 2013 13:54:13 +0300
Message-Id: <1380884056-27808-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

---
 .gitignore       |    2 ++
 Makefile.android |    7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/.gitignore b/.gitignore
index 8a25a3e..3707209 100644
--- a/.gitignore
+++ b/.gitignore
@@ -98,3 +98,5 @@ unit/test-gobex-packet
 unit/test-gobex-transfer
 unit/test-*.log
 unit/test-*.trs
+
+android/bluetoothd
diff --git a/Makefile.android b/Makefile.android
index 56fa9a7..e792c10 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -1 +1,8 @@
+if ANDROID
+noinst_PROGRAMS += android/bluetoothd
+
+android_bluetoothd_SOURCES = android/main.c
+android_bluetoothd_LDADD = @GLIB_LIBS@
+endif
+
 EXTRA_DIST += android/Android.mk
-- 
1.7.10.4

