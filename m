Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 7/7] Use entire include path for gobex.h
Date: Wed,  5 Dec 2012 09:22:55 -0200
Message-Id: <1354706575-4718-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 Makefile.obexd          | 7 ++-----
 obexd/client/map.c      | 3 +--
 obexd/client/pbap.c     | 2 +-
 obexd/client/session.c  | 2 +-
 obexd/client/transfer.c | 2 +-
 obexd/plugins/pbap.c    | 2 +-
 obexd/src/manager.c     | 2 +-
 obexd/src/server.c      | 2 +-
 8 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index a895753..e235acc 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -30,9 +30,7 @@ obexd_src_obexd_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 					-fPIC -D_FILE_OFFSET_BITS=64
 
 obexd_src_obexd_CPPFLAGS = -include $(top_builddir)/config.h -I$(builddir)/lib \
-				-I$(builddir)/obexd/src  \
-				-I$(srcdir)/obexd/src \
-				-I$(srcdir)/gobex
+				-I$(builddir)/obexd/src -I$(srcdir)/obexd/src
 
 obexd_src_obexd_SHORTNAME = obexd
 
@@ -78,7 +76,6 @@ obexd_client_obex_client_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 						-fPIC -D_FILE_OFFSET_BITS=64
 
 obexd_client_obex_client_CPPFLAGS = -include $(top_builddir)/config.h \
-				-I$(builddir)/lib -I$(srcdir)/obexd/src \
-				-I$(srcdir)/gobex
+				-I$(builddir)/lib -I$(srcdir)/obexd/src
 
 obexd_client_obex_client_SHORTNAME = obex-client
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 6d7d926..ba33fe2 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -25,8 +25,7 @@
 #include <stdio.h>
 #include <glib.h>
 #include <gdbus/gdbus.h>
-
-#include <gobex-apparam.h>
+#include <gobex/gobex-apparam.h>
 
 #include "dbus.h"
 #include "log.h"
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 00b631a..c9a5e48 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -29,7 +29,7 @@
 #include <gdbus/gdbus.h>
 
 #include <bluetooth/bluetooth.h>
-#include <gobex-apparam.h>
+#include <gobex/gobex-apparam.h>
 
 #include "log.h"
 
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 4ee9d21..2118992 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -32,7 +32,7 @@
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
-#include <gobex.h>
+#include <gobex/gobex.h>
 
 #include "dbus.h"
 #include "log.h"
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 662e087..362419c 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -33,7 +33,7 @@
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
-#include <gobex.h>
+#include <gobex/gobex.h>
 
 #include "dbus.h"
 #include "log.h"
diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 79237b6..e94edae 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -34,7 +34,7 @@
 #include <fcntl.h>
 #include <inttypes.h>
 
-#include <gobex.h>
+#include <gobex/gobex.h>
 #include <gobex-apparam.h>
 
 #include "obexd.h"
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index ccf03ca..ce66e19 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -30,7 +30,7 @@
 #include <inttypes.h>
 
 #include <btio/btio.h>
-#include <gobex.h>
+#include <gobex/gobex.h>
 
 #include "obexd.h"
 #include "obex.h"
diff --git a/obexd/src/server.c b/obexd/src/server.c
index 0b63276..9976bd0 100644
--- a/obexd/src/server.c
+++ b/obexd/src/server.c
@@ -31,7 +31,7 @@
 #include <inttypes.h>
 
 #include <glib.h>
-#include <gobex.h>
+#include <gobex/gobex.h>
 
 #include "log.h"
 #include "obex.h"
-- 
1.8.0.1

