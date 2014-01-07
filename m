Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/5] monitor: Add rfcomm.h to tree
Date: Tue,  7 Jan 2014 11:59:12 +0100
Message-Id: <1389092354-32544-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389092354-32544-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389092354-32544-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add initial rfcomm structs and defines to rfcomm.h.
---
 monitor/rfcomm.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 monitor/rfcomm.h

diff --git a/monitor/rfcomm.h b/monitor/rfcomm.h
new file mode 100644
index 0000000..02a1256
--- /dev/null
+++ b/monitor/rfcomm.h
@@ -0,0 +1,47 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013 Intel Corporation
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
+#define RFCOMM_SABM	0x2f
+#define RFCOMM_DISC	0x43
+#define RFCOMM_UA	0x63
+#define RFCOMM_DM	0x0f
+#define RFCOMM_UIH	0xef
+
+#define RFCOMM_GET_TYPE(control)	((control) & 0xef)
+#define RFCOMM_GET_DLCI(address)	((address & 0xfc) >> 2)
+#define RFCOMM_GET_CHANNEL(address)	((address & 0xf8) >> 3)
+#define RFCOMM_GET_DIR(address)	((address & 0x04) >> 2)
+#define RFCOMM_TEST_EA(length)	((length & 0x01))
+
+struct rfcomm_hdr {
+	uint8_t address;
+	uint8_t control;
+	uint8_t length;
+} __attribute__((packed));
+
+struct rfcomm_cmd {
+	uint8_t address;
+	uint8_t control;
+	uint8_t length;
+	uint8_t fcs;
+} __attribute__((packed));
-- 
1.8.3.1

