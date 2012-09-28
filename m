Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 3/4] proximity: Store Bluetooth Address type
Date: Fri, 28 Sep 2012 17:01:33 -0300
Message-Id: <1348862494-16911-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch stores the remote Bluetooth Address type in the "proximity"
file. The textfile key is now "address#type#alert"
---
 profiles/proximity/monitor.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 4745791..77caf35 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -94,9 +94,9 @@ static inline int create_filename(char *buf, size_t size,
 }
 
 static int write_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
-					const char *alert, const char *level)
+		uint8_t bdaddr_type, const char *alert, const char *level)
 {
-	char filename[PATH_MAX + 1], addr[18], key[38];
+	char filename[PATH_MAX + 1], addr[18], key[40];
 
 	create_filename(filename, PATH_MAX, sba, "proximity");
 
@@ -104,7 +104,7 @@ static int write_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 
 	ba2str(dba, addr);
 
-	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
+	snprintf(key, sizeof(key), "%17s#%hhu#%s", addr, bdaddr_type, alert);
 
 	if (level)
 		return textfile_put(filename, key, level);
@@ -113,15 +113,15 @@ static int write_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 }
 
 static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
-							const char *alert)
+					uint8_t bdaddr_type, const char *alert)
 {
-	char filename[PATH_MAX + 1], addr[18], key[38];
+	char filename[PATH_MAX + 1], addr[18], key[40];
 	char *str, *strnew;
 
 	create_filename(filename, PATH_MAX, sba, "proximity");
 
 	ba2str(dba, addr);
-	snprintf(key, sizeof(key), "%17s#%s", addr, alert);
+	snprintf(key, sizeof(key), "%17s#%hhu#%s", addr, bdaddr_type, alert);
 
 	str = textfile_caseget(filename, key);
 	if (str == NULL)
@@ -411,6 +411,7 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	struct monitor *monitor = data;
 	struct btd_device *device = monitor->device;
 	bdaddr_t sba, dba;
+	uint8_t bdaddr_type;
 
 	if (!level_is_valid(level))
 		return btd_error_invalid_args(msg);
@@ -422,9 +423,10 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	monitor->linklosslevel = g_strdup(level);
 
 	adapter_get_address(device_get_adapter(device), &sba);
-	device_get_address(device, &dba, NULL);
+	device_get_address(device, &dba, &bdaddr_type);
 
-	write_proximity_config(&sba, &dba, "LinkLossAlertLevel", level);
+	write_proximity_config(&sba, &dba, bdaddr_type, "LinkLossAlertLevel",
+									level);
 
 	if (monitor->attrib)
 		write_alert_level(monitor);
@@ -597,12 +599,14 @@ int monitor_register(struct btd_device *device,
 	const char *path = device_get_path(device);
 	struct monitor *monitor;
 	bdaddr_t sba, dba;
+	uint8_t bdaddr_type;
 	char *level;
 
 	adapter_get_address(device_get_adapter(device), &sba);
-	device_get_address(device, &dba, NULL);
+	device_get_address(device, &dba, &bdaddr_type);
 
-	level = read_proximity_config(&sba, &dba, "LinkLossAlertLevel");
+	level = read_proximity_config(&sba, &dba, bdaddr_type,
+							"LinkLossAlertLevel");
 
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
@@ -670,10 +674,12 @@ void monitor_unregister(struct btd_device *device, gboolean purge)
 							PROXIMITY_INTERFACE);
 	if (purge) {
 		bdaddr_t sba, dba;
+		uint8_t bdaddr_type;
 
 		adapter_get_address(device_get_adapter(device), &sba);
-		device_get_address(device, &dba, NULL);
+		device_get_address(device, &dba, &bdaddr_type);
 
-		write_proximity_config(&sba, &dba, "LinkLossAlertLevel", NULL);
+		write_proximity_config(&sba, &dba, bdaddr_type,
+						"LinkLossAlertLevel", NULL);
 	}
 }
-- 
1.7.12

