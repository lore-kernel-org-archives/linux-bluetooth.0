Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add sample JSON files to EXTRA_DIST
Date: Mon,  5 Mar 2018 12:08:21 -0800
Message-Id: <20180305200821.21546-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds mesh/local_node.json and mesh/prov_db.json samples
to be included with dist tarball.
---
 Makefile.tools | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 71d083e71..c2d81a884 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -32,6 +32,8 @@ mesh_meshctl_SOURCES = mesh/main.c \
 mesh_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				@GLIB_LIBS@ @DBUS_LIBS@ -ljson-c -lreadline
+
+EXTRA_DIST += mesh/local_node.json mesh/prov_db.json
 endif
 
 if MONITOR
-- 
2.13.6

