Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android: Add helper functions for converting bdaddr transmitted over IPC
Date: Mon, 28 Oct 2013 14:45:13 +0100
Message-ID: <1382967914-11102-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android holds Bluetooth address in reverse order comparing to
bluetoothd. Add convenient functions for converting to and from that
format.

Convertion will done on daemon side to keep HAL library simple.
---
 android/utils.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 android/utils.h

diff --git a/android/utils.h b/android/utils.h
new file mode 100644
index 0000000..5b009bc
--- /dev/null
+++ b/android/utils.h
@@ -0,0 +1,33 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+
+static inline void android2bdaddr(const void *buf, bdaddr_t *dst)
+{
+	baswap(dst, buf);
+}
+
+static inline void bdaddr2android(const bdaddr_t *src, void *buf)
+{
+	baswap(buf, src);
+}
-- 
1.8.4.1

