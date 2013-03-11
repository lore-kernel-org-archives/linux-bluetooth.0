Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/8] obexd: Add MAP notification dispatcher
Date: Mon, 11 Mar 2013 16:05:48 +0100
Message-Id: <1363014350-16114-7-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The MAP specification allows to reuse one MNS instance for all local
MAS client instances. This dispatching of event reports to the
correct MAS client instance is done by the instance id.

The dispatcher component allows MAP client instances to
register a notification handler (map_aquire_mns).
Events reports are then forwarded by the notification server
using (mns_dispatch_notification).
---
 Makefile.obexd                |  1 +
 obexd/client/map-dispatcher.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 obexd/client/map-dispatcher.h | 47 +++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 obexd/client/map-dispatcher.c
 create mode 100644 obexd/client/map-dispatcher.h

diff --git a/Makefile.obexd b/Makefile.obexd
index 5824e0a..02901a3 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -73,6 +73,7 @@ obexd_src_obexd_SOURCES = $(gdbus_sources) $(btio_sources) $(gobex_sources) \
 			obexd/client/ftp.h obexd/client/ftp.c \
 			obexd/client/opp.h obexd/client/opp.c \
 			obexd/client/map.h obexd/client/map.c \
+			obexd/client/map-dispatcher.h obexd/client/map-dispatcher.c \
 			obexd/client/transfer.h obexd/client/transfer.c \
 			obexd/client/transport.h obexd/client/transport.c \
 			obexd/client/dbus.h obexd/client/dbus.c \
diff --git a/obexd/client/map-dispatcher.c b/obexd/client/map-dispatcher.c
new file mode 100644
index 0000000..911e062
--- /dev/null
+++ b/obexd/client/map-dispatcher.c
@@ -0,0 +1,88 @@
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
+
+#include "log.h"
+#include "map-dispatcher.h"
+
+static GSList *mappings = NULL;
+
+struct mns_mapping {
+	int mas_instance_id;
+	map_handle_notification_func handler;
+	void *user_data;
+};
+
+gboolean map_acquire_mns(int mas_instance_id,
+			map_handle_notification_func handler, void *user_data)
+{
+	struct mns_mapping *mapping;
+
+	mapping = g_try_new0(struct mns_mapping, 1);
+	if (mapping == NULL)
+		return FALSE;
+
+	mapping->mas_instance_id = mas_instance_id;
+	mapping->handler = handler;
+	mapping->user_data = user_data;
+
+	mappings = g_slist_append(mappings, mapping);
+	DBG("Added MAP MNS mapping for instance %d", mas_instance_id);
+
+	return TRUE;
+}
+
+static struct mns_mapping *find_mapping(int mas_instance_id)
+{
+	GSList *list;
+
+	for (list = mappings; list; list = list->next) {
+		struct mns_mapping *mapping = list->data;
+		if (mapping->mas_instance_id == mas_instance_id)
+			return mapping;
+	}
+
+	DBG("Cannot find MAP MNS mapping for instance %d", mas_instance_id);
+	return NULL;
+}
+
+void map_release_mns(int mas_instance_id)
+{
+	struct mns_mapping *mapping = find_mapping(mas_instance_id);
+	if (mapping) {
+		mappings = g_slist_remove(mappings, mapping);
+		DBG("Removed MAP MNS mapping for instance %d", mas_instance_id);
+	}
+}
+
+void mns_dispatch_notification(int mas_instance_id, struct map_event *event)
+{
+	struct mns_mapping *mapping = find_mapping(mas_instance_id);
+	if (mapping)
+		mapping->handler(event, mapping->user_data);
+}
diff --git a/obexd/client/map-dispatcher.h b/obexd/client/map-dispatcher.h
new file mode 100644
index 0000000..3664e01
--- /dev/null
+++ b/obexd/client/map-dispatcher.h
@@ -0,0 +1,47 @@
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
+ * addressed to the given mas instance id.
+ */
+gboolean map_acquire_mns(int mas_instance_id, map_handle_notification_func,
+							void *user_data);
+
+/* Unregisters client notification handler callback.
+ */
+void map_release_mns(int mas_instance_id);
+
+/* Dispatch notification to a registered notification handler callback.
+ */
+void mns_dispatch_notification(int mas_instance_id, struct map_event *event);
-- 
1.8.1.5

