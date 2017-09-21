Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] shared/shell/bt_shell: Add initial implementation
Date: Thu, 21 Sep 2017 13:40:18 -0400
Message-Id: <20170921174021.20154-2-marcin.kraglak@tieto.com>
In-Reply-To: <20170921174021.20154-1-marcin.kraglak@tieto.com>
References: <20170921174021.20154-1-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This module will handle command line in applications like bluetoothctl and meshctl.
---
 src/shared/shell/bt_shell.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/shell/bt_shell.h | 42 +++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 src/shared/shell/bt_shell.c
 create mode 100644 src/shared/shell/bt_shell.h

diff --git a/src/shared/shell/bt_shell.c b/src/shared/shell/bt_shell.c
new file mode 100644
index 000000000..1f3a57e02
--- /dev/null
+++ b/src/shared/shell/bt_shell.c
@@ -0,0 +1,92 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/shell/bt_shell.h"
+
+#define CMD_LENGTH	48
+
+static struct {
+	const struct bt_shell_menu_entry *current;
+} bt_shell_data;
+
+bool bt_shell_init(const struct bt_shell_menu_entry *menu)
+{
+	if (bt_shell_data.current || !menu)
+		return false;
+
+	bt_shell_data.current = menu;
+
+	return true;
+}
+
+void bt_shell_cleanup(void)
+{
+	bt_shell_data.current = NULL;
+}
+
+void bt_shell_process(const char *cmd, const char *arg)
+{
+	const struct bt_shell_menu_entry *entry;
+
+	if (!bt_shell_data.current || !cmd)
+		return;
+
+	for (entry = bt_shell_data.current; entry->cmd; entry++) {
+		if (strcmp(cmd, entry->cmd))
+			continue;
+
+		if (entry->func) {
+			entry->func(arg);
+			return;
+		}
+	}
+
+	if (strcmp(cmd, "help")) {
+		printf("Invalid command\n");
+		return;
+	}
+
+	bt_shell_print_menu();
+}
+
+void bt_shell_print_menu(void)
+{
+	const struct bt_shell_menu_entry *entry;
+
+	if (!bt_shell_data.current)
+		return;
+
+	printf("Available commands:\n");
+	for (entry = bt_shell_data.current; entry->cmd; entry++) {
+		printf("  %s %-*s %s\n", entry->cmd,
+					(int)(CMD_LENGTH - strlen(entry->cmd)),
+					entry->arg ? : "", entry->desc ? : "");
+	}
+}
diff --git a/src/shared/shell/bt_shell.h b/src/shared/shell/bt_shell.h
new file mode 100644
index 000000000..93d7ed771
--- /dev/null
+++ b/src/shared/shell/bt_shell.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+typedef void (*bt_shell_menu_cb_t)(const char *arg);
+typedef char * (*bt_shell_menu_gen_t)(const char *text, int state);
+typedef void (*bt_shell_menu_disp_t) (char **matches, int num_matches,
+							int max_length);
+
+struct bt_shell_menu_entry {
+	const char *cmd;
+	const char *arg;
+	bt_shell_menu_cb_t func;
+	const char *desc;
+	bt_shell_menu_gen_t gen;
+	bt_shell_menu_disp_t disp;
+};
+
+bool bt_shell_init(const struct bt_shell_menu_entry *menu);
+void bt_shell_cleanup(void);
+
+void bt_shell_process(const char *cmd, const char *arg);
+void bt_shell_print_menu(void);
-- 
2.13.5

