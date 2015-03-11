Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <550043CD.7080202@ubnt.com>
References: <550043CD.7080202@ubnt.com>
Date: Wed, 11 Mar 2015 16:06:59 +0200
Message-ID: <CABBYNZLW19LcNQerGUa+U0DTn26HR9LpMqi2=RcPHwiFCHbC9g@mail.gmail.com>
Subject: Re: [PATCH] core/gatt-database: Fix memory corruption
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Wed, Mar 11, 2015 at 3:31 PM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
> Pointer to on-stack variable was returned from pending_write_new
> ---
>  src/gatt-database.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 35f8471..c0135b6 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1461,6 +1461,7 @@ static void pending_op_free(void *data)
>         if (op->owner_queue)
>                 queue_remove(op->owner_queue, op);
>
> +       free(op->setup_data);
>         free(op);
>  }
>
> @@ -1561,19 +1562,24 @@ static struct pending_op *pending_write_new(struct queue *owner_queue,
>                                         size_t len)
>  {
>         struct pending_op *op;
> -       struct iovec iov;
> +       struct iovec* iov;
>
>         op = new0(struct pending_op, 1);
>         if (!op)
>                 return NULL;
> +       iov = new0(struct iovec, 1);
> +       if (!iov) {
> +               free(op);
> +               return NULL;
> +       }

I guess we can eliminate the allocation and have the iov declared as
part of pending_op as setup_data, btw even though this is pretty
obvious fix Id include a backtrace whenever possible.

> -       iov.iov_base = (uint8_t *) value;
> -       iov.iov_len = len;
> +       iov->iov_base = (uint8_t *) value;
> +       iov->iov_len = len;
>
>         op->owner_queue = owner_queue;
>         op->attrib = attrib;
>         op->id = id;
> -       op->setup_data = &iov;
> +       op->setup_data = iov;
>         queue_push_tail(owner_queue, op);
>
>         return op;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
