Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v1 2/3] serial: Add DUN_GW_UUID
Date: Thu, 24 May 2012 12:00:17 +0200
Message-Id: <1337853618-7261-3-git-send-email-wagi@monom.org>
In-Reply-To: <1337853618-7261-1-git-send-email-wagi@monom.org>
References: <1337853618-7261-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 serial/common.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 serial/common.h

diff --git a/serial/common.h b/serial/common.h
new file mode 100644
index 0000000..429bf65
--- /dev/null
+++ b/serial/common.h
@@ -0,0 +1,24 @@
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
+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

