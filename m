Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340900155-26311-2-git-send-email-frederic.danis@linux.intel.com>
References: <1340900155-26311-1-git-send-email-frederic.danis@linux.intel.com>
	<1340900155-26311-2-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 5 Jul 2012 16:21:12 +0200
Message-ID: <CANT-zCVZx5QcPkh4Zeru1GvZrOyt2twqB9sy2Zz4KCRZWq_+YQ@mail.gmail.com>
Subject: Re: [PATCH v11 01/12] audio: Move telephony drivers to D-Bus interface
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

Some style-related nitpicking and a more interesting discussion afterwards.

On Thu, Jun 28, 2012 at 6:15 PM, Frédéric Danis
<frederic.danis@linux.intel.com> wrote:
> Add a D-Bus interface called org.bluez.Telephony to replace current
> telephony drivers for HeadSet/HandsFree Profiles.
>
> This will simplify BlueZ code by focusing on the Bluetooth
> communication part and by letting the external application (i.e. oFono)
> take charge of the Telephony tasks (AT parsing and modem specific code,
> which can be removed from BlueZ code). So, it becomes simpler, easier
> to maintain and debug.
>
> Telephony application will have to register an agent using this new
> interface.

<snip>

> diff --git a/audio/manager.c b/audio/manager.c
> index d442d1d..52079b8 100644
> --- a/audio/manager.c
> +++ b/audio/manager.c
> @@ -876,11 +876,11 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
>         adp->powered = powered;
>
>         if (powered) {
> -               /* telephony driver already initialized*/
> -               if (telephony == TRUE)
> -                       return;
> -               telephony_init();
> -               telephony = TRUE;
> +               if (telephony == FALSE) {
> +                       telephony_init();
> +                       telephony = TRUE;
> +               }
> +               telephony_adapter_init(adapter);

Empty line missing after if.

>                 return;
>         }
>
> @@ -888,6 +888,8 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
>         if (telephony == FALSE)
>                 return;
>
> +       telephony_adapter_exit(adapter);
> +
>         for (l = adapters; l; l = l->next) {
>                 adp = l->data;
>
> diff --git a/audio/telephony.c b/audio/telephony.c
> new file mode 100644
> index 0000000..43b7bac
> --- /dev/null
> +++ b/audio/telephony.c
> @@ -0,0 +1,596 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011  Intel Corporation
> + *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (C) 2011  Frederic Danis <frederic.danis@intel.com>
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdlib.h>
> +
> +#include <dbus/dbus.h>
> +#include <gdbus.h>
> +
> +#include <bluetooth/bluetooth.h>
> +#include <bluetooth/sdp.h>
> +#include <bluetooth/sdp_lib.h>
> +#include <bluetooth/uuid.h>
> +
> +#include "btio.h"
> +#include "log.h"
> +#include "device.h"
> +#include "error.h"
> +#include "glib-helper.h"
> +#include "sdp-client.h"
> +#include "headset.h"
> +#include "telephony.h"
> +#include "dbus-common.h"
> +#include "../src/adapter.h"
> +#include "../src/device.h"
> +
> +#define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
> +#define AUDIO_TELEPHONY_AGENT_INTERFACE "org.bluez.TelephonyAgent"
> +
> +#define DEFAULT_HS_HS_CHANNEL 6
> +#define DEFAULT_HF_HS_CHANNEL 7
> +
> +struct tel_device {
> +       void                    *au_dev;
> +       struct btd_device       *btd_dev;
> +       char                    *name;          /* agent DBus bus id */
> +       char                    *path;          /* agent object path */
> +       struct default_agent    *properties;
> +       GIOChannel              *rfcomm;
> +       uint16_t                version;
> +       uint16_t                features;
> +};
> +
> +struct default_agent {
> +       const char              *uuid;          /* agent property UUID */
> +       uint8_t                 channel;
> +       const char              *r_uuid;
> +       uint16_t                r_class;
> +       uint16_t                r_profile;
> +       DBusPendingCallNotifyFunction connection_reply;
> +};
> +
> +struct tel_agent {
> +       struct btd_adapter      *adapter;
> +       char                    *name;          /* agent DBus bus id */
> +       char                    *path;          /* agent object path */
> +       guint                   watch;          /* agent disconnect watcher */
> +       uint16_t                version;
> +       uint16_t                features;
> +       struct default_agent    *properties;
> +};
> +
> +static DBusConnection *connection = NULL;
> +
> +static GSList *agents = NULL;  /* server list */
> +
> +static void free_agent(struct tel_agent *agent)
> +{
> +       DBusMessage *msg;
> +
> +       if (agent->watch) {
> +               msg = dbus_message_new_method_call(agent->name, agent->path,
> +                               AUDIO_TELEPHONY_AGENT_INTERFACE, "Release");
> +               dbus_message_set_no_reply(msg, TRUE);
> +               g_dbus_send_message(connection, msg);
> +
> +               g_dbus_remove_watch(connection, agent->watch);
> +               agent->watch = 0;
> +       }
> +
> +       g_free(agent->name);
> +       g_free(agent->path);
> +       g_free(agent);
> +}
> +
> +static struct tel_agent *find_agent(struct btd_adapter *adapter,
> +                                       const char *sender, const char *path,
> +                                       const char *uuid)
> +{
> +       GSList *l;
> +
> +       for (l = agents; l; l = l->next) {
> +               struct tel_agent *agent = l->data;
> +
> +               if (agent->adapter != adapter)
> +                       continue;
> +
> +               if (sender && g_strcmp0(agent->name, sender) != 0)
> +                       continue;
> +
> +               if (path && g_strcmp0(agent->path, path) != 0)
> +                       continue;
> +
> +               if (uuid && g_strcmp0(agent->properties->uuid, uuid) != 0)
> +                       continue;
> +
> +               return agent;
> +       }
> +
> +       return NULL;
> +}
> +
> +void *telephony_agent_by_uuid(void *adapter, const char *uuid)
> +{
> +       return find_agent(adapter, NULL, NULL, uuid);
> +}
> +
> +static int parse_properties(DBusMessageIter *props, const char **uuid,
> +                               uint16_t *version, uint16_t *features)
> +{
> +       gboolean has_uuid = FALSE;
> +
> +       while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
> +               const char *key;
> +               DBusMessageIter value, entry;
> +               int var;
> +
> +               dbus_message_iter_recurse(props, &entry);
> +               dbus_message_iter_get_basic(&entry, &key);
> +
> +               dbus_message_iter_next(&entry);
> +               dbus_message_iter_recurse(&entry, &value);
> +
> +               var = dbus_message_iter_get_arg_type(&value);
> +               if (strcasecmp(key, "UUID") == 0) {
> +                       if (var != DBUS_TYPE_STRING)
> +                               return -EINVAL;
> +                       dbus_message_iter_get_basic(&value, uuid);
> +                       has_uuid = TRUE;
> +               } else if (strcasecmp(key, "Version") == 0) {
> +                       if (var != DBUS_TYPE_UINT16)
> +                               return -EINVAL;
> +                       dbus_message_iter_get_basic(&value, version);
> +               } else if (strcasecmp(key, "Features") == 0) {
> +                       if (var != DBUS_TYPE_UINT16)
> +                               return -EINVAL;
> +                       dbus_message_iter_get_basic(&value, features);
> +               }
> +
> +               dbus_message_iter_next(props);
> +       }
> +
> +       return (has_uuid) ? 0 : -EINVAL;
> +}
> +
> +static int dev_close(struct tel_device *dev)
> +{
> +       int sock;
> +
> +       if (dev->rfcomm) {
> +               sock = g_io_channel_unix_get_fd(dev->rfcomm);
> +               shutdown(sock, SHUT_RDWR);
> +       }
> +
> +       return 0;
> +}
> +
> +static gboolean agent_sendfd(struct tel_device *dev, int fd,
> +                               DBusPendingCallNotifyFunction notify)
> +{
> +       DBusMessage *msg;
> +       DBusMessageIter iter, dict;
> +       DBusPendingCall *call;
> +       const char *path;
> +
> +       msg = dbus_message_new_method_call(dev->name, dev->path,
> +                       AUDIO_TELEPHONY_AGENT_INTERFACE, "NewConnection");
> +
> +       dbus_message_iter_init_append(msg, &iter);
> +
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_UNIX_FD, &fd);
> +
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                       DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +                       DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
> +                       DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
> +
> +       path = device_get_path(dev->btd_dev);
> +       dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH, &path);
> +       dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING,
> +                                               &dev->properties->uuid);
> +       dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16, &dev->version);
> +
> +       if (dev->features != 0xFFFF)
> +               dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
> +                                                       &dev->features);
> +
> +       dbus_message_iter_close_container(&iter, &dict);
> +
> +       if (dbus_connection_send_with_reply(connection, msg, &call, -1)
> +                       == FALSE) {

I don't think this is consistent with the userland coding style.

> +               dbus_message_unref(msg);
> +               return FALSE;
> +       }
> +
> +       dbus_pending_call_set_notify(call, notify, dev, NULL);
> +       dbus_pending_call_unref(call);
> +       dbus_message_unref(msg);
> +
> +       return TRUE;
> +}
> +
> +static gboolean hs_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
> +                                               struct tel_device *dev)
> +{
> +       if (cond & G_IO_NVAL)
> +               return FALSE;
> +
> +       headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
> +
> +       return FALSE;
> +}
> +
> +static void hs_newconnection_reply(DBusPendingCall *call, void *user_data)
> +{
> +       struct tel_device *dev = user_data;
> +       DBusMessage *reply = dbus_pending_call_steal_reply(call);
> +       DBusError derr;
> +
> +       if (!dev->rfcomm) {
> +               DBG("RFCOMM disconnected from server before agent reply");
> +               goto done;
> +       }
> +
> +       dbus_error_init(&derr);
> +       if (!dbus_set_error_from_message(&derr, reply)) {
> +               DBG("Agent reply: file descriptor passed successfully");
> +               g_io_add_watch(dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> +                                       (GIOFunc) hs_dev_disconnect_cb, dev);
> +               headset_slc_complete(dev->au_dev);
> +               goto done;
> +       }
> +
> +       DBG("Agent reply: %s", derr.message);
> +
> +       dbus_error_free(&derr);
> +       headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
> +
> +done:
> +       dbus_message_unref(reply);
> +}
> +
> +static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
> +{
> +       struct tel_device *dev = user_data;
> +       sdp_data_t *sdpdata;
> +       uuid_t uuid;
> +       sdp_list_t *profiles;
> +       sdp_profile_desc_t *desc;
> +       int sk;
> +
> +       if (err < 0) {
> +               error("Unable to get service record: %s (%d)", strerror(-err),
> +                                       -err);
> +               goto failed;
> +       }
> +
> +       if (!recs || !recs->data) {
> +               error("No records found");
> +               goto failed;
> +       }
> +
> +       sdpdata = sdp_data_get(recs->data, SDP_ATTR_SUPPORTED_FEATURES);
> +       if (sdpdata && sdpdata->dtd == SDP_UINT16)
> +               dev->features = sdpdata->val.uint16;
> +
> +       sdp_uuid16_create(&uuid, dev->properties->r_profile);
> +
> +       sdp_get_profile_descs(recs->data, &profiles);
> +       if (profiles == NULL)
> +               goto failed;
> +
> +       desc = profiles->data;
> +
> +       if (sdp_uuid16_cmp(&desc->uuid, &uuid) == 0)
> +               dev->version = desc->version;
> +
> +       sdp_list_free(profiles, free);
> +
> +       sk = g_io_channel_unix_get_fd(dev->rfcomm);
> +
> +       if (agent_sendfd(dev, sk, dev->properties->connection_reply) == FALSE) {
> +               error("Failed to send RFComm socket to agent %s, path %s",
> +                                                       dev->name, dev->path);

Uppercase should probably used for RFComm.

> +               goto failed;
> +       }
> +
> +       return;
> +
> +failed:
> +       headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
> +}
> +
> +void *telephony_device_connecting(GIOChannel *io, struct btd_device *btd_dev,
> +                                       void *telephony_device, void *agent)
> +{
> +       struct audio_device *device = telephony_device;
> +       struct tel_device *dev;
> +       struct tel_agent *ag = agent;
> +       uuid_t uuid;
> +       int err;
> +
> +       dev = g_new0(struct tel_device, 1);
> +       dev->btd_dev = btd_dev;
> +       dev->name = g_strdup(ag->name);
> +       dev->path = g_strdup(ag->path);
> +       dev->properties = ag->properties;
> +       dev->au_dev = telephony_device;
> +       dev->rfcomm = io;
> +       dev->features = 0xFFFF;
> +
> +       sdp_uuid16_create(&uuid, dev->properties->r_class);
> +
> +       err = bt_search_service(&device->src, &device->dst, &uuid,
> +                                               get_record_cb, dev, NULL);
> +       if (err < 0) {
> +               g_free(dev->name);
> +               g_free(dev->path);
> +               g_free(dev);
> +               return NULL;
> +       }
> +
> +       return dev;
> +}
> +
> +void telephony_device_connected(void *telephony_device)
> +{
> +       DBG("telephony-dbus: device %p connected", telephony_device);
> +}
> +
> +void telephony_device_disconnect(void *slc)
> +{
> +       struct tel_device *dev = slc;
> +
> +       dev_close(dev);
> +
> +       g_free(dev->name);
> +       g_free(dev->path);
> +       g_free(dev);
> +}
> +
> +void telephony_device_disconnected(void *telephony_device)
> +{
> +       DBG("telephony-dbus: device %p disconnected", telephony_device);
> +}
> +
> +gboolean telephony_get_ready_state(void *adapter)
> +{
> +       return find_agent(adapter, NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
> +}
> +
> +uint32_t telephony_get_ag_features(void)
> +{
> +       return 0;
> +}
> +
> +static struct default_agent default_properties[] = {
> +       { HSP_AG_UUID,
> +               DEFAULT_HS_AG_CHANNEL,
> +               HSP_HS_UUID,
> +               HEADSET_SVCLASS_ID,
> +               HEADSET_PROFILE_ID,
> +               hs_newconnection_reply },
> +       { HFP_AG_UUID,
> +               DEFAULT_HF_AG_CHANNEL,
> +               HFP_HS_UUID,
> +               HANDSFREE_SVCLASS_ID,
> +               HANDSFREE_PROFILE_ID,
> +               hs_newconnection_reply },
> +};
> +
> +static void agent_disconnect_cb(DBusConnection *conn, void *user_data)
> +{
> +       struct tel_agent *agent = user_data;
> +
> +       DBG("Agent exited without calling Unregister");
> +
> +       agent->watch = 0;
> +       agents = g_slist_remove(agents, agent);
> +       free_agent(agent);
> +}
> +
> +static struct tel_agent *agent_new(struct btd_adapter *adapter,
> +                                       const char *sender, const char *path,
> +                                       const char *uuid, uint16_t version,
> +                                       uint16_t features)
> +{
> +       struct tel_agent *agent = NULL;
> +       unsigned int i;
> +
> +       for (i = 0; i < sizeof(default_properties) /
> +                               sizeof(struct default_agent) ; i++) {
> +               if (strcasecmp(uuid, default_properties[i].uuid) == 0) {
> +                       agent = g_new0(struct tel_agent, 1);
> +                       agent->adapter = adapter;
> +                       agent->properties = &default_properties[i];
> +                       agent->name = g_strdup(sender);
> +                       agent->path = g_strdup(path);
> +                       agent->version = version;
> +                       agent->features = features;
> +                       break;
> +               }
> +       }
> +
> +       return agent;
> +}
> +
> +static DBusMessage *register_agent(DBusConnection *conn,
> +                                       DBusMessage *msg, void *data)
> +{
> +       struct btd_adapter *adapter = data;
> +       DBusMessageIter args, props;
> +       const char *sender, *path, *uuid;
> +       uint16_t version = 0;
> +       uint16_t features = 0xFFFF;
> +       struct tel_agent *agent;
> +
> +       sender = dbus_message_get_sender(msg);
> +
> +       dbus_message_iter_init(msg, &args);
> +
> +       dbus_message_iter_get_basic(&args, &path);
> +       dbus_message_iter_next(&args);
> +
> +       if (find_agent(adapter, sender, path, NULL) != NULL)
> +               return btd_error_already_exists(msg);
> +
> +       dbus_message_iter_recurse(&args, &props);
> +       if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
> +               return btd_error_invalid_args(msg);
> +
> +       if (parse_properties(&props, &uuid, &version, &features) < 0)
> +               return btd_error_invalid_args(msg);
> +
> +       if (find_agent(adapter, NULL, NULL, uuid) != NULL)
> +               return btd_error_already_exists(msg);
> +
> +       /* initialize agent properties */
> +       agent = agent_new(adapter, sender, path, uuid, version, features);
> +       if (agent == NULL)
> +               return btd_error_invalid_args(msg);
> +
> +       agent->watch = g_dbus_add_disconnect_watch(conn, sender,
> +                                                       agent_disconnect_cb,
> +                                                       agent, NULL);
> +
> +       DBG("Register agent : %s%s for %s version 0x%04X with features 0x%02X",
> +                                       sender, path, uuid, version, features);
> +
> +       agents = g_slist_append(agents, agent);
> +
> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> +}
> +
> +static DBusMessage *unregister_agent(DBusConnection *conn,
> +                               DBusMessage *msg, void *data)
> +{
> +       struct btd_adapter *adapter = data;
> +       const char *sender, *path;
> +       struct tel_agent *agent;
> +
> +       if (!dbus_message_get_args(msg, NULL,
> +                               DBUS_TYPE_OBJECT_PATH, &path,
> +                               DBUS_TYPE_INVALID))
> +               return NULL;
> +
> +       sender = dbus_message_get_sender(msg);
> +
> +       agent = find_agent(adapter, sender, path, NULL);
> +       if (agent == NULL)
> +               return btd_error_does_not_exist(msg);
> +
> +       agents = g_slist_remove(agents, agent);
> +
> +       DBG("Unregister agent : %s%s", sender, path);
> +
> +       free_agent(agent);
> +
> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> +}
> +
> +static const GDBusMethodTable telsrv_methods[] = {
> +       { GDBUS_METHOD("RegisterAgent",
> +                       GDBUS_ARGS({ "agent", "o" }, { "properties", "a{sv}" }),
> +                       NULL, register_agent) },
> +       { GDBUS_METHOD("UnregisterAgent",
> +                       GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
> +       { }
> +};
> +
> +static void path_unregister(void *data)
> +{
> +       DBG("Unregistered interface %s", AUDIO_TELEPHONY_INTERFACE);
> +}
> +
> +static int register_interface(void *adapter)
> +{
> +       const char *path;
> +
> +       if (DBUS_TYPE_UNIX_FD < 0)
> +               return -1;
> +
> +       path = adapter_get_path(adapter);
> +
> +       if (!g_dbus_register_interface(connection, path,
> +                                       AUDIO_TELEPHONY_INTERFACE,
> +                                       telsrv_methods, NULL,
> +                                       NULL, adapter, path_unregister)) {
> +               error("D-Bus failed to register %s interface",
> +                               AUDIO_TELEPHONY_INTERFACE);
> +               return -1;
> +       }
> +
> +       DBG("Registered interface %s", AUDIO_TELEPHONY_INTERFACE);
> +
> +       return 0;
> +}
> +
> +static void unregister_interface(void *adapter)
> +{
> +       g_dbus_unregister_interface(connection, adapter_get_path(adapter),
> +                       AUDIO_TELEPHONY_INTERFACE);
> +}
> +
> +int telephony_adapter_init(void *adapter)
> +{
> +       DBG("adapter: %p", adapter);
> +
> +       return register_interface(adapter);
> +}
> +
> +void telephony_adapter_exit(void *adapter)
> +{
> +       struct tel_agent *agent;
> +
> +       DBG("adapter: %p", adapter);
> +
> +       unregister_interface(adapter);
> +
> +       while ((agent = find_agent(adapter, NULL, NULL, NULL)) != NULL) {
> +               agents = g_slist_remove(agents, agent);
> +               free_agent(agent);
> +       }
> +}
> +
> +int telephony_init(void)
> +{
> +       DBG("");
> +
> +       connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +
> +       return 0;
> +}
> +
> +void telephony_exit(void)
> +{
> +       DBG("");
> +
> +       dbus_connection_unref(connection);
> +       connection = NULL;
> +}
> diff --git a/audio/telephony.h b/audio/telephony.h
> index 73b390c..05ec932 100644
> --- a/audio/telephony.h
> +++ b/audio/telephony.h
> @@ -144,26 +144,15 @@ struct indicator {
>  /* Notify telephony-*.c of connected/disconnected devices. Implemented by
>   * telephony-*.c
>   */
> +void *telephony_device_connecting(GIOChannel *io, struct btd_device *dev,
> +                                       void *telephony_device, void *agent);
>  void telephony_device_connected(void *telephony_device);
> +void telephony_device_disconnect(void *slc);
>  void telephony_device_disconnected(void *telephony_device);
>
> -/* HF requests (sent by the handsfree device). These are implemented by
> - * telephony-*.c
> - */
> -void telephony_event_reporting_req(void *telephony_device, int ind);
> -void telephony_response_and_hold_req(void *telephony_device, int rh);
> -void telephony_last_dialed_number_req(void *telephony_device);
> -void telephony_terminate_call_req(void *telephony_device);
> -void telephony_answer_call_req(void *telephony_device);
> -void telephony_dial_number_req(void *telephony_device, const char *number);
> -void telephony_transmit_dtmf_req(void *telephony_device, char tone);
> -void telephony_subscriber_number_req(void *telephony_device);
> -void telephony_list_current_calls_req(void *telephony_device);
> -void telephony_operator_selection_req(void *telephony_device);
> -void telephony_call_hold_req(void *telephony_device, const char *cmd);
> -void telephony_nr_and_ec_req(void *telephony_device, gboolean enable);
> -void telephony_voice_dial_req(void *telephony_device, gboolean enable);
> -void telephony_key_press_req(void *telephony_device, const char *keys);
> +gboolean telephony_get_ready_state(void *adapter);
> +uint32_t telephony_get_ag_features(void);
> +void *telephony_agent_by_uuid(void *adapter, const char *uuid);
>
>  /* AG responses to HF requests. These are implemented by headset.c */
>  int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err);
> @@ -240,5 +229,7 @@ static inline int telephony_get_indicator(const struct indicator *indicators,
>         return -ENOENT;
>  }
>
> +int telephony_adapter_init(void *adapter);
> +void telephony_adapter_exit(void *adapter);
>  int telephony_init(void);
>  void telephony_exit(void);
> diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
> index cda934c..120d7ea 100644
> --- a/doc/assigned-numbers.txt
> +++ b/doc/assigned-numbers.txt
> @@ -8,6 +8,7 @@ avoid conflicts.
>  Profile                Channel
>  -----------------------
>  DUN            1
> +HSP HS         6
>  HFP HF         7
>  OPP            9
>  FTP            10
> diff --git a/doc/audio-api.txt b/doc/audio-api.txt
> index 9b1737d..fe34061 100644
> --- a/doc/audio-api.txt
> +++ b/doc/audio-api.txt
> @@ -456,3 +456,94 @@ properties boolean Connected [readonly]
>                 uint16 MicrophoneGain  [readonly]
>
>                         The speaker gain when available.
> +
> +
> +Telephony hierarchy
> +===================
> +
> +Service                org.bluez
> +Interface      org.bluez.Telephony
> +Object path    [variable prefix]/{hci0,hci1,...}
> +
> +Methods                void RegisterAgent(object path, dict properties)
> +
> +                       Register a TelephonyAgent to sender, the sender can
> +                       register as many agents as it likes.
> +
> +                       Note: If the sender disconnects its agents are
> +                       automatically unregistered.
> +
> +                       possible properties:
> +
> +                               string UUID:
> +
> +                                       UUID of the profile which the agent is
> +                                       for.
> +
> +                               uint16 Version:
> +
> +                                       Version of the profile which the agent
> +                                       implements.
> +
> +                               uint16 Features:
> +
> +                                       Agent supported features as defined in
> +                                       profile spec e.g. HFP.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +
> +

Second empty line should be removed.

> +               void UnregisterAgent(object path)
> +
> +                       Unregister sender agent.
> +
> +TelephonyAgent hierarchy
> +========================
> +
> +Service                unique name
> +Interface      org.bluez.TelephonyAgent
> +Object path    freely definable
> +
> +Methods                void NewConnection(filedescriptor fd, dict properties)
> +
> +                       This method gets called whenever a new connection
> +                       has been established. This method assumes that DBus

s/DBus/D-Bus/.

> +                       daemon with file descriptor passing capability is
> +                       being used.
> +
> +                       The agent should only return successfully once the
> +                       establishment of the service level connection (SLC)
> +                       has been completed.  In the case of Handsfree this
> +                       means that BRSF exchange has been performed and
> +                       necessary initialization has been done.
> +
> +                       possible properties:
> +
> +                               object Device:
> +
> +                                       BlueZ remote device object.
> +
> +                               string UUID:
> +
> +                                       Profile UUID of the connection.
> +
> +                               uint16 Version:
> +
> +                                       Remote profile version.
> +
> +                               uint16 Features:
> +
> +                                       Remote profile features.
> +
> +                               object Transport:
> +
> +                                       Optional. MediaTransport object path.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.Failed
> +
> +               void Release()
> +
> +                       This method gets called whenever the service daemon
> +                       unregisters the agent or whenever the Adapter where
> +                       the TelephonyAgent registers itself is removed.
> diff --git a/doc/audio-telephony-design.txt b/doc/audio-telephony-design.txt
> new file mode 100644
> index 0000000..dc92ff8
> --- /dev/null
> +++ b/doc/audio-telephony-design.txt
> @@ -0,0 +1,107 @@
> +The org.bluez.Telephony interface will simplify BlueZ code by focusing on
> +the Bluetooth communication part and by letting the external application (i.e.
> +oFono) take charge of the Telephony tasks (AT parsing and modem specific code).
> +So, it becomes simpler, easier to maintain and debug.
> +
> +External applications, which should implement AT parsing and telephony
> +part of HeadSet or HandsFree Profiles, will have to register an
> +org.bluez.TelephonyAgent using this new interface.

Newline should be removed here.

> +This will setup a SDP record for the profile and a RFComm server listening for
> +incoming connection.
> +
> +When a new device is connected, NewConnection method of TelephonyAgent is
> +called. The telephony agent should reply to it after proper communication
> +establishment (directly for HSP or after SLC setup completes for HFP).
> +
> +Interaction with the audio component (i.e. PulseAudio) will be done through the
> +MediaTransport object (passed to telephony agent during NewConnection call).

This is where the interesting part begins: how exactly are you
planning to do this?

Perhaps I'm missing something but I see no relation between Media
transport and telephony agent in your patchset. It seems this part of
the documentation is inconsistent with the code.

I don't understand your original motivation to do this, but from my
point of view, something similar would actually be interesting to
propagate call-states (HFP) from oFono to PulseAudio. This information
can later be useful for audio routing policies in PulseAudio.

That being said, I'm not sure if the Telephony API is the proper way
to address this.

Cheers,
Mikel
