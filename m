Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@holtmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 2/4] plugin: Add bonding callback support for plugins
Date: Thu,  5 Apr 2012 15:40:51 -0700
Message-Id: <1333665653-30266-3-git-send-email-scott@netsplit.com>
In-Reply-To: <1333665653-30266-1-git-send-email-scott@netsplit.com>
References: <1333665653-30266-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow plugins to register a bonding callback on a device, this will be
called on completion or cancellation of a bonding attempt on that
device and allow retrying of the bonding attempt.

These callbacks will only be called once, in the case of retrying the
callback must be registered again separately from another callback
(e.g. the pincode callback).
---
 src/device.c |   19 +++++++++++++++++++
 src/device.h |    8 ++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index feb330c..53ca977 100644
--- a/src/device.c
+++ b/src/device.c
@@ -147,6 +147,7 @@ struct btd_device {
 	GSList		*primaries;		/* List of primary services */
 	GSList		*drivers;		/* List of device drivers */
 	GSList		*watches;		/* List of disconnect_data */
+	GSList          *bonding_callbacks;	/* List of bonding callbacks */
 	gboolean	temporary;
 	struct agent	*agent;
 	guint		disconn_timer;
@@ -267,8 +268,12 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 
+	g_slist_free(device->bonding_callbacks);
+
 	att_cleanup(device);
 
+	g_attrib_unref(device->attrib);
+
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
 					(sdp_free_func_t) sdp_record_free);
@@ -2542,6 +2547,20 @@ static void device_auth_req_free(struct btd_device *device)
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
index f06042c..2a7409a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -103,6 +103,14 @@ guint device_add_disconnect_watch(struct btd_device *device,
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

