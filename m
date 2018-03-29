Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180328101055.16375-1-szymon.janc@codecoup.pl>
References: <20180328101055.16375-1-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Mar 2018 15:45:43 +0300
Message-ID: <CABBYNZK6dm3tZcytVH4xrfbFzuCQLBN-xHAiEegrUv12GqPJZg@mail.gmail.com>
Subject: Re: [PATCH v2] gatt: Add support for storing Service Changed CCC value
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Mar 28, 2018 at 1:10 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> This adds support for storing CCC value of Service Changed
> characteristic. Once bluetoothd is restart stored values are read
> and any device subscribed to indications will receive Service Changed
> indication with 0x00010-0xffff value. This is to invalidate any
> non-core services since there is no way to verify if applications
> will register their services in same order (or at all).
>
> This fix accessing invalid handles by stacks that rely only on Service
> Changed indication for rediscovery ie. Apple iOS.
> ---
>  doc/settings-storage.txt |  8 +++++
>  src/adapter.c            |  3 ++
>  src/device.c             | 78 ++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h             |  6 ++++
>  src/gatt-database.c      | 85 ++++++++++++++++++++++++++++++++++++++++++++++--
>  src/gatt-database.h      |  2 ++
>  6 files changed, 180 insertions(+), 2 deletions(-)
>
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> index 160bbb246..dd6fc5746 100644
> --- a/doc/settings-storage.txt
> +++ b/doc/settings-storage.txt
> @@ -302,3 +302,11 @@ Long term key) related to a remote device.
>    Counter              Integer         Signing counter
>
>    Authenticated                Boolean         True if the key is authenticated
> +
> +[ServiceChanged]
> +
> +   This section holds informations related to Service Changed characteristic
> +   of GATT core service.
> +
> +  CCC_LE               Integer         CCC value for LE transport
> +  CCC_BR/EDR           Integer         CCC value for BR/EDR transport
> diff --git a/src/adapter.c b/src/adapter.c
> index 6b9222bcf..932b2a34d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8017,6 +8017,9 @@ load:
>         clear_blocked(adapter);
>         load_devices(adapter);
>
> +       /* restore Service Changed CCC value for bonded devices */
> +       btd_gatt_database_restore_svc_chng_ccc(adapter->database);
> +
>         /* retrieve the active connections: address the scenario where
>          * the are active connections before the daemon've started */
>         if (adapter->current_settings & MGMT_SETTING_POWERED)
> diff --git a/src/device.c b/src/device.c
> index ce515be9b..f693b7023 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5250,6 +5250,10 @@ const bdaddr_t *device_get_address(struct btd_device *device)
>  {
>         return &device->bdaddr;
>  }
> +uint8_t device_get_le_address_type(struct btd_device *device)
> +{
> +       return device->bdaddr_type;
> +}
>
>  const char *device_get_path(const struct btd_device *device)
>  {
> @@ -5347,6 +5351,80 @@ void device_set_legacy(struct btd_device *device, bool legacy)
>                                         DEVICE_INTERFACE, "LegacyPairing");
>  }
>
> +void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
> +                                                               uint16_t value)
> +{
> +       char filename[PATH_MAX];
> +       char device_addr[18];
> +       GKeyFile *key_file;
> +       uint16_t old_value;
> +       gsize length = 0;
> +       char *str;
> +
> +       ba2str(&device->bdaddr, device_addr);
> +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
> +                               btd_adapter_get_storage_dir(device->adapter),
> +                               device_addr);
> +
> +       key_file = g_key_file_new();
> +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +       /* for bonded devices this is done on every connection so limit writes
> +        * to storage if no change needed
> +        */
> +       if (bdaddr_type == BDADDR_BREDR) {
> +               old_value = g_key_file_get_integer(key_file, "ServiceChanged",
> +                                                       "CCC_BR/EDR", NULL);
> +               if (old_value == value)
> +                       goto done;
> +
> +               g_key_file_set_integer(key_file, "ServiceChanged", "CCC_BR/EDR",
> +                                                                       value);
> +       } else {
> +               old_value = g_key_file_get_integer(key_file, "ServiceChanged",
> +                                                       "CCC_LE", NULL);
> +               if (old_value == value)
> +                       goto done;
> +
> +               g_key_file_set_integer(key_file, "ServiceChanged", "CCC_LE",
> +                                                                       value);
> +       }
> +
> +       create_file(filename, S_IRUSR | S_IWUSR);
> +
> +       str = g_key_file_to_data(key_file, &length, NULL);
> +       g_file_set_contents(filename, str, length, NULL);
> +       g_free(str);
> +
> +done:
> +       g_key_file_free(key_file);
> +}
> +void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
> +                                                       uint16_t *ccc_bredr)
> +{
> +       char filename[PATH_MAX];
> +       char device_addr[18];
> +       GKeyFile *key_file;
> +
> +       ba2str(&device->bdaddr, device_addr);
> +       snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
> +                               btd_adapter_get_storage_dir(device->adapter),
> +                               device_addr);
> +
> +       key_file = g_key_file_new();
> +       g_key_file_load_from_file(key_file, filename, 0, NULL);
> +
> +       if (ccc_le)
> +               *ccc_le = g_key_file_get_integer(key_file, "ServiceChanged",
> +                                                       "CCC_LE", NULL);
> +
> +       if (ccc_bredr)
> +               *ccc_bredr = g_key_file_get_integer(key_file, "ServiceChanged",
> +                                                       "CCC_BR/EDR", NULL);
> +
> +       g_key_file_free(key_file);
> +}
> +
>  void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
>                                                         int8_t delta_threshold)
>  {
> diff --git a/src/device.h b/src/device.h
> index 306c813fc..b90f9273a 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -87,6 +87,7 @@ void device_probe_profile(gpointer a, gpointer b);
>  void device_remove_profile(gpointer a, gpointer b);
>  struct btd_adapter *device_get_adapter(struct btd_device *device);
>  const bdaddr_t *device_get_address(struct btd_device *device);
> +uint8_t device_get_le_address_type(struct btd_device *device);
>  const char *device_get_path(const struct btd_device *device);
>  gboolean device_is_temporary(struct btd_device *device);
>  bool device_is_connectable(struct btd_device *device);
> @@ -132,6 +133,11 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
>  bool device_is_disconnecting(struct btd_device *device);
>  void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size);
>
> +void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
> +                                                               uint16_t value);
> +void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
> +                                                       uint16_t *ccc_bredr);
> +
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
>                                         void *user_data);
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 5e2390b34..1cdc72e1b 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -264,7 +264,7 @@ static struct ccc_state *find_ccc_state(struct device_state *dev_state,
>  }
>
>  static struct device_state *device_state_create(struct btd_gatt_database *db,
> -                                                       bdaddr_t *bdaddr,
> +                                                       const bdaddr_t *bdaddr,
>                                                         uint8_t bdaddr_type)
>  {
>         struct device_state *dev_state;
> @@ -324,8 +324,19 @@ static void att_disconnected(int err, void *user_data)
>         if (!device)
>                 goto remove;
>
> -       if (device_is_bonded(device, state->bdaddr_type))
> +       if (device_is_bonded(device, state->bdaddr_type)) {
> +               struct ccc_state *ccc;
> +               uint16_t handle;
> +
> +               handle = gatt_db_attribute_get_handle(state->db->svc_chngd_ccc);
> +
> +               ccc = find_ccc_state(state, handle);
> +               if (ccc)
> +                       device_store_svc_chng_ccc(device, state->bdaddr_type,
> +                                                               ccc->value[0]);
> +
>                 return;
> +       }
>
>  remove:
>         /* Remove device state if device no longer exists or is not paired */
> @@ -1076,6 +1087,7 @@ static void state_set_pending(struct device_state *state, struct notify *notify)
>  {
>         uint16_t start, end, old_start, old_end;
>
> +       /* Cache this only for Service Changed */
>         if (notify->conf != service_changed_conf)
>                 return;
>
> @@ -3275,3 +3287,72 @@ void btd_gatt_database_att_connected(struct btd_gatt_database *database,
>         free(state->pending);
>         state->pending = NULL;
>  }
> +
> +static void restore_ccc(struct btd_gatt_database *database,
> +                       const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
> +{
> +       struct device_state *dev_state;
> +       struct ccc_state *ccc;
> +
> +       dev_state = device_state_create(database, addr, addr_type);
> +       queue_push_tail(database->device_states, dev_state);
> +
> +       ccc = new0(struct ccc_state, 1);
> +       ccc->handle = gatt_db_attribute_get_handle(database->svc_chngd_ccc);
> +       memcpy(ccc->value, &value, sizeof(ccc->value));
> +       queue_push_tail(dev_state->ccc_states, ccc);
> +}
> +
> +static void restore_state(struct btd_device *device, void *data)
> +{
> +       struct btd_gatt_database *database = data;
> +       uint16_t ccc_le, ccc_bredr;
> +
> +       device_load_svc_chng_ccc(device, &ccc_le, &ccc_bredr);
> +
> +       if (ccc_le) {
> +               restore_ccc(database, device_get_address(device),
> +                               device_get_le_address_type(device), ccc_le);
> +
> +               DBG("%s LE", device_get_path(device));
> +       }
> +
> +       if (ccc_bredr) {
> +               restore_ccc(database, device_get_address(device),
> +                                               BDADDR_BREDR, ccc_bredr);
> +
> +               DBG("%s BR/EDR", device_get_path(device));
> +       }
> +}
> +
> +void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database)
> +{
> +       uint8_t value[4];
> +       uint16_t handle, ccc_handle;
> +
> +       handle = gatt_db_attribute_get_handle(database->svc_chngd);
> +       ccc_handle = gatt_db_attribute_get_handle(database->svc_chngd_ccc);
> +
> +       if (!handle || !ccc_handle) {
> +               error("Failed to obtain handles for \"Service Changed\""
> +                                                       " characteristic");
> +               return;
> +       }
> +
> +       /* restore states for bonded device that registered for Service Changed
> +        * indication
> +        */
> +       btd_adapter_for_each_device(database->adapter, restore_state, database);
> +
> +       /* This needs to be updated (probably to 0x0001) if we ever change
> +        * core services
> +        *
> +        * TODO we could also store this info (along with CCC value) and be able
> +        * to send 0x0001-0xffff only once per device.
> +        */
> +       put_le16(0x000a, value);
> +       put_le16(0xffff, value + 2);
> +
> +       send_notification_to_devices(database, handle, value, sizeof(value),
> +                                       ccc_handle, service_changed_conf, NULL);
> +}
> diff --git a/src/gatt-database.h b/src/gatt-database.h
> index 0da33f604..a6c3139c4 100644
> --- a/src/gatt-database.h
> +++ b/src/gatt-database.h
> @@ -25,3 +25,5 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database);
>  struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
>  void btd_gatt_database_att_connected(struct btd_gatt_database *database,
>                                                 struct bt_att *att);
> +
> +void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database);
> --
> 2.14.3

Applied, thanks.

-- 
Luiz Augusto von Dentz
