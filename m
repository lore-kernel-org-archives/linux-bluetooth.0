Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 4/4] gatt: Add reading stored Service Changed handle
Date: Fri, 28 Sep 2012 11:47:54 -0300
Message-Id: <1348843674-10878-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch avoids discovering Service Changed handle when the ATT
connection is established and there is a previous stored handle.
---
 profiles/gatt/gas.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 8b6a0bd..da6d555 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -25,9 +25,11 @@
 #endif
 
 #include <stdbool.h>
+#include <stdlib.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <errno.h>
 
 #include <glib.h>
 #include <bluetooth/uuid.h>
@@ -102,6 +104,32 @@ static int write_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
 	return textfile_put(filename, key, value);
 }
 
+static int read_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
+						uint16_t uuid, uint16_t *value)
+{
+	char filename[PATH_MAX + 1], addr[18], key[27];
+	char *str;
+
+	create_filename(filename, PATH_MAX, sba, "gatt");
+
+	ba2str(dba, addr);
+	snprintf(key, sizeof(key), "%17s#%hhu#0x%04x", addr, bdaddr_type,
+									uuid);
+
+	str = textfile_get(filename, key);
+	if (str == NULL)
+		return -errno;
+
+	if (sscanf(str, "%hx", value) != 1) {
+		free(str);
+		return -ENOENT;
+	}
+
+	free(str);
+
+	return 0;
+}
+
 static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -349,6 +377,8 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 						struct att_range *gatt)
 {
 	struct gas *gas;
+	bdaddr_t sba, dba;
+	uint8_t bdaddr_type;
 
 	gas = g_new0(struct gas, 1);
 	gas->gap.start = gap->start;
@@ -364,6 +394,12 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 						attio_connected_cb,
 						attio_disconnected_cb, gas);
 
+	adapter_get_address(device_get_adapter(gas->device), &sba);
+	device_get_address(gas->device, &dba, &bdaddr_type);
+
+	read_ctp_handle(&sba, &dba, bdaddr_type, GATT_CHARAC_SERVICE_CHANGED,
+							&gas->changed_handle);
+
 	return 0;
 }
 
-- 
1.7.12

