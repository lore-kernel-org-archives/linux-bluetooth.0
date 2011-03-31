Return-Path: <cyrus@holtmann.org>
From: Jaikumar Ganesh <jaikumar@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Fix include paths for health plugin.
Date: Thu, 31 Mar 2011 11:08:04 -0700
Message-Id: <1301594884-5730-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the include path of l2cap.h and sdp_lib.h
---
 health/hdp.c      |    2 +-
 health/hdp_util.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 7fed483..6f2c89d 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -37,7 +37,7 @@
 #include <mcap.h>
 #include <btio.h>
 #include <mcap_lib.h>
-#include <l2cap.h>
+#include <bluetooth/l2cap.h>
 #include <sdpd.h>
 #include "../src/dbus-common.h"
 #include <unistd.h>
diff --git a/health/hdp_util.c b/health/hdp_util.c
index aefe5f9..9ccb648 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -34,7 +34,7 @@
 #include <hdp.h>
 
 #include <sdpd.h>
-#include <sdp_lib.h>
+#include <bluetooth/sdp_lib.h>
 #include <glib-helper.h>
 
 #include <btio.h>
-- 
1.7.3.1

