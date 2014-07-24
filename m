Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, p.sinha@samsung.com, sanjay.nm@samsung.com,
	bharat.panda@samsung.com, vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH] monitor: Add AVCTP support to btmon
Date: Thu, 24 Jul 2014 17:06:41 +0530
Message-id: <1406201801-27715-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVCTP packets added in Bluetooth monitor.
---
 Makefile.tools  |  1 +
 monitor/avctp.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/avctp.h | 25 +++++++++++++++++++
 monitor/l2cap.c |  5 ++++
 4 files changed, 106 insertions(+)
 create mode 100644 monitor/avctp.c
 create mode 100644 monitor/avctp.h

diff --git a/Makefile.tools b/Makefile.tools
index dc9dde9..9226386 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -26,6 +26,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/ll.h monitor/ll.c \
 				monitor/l2cap.h monitor/l2cap.c \
 				monitor/sdp.h monitor/sdp.c \
+				monitor/avctp.h monitor/avctp.c \
 				monitor/uuid.h monitor/uuid.c \
 				monitor/hwdb.h monitor/hwdb.c \
 				monitor/keys.h monitor/keys.c \
diff --git a/monitor/avctp.c b/monitor/avctp.c
new file mode 100644
index 0000000..68a5a56
--- /dev/null
+++ b/monitor/avctp.c
@@ -0,0 +1,75 @@
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
+#include "avctp.h"
+
+void avctp_packet(const struct l2cap_frame *frame, uint16_t psm)
+{
+        uint8_t hdr;
+        uint16_t pid;
+        const char *pdu_color;
+
+        if (frame->size < 3) {
+                print_text(COLOR_ERROR, "frame too short");
+                packet_hexdump(frame->data, frame->size);
+                return;
+        }
+
+        hdr = *((uint8_t *) frame->data);
+
+        pid = get_be16(frame->data + 1);
+
+        if (frame->in)
+                pdu_color = COLOR_MAGENTA;
+        else
+                pdu_color = COLOR_BLUE;
+
+        print_indent(6, pdu_color, "AVCTP", "", COLOR_OFF,
+                        " %s: %s: Packet_type 0x%02x Transaction label %d "
+                        "PID 0x%04x",
+                        psm == 23 ? "Control" : "Browsing",
+                        hdr & 0x02 ? "Response" : "Command",
+                        hdr & 0x0c, hdr >> 4, pid);
+
+	packet_hexdump(frame->data + 3, frame->size - 3);
+}
diff --git a/monitor/avctp.h b/monitor/avctp.h
new file mode 100644
index 0000000..559193e
--- /dev/null
+++ b/monitor/avctp.h
@@ -0,0 +1,25 @@
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
+void avctp_packet(const struct l2cap_frame *frame, uint16_t psm);
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 993aa8b..2752ee4 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -41,6 +41,7 @@
 #include "uuid.h"
 #include "keys.h"
 #include "sdp.h"
+#include "avctp.h"
 
 #define MAX_CHAN 64
 
@@ -2634,6 +2635,10 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 		case 0x001f:
 			att_packet(index, in, handle, cid, data, size);
 			break;
+		case 0x0017:
+		case 0x001B:
+			avctp_packet(&frame, psm);
+			break;
 		default:
 			packet_hexdump(data, size);
 			break;
-- 
1.9.1

