Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] attrib: Fix "make distcheck" build
Date: Tue,  3 Apr 2012 12:01:31 -0400
Message-Id: <1333468891-2686-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Any new header files (att-database.h in this case) need to be added to
Makefile.am.

Fixes this "make distcheck" error:

  CC     attrib/bluetoothd-gatt-service.o
../attrib/gatt-service.c:35:26: fatal error: att-database.h: No such
file or directory
compilation terminated.
make[2]: *** [attrib/bluetoothd-gatt-service.o] Error 1
make[1]: *** [all] Error 2
make: *** [distcheck] Error 1
---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d475555..d6c1d73 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -106,7 +106,8 @@ sbc_sbctest_CFLAGS = $(AM_CFLAGS) @SNDFILE_CFLAGS@
 endif
 endif
 
-attrib_sources = attrib/att.h attrib/att.c attrib/gatt.h attrib/gatt.c \
+attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
+		attrib/gatt.h attrib/gatt.c \
 		attrib/gattrib.h attrib/gattrib.c attrib/client.h \
 		attrib/client.c attrib/gatt-service.h attrib/gatt-service.c
 
-- 
1.7.5.4

