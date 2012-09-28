Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 4/4] gatt: Remove Service Changed handle from storage
Date: Fri, 28 Sep 2012 17:01:34 -0300
Message-Id: <1348862494-16911-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the Service Changed handle from the GATT storage when
the device is removed from the system.
---
 profiles/gatt/gas.c     | 26 +++++++++++++++++++++++++-
 profiles/gatt/gas.h     |  2 +-
 profiles/gatt/manager.c |  2 +-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index da6d555..6917ea8 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -130,6 +130,19 @@ static int read_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
 	return 0;
 }
 
+static int delete_ctp_handle(bdaddr_t *sba, bdaddr_t *dba, uint8_t bdaddr_type,
+								uint16_t uuid)
+{
+	char filename[PATH_MAX + 1], addr[18], key[25];
+
+	create_filename(filename, PATH_MAX, sba, "gatt");
+
+	ba2str(dba, addr);
+	snprintf(key, sizeof(key), "%17s#%hhu#0x%04x", addr, bdaddr_type, uuid);
+
+	return textfile_del(filename, key);
+}
+
 static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -403,7 +416,7 @@ int gas_register(struct btd_device *device, struct att_range *gap,
 	return 0;
 }
 
-void gas_unregister(struct btd_device *device)
+void gas_unregister(struct btd_device *device, gboolean purge)
 {
 	struct gas *gas;
 	GSList *l;
@@ -414,5 +427,16 @@ void gas_unregister(struct btd_device *device)
 
 	gas = l->data;
 	devices = g_slist_remove(devices, gas);
+
+	if (gas->changed_handle && purge) {
+		bdaddr_t sba, dba;
+		uint8_t bdaddr_type;
+
+		adapter_get_address(device_get_adapter(gas->device), &sba);
+		device_get_address(gas->device, &dba, &bdaddr_type);
+		delete_ctp_handle(&sba, &dba, bdaddr_type,
+						GATT_CHARAC_SERVICE_CHANGED);
+	}
+
 	gas_free(gas);
 }
diff --git a/profiles/gatt/gas.h b/profiles/gatt/gas.h
index 34853c7..436a543 100644
--- a/profiles/gatt/gas.h
+++ b/profiles/gatt/gas.h
@@ -22,4 +22,4 @@
 
 int gas_register(struct btd_device *device, struct att_range *gap,
 						struct att_range *gatt);
-void gas_unregister(struct btd_device *device);
+void gas_unregister(struct btd_device *device, gboolean purge);
diff --git a/profiles/gatt/manager.c b/profiles/gatt/manager.c
index 94921d2..0392a23 100644
--- a/profiles/gatt/manager.c
+++ b/profiles/gatt/manager.c
@@ -70,7 +70,7 @@ static int gatt_driver_probe(struct btd_profile *p, struct btd_device *device,
 static void gatt_driver_remove(struct btd_profile *p,
 				struct btd_device *device, gboolean purge)
 {
-	gas_unregister(device);
+	gas_unregister(device, purge);
 }
 
 static struct btd_profile gatt_profile = {
-- 
1.7.12

