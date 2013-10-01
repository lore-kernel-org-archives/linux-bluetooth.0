Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/7] android-build: Add logging system
Date: Tue,  1 Oct 2013 14:58:38 +0200
Message-Id: <1380632319-7701-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
References: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
1.7.9.5

