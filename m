Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 2/4] plugin: Add bonding callback support for plugins
Date: Tue, 24 Jan 2012 10:47:56 -0800
Message-Id: <1327430878-23913-3-git-send-email-scott@netsplit.com>
In-Reply-To: <1327430878-23913-1-git-send-email-scott@netsplit.com>
References: <1327430878-23913-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow plugins to register a bonding callback on a device, this will be
called on completion or cancellation of a bonding attempt on that
device and allow retrying of the bonding attempt.

These callbacks will only be called once, in the case of retrying the
callback must be registered again separately from another callback
(e.g. the pincode callback).
---
 src/device.c |   17 +++++++++++++++++
 src/device.h |    8 ++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 278ad4b..4e11447 100644
--- a/src/device.c
+++ b/src/device.c
@@ -137,6 +137,7 @@ struct btd_device {
 	GSList		*primaries;		/* List of primary services */
 	GSList		*drivers;		/* List of device drivers */
 	GSList		*watches;		/* List of disconnect_data */
+	GSList          *bonding_callbacks;	/* List of bonding callbacks */
 	gboolean	temporary;
 	struct agent	*agent;
 	guint		disconn_timer;
@@ -235,6 +236,8 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 
+	g_slist_free(device->bonding_callbacks);
+
 	g_attrib_unref(device->attrib);
 
 	if (device->tmp_records)
@@ -2337,6 +2340,20 @@ static void device_auth_req_free(struct btd_device *device)
 	device->authr = NULL;
 }
 
+void btd_device_register_bonding_cb(struct btd_device *device,
+						btd_device_bonding_cb_t cb)
+{
+	device->bonding_callbacks = g_slist_prepend(
+						device->bonding_callbacks, cb);
+}
+
+void btd_device_unregister_bonding_cb(struct btd_device *device,
+						btd_device_bonding_cb_t cb)
+{
+	device->bonding_callbacks = g_slist_remove(
+						device->bonding_callbacks, cb);
+}
+
 gboolean device_is_retrying(struct btd_device *device)
 {
 	struct bonding_req *bonding = device->bonding;
diff --git a/src/device.h b/src/device.h
index 5b1152b..6dcbb5c 100644
--- a/src/device.h
+++ b/src/device.h
@@ -101,6 +101,14 @@ guint device_add_disconnect_watch(struct btd_device *device,
 void device_remove_disconnect_watch(struct btd_device *device, guint id);
 void device_set_class(struct btd_device *device, uint32_t value);
 
+typedef gboolean (*btd_device_bonding_cb_t) (struct btd_device *device,
+					gboolean complete, uint8_t status);
+
+void btd_device_register_bonding_cb(struct btd_device *dev,
+						btd_device_bonding_cb_t cb);
+void btd_device_unregister_bonding_cb(struct btd_device *dev,
+						btd_device_bonding_cb_t cb);
+
 #define BTD_UUIDS(args...) ((const char *[]) { args, NULL } )
 
 struct btd_device_driver {
-- 
1.7.7.3

