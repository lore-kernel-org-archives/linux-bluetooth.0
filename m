Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] obexd: Add MAP notification dispatcher
Date: Tue,  9 Apr 2013 13:55:21 +0200
Message-Id: <1365508525-13251-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508525-13251-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508525-13251-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The MAP specification allows to reuse one MNS server instance for all
local MAS client instances. This dispatching of event reports to the
correct MAS client instance is done by the MAS instance id and the
device address.

The dispatcher component allows MAS client instances to register a
notification handler (map_aquire_mns). Events reports are forwarded by the
MNS server using (mns_dispatch_notification).
---
 obexd/client/map-dispatcher.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 obexd/client/map-dispatcher.h |  48 ++++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 obexd/client/map-dispatcher.c
 create mode 100644 obexd/client/map-dispatcher.h

diff --git a/obexd/client/map-dispatcher.c b/obexd/client/map-dispatcher.c
new file mode 100644
index 0000000..f41bd91
--- /dev/null
+++ b/obexd/client/map-dispatcher.c
@@ -0,0 +1,101 @@
+/*
+ *
+ *  OBEX
+ *
+ *  Copyright (C) 2013  BMW Car IT GmbH. All rights reserved.
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
+#include <glib.h>
+#include <string.h>
+
+#include "log.h"
+#include "map-dispatcher.h"
+
+static GSList *mappings = NULL;
+
+struct mns_mapping {
+	int mas_instance_id;
+	char *device;
+	map_handle_notification_func handler;
+	void *user_data;
+};
+
+gboolean map_acquire_mns(int mas_instance_id, const char *device,
+			map_handle_notification_func handler, void *user_data)
+{
+	struct mns_mapping *mapping;
+
+	if (!device || strlen(device) == 0) {
+		DBG("Cannot add MAP MNS mapping for unknown device");
+		return FALSE;
+	}
+
+	mapping = g_try_new0(struct mns_mapping, 1);
+	if (mapping == NULL)
+		return FALSE;
+
+	mapping->mas_instance_id = mas_instance_id;
+	mapping->device = g_strdup(device);
+	mapping->handler = handler;
+	mapping->user_data = user_data;
+
+	mappings = g_slist_append(mappings, mapping);
+	DBG("Added MAP MNS mapping %s:%d", device, mas_instance_id);
+
+	return TRUE;
+}
+
+static struct mns_mapping *find_mapping(int mas_instance_id, const char *device)
+{
+	GSList *list;
+
+	for (list = mappings; list; list = list->next) {
+		struct mns_mapping *mapping = list->data;
+		if (mapping->mas_instance_id == mas_instance_id &&
+				!g_ascii_strcasecmp(mapping->device, device))
+			return mapping;
+	}
+
+	DBG("Cannot find MAP MNS mapping %s:%d", device, mas_instance_id);
+	return NULL;
+}
+
+void map_release_mns(int mas_instance_id, const char *device)
+{
+	struct mns_mapping *mapping;
+
+	mapping = find_mapping(mas_instance_id, device);
+	if (mapping) {
+		mappings = g_slist_remove(mappings, mapping);
+		g_free(mapping->device);
+		DBG("Removed MAP MNS mapping %s:%d", device, mas_instance_id);
+	}
+}
+
+void mns_dispatch_notification(int mas_instance_id, const char *device,
+							struct map_event *event)
+{
+	struct mns_mapping *mapping = find_mapping(mas_instance_id, device);
+	if (mapping)
+		mapping->handler(event, mapping->user_data);
+}
diff --git a/obexd/client/map-dispatcher.h b/obexd/client/map-dispatcher.h
new file mode 100644
index 0000000..00e9e03
--- /dev/null
+++ b/obexd/client/map-dispatcher.h
@@ -0,0 +1,48 @@
+/*
+ *
+ *  OBEX
+ *
+ *  Copyright (C) 2013  BMW Car IT GmbH. All rights reserved.
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
+#include "map-event.h"
+
+/* Handle notification in map client.
+ *
+ * event: Event report.
+ *
+ * Callback shall be called for every received event.
+ */
+typedef void (*map_handle_notification_func)(struct map_event *event,
+							void *user_data);
+
+/* Registers client notification handler callback for events that are
+ * addressed to the given mas instance id for the given device.
+ */
+gboolean map_acquire_mns(int mas_instance_id, const char *device,
+				map_handle_notification_func, void *user_data);
+
+/* Unregisters client notification handler callback.
+ */
+void map_release_mns(int mas_instance_id, const char *device);
+
+/* Dispatch notification to a registered notification handler callback.
+ */
+void mns_dispatch_notification(int mas_instance_id, const char *device,
+						struct map_event *event);
-- 
1.8.2.1

