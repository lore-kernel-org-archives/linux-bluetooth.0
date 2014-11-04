Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 01/47] android: Set exact Android version
Date: Tue,  4 Nov 2014 10:18:24 +0200
Message-Id: <1415089150-18798-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For local build set exact current Android version.
---
 android/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 496fbc4..bd05654 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -1,6 +1,6 @@
 if ANDROID
 
-AM_CFLAGS += -DANDROID_VERSION=0xFFFFFF -DBLUEZ_EXTENSIONS
+AM_CFLAGS += -DANDROID_VERSION=0x040404 -DBLUEZ_EXTENSIONS
 
 android_plugindir = $(abs_top_srcdir)/android/.libs
 
-- 
1.9.1

