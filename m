Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161216131853.2815-1-luiz.dentz@gmail.com>
References: <20161216131853.2815-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Dec 2016 11:58:05 +0200
Message-ID: <CABBYNZ+fSqhGEzQvtGkmohW1nEKp61a0733kNbMbCunQ9U4QCw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/gatt-database: Send offset if set to ReadValue
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 16, 2016 at 3:18 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If there remote is using Read Blob command as part of a Read Long
> procedure the offset needs to be set in order for the application to
> detect from where it shall start.
>
> Note that with this it is also possible to detect what the chunk sizes
> needs to be as the first offset indicates the maximum payload.
> ---
>  src/gatt-database.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 7b3ec16..88627ac 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -138,6 +138,7 @@ struct external_desc {
>  struct pending_op {
>         struct btd_device *device;
>         unsigned int id;
> +       uint16_t offset;
>         struct gatt_db_attribute *attrib;
>         struct queue *owner_queue;
>         struct iovec data;
> @@ -1605,7 +1606,7 @@ static void pending_op_free(void *data)
>  static struct pending_op *pending_read_new(struct btd_device *device,
>                                         struct queue *owner_queue,
>                                         struct gatt_db_attribute *attrib,
> -                                       unsigned int id)
> +                                       unsigned int id, uint16_t offset)
>  {
>         struct pending_op *op;
>
> @@ -1615,6 +1616,7 @@ static struct pending_op *pending_read_new(struct btd_device *device,
>         op->device = device;
>         op->attrib = attrib;
>         op->id = id;
> +       op->offset = offset;
>         queue_push_tail(owner_queue, op);
>
>         return op;
> @@ -1626,6 +1628,9 @@ static void append_options(DBusMessageIter *iter, void *user_data)
>         const char *path = device_get_path(op->device);
>
>         dict_append_entry(iter, "device", DBUS_TYPE_OBJECT_PATH, &path);
> +       if (op->offset)
> +               dict_append_entry(iter, "offset", DBUS_TYPE_UINT16,
> +                                                       &op->offset);
>  }
>
>  static void read_setup_cb(DBusMessageIter *iter, void *user_data)
> @@ -1649,11 +1654,12 @@ static struct pending_op *send_read(struct btd_device *device,
>                                         struct gatt_db_attribute *attrib,
>                                         GDBusProxy *proxy,
>                                         struct queue *owner_queue,
> -                                       unsigned int id)
> +                                       unsigned int id,
> +                                       uint16_t offset)
>  {
>         struct pending_op *op;
>
> -       op = pending_read_new(device, owner_queue, attrib, id);
> +       op = pending_read_new(device, owner_queue, attrib, id, offset);
>
>         if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup_cb,
>                                 read_reply_cb, op, pending_op_free) == TRUE)
> @@ -1974,7 +1980,8 @@ static void desc_read_cb(struct gatt_db_attribute *attrib,
>                 goto fail;
>         }
>
> -       if (send_read(device, attrib, desc->proxy, desc->pending_reads, id))
> +       if (send_read(device, attrib, desc->proxy, desc->pending_reads, id,
> +                                                               offset))
>                 return;
>
>  fail:
> @@ -2054,7 +2061,8 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
>                 goto fail;
>         }
>
> -       if (send_read(device, attrib, chrc->proxy, chrc->pending_reads, id))
> +       if (send_read(device, attrib, chrc->proxy, chrc->pending_reads, id,
> +                                                               offset))
>                 return;
>
>  fail:
> --
> 2.9.3

Applied.


-- 
Luiz Augusto von Dentz
