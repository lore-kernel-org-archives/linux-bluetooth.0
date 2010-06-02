Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jos=C3=A9=20Antonio=20Santos=20Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 04/32] Initial support for hdp_device_drivers
Date: Wed,  2 Jun 2010 15:19:00 +0200
Message-Id: <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos Cadenas <santoscadenas@gmail.com>

---
 health/hdp.c     |   11 +++++++++++
 health/hdp.h     |    3 +++
 health/manager.c |   10 +++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index ede4186..1094170 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -184,3 +184,14 @@ void hdp_adapter_unregister(struct btd_adapter *btd_adapter)
 
 	debug("HDP exit");
 }
+
+int health_device_register(struct btd_device *device, const char *uuid)
+{
+	debug("HDP_DRIVER_PROBE with uuid %s", uuid);
+	return 0;
+}
+
+void health_device_unregister(struct btd_device *device)
+{
+	debug("TODO: Remove device");
+}
diff --git a/health/hdp.h b/health/hdp.h
index 893f745..0aae7b9 100644
--- a/health/hdp.h
+++ b/health/hdp.h
@@ -25,3 +25,6 @@
 
 int hdp_adapter_register(DBusConnection *conn, struct btd_adapter *btd_adapter);
 void hdp_adapter_unregister(struct btd_adapter *btd_adapter);
+
+int health_device_register(struct btd_device *device, const char *uuid);
+void health_device_unregister(struct btd_device *device);
diff --git a/health/manager.c b/health/manager.c
index b5dec5a..9b3b1a5 100644
--- a/health/manager.c
+++ b/health/manager.c
@@ -63,17 +63,21 @@ static struct btd_adapter_driver hdp_adapter_driver = {
 
 static int hdp_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	debug("hdp driver probe");
+	while (uuids) {
+		health_device_register(device, uuids->data);
+		uuids = uuids->next;
+	}
+
 	return 0;
 }
 
 static void hdp_driver_remove(struct btd_device *device)
 {
-	debug("hdp driver remove");
+	health_device_unregister(device);
 }
 
 static struct btd_device_driver hdp_device_driver = {
-	.name	= "hdp_device-driver",
+	.name	= "hdp-device-driver",
 	.uuids	= BTD_UUIDS(HDP_UUID, HDP_SOURCE_UUID, HDP_SINK_UUID),
 	.probe	= hdp_driver_probe,
 	.remove	= hdp_driver_remove,
-- 
1.6.3.3

