Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 02/22] monitor/avdtp: Add basic decoding of AVDTP signalling
Date: Sun, 22 Nov 2015 21:20:14 +0100
Message-Id: <1448223634-23305-3-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

< ACL Data TX: Handle 256 flags 0x00 dlen 6
      Channel: 258 len 2 [PSM 25 mode 0] {chan 2}
      AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> ACL Data RX: Handle 256 flags 0x02 dlen 14
      Channel: 66 len 10 [PSM 25 mode 0] {chan 2}
      AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
        04 08 14 08 0c 08 08 08                          ........
---
 Makefile.tools     |   1 +
 android/Android.mk |   1 +
 monitor/avdtp.c    | 192 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/avdtp.h    |  24 +++++++
 monitor/l2cap.c    |   4 ++
 5 files changed, 222 insertions(+)
 create mode 100644 monitor/avdtp.c
 create mode 100644 monitor/avdtp.h

diff --git a/Makefile.tools b/Makefile.tools
index 6ebbe9f..8555a6b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -27,6 +27,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/l2cap.h monitor/l2cap.c \
 				monitor/sdp.h monitor/sdp.c \
 				monitor/avctp.h monitor/avctp.c \
+				monitor/avdtp.h monitor/avdtp.c \
 				monitor/rfcomm.h monitor/rfcomm.c \
 				monitor/bnep.h monitor/bnep.c \
 				monitor/uuid.h monitor/uuid.c \
diff --git a/android/Android.mk b/android/Android.mk
index 694a94e..fa1188b 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -339,6 +339,7 @@ LOCAL_SRC_FILES := \
 	bluez/monitor/packet.c \
 	bluez/monitor/l2cap.c \
 	bluez/monitor/avctp.c \
+	bluez/monitor/avdtp.c \
 	bluez/monitor/rfcomm.c \
 	bluez/monitor/bnep.c \
 	bluez/monitor/uuid.c \
diff --git a/monitor/avdtp.c b/monitor/avdtp.c
new file mode 100644
index 0000000..9d324bc
--- /dev/null
+++ b/monitor/avdtp.c
@@ -0,0 +1,192 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
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
+
+#include "lib/bluetooth.h"
+
+#include "src/shared/util.h"
+#include "bt.h"
+#include "packet.h"
+#include "display.h"
+#include "l2cap.h"
+#include "avdtp.h"
+
+/* Signal Identifiers */
+#define AVDTP_DISCOVER			0x01
+#define AVDTP_GET_CAPABILITIES		0x02
+#define AVDTP_SET_CONFIGURATION		0x03
+#define AVDTP_GET_CONFIGURATION		0x04
+#define AVDTP_RECONFIGURE		0x05
+#define AVDTP_OPEN			0x06
+#define AVDTP_START			0x07
+#define AVDTP_CLOSE			0x08
+#define AVDTP_SUSPEND			0x09
+#define AVDTP_ABORT			0x0a
+#define AVDTP_SECURITY_CONTROL		0x0b
+#define AVDTP_GET_ALL_CAPABILITIES	0x0c
+#define AVDTP_DELAYREPORT		0x0d
+
+struct avdtp_frame {
+	uint8_t hdr;
+	uint8_t sig_id;
+	struct l2cap_frame l2cap_frame;
+};
+
+static const char *msgtype2str(uint8_t msgtype)
+{
+	switch (msgtype) {
+	case 0:
+		return "Command";
+	case 1:
+		return "General Reject";
+	case 2:
+		return "Response Accept";
+	case 3:
+		return "Response Reject";
+	}
+
+	return "";
+}
+
+static const char *sigid2str(uint8_t sigid)
+{
+	switch (sigid) {
+	case AVDTP_DISCOVER:
+		return "Discover";
+	case AVDTP_GET_CAPABILITIES:
+		return "Get Capabilities";
+	case AVDTP_SET_CONFIGURATION:
+		return "Set Configuration";
+	case AVDTP_GET_CONFIGURATION:
+		return "Get Configuration";
+	case AVDTP_RECONFIGURE:
+		return "Reconfigure";
+	case AVDTP_OPEN:
+		return "Open";
+	case AVDTP_START:
+		return "Start";
+	case AVDTP_CLOSE:
+		return "Close";
+	case AVDTP_SUSPEND:
+		return "Suspend";
+	case AVDTP_ABORT:
+		return "Abort";
+	case AVDTP_SECURITY_CONTROL:
+		return "Security Control";
+	case AVDTP_GET_ALL_CAPABILITIES:
+		return "Get All Capabilities";
+	case AVDTP_DELAYREPORT:
+		return "Delay Report";
+	default:
+		return "Reserved";
+	}
+}
+
+static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
+{
+	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
+	const char *pdu_color;
+	uint8_t hdr;
+	uint8_t sig_id;
+	uint8_t nosp = 0;
+
+	if (frame->in)
+		pdu_color = COLOR_MAGENTA;
+	else
+		pdu_color = COLOR_BLUE;
+
+	if (!l2cap_frame_get_u8(frame, &hdr))
+		return false;
+
+	avdtp_frame->hdr = hdr;
+
+	/* Continue Packet || End Packet */
+	if (((hdr & 0x0c) == 0x08) || ((hdr & 0x0c) == 0x0c)) {
+		/* TODO: handle fragmentation */
+		packet_hexdump(frame->data, frame->size);
+		return true;
+	}
+
+	/* Start Packet */
+	if ((hdr & 0x0c) == 0x04) {
+		if (!l2cap_frame_get_u8(frame, &nosp))
+			return false;
+	}
+
+	if (!l2cap_frame_get_u8(frame, &sig_id))
+		return false;
+
+	sig_id &= 0x3f;
+
+	avdtp_frame->sig_id = sig_id;
+
+	print_indent(6, pdu_color, "AVDTP: ", sigid2str(sig_id), COLOR_OFF,
+			" (0x%02x) %s (0x%02x) type 0x%02x label %d nosp %d",
+			sig_id, msgtype2str(hdr & 0x03), hdr & 0x03,
+			hdr & 0x0c, hdr >> 4, nosp);
+
+	/* Start Packet */
+	if ((hdr & 0x0c) == 0x04) {
+		/* TODO: handle fragmentation */
+		packet_hexdump(frame->data, frame->size);
+		return true;
+	}
+
+	/* General Reject */
+	if ((hdr & 0x03) == 0x03)
+		return true;
+
+	/* TODO: decode signalling messages */
+
+	packet_hexdump(frame->data, frame->size);
+	return true;
+}
+
+void avdtp_packet(const struct l2cap_frame *frame)
+{
+	struct avdtp_frame avdtp_frame;
+	bool ret;
+
+	l2cap_frame_pull(&avdtp_frame.l2cap_frame, frame, 0);
+
+	switch (frame->seq_num) {
+	case 1:
+		ret = avdtp_signalling_packet(&avdtp_frame);
+		break;
+	default:
+		packet_hexdump(frame->data, frame->size);
+		return;
+	}
+
+	if (!ret) {
+		print_text(COLOR_ERROR, "PDU malformed");
+		packet_hexdump(frame->data, frame->size);
+	}
+}
diff --git a/monitor/avdtp.h b/monitor/avdtp.h
new file mode 100644
index 0000000..f77d82e
--- /dev/null
+++ b/monitor/avdtp.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
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
+void avdtp_packet(const struct l2cap_frame *frame);
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 79f7051..93a1b20 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -42,6 +42,7 @@
 #include "keys.h"
 #include "sdp.h"
 #include "avctp.h"
+#include "avdtp.h"
 #include "rfcomm.h"
 #include "bnep.h"
 
@@ -3099,6 +3100,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 		case 0x001B:
 			avctp_packet(&frame);
 			break;
+		case 0x0019:
+			avdtp_packet(&frame);
+			break;
 		default:
 			packet_hexdump(data, size);
 			break;
-- 
2.6.2

