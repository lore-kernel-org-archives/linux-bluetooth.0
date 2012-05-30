Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 02/15] audio: Move UUID defintion to core
Date: Wed, 30 May 2012 14:59:55 +0200
Message-Id: <1338382808-29725-3-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am       |    3 ++-
 audio/avctp.c     |    1 +
 audio/avdtp.c     |    1 +
 audio/avrcp.c     |    1 +
 audio/device.h    |   16 ----------------
 audio/manager.c   |    1 +
 audio/media.c     |    1 +
 audio/transport.c |    1 +
 src/uuid.h        |   38 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 46 insertions(+), 17 deletions(-)
 create mode 100644 src/uuid.h

diff --git a/Makefile.am b/Makefile.am
index d223a7a..8d96483 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -304,7 +304,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/event.h src/event.c \
-			src/oob.h src/oob.c src/eir.h src/eir.c
+			src/oob.h src/oob.c src/eir.h src/eir.c \
+			src/uuid.h
 src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
 								-ldl -lrt
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
diff --git a/audio/avctp.c b/audio/avctp.c
index 5f9afa1..5c2b0d0 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -45,6 +45,7 @@
 
 #include "adapter.h"
 #include "../src/device.h"
+#include "../src/uuid.h"
 
 #include "log.h"
 #include "error.h"
diff --git a/audio/avdtp.c b/audio/avdtp.c
index 34d49d2..785ce59 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -47,6 +47,7 @@
 #include "../src/adapter.h"
 #include "../src/manager.h"
 #include "../src/device.h"
+#include "../src/uuid.h"
 
 #include "device.h"
 #include "manager.h"
diff --git a/audio/avrcp.c b/audio/avrcp.c
index a040099..19e0aad 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -47,6 +47,7 @@
 
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "../src/uuid.h"
 
 #include "log.h"
 #include "error.h"
diff --git a/audio/device.h b/audio/device.h
index 5117fca..75f1da9 100644
--- a/audio/device.h
+++ b/audio/device.h
@@ -22,22 +22,6 @@
  *
  */
 
-#define GENERIC_AUDIO_UUID	"00001203-0000-1000-8000-00805f9b34fb"
-
-#define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
-#define HSP_AG_UUID		"00001112-0000-1000-8000-00805f9b34fb"
-
-#define HFP_HS_UUID		"0000111e-0000-1000-8000-00805f9b34fb"
-#define HFP_AG_UUID		"0000111f-0000-1000-8000-00805f9b34fb"
-
-#define ADVANCED_AUDIO_UUID	"0000110d-0000-1000-8000-00805f9b34fb"
-
-#define A2DP_SOURCE_UUID	"0000110a-0000-1000-8000-00805f9b34fb"
-#define A2DP_SINK_UUID		"0000110b-0000-1000-8000-00805f9b34fb"
-
-#define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
-#define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
-
 struct source;
 struct control;
 struct target;
diff --git a/audio/manager.c b/audio/manager.c
index fb7af98..376f563 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -51,6 +51,7 @@
 #include "../src/adapter.h"
 #include "../src/manager.h"
 #include "../src/device.h"
+#include "../src/uuid.h"
 
 #include "log.h"
 #include "ipc.h"
diff --git a/audio/media.c b/audio/media.c
index 2a2cf37..99548ae 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -34,6 +34,7 @@
 
 #include "../src/adapter.h"
 #include "../src/dbus-common.h"
+#include "../src/uuid.h"
 
 #include "glib-helper.h"
 #include "log.h"
diff --git a/audio/transport.c b/audio/transport.c
index 4273282..cc5bc16 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -33,6 +33,7 @@
 
 #include "../src/adapter.h"
 #include "../src/dbus-common.h"
+#include "../src/uuid.h"
 
 #include "log.h"
 #include "error.h"
diff --git a/src/uuid.h b/src/uuid.h
new file mode 100644
index 0000000..8aecec5
--- /dev/null
+++ b/src/uuid.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  BMW Car IT GmbH. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define GENERIC_AUDIO_UUID	"00001203-0000-1000-8000-00805f9b34fb"
+
+#define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
+#define HSP_AG_UUID		"00001112-0000-1000-8000-00805f9b34fb"
+
+#define HFP_HS_UUID		"0000111e-0000-1000-8000-00805f9b34fb"
+#define HFP_AG_UUID		"0000111f-0000-1000-8000-00805f9b34fb"
+
+#define ADVANCED_AUDIO_UUID	"0000110d-0000-1000-8000-00805f9b34fb"
+
+#define A2DP_SOURCE_UUID	"0000110a-0000-1000-8000-00805f9b34fb"
+#define A2DP_SINK_UUID		"0000110b-0000-1000-8000-00805f9b34fb"
+
+#define AVRCP_REMOTE_UUID	"0000110e-0000-1000-8000-00805f9b34fb"
+#define AVRCP_TARGET_UUID	"0000110c-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

