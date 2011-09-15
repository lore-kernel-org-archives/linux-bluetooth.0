Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 4/5] Remove unneeded headers included in storage.c
Date: Thu, 15 Sep 2011 16:32:31 -0300
Message-Id: <1316115151-19838-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1315572669-5006-5-git-send-email-claudio.takahasi@openbossa.org>
References: <1315572669-5006-5-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/storage.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index 85cfed8..00dc483 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -35,8 +35,6 @@
 #include <time.h>
 #include <sys/file.h>
 #include <sys/stat.h>
-#include <sys/param.h>
-#include <sys/socket.h>
 
 #include <glib.h>
 
@@ -45,8 +43,6 @@
 #include <bluetooth/sdp_lib.h>
 
 #include "textfile.h"
-#include "adapter.h"
-#include "device.h"
 #include "glib-helper.h"
 #include "storage.h"
 
-- 
1.7.6.1

