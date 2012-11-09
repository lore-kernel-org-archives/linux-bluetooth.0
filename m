Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 1/2] build: Require D-Bus 1.5 or later
Date: Fri, 09 Nov 2012 14:01:28 +0530
Message-id: <1352449889-5149-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The gdbus require D-Bus 1.5 version.

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
 acinclude.m4 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index ddc8183..1ae402c 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -92,8 +92,8 @@ AC_DEFUN([AC_INIT_BLUEZ], [
 ])
 
 AC_DEFUN([AC_PATH_DBUS], [
-	PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.4, dummy=yes,
-				AC_MSG_ERROR(D-Bus >= 1.4 is required))
+	PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.5, dummy=yes,
+				AC_MSG_ERROR(D-Bus >= 1.5 is required))
 	AC_SUBST(DBUS_CFLAGS)
 	AC_SUBST(DBUS_LIBS)
 ])
-- 
1.7.4.1

