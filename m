Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 12/15] build: Add heartrate soletta node type to the build system
Date: Tue, 21 Jul 2015 20:16:45 -0300
Message-Id: <1437520608-22444-13-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Makefile.tools b/Makefile.tools
index 1899fcb..4e5d645 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -73,6 +73,26 @@ peripheral_btsensor_SOURCES = peripheral/main.c \
 peripheral_btsensor_LDADD = src/libshared-mainloop.la \
 				lib/libbluetooth-internal.la
 
+if SOLETTA
+soletta_descdir = @SOLETTA_DESCDIR@/flow/descriptions/
+soletta_desc_DATA = peripheral/soletta/heartrate.json
+solettamodulesdir = @SOLETTA_MODULESDIR@/flow
+solettamodules_LTLIBRARIES = peripheral/soletta/heartrate.la
+peripheral_soletta_heartrate_la_SOURCES = peripheral/soletta/heartrate.c peripheral/gap.h peripheral/gap.c \
+				peripheral/gatt.h peripheral/gatt.c
+peripheral_soletta_heartrate_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
+peripheral_soletta_heartrate_la_LIBADD = src/libshared-soletta.la \
+			lib/libbluetooth-internal.la \
+			@SOLETTA_LIBS@
+peripheral_soletta_heartrate_la_CFLAGS = $(AM_CFLAGS) @SOLETTA_CFLAGS@ -DSOL_FLOW_NODE_TYPE_MODULE_EXTERNAL
+
+peripheral/soletta/%-gen.c peripheral/soletta/%-gen.h: peripheral/soletta/heartrate-genspec.json
+		$(AM_V_GEN)$(PYTHON) @SOLETTA_PREFIX@/bin/sol-flow-node-type-gen.py $< peripheral/soletta/$*-gen.h peripheral/soletta/$*-gen.c peripheral/soletta/heartrate.json
+
+BUILT_SOURCES += peripheral/soletta/heartrate-gen.c peripheral/soletta/heartrate-gen.h
+
+endif
+
 tools_3dsp_SOURCES = tools/3dsp.c monitor/bt.h
 tools_3dsp_LDADD = src/libshared-mainloop.la
 
-- 
2.4.6

