Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/7] build: Add BlueZ Android daemon
Date: Tue,  1 Oct 2013 14:58:36 +0200
Message-Id: <1380632319-7701-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
References: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
1.7.9.5

