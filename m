Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] Makefile: Add att-database.h to attrib_sources
Date: Wed,  4 Apr 2012 16:55:33 +0200
Message-Id: <1333551333-6113-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

att-database is missing in the dist target.
---
 Makefile.am |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d475555..da6a584 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -108,7 +108,8 @@ endif
 
 attrib_sources = attrib/att.h attrib/att.c attrib/gatt.h attrib/gatt.c \
 		attrib/gattrib.h attrib/gattrib.c attrib/client.h \
-		attrib/client.c attrib/gatt-service.h attrib/gatt-service.c
+		attrib/client.c attrib/gatt-service.h attrib/gatt-service.c \
+		attrib/att-database.h
 
 gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
 					gdbus/object.c gdbus/polkit.c
-- 
1.7.10.rc3.1.gb3065

