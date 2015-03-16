Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5506F29B.20902@ubnt.com>
References: <5506F29B.20902@ubnt.com>
Date: Mon, 16 Mar 2015 08:23:02 -0700
Message-ID: <CAHrH25Q4DqvsTOi1YZOS3=r40YSRJdXz3cPdreU9Kb06pUY2EQ@mail.gmail.com>
Subject: Re: [PATCH] Honor offset when reading external chrc.
From: Arman Uguray <armansito@chromium.org>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

> On Mon, Mar 16, 2015 at 8:11 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
> Honor offset when reading external characteristics via D-Bus and respond with properly chunked data.
> ---

The subject should contain "core/gatt: " as its prefix, at least
that's how we've been organizing patches to different parts of the
code.

Also, a similar problem may also exist with WriteValue but we may not
be able to fully address it without an API change.

>  src/gatt-database.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index e07c70f..3ae2f62 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -119,6 +119,7 @@ struct pending_op {
>         struct gatt_db_attribute *attrib;
>         struct queue *owner_queue;
>         struct iovec data;
> +       uint16_t offset;
>  };
>
>  struct device_state {
> @@ -1446,6 +1447,19 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
>                 goto done;
>         }
>
> +       if (op->offset > len) {
> +               ecode = BT_ATT_ERROR_INVALID_OFFSET;
> +               value = NULL;
> +               len = 0;
> +               goto done;
> +       } else if (op->offset == len) {

No need for the else statement since the previous if-body ends in a goto.

> +               value = NULL;
> +               len = 0;
> +       } else {
> +               len -= op->offset;
> +               value = &value[op->offset];
> +       }

The above code is a bit redundant since we already do the NULL
assignment below. Basically, all you should need to do is this:

       if (op->offset > len) {
               ecode = BT_ATT_ERROR_INVALID_OFFSET;
               value = NULL;
               len = 0;
               goto done;
       }

       len -= op->offset;

       /* Truncate the value if it's too large */
       len = MIN(BT_ATT_MAX_VALUE_LEN, len);
       value = len ? &value[op->offset] : NULL;

If len == op->offset, len will end up with 0 as its value and since
you already handle the offset being larger than len above, this won't
cause an overflow.

> +
>         /* Truncate the value if it's too large */
>         len = MIN(BT_ATT_MAX_VALUE_LEN, len);
>         value = len ? value : NULL;
> @@ -1466,7 +1480,7 @@ static void pending_op_free(void *data)
>
>  static struct pending_op *pending_read_new(struct queue *owner_queue,
>                                         struct gatt_db_attribute *attrib,
> -                                       unsigned int id)
> +                                       unsigned int id, uint16_t offset)
>  {
>         struct pending_op *op;
>
> @@ -1477,6 +1491,7 @@ static struct pending_op *pending_read_new(struct queue *owner_queue,
>         op->owner_queue = owner_queue;
>         op->attrib = attrib;
>         op->id = id;
> +       op->offset = offset;
>         queue_push_tail(owner_queue, op);
>
>         return op;
> @@ -1484,12 +1499,12 @@ static struct pending_op *pending_read_new(struct queue *owner_queue,
>
>  static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
>                                                 struct queue *owner_queue,
> -                                               unsigned int id)
> +                                               unsigned int id, uint16_t offset)
>  {
>         struct pending_op *op;
>         uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
>
> -       op = pending_read_new(owner_queue, attrib, id);
> +       op = pending_read_new(owner_queue, attrib, id, offset);
>         if (!op) {
>                 error("Failed to allocate memory for pending read call");
>                 ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
> @@ -1785,7 +1800,7 @@ static void desc_read_cb(struct gatt_db_attribute *attrib,
>                 return;
>         }
>
> -       send_read(attrib, desc->proxy, desc->pending_reads, id);
> +       send_read(attrib, desc->proxy, desc->pending_reads, id, offset);
>  }
>
>  static void desc_write_cb(struct gatt_db_attribute *attrib,
> @@ -1843,7 +1858,7 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
>                 return;
>         }
>
> -       send_read(attrib, chrc->proxy, chrc->pending_reads, id);
> +       send_read(attrib, chrc->proxy, chrc->pending_reads, id, offset);
>  }
>
>  static void chrc_write_cb(struct gatt_db_attribute *attrib,
> --
> 1.9.1
>

Thanks,
Arman
