Return-Path: <cyrus@holtmann.org>
From: Andre Dieb Martins <andre.dieb@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH -v3 1/6] Partial dump of ATT PDUs
Date: Wed,  9 Feb 2011 14:28:50 -0300
Message-Id: <1297272535-14890-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Starts implementing dumping for ATT/GATT pdus.
---
 Makefile.am     |    1 +
 parser/att.c    |  161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/l2cap.c  |    7 +++
 parser/parser.h |    2 +
 src/hcidump.c   |    1 +
 5 files changed, 172 insertions(+), 0 deletions(-)
 create mode 100644 parser/att.c

diff --git a/Makefile.am b/Makefile.am
index e39ae1e..99dd422 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,6 +5,7 @@ parser_sources =  parser/parser.h parser/parser.c \
 					parser/lmp.c \
 					parser/hci.c \
 					parser/l2cap.c \
+					parser/att.c \
 					parser/sdp.h parser/sdp.c \
 					parser/rfcomm.h parser/rfcomm.c \
 					parser/bnep.c \
diff --git a/parser/att.c b/parser/att.c
new file mode 100644
index 0000000..eb0d00b
--- /dev/null
+++ b/parser/att.c
@@ -0,0 +1,161 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  André Dieb Martins <andre.dieb@gmail.com>
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
+#include <sys/types.h>
+#include <netinet/in.h>
+
+#include "parser.h"
+
+/* Attribute Protocol Opcodes */
+#define ATT_OP_ERROR			0x01
+#define ATT_OP_MTU_REQ			0x02
+#define ATT_OP_MTU_RESP			0x03
+#define ATT_OP_FIND_INFO_REQ		0x04
+#define ATT_OP_FIND_INFO_RESP		0x05
+#define ATT_OP_FIND_BY_TYPE_REQ		0x06
+#define ATT_OP_FIND_BY_TYPE_RESP	0x07
+#define ATT_OP_READ_BY_TYPE_REQ		0x08
+#define ATT_OP_READ_BY_TYPE_RESP	0x09
+#define ATT_OP_READ_REQ			0x0A
+#define ATT_OP_READ_RESP		0x0B
+#define ATT_OP_READ_BLOB_REQ		0x0C
+#define ATT_OP_READ_BLOB_RESP		0x0D
+#define ATT_OP_READ_MULTI_REQ		0x0E
+#define ATT_OP_READ_MULTI_RESP		0x0F
+#define ATT_OP_READ_BY_GROUP_REQ	0x10
+#define ATT_OP_READ_BY_GROUP_RESP	0x11
+#define ATT_OP_WRITE_REQ		0x12
+#define ATT_OP_WRITE_RESP		0x13
+#define ATT_OP_WRITE_CMD		0x52
+#define ATT_OP_PREP_WRITE_REQ		0x16
+#define ATT_OP_PREP_WRITE_RESP		0x17
+#define ATT_OP_EXEC_WRITE_REQ		0x18
+#define ATT_OP_EXEC_WRITE_RESP		0x19
+#define ATT_OP_HANDLE_NOTIFY		0x1B
+#define ATT_OP_HANDLE_IND		0x1D
+#define ATT_OP_HANDLE_CNF		0x1E
+#define ATT_OP_SIGNED_WRITE_CMD		0xD2
+
+
+/* Attribute Protocol Opcodes */
+static const char *attop2str(uint8_t op)
+{
+	switch (op) {
+	case ATT_OP_ERROR:
+		return "Error";
+	case ATT_OP_MTU_REQ:
+		return "MTU req";
+	case ATT_OP_MTU_RESP:
+		return "MTU resp";
+	case ATT_OP_FIND_INFO_REQ:
+		return "Find Information req";
+	case ATT_OP_FIND_INFO_RESP:
+		return "Find Information resp";
+	case ATT_OP_FIND_BY_TYPE_REQ:
+		return "Find By Type req";
+	case ATT_OP_FIND_BY_TYPE_RESP:
+		return "Find By Type resp";
+	case ATT_OP_READ_BY_TYPE_REQ:
+		return "Read By Type req";
+	case ATT_OP_READ_BY_TYPE_RESP:
+		return "Read By Type resp";
+	case ATT_OP_READ_REQ:
+		return "Read req";
+	case ATT_OP_READ_RESP:
+		return "Read resp";
+	case ATT_OP_READ_BLOB_REQ:
+		return "Read Blob req";
+	case ATT_OP_READ_BLOB_RESP:
+		return "Read Blob resp";
+	case ATT_OP_READ_MULTI_REQ:
+		return "Read Multi req";
+	case ATT_OP_READ_MULTI_RESP:
+		return "Read Multi resp";
+	case ATT_OP_READ_BY_GROUP_REQ:
+		return "Read By Group req";
+	case ATT_OP_READ_BY_GROUP_RESP:
+		return "Read By Group resp";
+	case ATT_OP_WRITE_REQ:
+		return "Write req";
+	case ATT_OP_WRITE_RESP:
+		return "Write resp";
+	case ATT_OP_WRITE_CMD:
+		return "Write cmd";
+	case ATT_OP_PREP_WRITE_REQ:
+		return "Prepare Write req";
+	case ATT_OP_PREP_WRITE_RESP:
+		return "Prepare Write resp";
+	case ATT_OP_EXEC_WRITE_REQ:
+		return "Exec Write req";
+	case ATT_OP_EXEC_WRITE_RESP:
+		return "Exec Write resp";
+	case ATT_OP_HANDLE_NOTIFY:
+		return "Handle notify";
+	case ATT_OP_HANDLE_IND:
+		return "Handle indicate";
+	case ATT_OP_HANDLE_CNF:
+		return "Handle CNF";
+	case ATT_OP_SIGNED_WRITE_CMD:
+		return "Signed Write Cmd";
+	default:
+		return "Unknown";
+	}
+}
+
+static void att_handle_notify_dump(int level, struct frame *frm)
+{
+	uint16_t handle = btohs(htons(get_u16(frm)));
+
+	p_indent(level, frm);
+	printf("handle 0x%2.2x\n", handle);
+}
+
+void att_dump(int level, struct frame *frm)
+{
+	uint8_t op;
+
+	op = get_u8(frm);
+
+	p_indent(level, frm);
+	printf("ATT: %s (0x%.2x)\n", attop2str(op), op);
+
+	switch (op) {
+		case ATT_OP_HANDLE_NOTIFY:
+			att_handle_notify_dump(level + 1, frm);
+			break;
+
+		default:
+			raw_dump(level, frm);
+			break;
+	}
+}
diff --git a/parser/l2cap.c b/parser/l2cap.c
index 5c5371f..963468c 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -898,6 +898,13 @@ static void l2cap_parse(int level, struct frame *frm)
 				raw_dump(level + 1, frm);
 			break;
 
+		case 0x1f:
+			if (!p_filter(FILT_ATT))
+				att_dump(level, frm);
+			else
+				raw_dump(level + 1, frm);
+			break;
+
 		default:
 			proto = get_proto(frm->handle, psm, 0);
 
diff --git a/parser/parser.h b/parser/parser.h
index 973ab22..f093b6b 100644
--- a/parser/parser.h
+++ b/parser/parser.h
@@ -77,6 +77,7 @@ struct frame {
 #define FILT_HCRP	0x0200
 #define FILT_AVDTP	0x0400
 #define FILT_AVCTP	0x0800
+#define FILT_ATT 	0x1000
 
 #define FILT_OBEX	0x00010000
 #define FILT_CAPI	0x00020000
@@ -229,6 +230,7 @@ void hidp_dump(int level, struct frame *frm);
 void hcrp_dump(int level, struct frame *frm);
 void avdtp_dump(int level, struct frame *frm);
 void avctp_dump(int level, struct frame *frm);
+void att_dump(int level, struct frame *frm);
 
 void obex_dump(int level, struct frame *frm);
 void capi_dump(int level, struct frame *frm);
diff --git a/src/hcidump.c b/src/hcidump.c
index b344489..af086c7 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -824,6 +824,7 @@ static struct {
 	{ "cmtp",	FILT_CMTP	},
 	{ "hidp",	FILT_HIDP	},
 	{ "hcrp",	FILT_HCRP	},
+	{ "att",	FILT_ATT	},
 	{ "avdtp",	FILT_AVDTP	},
 	{ "avctp",	FILT_AVCTP	},
 	{ "obex",	FILT_OBEX	},
-- 
1.7.1

