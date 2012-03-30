Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <lukasz.rymanowski@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCHv2 hcidump 1/3] Add basic SAP parsing
Date: Fri, 30 Mar 2012 14:24:36 +0200
Message-ID: <1333110278-9230-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1333110278-9230-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1333110278-9230-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am     |    1 +
 parser/parser.h |    2 +
 parser/rfcomm.c |    7 ++++
 parser/sap.c    |  123 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/hcidump.c   |    1 +
 5 files changed, 134 insertions(+)
 create mode 100644 parser/sap.c

diff --git a/Makefile.am b/Makefile.am
index b0aaf79..80d04e8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -19,6 +19,7 @@ parser_sources =  parser/parser.h parser/parser.c \
 					parser/avdtp.c \
 					parser/avctp.c \
 					parser/avrcp.c \
+					parser/sap.c \
 					parser/obex.c \
 					parser/capi.c \
 					parser/ppp.c \
diff --git a/parser/parser.h b/parser/parser.h
index 22d18c3..1130a5f 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -85,6 +85,7 @@ struct frame {
 #define FILT_OBEX	0x00010000
 #define FILT_CAPI	0x00020000
 #define FILT_PPP	0x00040000
+#define FILT_SAP	0x00080000
 #define FILT_ERICSSON	0x10000000
 #define FILT_CSR	0x1000000a
 #define FILT_DGA	0x1000000c
@@ -236,6 +237,7 @@ void avctp_dump(int level, struct frame *frm);
 void avrcp_dump(int level, struct frame *frm);
 void att_dump(int level, struct frame *frm);
 void smp_dump(int level, struct frame *frm);
+void sap_dump(int level, struct frame *frm);
 
 void obex_dump(int level, struct frame *frm);
 void capi_dump(int level, struct frame *frm);
diff --git a/parser/rfcomm.c b/parser/rfcomm.c
index 258fb8b..51d7c5f 100644
--- a/parser/rfcomm.c
+++ b/parser/rfcomm.c
@@ -281,6 +281,13 @@ static inline void uih_frame(int level, struct frame *frm, long_frame_head *head
 					raw_dump(level, frm);
 				break;
 
+			case SDP_UUID_SIM_ACCESS:
+				if (!p_filter(FILT_SAP))
+					sap_dump(level + 1, frm);
+				else
+					raw_dump(level, frm);
+				break;
+
 			default:
 				if (p_filter(FILT_RFCOMM))
 					break;
diff --git a/parser/sap.c b/parser/sap.c
new file mode 100644
index 0000000..d463719
--- /dev/null
+++ b/parser/sap.c
@@ -0,0 +1,123 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Tieto Poland
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "parser.h"
+
+#define SAP_CONNECT_REQ				0x00
+#define SAP_CONNECT_RESP			0x01
+#define SAP_DISCONNECT_REQ			0x02
+#define SAP_DISCONNECT_RESP			0x03
+#define SAP_DISCONNECT_IND			0x04
+#define SAP_TRANSFER_APDU_REQ			0x05
+#define SAP_TRANSFER_APDU_RESP			0x06
+#define SAP_TRANSFER_ATR_REQ			0x07
+#define SAP_TRANSFER_ATR_RESP			0x08
+#define SAP_POWER_SIM_OFF_REQ			0x09
+#define SAP_POWER_SIM_OFF_RESP			0x0A
+#define SAP_POWER_SIM_ON_REQ			0x0B
+#define SAP_POWER_SIM_ON_RESP			0x0C
+#define SAP_RESET_SIM_REQ			0x0D
+#define SAP_RESET_SIM_RESP			0x0E
+#define SAP_TRANSFER_CARD_READER_STATUS_REQ	0x0F
+#define SAP_TRANSFER_CARD_READER_STATUS_RESP	0x10
+#define SAP_STATUS_IND				0x11
+#define SAP_ERROR_RESP				0x12
+#define SAP_SET_TRANSPORT_PROTOCOL_REQ		0x13
+#define SAP_SET_TRANSPORT_PROTOCOL_RESP		0x14
+
+static const char *msg2str(uint8_t msg)
+{
+	switch (msg) {
+	case SAP_CONNECT_REQ:
+		return "Connect Req";
+	case SAP_CONNECT_RESP:
+		return "Connect Resp";
+	case SAP_DISCONNECT_REQ:
+		return "Disconnect Req";
+	case SAP_DISCONNECT_RESP:
+		return "Disconnect Resp";
+	case SAP_DISCONNECT_IND:
+		return "Disconnect Ind";
+	case SAP_TRANSFER_APDU_REQ:
+		return "Transfer APDU Req";
+	case SAP_TRANSFER_APDU_RESP:
+		return "Transfer APDU Resp";
+	case SAP_TRANSFER_ATR_REQ:
+		return "Transfer ATR Req";
+	case SAP_TRANSFER_ATR_RESP:
+		return "Transfer ATR Resp";
+	case SAP_POWER_SIM_OFF_REQ:
+		return "Power SIM Off Req";
+	case SAP_POWER_SIM_OFF_RESP:
+		return "Power SIM Off Resp";
+	case SAP_POWER_SIM_ON_REQ:
+		return "Power SIM On Req";
+	case SAP_POWER_SIM_ON_RESP:
+		return "Power SIM On Resp";
+	case SAP_RESET_SIM_REQ:
+		return "Reset SIM Req";
+	case SAP_RESET_SIM_RESP:
+		return "Reset SIM Resp";
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		return "Transfer Card Reader Status Req";
+	case SAP_TRANSFER_CARD_READER_STATUS_RESP:
+		return "Transfer Card Reader Status Resp";
+	case SAP_STATUS_IND:
+		return "Status Ind";
+	case SAP_ERROR_RESP:
+		return "Error Resp";
+	case SAP_SET_TRANSPORT_PROTOCOL_REQ:
+		return "Set Transport Protocol Req";
+	case SAP_SET_TRANSPORT_PROTOCOL_RESP:
+		return "Set Transport Protocol Resp";
+	default:
+		return "Reserved";
+	}
+}
+
+void sap_dump(int level, struct frame *frm)
+{
+	uint8_t msg, params;
+
+	msg = get_u8(frm);
+	params = get_u8(frm);
+
+	/* Skip reserved field */
+	get_u16(frm);
+
+	p_indent(level, frm);
+
+	printf("SAP: %s: params %d\n", msg2str(msg), params);
+
+	raw_dump(level, frm);
+}
diff --git a/src/hcidump.c b/src/hcidump.c
index eedc885..089bff8 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -816,6 +816,7 @@ static struct {
 	{ "obex",	FILT_OBEX	},
 	{ "capi",	FILT_CAPI	},
 	{ "ppp",	FILT_PPP	},
+	{ "sap",	FILT_SAP	},
 	{ "csr",	FILT_CSR	},
 	{ "dga",	FILT_DGA	},
 	{ 0 }
-- 
1.7.9.4

