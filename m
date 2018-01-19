Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 1/4] lib: Add monitor.h
Date: Fri, 19 Jan 2018 16:37:37 +0100
Message-Id: <20180119153740.4848-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to separate monitor and control channels.
---
 lib/monitor.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 lib/monitor.h

diff --git a/lib/monitor.h b/lib/monitor.h
new file mode 100644
index 000000000..34c3cc7fb
--- /dev/null
+++ b/lib/monitor.h
@@ -0,0 +1,34 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation
+ *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
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
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+#define MONITOR_INDEX_NONE 0xffff
+
+struct monitor_hdr {
+	uint16_t opcode;
+	uint16_t index;
+	uint16_t len;
+} __packed;
-- 
2.14.3

