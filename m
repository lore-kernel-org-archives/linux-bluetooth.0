Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 1/1] gdbus: Fix compilation error due to missing #defines
Date: Wed, 14 Nov 2012 18:37:10 +0530
Message-id: <1352898430-3383-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since these are simple #define strings, we are defining it here
instead of upgrading to D-Bus 1.5 or later.

Log:
  CC     gdbus/object.o
gdbus/object.c: In function ‘properties_set’:
gdbus/object.c:876:7: error: ‘DBUS_ERROR_UNKNOWN_PROPERTY’ undeclared
 (first use in this function)
gdbus/object.c:876:7: note: each undeclared identifier is reported
 only once for each function it appears in
gdbus/object.c:881:6: error: ‘DBUS_ERROR_PROPERTY_READ_ONLY’
 undeclared (first use in this function)
make[1]: *** [gdbus/object.o] Error 1
make: *** [all] Error 2
---
 gdbus/object.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index e3ad067..3101ca6 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -39,6 +39,14 @@
 
 #define DBUS_INTERFACE_OBJECT_MANAGER "org.freedesktop.DBus.ObjectManager"
 
+#ifndef DBUS_ERROR_UNKNOWN_PROPERTY
+#define DBUS_ERROR_UNKNOWN_PROPERTY "org.freedesktop.DBus.Error.UnknownProperty"
+#endif
+
+#ifndef DBUS_ERROR_PROPERTY_READ_ONLY
+#define DBUS_ERROR_PROPERTY_READ_ONLY "org.freedesktop.DBus.Error.PropertyReadOnly"
+#endif
+
 struct generic_data {
 	unsigned int refcount;
 	DBusConnection *conn;
-- 
1.7.4.1

