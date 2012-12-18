Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] hog: Rename hog_device.c file to hog.c
Date: Tue, 18 Dec 2012 15:49:43 -0300
Message-Id: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since hog_manager.c and hog_device.h were merged into hog_device.c,
now the whole HoG logic is in this file. So, calling this file hog.c
instead of hog_device.c is more suitable.
---
 Makefile.plugins                       | 2 +-
 profiles/input/{hog_device.c => hog.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename profiles/input/{hog_device.c => hog.c} (100%)

diff --git a/Makefile.plugins b/Makefile.plugins
index 41b6876..73055ef 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -59,7 +59,7 @@ builtin_sources += profiles/input/manager.h profiles/input/manager.c \
 			profiles/input/device.h profiles/input/device.c
 
 builtin_modules += hog
-builtin_sources += profiles/input/hog_device.c profiles/input/uhid_copy.h \
+builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
 			profiles/input/suspend.h profiles/input/suspend-dummy.c
 
 builtin_modules += health
diff --git a/profiles/input/hog_device.c b/profiles/input/hog.c
similarity index 100%
rename from profiles/input/hog_device.c
rename to profiles/input/hog.c
-- 
1.8.0.1

