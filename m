Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 01/11] core: Add btd_service to represent device services
Date: Tue, 19 Mar 2013 08:40:45 +0100
Message-Id: <1363678855-12765-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1363678855-12765-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add object to centralize all data corresponding to a service provided by
a remote device as well as the possible states for such a service.
---
 Makefile.am   |   1 +
 src/service.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/service.h |  53 +++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 src/service.c
 create mode 100644 src/service.h

diff --git a/Makefile.am b/Makefile.am
index f75b8d6..c30ab69 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -142,6 +142,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/error.h src/error.c \
 			src/adapter.h src/adapter.c \
 			src/profile.h src/profile.c \
+			src/service.h src/service.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c \
diff --git a/src/service.c b/src/service.c
new file mode 100644
index 0000000..ee56a0a
--- /dev/null
+++ b/src/service.c
@@ -0,0 +1,202 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include <glib.h>
+
+#include "log.h"
+
+#include "adapter.h"
+#include "device.h"
+#include "profile.h"
+#include "service.h"
+
+struct btd_service {
+	gint			ref;
+	struct btd_device	*device;
+	struct btd_profile	*profile;
+	void			*user_data;
+	service_state_t		state;
+	int			err;
+};
+
+static char *str_state[] = {
+	"SERVICE_STATE_UNAVAILABLE",
+	"SERVICE_STATE_DISCONNECTED",
+	"SERVICE_STATE_CONNECTING",
+	"SERVICE_STATE_CONNECTED",
+	"SERVICE_STATE_DISCONNECTING",
+};
+
+struct btd_device *service_get_device(struct btd_service *service)
+{
+	return service->device;
+}
+
+struct btd_profile *service_get_profile(struct btd_service *service)
+{
+	return service->profile;
+}
+
+void service_set_user_data(struct btd_service *service, void *user_data)
+{
+	assert(service->state == SERVICE_STATE_UNAVAILABLE);
+	service->user_data = user_data;
+}
+
+void *service_get_user_data(struct btd_service *service)
+{
+	return service->user_data;
+}
+
+int service_get_error(struct btd_service *service)
+{
+	return service->err;
+}
+
+service_state_t service_get_state(struct btd_service *service)
+{
+	return service->state;
+}
+
+static void service_set_state(struct btd_service *service,
+							service_state_t state)
+{
+	service_state_t old = service->state;
+
+	if (state == old)
+		return;
+
+	service->state = state;
+
+	DBG("State changed %p: %s -> %s", service, str_state[old],
+							str_state[state]);
+}
+
+struct btd_service *service_create(struct btd_device *device,
+						struct btd_profile *profile)
+{
+	struct btd_service *service;
+
+	service = g_try_new0(struct btd_service, 1);
+	if (!service) {
+		error("service_create: failed to alloc memory");
+		return NULL;
+	}
+
+	service->ref = 1;
+	service->device = btd_device_ref(device);
+	service->profile = profile;
+	service->state = SERVICE_STATE_UNAVAILABLE;
+
+	return service;
+}
+
+struct btd_service *btd_service_ref(struct btd_service *service)
+{
+	service->ref++;
+
+	DBG("%p: ref=%d", service, service->ref);
+
+	return service;
+}
+
+void btd_service_unref(struct btd_service *service)
+{
+	service->ref--;
+
+	DBG("%p: ref=%d", service, service->ref);
+
+	if (service->ref > 0)
+		return;
+
+	btd_device_unref(service->device);
+	g_free(service);
+}
+
+void service_probed(struct btd_service *service)
+{
+	assert(service->state == SERVICE_STATE_UNAVAILABLE);
+	service_set_state(service, SERVICE_STATE_DISCONNECTED);
+}
+
+void service_connecting(struct btd_service *service)
+{
+	assert(service->state == SERVICE_STATE_DISCONNECTED);
+	service->err = 0;
+	service_set_state(service, SERVICE_STATE_CONNECTING);
+}
+
+void service_connecting_complete(struct btd_service *service, int err)
+{
+	if (service->state != SERVICE_STATE_DISCONNECTED &&
+				service->state != SERVICE_STATE_CONNECTING)
+		return;
+
+	service->err = err;
+
+	if (err == 0)
+		service_set_state(service, SERVICE_STATE_CONNECTED);
+	else
+		service_set_state(service, SERVICE_STATE_DISCONNECTED);
+}
+
+void service_disconnecting(struct btd_service *service)
+{
+	assert(service->state == SERVICE_STATE_CONNECTING ||
+				service->state == SERVICE_STATE_CONNECTED);
+	service->err = 0;
+	service_set_state(service, SERVICE_STATE_DISCONNECTING);
+}
+
+void service_disconnecting_complete(struct btd_service *service, int err)
+{
+	if (service->state != SERVICE_STATE_CONNECTED &&
+				service->state != SERVICE_STATE_DISCONNECTING)
+		return;
+
+	service->err = err;
+	service_set_state(service, SERVICE_STATE_DISCONNECTED);
+}
+
+void service_unavailable(struct btd_service *service)
+{
+	service->profile = NULL;
+	service->err = 0;
+	service_set_state(service, SERVICE_STATE_UNAVAILABLE);
+}
diff --git a/src/service.h b/src/service.h
new file mode 100644
index 0000000..72282bd
--- /dev/null
+++ b/src/service.h
@@ -0,0 +1,53 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
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
+typedef enum {
+	SERVICE_STATE_UNAVAILABLE, /* Not probed */
+	SERVICE_STATE_DISCONNECTED,
+	SERVICE_STATE_CONNECTING,
+	SERVICE_STATE_CONNECTED,
+	SERVICE_STATE_DISCONNECTING,
+} service_state_t;
+
+struct btd_service;
+
+struct btd_service *service_create(struct btd_device *device,
+						struct btd_profile *profile);
+
+struct btd_service *btd_service_ref(struct btd_service *service);
+void btd_service_unref(struct btd_service *service);
+
+struct btd_device *service_get_device(struct btd_service *service);
+struct btd_profile *service_get_profile(struct btd_service *service);
+service_state_t service_get_state(struct btd_service *service);
+
+void service_set_user_data(struct btd_service *service, void *user_data);
+void *service_get_user_data(struct btd_service *service);
+int service_get_error(struct btd_service *service);
+
+void service_probed(struct btd_service *service);
+void service_connecting(struct btd_service *service);
+void service_connecting_complete(struct btd_service *service, int err);
+void service_disconnecting(struct btd_service *service);
+void service_disconnecting_complete(struct btd_service *service, int err);
+void service_unavailable(struct btd_service *service);
-- 
1.8.1.4

