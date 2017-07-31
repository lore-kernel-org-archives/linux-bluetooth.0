Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170728120754.5263-1-luiz.dentz@gmail.com>
References: <20170728120754.5263-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Jul 2017 19:30:23 +0300
Message-ID: <CABBYNZLqZ46GAjy4LRiyHnKgaasuSKP+qOHyLdxzcifCHVPEag@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] core: Add ResetData filter
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 28, 2017 at 3:07 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Reset service/manufactorer data so the application can see each and
> every instance of them.
> ---
>  doc/adapter-api.txt |  5 +++++
>  src/adapter.c       | 40 ++++++++++++++++++++++++++++++++++++----
>  src/device.c        | 12 ++++++++++--
>  src/device.h        |  5 +++--
>  4 files changed, 54 insertions(+), 8 deletions(-)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 08de6cd87..03b56119d 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -58,6 +58,7 @@ Methods               void StartDiscovery()
>                         int16         RSSI      : RSSI threshold value
>                         uint16        Pathloss  : Pathloss threshold value
>                         string        Transport : type of scan to run
> +                       bool          ResetData : Reset advertisement data
>
>                         When a remote device is found that advertises any UUID
>                         from UUIDs, it will be reported if:
> @@ -90,6 +91,10 @@ Methods              void StartDiscovery()
>                         the RSSI delta-threshold, that is imposed by
>                         StartDiscovery by default, will not be applied.
>
> +                       If ResetData is enabled PropertiesChanged signals will
> +                       be generated for either ManufacturerData and ServiceData
> +                       everytime they are discovered.
> +
>                         When multiple clients call SetDiscoveryFilter, their
>                         filters are internally merged, and notifications about
>                         new devices are sent to all clients. Therefore, each
> diff --git a/src/adapter.c b/src/adapter.c
> index 39354602e..a2c8b44b9 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -155,6 +155,7 @@ struct discovery_filter {
>         uint16_t pathloss;
>         int16_t rssi;
>         GSList *uuids;
> +       bool reset;
>  };
>
>  struct watch_client {
> @@ -2213,6 +2214,16 @@ static bool parse_transport(DBusMessageIter *value, uint8_t *transport)
>         return true;
>  }
>
> +static bool parse_reset_data(DBusMessageIter *value, bool *duplicates)
> +{
> +       if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
> +               return false;
> +
> +       dbus_message_iter_get_basic(value, duplicates);
> +
> +       return true;
> +}
> +
>  static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
>                                                 struct discovery_filter *filter)
>  {
> @@ -2228,6 +2239,9 @@ static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
>         if (!strcmp("Transport", key))
>                 return parse_transport(value, &filter->type);
>
> +       if (!strcmp("ResetData", key))
> +               return parse_reset_data(value, &filter->reset);
> +
>         DBG("Unknown key parameter: %s!\n", key);
>         return false;
>  }
> @@ -2253,6 +2267,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
>         (*filter)->pathloss = DISTANCE_VAL_INVALID;
>         (*filter)->rssi = DISTANCE_VAL_INVALID;
>         (*filter)->type = get_scan_type(adapter);
> +       (*filter)->reset = false;
>
>         dbus_message_iter_init(msg, &iter);
>         if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
> @@ -2297,8 +2312,9 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
>             (*filter)->rssi != DISTANCE_VAL_INVALID)
>                 goto invalid_args;
>
> -       DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d",
> -           (*filter)->type, (*filter)->rssi, (*filter)->pathloss);
> +       DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d "
> +               " reset data: %s ", (*filter)->type, (*filter)->rssi,
> +               (*filter)->pathloss, (*filter)->reset ? "true" : "false");
>
>         return true;
>
> @@ -5568,6 +5584,17 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
>         return got_match;
>  }
>
> +static void filter_reset_data(void *data, void *user_data)
> +{
> +       struct watch_client *client = data;
> +       bool *reset = user_data;
> +
> +       if (*reset || !client->discovery_filter)
> +               return;
> +
> +       *reset = client->discovery_filter->reset;
> +}
> +
>  static void update_found_devices(struct btd_adapter *adapter,
>                                         const bdaddr_t *bdaddr,
>                                         uint8_t bdaddr_type, int8_t rssi,
> @@ -5579,6 +5606,7 @@ static void update_found_devices(struct btd_adapter *adapter,
>         struct eir_data eir_data;
>         bool name_known, discoverable;
>         char addr[18];
> +       bool reset = false;
>
>         memset(&eir_data, 0, sizeof(eir_data));
>         eir_parse(&eir_data, data, data_len);
> @@ -5678,13 +5706,17 @@ static void update_found_devices(struct btd_adapter *adapter,
>
>         device_add_eir_uuids(dev, eir_data.services);
>
> +       if (adapter->discovery_list)
> +               g_slist_foreach(adapter->discovery_list, filter_reset_data,
> +                                                               &reset);
> +
>         if (eir_data.msd_list) {
> -               device_set_manufacturer_data(dev, eir_data.msd_list);
> +               device_set_manufacturer_data(dev, eir_data.msd_list, reset);
>                 adapter_msd_notify(adapter, dev, eir_data.msd_list);
>         }
>
>         if (eir_data.sd_list)
> -               device_set_service_data(dev, eir_data.sd_list);
> +               device_set_service_data(dev, eir_data.sd_list, reset);
>
>         if (bdaddr_type != BDADDR_BREDR)
>                 device_set_flags(dev, eir_data.flags);
> diff --git a/src/device.c b/src/device.c
> index fb9c0e766..f34d408fa 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1611,8 +1611,12 @@ static void add_manufacturer_data(void *data, void *user_data)
>                                         DEVICE_INTERFACE, "ManufacturerData");
>  }
>
> -void device_set_manufacturer_data(struct btd_device *dev, GSList *list)
> +void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
> +                                                               bool reset)
>  {
> +       if (reset)
> +               bt_ad_clear_manufacturer_data(dev->ad);
> +
>         g_slist_foreach(list, add_manufacturer_data, dev);
>  }
>
> @@ -1632,8 +1636,12 @@ static void add_service_data(void *data, void *user_data)
>                                         DEVICE_INTERFACE, "ServiceData");
>  }
>
> -void device_set_service_data(struct btd_device *dev, GSList *list)
> +void device_set_service_data(struct btd_device *dev, GSList *list,
> +                                                       bool reset)
>  {
> +       if (reset)
> +               bt_ad_clear_service_data(dev->ad);
> +
>         g_slist_foreach(list, add_service_data, dev);
>  }
>
> diff --git a/src/device.h b/src/device.h
> index 3cab366ee..5f56918ed 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -76,8 +76,9 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
>  bool device_attach_att(struct btd_device *dev, GIOChannel *io);
>  void btd_device_add_uuid(struct btd_device *device, const char *uuid);
>  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
> -void device_set_manufacturer_data(struct btd_device *dev, GSList *list);
> -void device_set_service_data(struct btd_device *dev, GSList *list);
> +void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
> +                                                               bool reset);
> +void device_set_service_data(struct btd_device *dev, GSList *list, bool reset);
>  void device_probe_profile(gpointer a, gpointer b);
>  void device_remove_profile(gpointer a, gpointer b);
>  struct btd_adapter *device_get_adapter(struct btd_device *device);
> --
> 2.13.3

Applied.


-- 
Luiz Augusto von Dentz
