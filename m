Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/9] Move the primary service storage code to a local function
Date: Thu,  7 Apr 2011 14:30:09 -0300
Message-Id: <1302197414-833-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/src/device.c b/src/device.c
index d1ed05a..eecaee0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1636,14 +1636,26 @@ static char *primary_list_to_string(GSList *primary_list)
 	return g_string_free(services, FALSE);
 }
 
+static void store_services(struct btd_device *device)
+{
+	struct btd_adapter *adapter = device->adapter;
+	bdaddr_t dba, sba;
+	char *str = primary_list_to_string(device->services);
+
+	adapter_get_address(adapter, &sba);
+	device_get_address(device, &dba);
+
+	write_device_type(&sba, &dba, device->type);
+	write_device_services(&sba, &dba, str);
+
+	g_free(str);
+}
+
 static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 {
 	struct browse_req *req = user_data;
 	struct btd_device *device = req->device;
-	struct btd_adapter *adapter = device->adapter;
 	GSList *l, *uuids = NULL;
-	bdaddr_t dba, sba;
-	char *str;
 
 	if (status) {
 		DBusMessage *reply;
@@ -1668,14 +1680,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 
 	create_device_reply(device, req);
 
-	str = primary_list_to_string(services);
-
-	adapter_get_address(adapter, &sba);
-	device_get_address(device, &dba);
-
-	write_device_type(&sba, &dba, device->type);
-	write_device_services(&sba, &dba, str);
-	g_free(str);
+	store_services(device);
 
 done:
 	device->browse = NULL;
-- 
1.7.4.1

