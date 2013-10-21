Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 07/11] android: Add main_quit function
Date: Mon, 21 Oct 2013 20:56:47 +0200
Message-Id: <1382381811-28123-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to stop mainloop from outside of main.c.
---
 android/main.c |  6 ++++++
 android/main.h | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 android/main.h

diff --git a/android/main.c b/android/main.c
index b24451e..04e8a48 100644
--- a/android/main.c
+++ b/android/main.c
@@ -48,6 +48,7 @@
 
 #include "adapter.h"
 #include "hal-msg.h"
+#include "main.h"
 
 static GMainLoop *event_loop;
 static struct mgmt *mgmt_if = NULL;
@@ -418,6 +419,11 @@ static void cleanup_hal_connection(void)
 	}
 }
 
+void main_quit(void)
+{
+	g_main_loop_quit(event_loop);
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
diff --git a/android/main.h b/android/main.h
new file mode 100644
index 0000000..4aa2557
--- /dev/null
+++ b/android/main.h
@@ -0,0 +1,24 @@
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
+void main_quit(void);
-- 
1.8.4

