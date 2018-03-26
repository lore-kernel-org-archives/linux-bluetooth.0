Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8749589.KtZPE1j0KQ@ix>
References: <20180323120618.6260-1-szymon.janc@codecoup.pl>
 <CABBYNZKu=5PH8ktzzWbnB2Er2pOzp9z6VHP0kS5-6b+c4GTmKg@mail.gmail.com> <8749589.KtZPE1j0KQ@ix>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Mar 2018 17:51:55 +0300
Message-ID: <CABBYNZKfHhfbN4H9iTPC=cWX4esg=3zS8AX0W8iNqH6OqZ-81w@mail.gmail.com>
Subject: Re: [PATCH] gatt: Add support for storing Service Changed CCC value
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Mar 26, 2018 at 5:25 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi Luiz,
>
> On Monday, 26 March 2018 11:33:38 CEST Luiz Augusto von Dentz wrote:
>> Hi Szymon,
>>
>> On Fri, Mar 23, 2018 at 2:06 PM, Szymon Janc <szymon.janc@codecoup.pl>
> wrote:
>> > This adds support for storing CCC value of Service Changed
>> > characteristic. Once bluetoothd is restart stored values are read
>> > and any device subscribed to indications will receive Service Changed
>> > indication with 0x00010-0xffff value. This is to invalidate any
>> > non-core services since there is no way to verify if applications
>> > will register their services in same order (or at all).
>> >
>> > This fix accessing invalid handles by stacks that rely only on Service
>> > Changed indication for rediscovery ie. Apple iOS.
>> > ---
>> >
>> >  src/adapter.c       |   3 ++
>> >  src/device.c        |  49 +++++++++++++++++++++++++
>> >  src/device.h        |   4 +++
>> >  src/gatt-database.c | 100
>> >  +++++++++++++++++++++++++++++++++++++++++++++++++--- src/gatt-database.h
>> >  |   2 ++
>> >  5 files changed, 154 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/src/adapter.c b/src/adapter.c
>> > index 6d7d61504..fba01df0c 100644
>> > --- a/src/adapter.c
>> > +++ b/src/adapter.c
>> >
>> > @@ -7998,6 +7998,9 @@ load:
>> >         clear_blocked(adapter);
>> >         load_devices(adapter);
>> >
>> > +       /* restore Service Changed CCC value for bonded devices */
>> > +       btd_gatt_database_restore_svc_chng_ccc(adapter->database);
>> > +
>> >
>> >         /* retrieve the active connections: address the scenario where
>> >
>> >          * the are active connections before the daemon've started */
>> >
>> >         if (adapter->current_settings & MGMT_SETTING_POWERED)
>> >
>> > diff --git a/src/device.c b/src/device.c
>> > index bf5441543..f624649ff 100644
>> > --- a/src/device.c
>> > +++ b/src/device.c
>> > @@ -225,6 +225,9 @@ struct btd_device {
>> >
>> >         uint16_t att_mtu;                       /* The ATT MTU */
>> >         unsigned int att_disconn_id;
>> >
>> > +       uint16_t le_svc_cng_ccc;
>> > +       uint16_t br_svc_cng_ccc;
>>
>> I wonder why can't we pass these directly to gatt-database.c? I mean
>> once you load it you could call restore_state directly instead of
>> iterating to each device
>> and calling device_get_svc_chng_ccc.
>
> It was initially like that, but the thing is that CCC value might be set
> before device is bonded but must be stored only after it bonded. So to handle
> this only in gatt-database it would have to track if/when device is bonded.

Fair enough, it just looked a little odd the dependency is
gatt-database.c -> device.c for storing but for loading is the
opposite.

>>
>> >         /*
>> >
>> >          * TODO: For now, device creates and owns the client-role gatt_db,
>> >          but
>> >          * this needs to be persisted in a more central place so that
>> >          proper
>> >
>> > @@ -364,6 +367,17 @@ static void store_csrk(struct csrk_info *csrk,
>> > GKeyFile *key_file,>
>> >         g_key_file_set_integer(key_file, group, "Counter", csrk->counter);
>> >
>> >  }
>> >
>> > +static void update_svc_chng_ccc(GKeyFile *file, struct btd_device *dev)
>> > +{
>> > +       if (dev->bredr && dev->bredr_state.bonded)
>> > +               g_key_file_set_integer(file, "ServiceChanged",
>> > "CCC_BR/EDR", +
>> > dev->br_svc_cng_ccc); +
>> > +       if (dev->le && dev->le_state.bonded)
>> > +               g_key_file_set_integer(file, "ServiceChanged", "CCC_LE",
>> > +
>> > dev->le_svc_cng_ccc); +}
>> > +
>> >
>> >  static gboolean store_device_info_cb(gpointer user_data)
>> >  {
>> >
>> >         struct btd_device *device = user_data;
>> >
>> > @@ -408,6 +422,7 @@ static gboolean store_device_info_cb(gpointer
>> > user_data)>
>> >         }
>> >
>> >         update_technologies(key_file, device);
>> >
>> > +       update_svc_chng_ccc(key_file, device);
>> >
>> >         g_key_file_set_boolean(key_file, "General", "Trusted",
>> >
>> >                                                         device->trusted);
>> >
>> > @@ -2991,6 +3006,16 @@ static void load_info(struct btd_device *device,
>> > const char *local,>
>> >                 device->remote_csrk = load_csrk(key_file,
>> >                 "RemoteSignatureKey");
>> >
>> >         }
>> >
>> > +       if (device->bredr)
>> > +               device->br_svc_cng_ccc = g_key_file_get_integer(key_file,
>> > +                                               "ServiceChanged",
>> > "CCC_BR/EDR", +                                               NULL);
>> > +
>> > +       if (device->le)
>> > +               device->le_svc_cng_ccc = g_key_file_get_integer(key_file,
>> > +                                               "ServiceChanged",
>> > "CCC_LE",
>> > +                                               NULL);
>>
>> We should probably document these in the storage documentation. Also
>
> Right, I'll update documentation.
>
>> Id like to store the core service handle range along with it so we can
>> compare and in case it changes a full reset shall be sent, it is not
>> fail proof but it should make it easier to detect if plugin register a
>> service which shall probably be considered a fixed service as well.
>
> We can do that for core (ie GAP and GATT) which are handled in gatt-database.c
> anyway (there is even command on this in the patch). I'm not sure about other
> plugins though. With core it is simple, we just need to track end handle,  for
> plugins... should ranges be stored and compared?

Yep, we would probably need to separate the handle range of
application, with that it should be able to detect if a plugin is
adding a service or it is an application, but perhaps we should leave
this for later as the
as there are no plugins adding service currently.

> Also, do we have plugins that act as GATT server? Weren't those deprecated and
> removed?

The old ones were deprecated because none of them require tight
integration with the daemon, but there could be services that would
still require being a plugin, e.g. BAS or something like that.

>>
>> >         g_strfreev(techno);
>> >
>> >  next:
>> > @@ -5238,6 +5263,10 @@ const bdaddr_t *device_get_address(struct
>> > btd_device *device)>
>> >  {
>> >
>> >         return &device->bdaddr;
>> >
>> >  }
>> >
>> > +uint8_t device_get_le_address_type(struct btd_device *device)
>> > +{
>> > +       return device->bdaddr_type;
>> > +}
>> >
>> >  const char *device_get_path(const struct btd_device *device)
>> >  {
>> >
>> > @@ -5329,6 +5358,26 @@ void device_set_legacy(struct btd_device *device,
>> > bool legacy)>
>> >                                         DEVICE_INTERFACE,
>> >                                         "LegacyPairing");
>> >
>> >  }
>> >
>> > +void device_set_svc_chng_ccc(struct btd_device *device, uint8_t
>> > addr_type,
>> > +                                                               uint16_t
>> > value) +{
>> > +       if (addr_type == BDADDR_BREDR)
>> > +               device->br_svc_cng_ccc = value;
>> > +       else
>> > +               device->le_svc_cng_ccc = value;
>> > +
>> > +       if (device_is_bonded(device, addr_type))
>> > +               store_device_info(device);
>> > +}
>> > +
>> > +uint16_t device_get_svc_chng_ccc(struct btd_device *device, uint8_t
>> > addr_type) +{
>> > +       if (addr_type == BDADDR_BREDR)
>> > +               return device->br_svc_cng_ccc;
>> > +
>> > +       return  device->le_svc_cng_ccc;
>> > +}
>> > +
>> >
>> >  void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
>> >
>> >                                                         int8_t
>> >                                                         delta_threshold)
>> >
>> >  {
>> >
>> > diff --git a/src/device.h b/src/device.h
>> > index bc046f780..4afaa9cde 100644
>> > --- a/src/device.h
>> > +++ b/src/device.h
>> > @@ -87,6 +87,7 @@ void device_probe_profile(gpointer a, gpointer b);
>> >
>> >  void device_remove_profile(gpointer a, gpointer b);
>> >  struct btd_adapter *device_get_adapter(struct btd_device *device);
>> >  const bdaddr_t *device_get_address(struct btd_device *device);
>> >
>> > +uint8_t device_get_le_address_type(struct btd_device *device);
>> >
>> >  const char *device_get_path(const struct btd_device *device);
>> >  gboolean device_is_temporary(struct btd_device *device);
>> >  bool device_is_connectable(struct btd_device *device);
>> >
>> > @@ -131,6 +132,9 @@ void device_remove_connection(struct btd_device
>> > *device, uint8_t bdaddr_type);>
>> >  void device_request_disconnect(struct btd_device *device, DBusMessage
>> >  *msg); bool device_is_disconnecting(struct btd_device *device);
>> >
>> > +void device_set_svc_chng_ccc(struct btd_device *device, uint8_t
>> > badddr_type, uint16_t value); +uint16_t device_get_svc_chng_ccc(struct
>> > btd_device *device, uint8_t badddr_type); +
>> >
>> >  typedef void (*disconnect_watch) (struct btd_device *device, gboolean
>> >  removal,>
>> >                                         void *user_data);
>> >
>> > diff --git a/src/gatt-database.c b/src/gatt-database.c
>> > index 19f03c544..f97f3caf7 100644
>> > --- a/src/gatt-database.c
>> > +++ b/src/gatt-database.c
>> > @@ -265,7 +265,7 @@ static struct ccc_state *find_ccc_state(struct
>> > device_state *dev_state,>
>> >  }
>> >
>> >  static struct device_state *device_state_create(struct btd_gatt_database
>> >  *db,>
>> > -                                                       bdaddr_t *bdaddr,
>> > +                                                       const bdaddr_t
>> > *bdaddr,>
>> >                                                         uint8_t
>> >                                                         bdaddr_type)
>> >
>> >  {
>> >
>> >         struct device_state *dev_state;
>> >
>> > @@ -950,6 +950,25 @@ service_add_ccc(struct gatt_db_attribute *service,
>> >
>> >         return ccc;
>> >
>> >  }
>> >
>> > +static uint8_t svc_chngd_ccc_write_cb(struct bt_att *att, uint16_t value,
>> > +                                                               void
>> > *user_data) +{
>> > +       struct btd_gatt_database *database = user_data;
>> > +       struct btd_device * device;
>> > +       bdaddr_t bdaddr;
>> > +       uint8_t bdaddr_type;
>> > +
>> > +       if (!get_dst_info(att, &bdaddr, &bdaddr_type))
>> > +               return 0;
>> > +
>> > +       device = btd_adapter_find_device(database->adapter, &bdaddr,
>> > +
>> > bdaddr_type); +       if (device)
>> > +               device_set_svc_chng_ccc(device, bdaddr_type, value);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> >
>> >  static void populate_gatt_service(struct btd_gatt_database *database)
>> >  {
>> >
>> >         bt_uuid_t uuid;
>> >
>> > @@ -964,8 +983,9 @@ static void populate_gatt_service(struct
>> > btd_gatt_database *database)>
>> >                                 BT_ATT_PERM_READ,
>> >                                 BT_GATT_CHRC_PROP_INDICATE,
>> >                                 NULL, NULL, database);
>> >
>> > -       database->svc_chngd_ccc = service_add_ccc(service, database, NULL,
>> > NULL, -
>> >     NULL); +       database->svc_chngd_ccc = service_add_ccc(service,
>> > database, +
>> > svc_chngd_ccc_write_cb, +
>> >       database, NULL);>
>> >         gatt_db_service_set_active(service, true);
>> >
>> >  }
>> >
>> > @@ -996,6 +1016,7 @@ static void state_set_pending(struct device_state
>> > *state, struct notify *notify)>
>> >  {
>> >
>> >         uint16_t start, end, old_start, old_end;
>> >
>> > +       /* Cache this only for Service Changed */
>> >
>> >         if (notify->conf != service_changed_conf)
>> >
>> >                 return;
>> >
>> > @@ -3175,7 +3196,6 @@ struct btd_gatt_database
>> > *btd_gatt_database_new(struct btd_adapter *adapter)>
>> >         if (!database->db_id)
>> >
>> >                 goto fail;
>> >
>> > -
>> >
>> >         return database;
>> >
>> >  fail:
>> > @@ -3224,3 +3244,75 @@ void btd_gatt_database_att_connected(struct
>> > btd_gatt_database *database,>
>> >         free(state->pending);
>> >         state->pending = NULL;
>> >
>> >  }
>> >
>> > +
>> > +static void restore_ccc(struct btd_gatt_database *database,
>> > +                       const bdaddr_t *addr, uint8_t addr_type, uint16_t
>> > value) +{
>> > +       struct device_state *dev_state;
>> > +       struct ccc_state *ccc;
>> > +
>> > +       dev_state = device_state_create(database, addr, addr_type);
>> > +       queue_push_tail(database->device_states, dev_state);
>> > +
>> > +       ccc = new0(struct ccc_state, 1);
>> > +       ccc->handle =
>> > gatt_db_attribute_get_handle(database->svc_chngd_ccc); +
>> > memcpy(ccc->value, &value, sizeof(ccc->value));
>> > +       queue_push_tail(dev_state->ccc_states, ccc);
>> > +}
>> > +
>> > +static void restore_state(struct btd_device *device, void *data)
>> > +{
>> > +       struct btd_gatt_database *database = data;
>> > +       uint16_t ccc_value;
>> > +       uint8_t addr_type;
>> > +
>> > +       addr_type = device_get_le_address_type(device);
>> > +
>> > +       if (addr_type != BDADDR_BREDR) {
>> > +               ccc_value = device_get_svc_chng_ccc(device, addr_type);
>> > +               if (ccc_value) {
>> > +                       restore_ccc(database, device_get_address(device),
>> > +                                                       addr_type,
>> > ccc_value); +                       DBG("%s LE",
>> > device_get_path(device));
>> > +               }
>> > +       }
>> > +
>> > +       ccc_value = device_get_svc_chng_ccc(device, BDADDR_BREDR);
>> > +       if (ccc_value) {
>> > +               restore_ccc(database, device_get_address(device),
>> > BDADDR_BREDR, +
>> >     ccc_value); +               DBG("%s BR/EDR",
>> > device_get_path(device));
>> > +       }
>> > +}
>> > +
>> > +void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database
>> > *database) +{
>> > +       uint8_t value[4];
>> > +       uint16_t handle, ccc_handle;
>> > +
>> > +       handle = gatt_db_attribute_get_handle(database->svc_chngd);
>> > +       ccc_handle =
>> > gatt_db_attribute_get_handle(database->svc_chngd_ccc);
>> > +
>> > +       if (!handle || !ccc_handle) {
>> > +               error("Failed to obtain handles for \"Service Changed\""
>> > +                                                       "
>> > characteristic");
>> > +               return;
>> > +       }
>> > +
>> > +       /* restore states for bonded device that registered for Service
>> > Changed +        * indication
>> > +        */
>> > +       btd_adapter_for_each_device(database->adapter, restore_state,
>> > database); +
>> > +       /* This needs to be updated (probably to 0x0001) if we ever change
>> > +        * core services
>> > +        *
>> > +        * TODO we could also store this info (along with CCC value) and
>> > be able +        * to send 0x0001-0xffff only once per device.
>> > +        */
>> > +       put_le16(0x000a, value);
>> > +       put_le16(0xffff, value + 2);
>> > +
>> > +       send_notification_to_devices(database, handle, value,
>> > sizeof(value), +                                       ccc_handle,
>> > service_changed_conf, NULL); +}
>> > diff --git a/src/gatt-database.h b/src/gatt-database.h
>> > index 0da33f604..a6c3139c4 100644
>> > --- a/src/gatt-database.h
>> > +++ b/src/gatt-database.h
>> > @@ -25,3 +25,5 @@ void btd_gatt_database_destroy(struct btd_gatt_database
>> > *database);>
>> >  struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database
>> >  *database); void btd_gatt_database_att_connected(struct
>> >  btd_gatt_database *database,>
>> >                                                 struct bt_att *att);
>> >
>> > +
>> > +void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database
>> > *database); --
>> > 2.14.3
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> > in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> pozdrawiam
> Szymon Janc
>
>



-- 
Luiz Augusto von Dentz
