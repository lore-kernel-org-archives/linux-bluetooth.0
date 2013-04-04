Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	vinicius.gomes@openbossa.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v4 2/2] input: Implement the new ReconnectMode Input1 property.
Date: Thu,  4 Apr 2013 14:31:53 -0700
Message-Id: <1365111113-13741-3-git-send-email-deymo@chromium.org>
In-Reply-To: <1365111113-13741-1-git-send-email-deymo@chromium.org>
References: <1365111113-13741-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The "Connectability" of a HID device, as defined by the HID spec,
governs the way the host may and should connect to a HID device or
expect a connection from it. In the comon case of mice and keyboards
the HIDNormallyConnectable is FALSE and HIDReconnectInitiate is TRUE,
since those devices only attempt a connection to the host when they
have some data to transfer. A connection attempt initiated from the
host after the device drops the connection (while still paired) will
result in a Page timeout.

This patch exposes a new property called "ReconnectMode" combining the
those two SDP attributes as shown in the Connectability section of the
HID spec (see section 5.4.2). The property can have one of the following
four values: "None", "Device", "Host", "Any", and is derived from the
SDP cached value on device creation even if the device is off.
---
 profiles/input/device.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1da9d99..33a6f65 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -54,6 +54,22 @@
 
 #include "sdp-client.h"
 
+#define INPUT_INTERFACE "org.bluez.Input1"
+
+enum reconnect_mode_t {
+	RECONNECT_NONE = 0,
+	RECONNECT_DEVICE,
+	RECONNECT_HOST,
+	RECONNECT_ANY
+};
+
+static const char * const reconnect_value[] = {
+	"None",
+	"Device",
+	"Host",
+	"Any"
+};
+
 struct input_device {
 	struct btd_device	*device;
 	char			*path;
@@ -69,8 +85,9 @@ struct input_device {
 	int			timeout;
 	struct hidp_connadd_req *req;
 	guint			dc_id;
-	gboolean		disable_sdp;
+	bool			disable_sdp;
 	char			*name;
+	enum reconnect_mode_t	reconnect_mode;
 };
 
 static GSList *devices = NULL;
@@ -676,7 +693,7 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile)
 
 static struct input_device *input_device_new(struct btd_device *device,
 				const char *path, const uint32_t handle,
-				gboolean disable_sdp)
+				bool disable_sdp)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
@@ -697,7 +714,7 @@ static struct input_device *input_device_new(struct btd_device *device,
 	return idev;
 }
 
-static gboolean is_device_sdp_disable(const sdp_record_t *rec)
+static bool is_device_sdp_disable(const sdp_record_t *rec)
 {
 	sdp_data_t *data;
 
@@ -706,6 +723,56 @@ static gboolean is_device_sdp_disable(const sdp_record_t *rec)
 	return data && data->val.uint8;
 }
 
+static enum reconnect_mode_t hid_reconnection_mode(bool reconnect_initiate,
+						bool normally_connectable)
+{
+	if (!reconnect_initiate && !normally_connectable)
+		return RECONNECT_NONE;
+	else if (!reconnect_initiate && normally_connectable)
+		return RECONNECT_HOST;
+	else if (reconnect_initiate && !normally_connectable)
+		return RECONNECT_DEVICE;
+	else /* (reconnect_initiate && normally_connectable) */
+		return RECONNECT_ANY;
+}
+
+static void extract_hid_props(struct input_device *idev,
+					const sdp_record_t *rec)
+{
+	/* Extract HID connectability */
+	bool reconnect_initiate, normally_connectable;
+	sdp_data_t *pdlist;
+
+	/* HIDNormallyConnectable is optional and assumed FALSE
+	* if not present. */
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_RECONNECT_INITIATE);
+	reconnect_initiate = pdlist ? pdlist->val.uint8 : TRUE;
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_NORMALLY_CONNECTABLE);
+	normally_connectable = pdlist ? pdlist->val.uint8 : FALSE;
+
+	/* Update local values */
+	idev->reconnect_mode =
+		hid_reconnection_mode(reconnect_initiate, normally_connectable);
+}
+
+static gboolean property_get_reconnect_mode(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct input_device *idev = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+					reconnect_value + idev->reconnect_mode);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable input_properties[] = {
+	{ "ReconnectMode", "s", property_get_reconnect_mode },
+	{ }
+};
+
 int input_device_register(struct btd_device *device,
 					const char *path, const char *uuid,
 					const sdp_record_t *rec, int timeout)
@@ -723,6 +790,19 @@ int input_device_register(struct btd_device *device,
 	if (!idev)
 		return -EINVAL;
 
+	/* Initialize device properties */
+	extract_hid_props(idev, rec);
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					idev->path, INPUT_INTERFACE,
+					NULL, NULL,
+					input_properties, idev,
+					NULL) == FALSE) {
+		error("Unable to register %s interface", INPUT_INTERFACE);
+		input_device_free(idev);
+		return -EINVAL;
+	}
+
 	idev->timeout = timeout;
 	idev->uuid = g_strdup(uuid);
 
@@ -761,6 +841,9 @@ int input_device_unregister(const char *path, const char *uuid)
 		return -EBUSY;
 	}
 
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						idev->path, INPUT_INTERFACE);
+
 	devices = g_slist_remove(devices, idev);
 	input_device_free(idev);
 
-- 
1.8.1.3
