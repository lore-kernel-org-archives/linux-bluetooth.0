Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171122142724.27865-1-luiz.dentz@gmail.com>
References: <20171122142724.27865-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Nov 2017 11:11:42 +0200
Message-ID: <CABBYNZLOF+2Ty+Sj4MGDa7wb=2=q1sptSvwDqyBQVFd3c14QQg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Cleanup temporary devices using private addresses
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 22, 2017 at 4:27 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Cleanup temporary devices using private addresses during the
> discovery as they may not be valid anymore since they can be rotated at
> any point it may change its address while temp_devices_timeout is active.
> ---
>  src/adapter.c | 15 +++++++++++++++
>  src/device.c  | 16 ++++++++--------
>  src/device.h  |  1 +
>  3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 4d20acb83..7708c3eea 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1766,6 +1766,8 @@ static gboolean remove_temp_devices(gpointer user_data)
>
>  static void discovery_cleanup(struct btd_adapter *adapter)
>  {
> +       GSList *l, *next;
> +
>         adapter->discovery_type = 0x00;
>
>         if (adapter->discovery_idle_timeout > 0) {
> @@ -1785,6 +1787,19 @@ static void discovery_cleanup(struct btd_adapter *adapter)
>         if (!adapter->devices)
>                 return;
>
> +       /* Cleanup temporary device using private address */
> +       for (l = adapter->devices; l != NULL; l = next) {
> +               struct btd_device *dev = l->data;
> +
> +               next = g_slist_next(l);
> +
> +               if (!device_is_private(dev))
> +                       continue;
> +
> +               if (device_is_temporary(dev) && !btd_device_is_connected(dev))
> +                       btd_adapter_remove_device(adapter, dev);
> +       }
> +
>         adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
>                                                 remove_temp_devices, adapter);
>  }
> diff --git a/src/device.c b/src/device.c
> index 7701987a7..206d3fc10 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -459,7 +459,7 @@ static gboolean store_device_info_cb(gpointer user_data)
>         return FALSE;
>  }
>
> -static bool device_address_is_private(struct btd_device *dev)
> +bool device_is_private(struct btd_device *dev)
>  {
>         if (dev->bdaddr_type != BDADDR_LE_RANDOM)
>                 return false;
> @@ -478,7 +478,7 @@ static void store_device_info(struct btd_device *device)
>         if (device->temporary || device->store_id > 0)
>                 return;
>
> -       if (device_address_is_private(device)) {
> +       if (device_is_private(device)) {
>                 warn("Can't store info for private addressed device %s",
>                                                                 device->path);
>                 return;
> @@ -495,7 +495,7 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
>         char *data;
>         gsize length = 0;
>
> -       if (device_address_is_private(dev)) {
> +       if (device_is_private(dev)) {
>                 warn("Can't store name for private addressed device %s",
>                                                                 dev->path);
>                 return;
> @@ -1984,7 +1984,7 @@ static void store_services(struct btd_device *device)
>         char *data;
>         gsize length = 0;
>
> -       if (device_address_is_private(device)) {
> +       if (device_is_private(device)) {
>                 warn("Can't store services for private addressed device %s",
>                                                                 device->path);
>                 return;
> @@ -2173,7 +2173,7 @@ static void store_gatt_db(struct btd_device *device)
>         gsize length = 0;
>         struct gatt_saver saver;
>
> -       if (device_address_is_private(device)) {
> +       if (device_is_private(device)) {
>                 warn("Can't store GATT db for private addressed device %s",
>                                                                 device->path);
>                 return;
> @@ -2759,7 +2759,7 @@ static char *load_cached_name(struct btd_device *device, const char *local,
>         char *str = NULL;
>         int len;
>
> -       if (device_address_is_private(device))
> +       if (device_is_private(device))
>                 return NULL;
>
>         snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
> @@ -3763,7 +3763,7 @@ char *btd_device_get_storage_path(struct btd_device *device,
>  {
>         char srcaddr[18], dstaddr[18];
>
> -       if (device_address_is_private(device)) {
> +       if (device_is_private(device)) {
>                 warn("Refusing storage path for private addressed device %s",
>                                                                 device->path);
>                 return NULL;
> @@ -5214,7 +5214,7 @@ void btd_device_set_temporary(struct btd_device *device, bool temporary)
>         if (device->temporary == temporary)
>                 return;
>
> -       if (device_address_is_private(device))
> +       if (device_is_private(device))
>                 return;
>
>         DBG("temporary %d", temporary);
> diff --git a/src/device.h b/src/device.h
> index 32f8edce5..2415b512f 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -89,6 +89,7 @@ struct btd_adapter *device_get_adapter(struct btd_device *device);
>  const bdaddr_t *device_get_address(struct btd_device *device);
>  const char *device_get_path(const struct btd_device *device);
>  gboolean device_is_temporary(struct btd_device *device);
> +bool device_is_private(struct btd_device *device);
>  bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
>  bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
>  gboolean device_is_trusted(struct btd_device *device);
> --
> 2.13.6

Applied.


-- 
Luiz Augusto von Dentz
