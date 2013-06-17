Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] obexd: Add MAP notification dispatching
Date: Mon, 17 Jun 2013 10:35:27 +0200
Message-Id: <1371458131-2741-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The MAP specification allows to reuse one MNS server instance for all
local MAS client instances. This dispatching of event reports to the
correct MAS client instance is done by the MAS instance id and the
device address.

The dispatcher component allows MAS client instances to register a
notification handler. Events reports are forwarded by the MNS server using
mns_dispatch_notification.
---
 obexd/client/map-event.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 obexd/client/map-event.h |  29 ++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 obexd/client/map-event.c

diff --git a/obexd/client/map-event.c b/obexd/client/map-event.c
new file mode 100644
index 0000000..6d64bbd
--- /dev/null
+++ b/obexd/client/map-event.c
@@ -0,0 +1,112 @@
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
+#include "map-event.h"
+
+#include <gdbus/gdbus.h>
+#include "transfer.h"
+#include "session.h"
+
+static GSList *mappings;
+
+struct mns_mapping {
+	int mas_instance_id;
+	struct obc_session *session;
+	map_handle_notification_func handler;
+	void *user_data;
+};
+
+gboolean map_register_event_handler(struct obc_session *session,
+					int mas_instance_id,
+					map_handle_notification_func handler,
+					void *user_data)
+{
+	struct mns_mapping *mapping;
+
+	if (!session || !obc_session_get_destination(session)) {
+		DBG("Cannot add MAP MNS mapping");
+		return FALSE;
+	}
+
+	mapping = g_try_new0(struct mns_mapping, 1);
+	if (mapping == NULL)
+		return FALSE;
+
+	mapping->mas_instance_id = mas_instance_id;
+	mapping->session = session;
+	mapping->handler = handler;
+	mapping->user_data = user_data;
+
+	mappings = g_slist_append(mappings, mapping);
+	DBG("Added MAP MNS mapping %s:%d", obc_session_get_destination(session),
+		mas_instance_id);
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
+				!g_ascii_strcasecmp(
+					obc_session_get_destination(
+						mapping->session), device))
+			return mapping;
+	}
+
+	DBG("Cannot find MAP MNS mapping %s:%d", device, mas_instance_id);
+	return NULL;
+}
+
+void map_unregister_event_handler(struct obc_session *session,
+							int mas_instance_id)
+{
+	struct mns_mapping *mapping;
+
+	mapping = find_mapping(mas_instance_id,
+					obc_session_get_destination(session));
+	if (mapping) {
+		mappings = g_slist_remove(mappings, mapping);
+		DBG("Removed MAP MNS mapping %s:%d",
+			obc_session_get_destination(session), mas_instance_id);
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
diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
index 749f1e0..6fab6e3 100644
--- a/obexd/client/map-event.h
+++ b/obexd/client/map-event.h
@@ -21,6 +21,8 @@
  *
  */
 
+struct obc_session;
+
 enum map_event_type {
 	MAP_ET_NEW_MESSAGE,
 	MAP_ET_DELIVERY_SUCCESS,
@@ -40,3 +42,30 @@ struct map_event {
 	char *old_folder;
 	char *msg_type;
 };
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
+gboolean map_register_event_handler(struct obc_session *session,
+					int mas_instance_id,
+					map_handle_notification_func handler,
+					void *user_data);
+
+/* Unregisters client notification handler callback.
+ */
+void map_unregister_event_handler(struct obc_session *session,
+							int mas_instance_id);
+
+/* Dispatch notification to a registered notification handler callback.
+ */
+void mns_dispatch_notification(int mas_instance_id, const char *device,
+						struct map_event *event);
-- 
1.8.2.3

