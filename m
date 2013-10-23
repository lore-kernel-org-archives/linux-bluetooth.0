Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 3/4] android: Fix build dependency of haltest on target
Date: Wed, 23 Oct 2013 11:50:39 +0300
Message-Id: <1382518240-31896-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382518240-31896-1-git-send-email-luiz.dentz@gmail.com>
References: <1382518240-31896-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing headers necessary to build haltest.
---
 android/Android.mk | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 6d707c2..93dcc23 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -92,11 +92,12 @@ include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
 	client/haltest.c \
-	client/pollhandler.c \
-	client/terminal.c \
-	client/history.c \
-	client/textconv.c \
+	client/pollhandler.c client/pollhandler.h \
+	client/terminal.c client/terminal.h \
+	client/history.c client/history.h \
+	client/textconv.c client/textconv.h \
 	client/tabcompletion.c \
+	client/if-main.h \
 	client/if-bt.c \
 	client/if-hh.c \
 
-- 
1.8.3.1

