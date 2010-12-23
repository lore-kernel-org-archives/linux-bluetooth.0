Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Add support for creating devices from stored primary services
Date: Wed, 22 Dec 2010 22:16:37 -0200
Message-Id: <1293063397-24958-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <20101222225054.GD10702@jh-x301>
References: <20101222225054.GD10702@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From what we can retrieve from storage we are able to create the devices
and probe the device drivers.
---
 src/adapter.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9c57bea..77a04f0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -55,6 +55,7 @@
 #include "glib-helper.h"
 #include "agent.h"
 #include "storage.h"
+#include "att.h"
 
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
@@ -1931,6 +1932,78 @@ static void create_stored_device_from_types(char *key, char *value,
 	}
 }
 
+static GSList *string_to_primary_list(char *str)
+{
+	GSList *l = NULL;
+	char **services;
+	int i;
+
+	if (str == NULL)
+		return NULL;
+
+	services = g_strsplit(str, " ", 0);
+	if (services == NULL)
+		return NULL;
+
+	for (i = 0; services[i]; i++) {
+		struct att_primary *prim;
+		int ret;
+
+		prim = g_new0(struct att_primary, 1);
+
+		ret = sscanf(services[i], "%04hX#%04hX#%s", &prim->start,
+							&prim->end, prim->uuid);
+
+		if (ret < 3) {
+			g_free(prim);
+			continue;
+		}
+
+		l = g_slist_append(l, prim);
+	}
+
+	g_strfreev(services);
+
+	return l;
+}
+
+static void create_stored_device_from_primary(char *key, char *value,
+							void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	struct btd_device *device;
+	GSList *services, *uuids, *l;
+
+	l = g_slist_find_custom(adapter->devices,
+				key, (GCompareFunc) device_address_cmp);
+	if (l)
+		device = l->data;
+	else {
+		device = device_create(connection, adapter, key, DEVICE_TYPE_BREDR);
+		if (!device)
+			return;
+
+		device_set_temporary(device, FALSE);
+		adapter->devices = g_slist_append(adapter->devices, device);
+	}
+
+	services = string_to_primary_list(value);
+	if (services == NULL)
+		return;
+
+	for (l = services, uuids = NULL; l; l = l->next) {
+		struct att_primary *prim = l->data;
+		uuids = g_slist_append(uuids, prim->uuid);
+	}
+
+	device_probe_drivers(device, uuids);
+
+	g_slist_free(uuids);
+
+	g_slist_foreach(services, (GFunc) g_free, NULL);
+	g_slist_free(services);
+}
+
 static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -1944,6 +2017,10 @@ static void load_devices(struct btd_adapter *adapter)
 	textfile_foreach(filename, create_stored_device_from_profiles,
 								adapter);
 
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "primary");
+	textfile_foreach(filename, create_stored_device_from_primary,
+								adapter);
+
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "linkkeys");
 	textfile_foreach(filename, create_stored_device_from_linkkeys, &keys);
 
-- 
1.7.3.4

