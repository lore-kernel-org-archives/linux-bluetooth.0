Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jul 2012 10:58:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v15 02/14] audio: Move telephony drivers to D-Bus
 interface
Message-ID: <20120730075852.GA5208@x220>
References: <1343292324-959-1-git-send-email-frederic.danis@linux.intel.com>
 <1343292324-959-3-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1343292324-959-3-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, Jul 26, 2012, Frédéric Danis wrote:
> +static int parse_properties(DBusMessageIter *props, const char **uuid,
> +				uint16_t *version, uint16_t *features)
> +{
> +	gboolean has_uuid = FALSE;
> +
> +	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
> +		const char *key;
> +		DBusMessageIter value, entry;
> +		int var;
> +
> +		dbus_message_iter_recurse(props, &entry);
> +		dbus_message_iter_get_basic(&entry, &key);
> +
> +		dbus_message_iter_next(&entry);
> +		dbus_message_iter_recurse(&entry, &value);
> +
> +		var = dbus_message_iter_get_arg_type(&value);
> +		if (strcasecmp(key, "UUID") == 0) {
> +			if (var != DBUS_TYPE_STRING)
> +				return -EINVAL;
> +			dbus_message_iter_get_basic(&value, uuid);
> +			has_uuid = TRUE;
> +		} else if (strcasecmp(key, "Version") == 0) {
> +			if (var != DBUS_TYPE_UINT16)
> +				return -EINVAL;
> +			dbus_message_iter_get_basic(&value, version);
> +		} else if (strcasecmp(key, "Features") == 0) {
> +			if (var != DBUS_TYPE_UINT16)
> +				return -EINVAL;
> +			dbus_message_iter_get_basic(&value, features);
> +		}
> +
> +		dbus_message_iter_next(props);
> +	}
> +
> +	return (has_uuid) ? 0 : -EINVAL;
> +}

I suppose you could just make the above function return gboolean as it
only has two possible return values.

> +static int dev_close(struct telephony_device *tel_dev)
> +{
> +	int sock;
> +
> +	if (tel_dev->rfcomm) {
> +		sock = g_io_channel_unix_get_fd(tel_dev->rfcomm);
> +		shutdown(sock, SHUT_RDWR);
> +		tel_dev->rfcomm = NULL;
> +	}

Looks like you're missing a g_io_channel_unref there.

> +static void hs_newconnection_reply(DBusPendingCall *call, void *user_data)
> +{
> +	struct telephony_device *tel_dev = user_data;
> +	DBusMessage *reply = dbus_pending_call_steal_reply(call);
> +	DBusError derr;
> +
> +	dbus_error_init(&derr);
> +	if (!dbus_set_error_from_message(&derr, reply)) {
> +		DBG("Agent reply: file descriptor passed successfully");
> +		g_io_add_watch(tel_dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> +				(GIOFunc) hs_dev_disconnect_cb, tel_dev);
> +		headset_slc_complete(tel_dev->au_dev);
> +		goto done;
> +	}

Firstly, a more common way would be to test for positive return of
dbus_set_error_from_message and handle the error reply within the
if-clause. Secondly, please don't do callback typecasts (GIOFunc) but
instead just assign to the right type inside the callback function
itself.

> +static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
> +{
> +	struct telephony_device *tel_dev = user_data;

Here you do the right kind of handling of callback types. Why the
inconsistency?

> +	sdp_get_profile_descs(recs->data, &profiles);
> +	if (profiles == NULL)
> +		goto failed;

I think it'd be cleaner/simpler to do:

	if (sdp_get_profile_descs(...) < 0)
		goto failed;


> +	desc = profiles->data;
> +
> +	if (sdp_uuid16_cmp(&desc->uuid, &uuid) == 0)
> +		tel_dev->version = desc->version;

I don't think it's safe to assume that what's returned by
sdp_get_profile_descs is always a uuid16. Instead using sdp_uuid_cmp()
would seem more appropriate.

> +struct telephony_device *telephony_device_connecting(GIOChannel *io,
> +					struct btd_device *btd_dev,
> +					struct audio_device *au_dev,
> +					const char *uuid)
> +{
> +	struct btd_adapter *adapter;
> +	struct telephony_agent *agent;
> +	struct telephony_device *tel_dev;
> +	uuid_t r_uuid;
> +	int err;
> +
> +	adapter = device_get_adapter(btd_dev);
> +	agent = find_agent(adapter, NULL, NULL, uuid);
> +	if (agent == NULL)
> +		return NULL;
> +
> +	tel_dev = g_new0(struct telephony_device, 1);
> +	tel_dev->btd_dev = btd_device_ref(btd_dev);
> +	tel_dev->name = g_strdup(agent->name);
> +	tel_dev->path = g_strdup(agent->path);
> +	tel_dev->config = agent->config;
> +	tel_dev->au_dev = au_dev;
> +	tel_dev->rfcomm = io;

Missing g_io_channel_ref here.

> +	err = bt_search_service(&au_dev->src, &au_dev->dst, &r_uuid,
> +				get_record_cb, tel_dev, NULL);
> +	if (err < 0) {
> +		telephony_device_disconnect(tel_dev);
> +		return NULL;
> +	}
> +	tel_dev->pending_sdp = TRUE;

An empty line should follow after }

> +void telephony_device_disconnect(struct telephony_device *device)
> +{
> +	dev_close(device);
> +
> +	if (device->pending_sdp)
> +		return;

Shouldn't you cancel the SDP operation here with bt_cancel_discovery?

> +gboolean telephony_get_ready_state(struct btd_adapter *adapter)
> +{
> +	return find_agent(adapter, NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
> +}

If such a function is needed just call it telephony_is_ready. It makes
the calling side look more natural: "if (telephony_is_ready(adapter))".

> +static int register_interface(struct btd_adapter *adapter)
> +{
> +	const char *path;
> +
> +	path = adapter_get_path(adapter);
> +
> +	if (!g_dbus_register_interface(connection, path,
> +					AUDIO_TELEPHONY_INTERFACE,
> +					telsrv_methods, NULL,
> +					NULL, adapter, path_unregister)) {
> +		error("D-Bus failed to register %s interface",
> +				AUDIO_TELEPHONY_INTERFACE);
> +		return -1;
> +	}
> +
> +	DBG("Registered interface %s", AUDIO_TELEPHONY_INTERFACE);
> +
> +	return 0;
> +}
> +
> +static void unregister_interface(struct btd_adapter *adapter)
> +{
> +	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
> +			AUDIO_TELEPHONY_INTERFACE);
> +}
> +
> +int telephony_adapter_init(struct btd_adapter *adapter)
> +{
> +	DBG("adapter: %p", adapter);
> +
> +	return register_interface(adapter);
> +}
> +
> +void telephony_adapter_exit(struct btd_adapter *adapter)
> +{
> +	struct telephony_agent *agent;
> +
> +	DBG("adapter: %p", adapter);
> +
> +	unregister_interface(adapter);
> +
> +	while ((agent = find_agent(adapter, NULL, NULL, NULL)) != NULL) {
> +		agents = g_slist_remove(agents, agent);
> +		free_agent(agent);
> +	}
> +}

The register_interface and unregister_interface functions above seem
unnecessary to me. Just include their code directly within
telephony_adapter_init and telephony_adapter_exit.

Johan
