Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/5] android: Add adapter and device struct for BlueZ daemon
Date: Tue, 15 Oct 2013 13:37:01 +0300
Message-Id: <1381833423-862-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adapter structure in BlueZ daemon keeps track of default adapter
and device structure keeps track about found devices.
---
 android/adapter.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/adapter.h |   36 ++++++++++++++++++++++++++++++
 android/device.c  |   29 ++++++++++++++++++++++++
 android/device.h  |   24 ++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 android/adapter.c
 create mode 100644 android/adapter.h
 create mode 100644 android/device.c
 create mode 100644 android/device.h

diff --git a/android/adapter.c b/android/adapter.c
new file mode 100644
index 0000000..b97a7c7
--- /dev/null
+++ b/android/adapter.c
@@ -0,0 +1,63 @@
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
+#include "src/shared/mgmt.h"
+#include "log.h"
+#include "adapter.h"
+
+struct bt_adapter {
+	struct mgmt *mgmt;
+	bdaddr_t bdaddr;
+	uint32_t dev_class;
+
+	char *name;
+
+	uint32_t supported_settings;
+	uint32_t current_settings;
+
+	GList *found_devices;
+};
+
+struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
+{
+	struct bt_adapter *adapter;
+
+	adapter = g_new0(struct bt_adapter, 1);
+
+	adapter->mgmt = mgmt_ref(mgmt_if);
+
+	return adapter;
+}
+
+void bt_adapter_start(struct bt_adapter *adapter)
+{
+	DBG("");
+
+	/* TODO: CB: report scan mode */
+	/* TODO: CB: report state on */
+}
+
+void bt_adapter_stop(struct bt_adapter *adapter)
+{
+	DBG("");
+}
diff --git a/android/adapter.h b/android/adapter.h
new file mode 100644
index 0000000..0f1445a
--- /dev/null
+++ b/android/adapter.h
@@ -0,0 +1,36 @@
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <glib.h>
+
+#include "lib/bluetooth.h"
+
+struct bt_adapter;
+
+struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if);
+
+void bt_adapter_start(struct bt_adapter *adapter);
+void bt_adapter_stop(struct bt_adapter *adapter);
diff --git a/android/device.c b/android/device.c
new file mode 100644
index 0000000..224a317
--- /dev/null
+++ b/android/device.c
@@ -0,0 +1,29 @@
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
+struct bt_device {
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+	uint32_t cod;
+	char *name;
+};
diff --git a/android/device.h b/android/device.h
new file mode 100644
index 0000000..f5b1da6
--- /dev/null
+++ b/android/device.h
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
+struct bt_device;
-- 
1.7.10.4

