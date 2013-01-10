Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 08/10] proximity: Fix remaining references to bluetooth/uuid.h
Date: Thu, 10 Jan 2013 09:15:07 -0400
Message-Id: <1357823709-8627-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357823709-8627-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These headers are not public anymore, so need to use "lib/uuid.h".
---
 profiles/proximity/immalert.c |    2 +-
 profiles/proximity/linkloss.c |    2 +-
 profiles/proximity/monitor.c  |    2 +-
 profiles/proximity/reporter.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 04557b4..06e8eb8 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -27,12 +27,12 @@
 #include <stdbool.h>
 
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <adapter.h>
 
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#include "lib/uuid.h"
 #include "log.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index c1c4177..cb87b12 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -27,12 +27,12 @@
 #include <stdbool.h>
 
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <adapter.h>
 
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#include "lib/uuid.h"
 #include "log.h"
 #include "attrib/att-database.h"
 #include "attrib/gattrib.h"
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index e502605..37b02e1 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -36,8 +36,8 @@
 #include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/uuid.h>
 
+#include "lib/uuid.h"
 #include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index ef3ab6a..31c33ef 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -30,7 +30,6 @@
 #include <errno.h>
 
 #include <glib.h>
-#include <bluetooth/uuid.h>
 #include <adapter.h>
 
 #include <dbus/dbus.h>
@@ -38,6 +37,7 @@
 
 #include "log.h"
 
+#include "lib/uuid.h"
 #include "dbus-common.h"
 #include "error.h"
 #include "device.h"
-- 
1.7.9.5

