Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v3 2/2] input: Expose HIDNormallyConnectable and HIDReconnectInitiate properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364863226-10566-3-git-send-email-deymo@chromium.org>
Date: Wed, 3 Apr 2013 20:42:44 -0700
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Message-Id: <9B07FA89-F629-456F-B60D-BB3079A33E4E@holtmann.org>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org> <1364863226-10566-1-git-send-email-deymo@chromium.org> <1364863226-10566-3-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> The "Connectability" of a HID device, as defined by the HID spec,
> governs the way the host may and should connect to a HID device or
> expect a connection from it. In the comon case of mice and keyboards
> the HIDNormallyConnectable is FALSE and HIDReconnectInitiate is TRUE,
> since those devices only attempt a connection to the host when they
> have some data to transfer. A connection attempt initiated from the
> host after the device drops the connection (while still paired) will
> result in a Page timeout.
> 
> This patch exposes these two HID properties in a new Input1 interface,
> updates them every time new SDP records are available and persists them
> in a new device "input" file.
> ---
> profiles/input/device.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 168 insertions(+), 2 deletions(-)
> 
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 1da9d99..a2a87a0 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -54,6 +54,8 @@
> 
> #include "sdp-client.h"
> 
> +#define INPUT_INTERFACE "org.bluez.Input1"
> +
> struct input_device {
> 	struct btd_device	*device;
> 	char			*path;
> @@ -69,8 +71,10 @@ struct input_device {
> 	int			timeout;
> 	struct hidp_connadd_req *req;
> 	guint			dc_id;
> -	gboolean		disable_sdp;
> +	bool			disable_sdp;

if you change this one, then you need to change another one in is_device_sdp_disable.

> 	char			*name;
> +	bool			normally_connectable;
> +	bool			reconnect_initiate;
> };
> 
> static GSList *devices = NULL;
> @@ -116,6 +120,81 @@ static void input_device_free(struct input_device *idev)
> 	g_free(idev);
> }
> 
> +static void input_device_config_filename(struct input_device *idev,
> +						char *filename, size_t maxlen)
> +{
> +	char adapter_addr[18];
> +	char device_addr[18];
> +
> +	ba2str(device_get_address(idev->device), device_addr);
> +	ba2str(adapter_get_address(device_get_adapter(idev->device)),
> +								adapter_addr);
> +	snprintf(filename, maxlen, STORAGEDIR "/%s/%s/input", adapter_addr,
> +								device_addr);
> +	filename[maxlen-1] = '\0';
> +}
> +
> +static void input_device_load_props(struct input_device *idev)
> +{
> +	char filename[PATH_MAX + 1];
> +	GKeyFile *key_file;
> +	GError *err = NULL;
> +
> +	input_device_config_filename(idev, filename, PATH_MAX + 1);
> +
> +	key_file = g_key_file_new();
> +	if (!key_file)
> +		return;

Minor nitpick, but put an extra empty line here.

> +	g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +	/* Load HID connectivity properties */
> +	idev->normally_connectable = g_key_file_get_boolean(key_file,
> +				"Input", "NormallyConnectable", &err);
> +	if (err) {
> +		idev->normally_connectable = FALSE;
> +		g_error_free(err);
> +		err = NULL;
> +	}
> +
> +	idev->reconnect_initiate = g_key_file_get_boolean(key_file,
> +				"Input", "ReconnectInitiate", &err);
> +	if (err) {
> +		idev->reconnect_initiate = TRUE;
> +		g_error_free(err);
> +		err = NULL;
> +	}
> +
> +	g_key_file_free(key_file);
> +}
> +
> +static void input_device_store_props(struct input_device *idev)
> +{
> +	char filename[PATH_MAX + 1];
> +	GKeyFile *key_file;
> +	char *str;
> +	gsize length = 0;
> +
> +	input_device_config_filename(idev, filename, PATH_MAX + 1);
> +
> +	key_file = g_key_file_new();
> +	if (!key_file)
> +		return;

Same here. And just thinking about it, can g_key_file_new() actually fail. Some of the GLib new function will just abort if no memory can be allocated. Can you check please. In the past we added pointless NULL pointer checks since we never checked.

> +	g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +	g_key_file_set_boolean(key_file, "Input",
> +		"NormallyConnectable", idev->normally_connectable);
> +	g_key_file_set_boolean(key_file, "Input",
> +		"ReconnectInitiate", idev->reconnect_initiate);
> +
> +	create_file(filename, S_IRUSR | S_IWUSR);
> +
> +	str = g_key_file_to_data(key_file, &length, NULL);
> +	g_file_set_contents(filename, str, length, NULL);
> +	g_free(str);
> +
> +	g_key_file_free(key_file);
> +}
> +
> static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
> {
> 	struct input_device *idev = data;
> @@ -676,7 +755,7 @@ int input_device_disconnect(struct btd_device *dev, struct btd_profile *profile)
> 
> static struct input_device *input_device_new(struct btd_device *device,
> 				const char *path, const uint32_t handle,
> -				gboolean disable_sdp)
> +				bool disable_sdp)
> {
> 	struct btd_adapter *adapter = device_get_adapter(device);
> 	struct input_device *idev;
> @@ -694,6 +773,8 @@ static struct input_device *input_device_new(struct btd_device *device,
> 	if (strlen(name) > 0)
> 		idev->name = g_strdup(name);
> 
> +	input_device_load_props(idev);
> +
> 	return idev;
> }
> 
> @@ -706,6 +787,76 @@ static gboolean is_device_sdp_disable(const sdp_record_t *rec)
> 	return data && data->val.uint8;
> }
> 
> +static void update_hid_props(struct input_device *idev,
> +		gboolean normally_connectable, gboolean reconnect_initiate)

Can we go with bool here as well.

> +{
> +	gboolean update_nc, update_ri;
> +	DBusConnection *dbus_conn = btd_get_dbus_connection();
> +
> +	update_nc = idev->normally_connectable != normally_connectable;
> +	idev->normally_connectable = normally_connectable;
> +	if (update_nc)
> +		g_dbus_emit_property_changed(dbus_conn, idev->path,
> +				DEVICE_INTERFACE, "HIDNormallyConnectable");
> +
> +	update_ri = idev->reconnect_initiate != reconnect_initiate;
> +	idev->reconnect_initiate = reconnect_initiate;
> +	if (update_ri)
> +		g_dbus_emit_property_changed(dbus_conn, idev->path,
> +				DEVICE_INTERFACE, "HIDReconnectInitiate");
> +
> +	if (update_nc || update_ri)
> +		input_device_store_props(idev);
> +}
> +
> +static void extract_hid_props(struct input_device *idev,
> +							const sdp_record_t *rec)
> +{
> +	/* Extract HID connectability */
> +	bool hid_nc, hid_ri;
> +	sdp_data_t *pdlist;
> +
> +	/* HIDNormallyConnectable is optional and assumed FALSE
> +	* if not present. */
> +	pdlist = sdp_data_get(rec, SDP_ATTR_HID_NORMALLY_CONNECTABLE);
> +	hid_nc = pdlist ? pdlist->val.uint8 : FALSE;
> +
> +	pdlist = sdp_data_get(rec, SDP_ATTR_HID_RECONNECT_INITIATE);
> +	hid_ri = pdlist ? pdlist->val.uint8 : TRUE;
> +
> +	update_hid_props(idev, hid_nc, hid_ri);
> +}
> +
> +static gboolean property_get_normally_connectable(
> +					const GDBusPropertyTable *property,
> +					DBusMessageIter *iter, void *data)
> +{
> +	struct input_device *idev = data;
> +
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
> +						&idev->normally_connectable);

If we want to be 100% safe here, then converting it to dbus_bool_t first is better.

> +
> +	return TRUE;
> +}
> +
> +static gboolean property_get_reconnect_initiate(
> +					const GDBusPropertyTable *property,
> +					DBusMessageIter *iter, void *data)
> +{
> +	struct input_device *idev = data;
> +
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
> +						&idev->reconnect_initiate);

Same here.

> +
> +	return TRUE;
> +}
> +
> +static const GDBusPropertyTable input_properties[] = {
> +	{ "NormallyConnectable", "b", property_get_normally_connectable },
> +	{ "ReconnectInitiate", "b", property_get_reconnect_initiate },
> +	{ }
> +};
> +
> int input_device_register(struct btd_device *device,
> 					const char *path, const char *uuid,
> 					const sdp_record_t *rec, int timeout)
> @@ -723,6 +874,18 @@ int input_device_register(struct btd_device *device,
> 	if (!idev)
> 		return -EINVAL;
> 
> +	if (g_dbus_register_interface(btd_get_dbus_connection(),
> +					idev->path, INPUT_INTERFACE,
> +					NULL, NULL,
> +					input_properties, idev,
> +					NULL) == FALSE) {
> +		error("Unable to register %s interface", INPUT_INTERFACE);
> +		input_device_free(idev);
> +		return -EINVAL;
> +	}
> +
> +	extract_hid_props(idev, rec);
> +
> 	idev->timeout = timeout;
> 	idev->uuid = g_strdup(uuid);
> 
> @@ -761,6 +924,9 @@ int input_device_unregister(const char *path, const char *uuid)
> 		return -EBUSY;
> 	}
> 
> +	g_dbus_unregister_interface(btd_get_dbus_connection(),
> +						idev->path, INPUT_INTERFACE);
> +
> 	devices = g_slist_remove(devices, idev);
> 	input_device_free(idev);

Regards

Marcel

