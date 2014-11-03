Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v2 1/6] monitor/rfcomm: Add RFCOMM support to btmon
Date: Mon, 03 Nov 2014 20:55:18 +0530
Message-id: <1415028323-13861-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1415028323-13861-1-git-send-email-gowtham.ab@samsung.com>
References: <1415028323-13861-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to add initial code to support RFCOMM frame in btmon
---
 Makefile.tools     |  1 +
 android/Android.mk |  1 +
 monitor/l2cap.c    |  4 ++++
 monitor/l2cap.h    |  1 +
 monitor/rfcomm.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+)
 create mode 100644 monitor/rfcomm.c

diff --git a/Makefile.tools b/Makefile.tools
index 42cccc6..75a6faa 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -26,6 +26,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/l2cap.h monitor/l2cap.c \
 				monitor/sdp.h monitor/sdp.c \
 				monitor/avctp.h monitor/avctp.c \
+				monitor/rfcomm.h monitor/rfcomm.c \
 				monitor/uuid.h monitor/uuid.c \
 				monitor/hwdb.h monitor/hwdb.c \
 				monitor/keys.h monitor/keys.c \
diff --git a/android/Android.mk b/android/Android.mk
index aefe41c..eebd863 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -289,6 +289,7 @@ LOCAL_SRC_FILES := \
 	bluez/monitor/packet.c \
 	bluez/monitor/l2cap.c \
 	bluez/monitor/avctp.c \
+	bluez/monitor/rfcomm.c \
 	bluez/monitor/uuid.c \
 	bluez/monitor/sdp.c \
 	bluez/monitor/vendor.c \
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index c004d6b..ebdd20f 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -42,6 +42,7 @@
 #include "keys.h"
 #include "sdp.h"
 #include "avctp.h"
+#include "rfcomm.h"
 
 #define MAX_CHAN 64
 
@@ -2643,6 +2644,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 		case 0x0001:
 			sdp_packet(&frame);
 			break;
+		case 0x0003:
+			rfcomm_packet(&frame);
+			break;
 		case 0x001f:
 			att_packet(index, in, handle, cid, data, size);
 			break;
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 5faaea6..1f70b68 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -153,3 +153,4 @@ static inline bool l2cap_frame_get_le64(struct l2cap_frame *frame,
 
 void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 					const void *data, uint16_t size);
+void rfcomm_packet(const struct l2cap_frame *frame);
diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
new file mode 100644
index 0000000..8b7e8ce
--- /dev/null
+++ b/monitor/rfcomm.c
@@ -0,0 +1,61 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2014  Intel Corporation
+ *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <inttypes.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include "src/shared/util.h"
+#include "bt.h"
+#include "packet.h"
+#include "display.h"
+#include "l2cap.h"
+#include "uuid.h"
+#include "keys.h"
+#include "sdp.h"
+#include "rfcomm.h"
+
+const char *opcode_color;
+
+void rfcomm_packet(const struct l2cap_frame *frame)
+{
+	if (frame->in)
+		opcode_color = COLOR_MAGENTA;
+	else
+		opcode_color = COLOR_BLUE;
+
+	print_indent(7, opcode_color, "RFCOMM: ", "",
+							COLOR_OFF, "");
+
+	packet_hexdump(frame->data, frame->size);
+	return;
+}
-- 
1.9.1

