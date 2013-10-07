Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 08/15] android: Add adapter and device struct for BlueZ daemon
Date: Mon,  7 Oct 2013 10:38:09 +0300
Message-Id: <1381131496-9417-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adapter structure in BlueZ daemon keeps track of default adapter
and device structure keeps track about found devices.
---
 android/bt_adapter.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++
 android/bt_adapter.h |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 android/bt_adapter.c
 create mode 100644 android/bt_adapter.h

diff --git a/android/bt_adapter.c b/android/bt_adapter.c
new file mode 100644
index 0000000..e21d50c
--- /dev/null
+++ b/android/bt_adapter.c
@@ -0,0 +1,56 @@
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
+#include "bt_adapter.h"
+#include "log.h"
+#include "src/shared/mgmt.h"
+
+struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
+{
+	struct bt_adapter *adapter;
+
+	adapter = g_try_new0(struct bt_adapter, 1);
+	if (!adapter)
+		return NULL;
+
+	adapter->dev_id = index;
+	adapter->mgmt = mgmt_ref(mgmt_if);
+
+	return adapter;
+}
+
+void adapter_start(struct bt_adapter *adapter)
+{
+	DBG("enabled %u", adapter->dev_id);
+
+	/* TODO: CB: report scan mode */
+
+	/* TODO: SDP start here */
+
+	/* TODO: CB: report state on */
+}
+
+void adapter_stop(struct bt_adapter *adapter)
+{
+	DBG("disabled %u", adapter->dev_id);
+}
diff --git a/android/bt_adapter.h b/android/bt_adapter.h
new file mode 100644
index 0000000..6877cc7
--- /dev/null
+++ b/android/bt_adapter.h
@@ -0,0 +1,60 @@
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
+struct bt_device {
+	int refcnt;
+
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+	uint32_t cod;
+	char *name;
+};
+
+struct bt_adapter {
+	int refcnt;
+
+	uint16_t dev_id;
+	struct mgmt *mgmt;
+	bdaddr_t bdaddr;
+	uint32_t dev_class;
+
+	char *name;
+	char *short_name;
+
+	uint32_t supported_settings;
+	uint32_t current_settings;
+
+	GList *found_devices;
+};
+
+struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if);
+
+void adapter_start(struct bt_adapter *adapter);
+void adapter_stop(struct bt_adapter *adapter);
-- 
1.7.10.4

