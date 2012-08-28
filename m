Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] input: Fix build error due to O_CLOEXEC
Date: Tue, 28 Aug 2012 10:28:47 -0400
Message-Id: <1346164127-22102-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On some (not so old) systems like Ubuntu 10.04 LTS, O_CLOEXEC is only
defined if _GNU_SOURCE is defined.

This fixes this build error:

profiles/input/hog_device.c: In function 'hog_device_register':
profiles/input/hog_device.c:712: error: 'O_CLOEXEC' undeclared (first
use in this function)
profiles/input/hog_device.c:712: error: (Each undeclared identifier is
reported only once
profiles/input/hog_device.c:712: error: for each function it appears
in.)
---
 profiles/input/hog_device.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 000f173..b502274 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -27,6 +27,7 @@
 #include <config.h>
 #endif
 
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-- 
1.7.9.5

