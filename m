Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/9] Get thermometer service range to load the driver.
Date: Wed, 28 Sep 2011 19:48:38 +0200
Message-Id: <1317232126-12640-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1317232126-12640-1-git-send-email-sancane@gmail.com>
References: <1317232126-12640-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 thermometer/manager.c     |   13 ++++++++++++-
 thermometer/thermometer.c |    5 ++++-
 thermometer/thermometer.h |    3 ++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/thermometer/manager.c b/thermometer/manager.c
index 08f0e0a..b39094f 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -21,9 +21,11 @@
  */
 
 #include <gdbus.h>
+#include <bluetooth/uuid.h>
 
 #include "adapter.h"
 #include "device.h"
+#include "att.h"
 #include "thermometer.h"
 #include "manager.h"
 
@@ -33,7 +35,16 @@ static DBusConnection *connection = NULL;
 
 static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	return thermometer_register(connection, device);
+	struct att_primary *tattr;
+	GSList *list;
+
+	list = device_services_from_record(device, uuids);
+	if (!list)
+		return -1;
+
+	tattr = list->data;
+
+	return thermometer_register(connection, device, tattr);
 }
 
 static void thermometer_driver_remove(struct btd_device *device)
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 3cd821a..027ae02 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -21,12 +21,15 @@
  */
 
 #include <gdbus.h>
+#include <bluetooth/uuid.h>
 
 #include "adapter.h"
 #include "device.h"
+#include "att.h"
 #include "thermometer.h"
 
-int thermometer_register(DBusConnection *connection, struct btd_device *device)
+int thermometer_register(DBusConnection *connection, struct btd_device *device,
+						struct att_primary *tattr)
 {
 	/* TODO: Register Health Thermometer Interface */
 	return 0;
diff --git a/thermometer/thermometer.h b/thermometer/thermometer.h
index 0937444..298c9ad 100644
--- a/thermometer/thermometer.h
+++ b/thermometer/thermometer.h
@@ -20,5 +20,6 @@
  *
  */
 
-int thermometer_register(DBusConnection *connection, struct btd_device *device);
+int thermometer_register(DBusConnection *connection, struct btd_device *device,
+						struct att_primary *tattr);
 void thermometer_unregister(struct btd_device *device);
-- 
1.7.6.1

