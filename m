Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/6] client: add support for transport drivers
Date: Fri, 20 Jan 2012 11:49:58 +0200
Message-Id: <1327053001-9506-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
References: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am        |    1 +
 client/transport.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/transport.h |   37 +++++++++++++++++++++++
 3 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 client/transport.c
 create mode 100644 client/transport.h

diff --git a/Makefile.am b/Makefile.am
index f65a3dc..32ccc89 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -124,6 +124,7 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/map.h client/map.c \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
+				client/transport.h client/transport.c \
 				client/driver.h client/driver.c \
 				src/map_ap.h src/map_ap.c
 
diff --git a/client/transport.c b/client/transport.c
new file mode 100644
index 0000000..77e52f7
--- /dev/null
+++ b/client/transport.c
@@ -0,0 +1,82 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2012 Intel Corporation
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
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+#include <inttypes.h>
+
+#include "transport.h"
+#include "log.h"
+
+static GSList *transports = NULL;
+
+struct obc_transport *obc_transport_find(const char *name)
+{
+	GSList *l;
+
+	for (l = transports; l; l = l->next) {
+		struct obc_transport *transport = l->data;
+
+		if (strcasecmp(name, transport->name) == 0)
+			return transport;
+	}
+
+	return NULL;
+}
+
+int obc_transport_register(struct obc_transport *transport)
+{
+	if (!transport) {
+		error("Invalid transport");
+		return -EINVAL;
+	}
+
+	if (obc_transport_find(transport->name)) {
+		error("Permission denied: transport %s already registered",
+							transport->name);
+		return -EPERM;
+	}
+
+	DBG("transport %p name %s registered", transport, transport->name);
+
+	transports = g_slist_append(transports, transport);
+
+	return 0;
+}
+
+void obc_transport_unregister(struct obc_transport *transport)
+{
+	if (!g_slist_find(transports, transport)) {
+		error("Unable to unregister: No such transport %p", transport);
+		return;
+	}
+
+	DBG("transport %p name %s unregistered", transport, transport->name);
+
+	transports = g_slist_remove(transports, transport);
+}
diff --git a/client/transport.h b/client/transport.h
new file mode 100644
index 0000000..4c9bf2d
--- /dev/null
+++ b/client/transport.h
@@ -0,0 +1,37 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2012 Intel Corporation
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
+typedef void (*obc_transport_func)(GIOChannel *io, GError *err,
+							gpointer user_data);
+
+struct obc_transport {
+	const char *name;
+	guint (*connect) (const char *source, const char *destination,
+				const char *service, uint16_t port,
+				obc_transport_func func, void *user_data);
+	void (*disconnect) (guint id);
+};
+
+int obc_transport_register(struct obc_transport *transport);
+void obc_transport_unregister(struct obc_transport *transport);
+struct obc_transport *obc_transport_find(const char *name);
-- 
1.7.7.5

