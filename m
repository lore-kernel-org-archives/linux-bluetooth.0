Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 12/13] build: Add heartrate soletta node type to the build system
Date: Thu,  2 Jul 2015 11:33:53 -0300
Message-Id: <1435847634-22831-13-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 1899fcb..9b330cb 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -73,6 +73,26 @@ peripheral_btsensor_SOURCES = peripheral/main.c \
 peripheral_btsensor_LDADD = src/libshared-mainloop.la \
 				lib/libbluetooth-internal.la
 
+if SOLETTA
+soletta_descdir = @SOLETTA_DESCDIR@/flow/descriptions/
+soletta_desc_DATA = soletta/heartrate.json
+solettamodulesdir = @SOLETTA_MODULESDIR@/flow
+solettamodules_LTLIBRARIES = soletta/heartrate.la
+soletta_heartrate_la_SOURCES = soletta/heartrate.c peripheral/gap.h peripheral/gap.c \
+				peripheral/gatt.h peripheral/gatt.c
+soletta_heartrate_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
+soletta_heartrate_la_LIBADD = src/libshared-soletta.la \
+			lib/libbluetooth-internal.la \
+			@SOLETTA_LIBS@
+soletta_heartrate_la_CFLAGS = $(AM_CFLAGS) @SOLETTA_CFLAGS@ -DSOL_FLOW_NODE_TYPE_MODULE_EXTERNAL
+
+soletta/%-gen.c soletta/%-gen.h: soletta/heartrate-src.json
+		$(AM_V_GEN)$(PYTHON) @SOLETTA_PREFIX@/bin/sol-flow-node-type-gen.py $< soletta/$*-gen.h soletta/$*-gen.c soletta/heartrate.json
+
+BUILT_SOURCES += soletta/heartrate-gen.c soletta/heartrate-gen.h
+
+endif
+
 tools_3dsp_SOURCES = tools/3dsp.c monitor/bt.h
 tools_3dsp_LDADD = src/libshared-mainloop.la
 
-- 
2.4.5

