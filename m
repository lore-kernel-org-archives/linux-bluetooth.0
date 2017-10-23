Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yunhanw@nestlabs.com
In-Reply-To: <20171023111723.20729-2-luiz.dentz@gmail.com>
References: <20171023111723.20729-1-luiz.dentz@gmail.com> <20171023111723.20729-2-luiz.dentz@gmail.com>
From: Yunhan Wang <yunhanw@nestlabs.com>
Date: Mon, 23 Oct 2017 13:26:24 -0700
Message-ID: <CALvjcs9i_J5H2jbVWToQbc4xNo9+N3jxrHh3FTo7LKjRN1E=Wg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] gatt: Clear subscriptions for device not paired
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

WIth latest bluez master, I am seeing segmentation fault in bluetoothd
when ble disconnection happens. I think it related to this patch.

The backtract is as below,
#0  0x0000000000000000 in ?? ()
#1  0x0000000000481b4d in queue_foreach (queue=0x6fe4e0,
function=function@entry=0x442d40 <clear_ccc_state>,
user_data=0x6ee630) at src/shared/queue.c:220
#2  0x00000000004436c9 in att_disconnected (err=<optimized out>,
user_data=0x6fe4b0) at src/gatt-database.c:310
#3  0x0000000000481b4d in queue_foreach (queue=0x705b70,
function=function@entry=0x485280 <disconn_handler>, user_data=0x68) at
src/shared/queue.c:220
#4  0x0000000000486632 in disconnect_cb (io=<optimized out>,
user_data=0x70b140) at src/shared/att.c:590
#5  0x000000000048fbc5 in watch_callback (channel=<optimized out>,
cond=<optimized out>, user_data=<optimized out>) at
src/shared/io-glib.c:170
#6  0x00007ffff7b1ace5 in g_main_context_dispatch () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x00007ffff7b1b048 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x00007ffff7b1b30a in g_main_loop_run () from
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x000000000040b51b in main (argc=1, argv=0x7fffffffe618) at src/main.c:770

thanks
best wishes
yunhan

On Mon, Oct 23, 2017 at 4:17 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the device is no longer valid or is not considered bonded anymore
> clear its CCC states before removing otherwise application may continue
> to notify when there are no devices listening.
> ---
>  src/gatt-database.c | 155 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 103 insertions(+), 52 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 47304704a..6784998c3 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -150,8 +150,10 @@ struct pending_op {
>  };
>
>  struct device_state {
> +       struct btd_gatt_database *db;
>         bdaddr_t bdaddr;
>         uint8_t bdaddr_type;
> +       unsigned int disc_id;
>         struct queue *ccc_states;
>  };
>
> @@ -245,12 +247,14 @@ static struct ccc_state *find_ccc_state(struct device_state *dev_state,
>                                                         UINT_TO_PTR(handle));
>  }
>
> -static struct device_state *device_state_create(bdaddr_t *bdaddr,
> +static struct device_state *device_state_create(struct btd_gatt_database *db,
> +                                                       bdaddr_t *bdaddr,
>                                                         uint8_t bdaddr_type)
>  {
>         struct device_state *dev_state;
>
>         dev_state = new0(struct device_state, 1);
> +       dev_state->db = db;
>         dev_state->ccc_states = queue_new();
>         bacpy(&dev_state->bdaddr, bdaddr);
>         dev_state->bdaddr_type = bdaddr_type;
> @@ -258,36 +262,117 @@ static struct device_state *device_state_create(bdaddr_t *bdaddr,
>         return dev_state;
>  }
>
> +static void device_state_free(void *data)
> +{
> +       struct device_state *state = data;
> +
> +       queue_destroy(state->ccc_states, free);
> +       free(state);
> +}
> +
> +static void clear_ccc_state(void *data, void *user_data)
> +{
> +       struct ccc_state *ccc = data;
> +       struct btd_gatt_database *db = user_data;
> +       struct ccc_cb_data *ccc_cb;
> +
> +       if (!ccc->value[0])
> +               return;
> +
> +       ccc_cb = queue_find(db->ccc_callbacks, ccc_cb_match_handle,
> +                                               UINT_TO_PTR(ccc->handle));
> +       if (!ccc_cb)
> +               return;
> +
> +       ccc_cb->callback(NULL, 0, ccc_cb->user_data);
> +}
> +
> +static void att_disconnected(int err, void *user_data)
> +{
> +       struct device_state *state = user_data;
> +       struct btd_device *device;
> +
> +       DBG("");
> +
> +       state->disc_id = 0;
> +
> +       device = btd_adapter_get_device(state->db->adapter, &state->bdaddr,
> +                                       state->bdaddr_type);
> +       if (!device)
> +               goto remove;
> +
> +       if (device_is_paired(device, state->bdaddr_type))
> +               return;
> +
> +remove:
> +       /* Remove device state if device no longer exists or is not paired */
> +       if (queue_remove(state->db->device_states, state)) {
> +               queue_foreach(state->ccc_states, clear_ccc_state, state->db);
> +               device_state_free(state);
> +       }
> +}
> +
> +static bool get_dst_info(struct bt_att *att, bdaddr_t *dst, uint8_t *dst_type)
> +{
> +       GIOChannel *io = NULL;
> +       GError *gerr = NULL;
> +
> +       io = g_io_channel_unix_new(bt_att_get_fd(att));
> +       if (!io)
> +               return false;
> +
> +       bt_io_get(io, &gerr, BT_IO_OPT_DEST_BDADDR, dst,
> +                                               BT_IO_OPT_DEST_TYPE, dst_type,
> +                                               BT_IO_OPT_INVALID);
> +       if (gerr) {
> +               error("gatt: bt_io_get: %s", gerr->message);
> +               g_error_free(gerr);
> +               g_io_channel_unref(io);
> +               return false;
> +       }
> +
> +       g_io_channel_unref(io);
> +       return true;
> +}
> +
>  static struct device_state *get_device_state(struct btd_gatt_database *database,
> -                                                       bdaddr_t *bdaddr,
> -                                                       uint8_t bdaddr_type)
> +                                               struct bt_att *att)
>  {
>         struct device_state *dev_state;
> +       bdaddr_t bdaddr;
> +       uint8_t bdaddr_type;
> +
> +       if (!get_dst_info(att, &bdaddr, &bdaddr_type))
> +               return NULL;
>
>         /*
>          * Find and return a device state. If a matching state doesn't exist,
>          * then create a new one.
>          */
> -       dev_state = find_device_state(database, bdaddr, bdaddr_type);
> +       dev_state = find_device_state(database, &bdaddr, bdaddr_type);
>         if (dev_state)
> -               return dev_state;
> +               goto done;
>
> -       dev_state = device_state_create(bdaddr, bdaddr_type);
> +       dev_state = device_state_create(database, &bdaddr, bdaddr_type);
>
>         queue_push_tail(database->device_states, dev_state);
>
> +done:
> +       dev_state->disc_id = bt_att_register_disconnect(att, att_disconnected,
> +                                                       dev_state, NULL);
> +
>         return dev_state;
>  }
>
>  static struct ccc_state *get_ccc_state(struct btd_gatt_database *database,
> -                                                       bdaddr_t *bdaddr,
> -                                                       uint8_t bdaddr_type,
> -                                                       uint16_t handle)
> +                                       struct bt_att *att, uint16_t handle)
>  {
>         struct device_state *dev_state;
>         struct ccc_state *ccc;
>
> -       dev_state = get_device_state(database, bdaddr, bdaddr_type);
> +       dev_state = get_device_state(database, att);
> +       if (!dev_state)
> +               return NULL;
>
>         ccc = find_ccc_state(dev_state, handle);
>         if (ccc)
> @@ -300,14 +385,6 @@ static struct ccc_state *get_ccc_state(struct btd_gatt_database *database,
>         return ccc;
>  }
>
> -static void device_state_free(void *data)
> -{
> -       struct device_state *state = data;
> -
> -       queue_destroy(state->ccc_states, free);
> -       free(state);
> -}
> -
>  static void cancel_pending_read(void *data)
>  {
>         struct pending_op *op = data;
> @@ -690,29 +767,6 @@ static void populate_gap_service(struct btd_gatt_database *database)
>         gatt_db_service_set_active(service, true);
>  }
>
> -static bool get_dst_info(struct bt_att *att, bdaddr_t *dst, uint8_t *dst_type)
> -{
> -       GIOChannel *io = NULL;
> -       GError *gerr = NULL;
> -
> -       io = g_io_channel_unix_new(bt_att_get_fd(att));
> -       if (!io)
> -               return false;
> -
> -       bt_io_get(io, &gerr, BT_IO_OPT_DEST_BDADDR, dst,
> -                                               BT_IO_OPT_DEST_TYPE, dst_type,
> -                                               BT_IO_OPT_INVALID);
> -       if (gerr) {
> -               error("gatt: bt_io_get: %s", gerr->message);
> -               g_error_free(gerr);
> -               g_io_channel_unref(io);
> -               return false;
> -       }
> -
> -       g_io_channel_unref(io);
> -       return true;
> -}
> -
>  static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
>                                         unsigned int id, uint16_t offset,
>                                         uint8_t opcode, struct bt_att *att,
> @@ -724,8 +778,6 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
>         uint8_t ecode = 0;
>         const uint8_t *value = NULL;
>         size_t len = 0;
> -       bdaddr_t bdaddr;
> -       uint8_t bdaddr_type;
>
>         handle = gatt_db_attribute_get_handle(attrib);
>
> @@ -736,13 +788,12 @@ static void gatt_ccc_read_cb(struct gatt_db_attribute *attrib,
>                 goto done;
>         }
>
> -       if (!get_dst_info(att, &bdaddr, &bdaddr_type)) {
> +       ccc = get_ccc_state(database, att, handle);
> +       if (!ccc) {
>                 ecode = BT_ATT_ERROR_UNLIKELY;
>                 goto done;
>         }
>
> -       ccc = get_ccc_state(database, &bdaddr, bdaddr_type, handle);
> -
>         len = 2 - offset;
>         value = len ? &ccc->value[offset] : NULL;
>
> @@ -761,8 +812,6 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
>         struct ccc_cb_data *ccc_cb;
>         uint16_t handle;
>         uint8_t ecode = 0;
> -       bdaddr_t bdaddr;
> -       uint8_t bdaddr_type;
>
>         handle = gatt_db_attribute_get_handle(attrib);
>
> @@ -778,13 +827,12 @@ static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
>                 goto done;
>         }
>
> -       if (!get_dst_info(att, &bdaddr, &bdaddr_type)) {
> +       ccc = get_ccc_state(database, att, handle);
> +       if (!ccc) {
>                 ecode = BT_ATT_ERROR_UNLIKELY;
>                 goto done;
>         }
>
> -       ccc = get_ccc_state(database, &bdaddr, bdaddr_type, handle);
> -
>         ccc_cb = queue_find(database->ccc_callbacks, ccc_cb_match_handle,
>                         UINT_TO_PTR(gatt_db_attribute_get_handle(attrib)));
>         if (!ccc_cb) {
> @@ -940,8 +988,11 @@ static void send_notification_to_device(void *data, void *user_data)
>
>  remove:
>         /* Remove device state if device no longer exists or is not paired */
> -       if (queue_remove(notify->database->device_states, device_state))
> +       if (queue_remove(notify->database->device_states, device_state)) {
> +               queue_foreach(device_state->ccc_states, clear_ccc_state,
> +                                               notify->database);
>                 device_state_free(device_state);
> +       }
>  }
>
>  static void send_notification_to_devices(struct btd_gatt_database *database,
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
