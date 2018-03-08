Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] build: Include Mesh JSON files unconditionally in EXTRA_DIST
Date: Thu,  8 Mar 2018 15:01:13 +0200
Message-Id: <20180308130113.9082-1-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We always want the JSON files to be part of the generated tarball, and
not just when --enable-mesh has been given.
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index c2d81a884e7d..f7ab77de1784 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -32,9 +32,9 @@ mesh_meshctl_SOURCES = mesh/main.c \
 mesh_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
+endif
 
 EXTRA_DIST += mesh/local_node.json mesh/prov_db.json
-endif
 
 if MONITOR
 bin_PROGRAMS += monitor/btmon
-- 
2.14.3

