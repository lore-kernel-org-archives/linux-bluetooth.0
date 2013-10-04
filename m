Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 6/7] android-build: Add logging system
Date: Fri,  4 Oct 2013 13:54:15 +0300
Message-Id: <1380884056-27808-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

---
 android/Android.mk |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index fc3d6c2..ec820ac 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -14,10 +14,12 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	main.c \
+	log.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
 	$(call include-path-for, glib)/glib \
+	$(LOCAL_PATH)/../src \
 
 LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 
-- 
1.7.10.4

