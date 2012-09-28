Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 3/4] gatt: Add storing Service Changed handle
Date: Fri, 28 Sep 2012 11:47:53 -0300
Message-Id: <1348843674-10878-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch stores the Service Changed control-point handle in order to
be able to listen for Service Changed indications when the connection
is established.
---
 profiles/gatt/gas.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index b42aa64..8b6a0bd 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -25,6 +25,9 @@
 #endif
 
 #include <stdbool.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include <glib.h>
 #include <bluetooth/uuid.h>
@@ -37,6 +40,7 @@
 #include "btio.h"
 #include "gatt.h"
 #include "log.h"
+#include "textfile.h"
 #include "gas.h"
 
 /* Generic Attribute/Access Service */
@@ -70,6 +74,34 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return (gas->device == device ? 0 : -1);
 }
 
+static inline int create_filename(char *buf, size_t size,
+				const bdaddr_t *bdaddr, const char *name)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+
+	return create_name(buf, size, STORAGEDIR, addr, name);
+}
+
+static int write_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
+						uint16_t uuid, uint16_t handle)
+{
+	char filename[PATH_MAX + 1], addr[18], key[27], value[7];
+
+	create_filename(filename, PATH_MAX, sba, "gatt");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(dba, addr);
+
+	snprintf(key, sizeof(key), "%17s#%hhu#0x%4.4x", addr, bdaddr_type,
+									uuid);
+	snprintf(value, sizeof(value), "0x%4.4x", handle);
+
+	return textfile_put(filename, key, value);
+}
+
 static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -107,6 +139,10 @@ done:
 static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct gas *gas = user_data;
+	bdaddr_t sba, dba;
+	uint8_t bdaddr_type;
+
 	if (status) {
 		error("Write Service Changed CCC failed: %s",
 						att_ecode2str(status));
@@ -114,6 +150,12 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	DBG("Service Changed indications enabled");
+
+	adapter_get_address(device_get_adapter(gas->device), &sba);
+	device_get_address(gas->device, &dba, &bdaddr_type);
+
+	write_ctp_handle(&sba, &dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
+							gas->changed_handle);
 }
 
 static void write_ccc(GAttrib *attrib, uint16_t handle, gpointer user_data)
-- 
1.7.12

