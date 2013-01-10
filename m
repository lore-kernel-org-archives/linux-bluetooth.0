Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 01/10] core: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:00 -0400
Message-Id: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 src/attrib-server.c |    2 +-
 src/main.c          |    2 +-
 src/storage.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 0a56942..b2360c3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -35,10 +35,10 @@
 #include <sys/file.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "lib/uuid.h"
 #include <gdbus/gdbus.h>
 #include "log.h"
 #include <btio/btio.h>
diff --git a/src/main.c b/src/main.c
index bd1e9d9..b9fd369 100644
--- a/src/main.c
+++ b/src/main.c
@@ -38,7 +38,6 @@
 #include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
 
 #include <glib.h>
 
@@ -48,6 +47,7 @@
 
 #include "log.h"
 
+#include "lib/uuid.h"
 #include "hcid.h"
 #include "sdpd.h"
 #include "adapter.h"
diff --git a/src/storage.c b/src/storage.c
index 8b634ba..f7e4db6 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -41,8 +41,8 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
-#include <bluetooth/uuid.h>
 
+#include "lib/uuid.h"
 #include "textfile.h"
 #include "glib-helper.h"
 #include "storage.h"
-- 
1.7.9.5

