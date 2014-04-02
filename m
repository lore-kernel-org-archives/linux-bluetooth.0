Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Remove unneeded headers include
Date: Wed,  2 Apr 2014 18:06:56 -0300
Message-Id: <1396472817-7314-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-example.c        | 1 -
 profiles/proximity/main.c     | 1 -
 profiles/proximity/reporter.c | 2 --
 src/attrib-server.c           | 4 ----
 4 files changed, 8 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 1e1483c..6e20b1f 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -32,7 +32,6 @@
 #include "lib/uuid.h"
 #include "src/plugin.h"
 #include "src/adapter.h"
-#include "src/hcid.h"
 #include "src/shared/util.h"
 #include "src/log.h"
 #include "attrib/gattrib.h"
diff --git a/profiles/proximity/main.c b/profiles/proximity/main.c
index d4fe419..8a350d4 100644
--- a/profiles/proximity/main.c
+++ b/profiles/proximity/main.c
@@ -33,7 +33,6 @@
 
 #include "src/log.h"
 #include "src/plugin.h"
-#include "src/hcid.h"
 #include "manager.h"
 
 static GKeyFile *config = NULL;
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 3e4c741..fb91bc1 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -38,13 +38,11 @@
 
 #include "lib/uuid.h"
 #include "src/dbus-common.h"
-#include "src/error.h"
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/shared/util.h"
-#include "src/hcid.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
diff --git a/src/attrib-server.c b/src/attrib-server.c
index ed843d0..e65fff2 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -38,13 +38,9 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include <gdbus/gdbus.h>
-
 #include "lib/uuid.h"
 #include "btio/btio.h"
 #include "log.h"
-#include "sdpd.h"
-#include "hcid.h"
 #include "adapter.h"
 #include "device.h"
 #include "src/shared/util.h"
-- 
1.8.3.1

