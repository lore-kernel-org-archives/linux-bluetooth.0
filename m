Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 01/15] android: Supress missing initializers warnings
Date: Tue,  8 Oct 2013 13:33:43 +0300
Message-Id: <1381228437-5553-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381228437-5553-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

These types of warnings are disabled in BlueZ makeifiles

main.c:67:2: warning: missing initializer [-Wmissing-field-initializers]
main.c:67:2: warning: (near initialization for 'options[1].short_name')
	[-Wmissing-field-initializers]
---
 android/Android.mk |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index ec820ac..5498b41 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -23,6 +23,9 @@ LOCAL_C_INCLUDES := \
 
 LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 
+# to suppress the "warning: missing initializer near initialization.." warning
+LOCAL_CFLAGS += -Wno-missing-field-initializers
+
 LOCAL_SHARED_LIBRARIES := \
 	libglib \
 
-- 
1.7.10.4

