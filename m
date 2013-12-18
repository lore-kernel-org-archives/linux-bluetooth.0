Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] avctp: Move avctp.c|h from profiles/audio to protocol/
Date: Wed, 18 Dec 2013 13:24:21 +0200
Message-Id: <1387365861-23356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an initial patch for decoupling avctp.c|h from profiles/audio.
Goal is to remove external dependency (glib is enough) and reusable
to android/* sources.
---
 Makefile.plugins                     | 2 +-
 {profiles/audio => protocol}/avctp.c | 7 +------
 {profiles/audio => protocol}/avctp.h | 0
 3 files changed, 2 insertions(+), 7 deletions(-)
 rename {profiles/audio => protocol}/avctp.c (99%)
 rename {profiles/audio => protocol}/avctp.h (100%)

diff --git a/Makefile.plugins b/Makefile.plugins
index 6a1ddbf..a64d4f5 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -41,7 +41,7 @@ builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 
 builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
-			profiles/audio/avctp.h profiles/audio/avctp.c \
+			protocol/avctp.h protocol/avctp.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
 			profiles/audio/player.h profiles/audio/player.c
 
diff --git a/profiles/audio/avctp.c b/protocol/avctp.c
similarity index 99%
rename from profiles/audio/avctp.c
rename to protocol/avctp.c
index 6669ddc..a09cd93 100644
--- a/profiles/audio/avctp.c
+++ b/protocol/avctp.c
@@ -32,12 +32,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
-#include <assert.h>
-#include <signal.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
-#include <netinet/in.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -54,7 +49,7 @@
 #include "error.h"
 #include "uinput.h"
 #include "avctp.h"
-#include "avrcp.h"
+#include <profiles/audio/avrcp.h>
 
 /* AV/C Panel 1.23, page 76:
  * command with the pressed value is valid for two seconds
diff --git a/profiles/audio/avctp.h b/protocol/avctp.h
similarity index 100%
rename from profiles/audio/avctp.h
rename to protocol/avctp.h
-- 
1.8.3.2

