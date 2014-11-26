Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416979609-3056-3-git-send-email-armansito@chromium.org>
References: <1416979609-3056-1-git-send-email-armansito@chromium.org>
	<1416979609-3056-3-git-send-email-armansito@chromium.org>
Date: Wed, 26 Nov 2014 12:15:06 +0200
Message-ID: <CABBYNZLgGEn6xjNdamNikOELdXU1mM9HZ-VPm5v+ZQJsN4UPjw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/5] shared: Add function to insert element after entry
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Nov 26, 2014 at 7:26 AM, Arman Uguray <armansito@chromium.org> wrote:
> This patch adds queue_insert_after, which inserts the given "data"
> after the first occurence of element "entry" in a queue.
> ---
>  src/shared/queue.c | 30 ++++++++++++++++++++++++++++++
>  src/shared/queue.h |  1 +
>  2 files changed, 31 insertions(+)
>
> diff --git a/src/shared/queue.c b/src/shared/queue.c
> index 5329a80..1373d0d 100644
> --- a/src/shared/queue.c
> +++ b/src/shared/queue.c
> @@ -134,6 +134,36 @@ bool queue_push_head(struct queue *queue, void *data)
>         return true;
>  }
>
> +bool queue_insert_after(struct queue *queue, void *entry, void *data)
> +{
> +       struct queue_entry *qentry = NULL, *tmp, *new_entry;
> +
> +       if (!queue)
> +               return false;
> +
> +       for (tmp = queue->head; tmp; tmp = tmp->next)
> +               if (tmp->data == entry)
> +                       qentry = tmp;
> +
> +       if (!qentry)
> +               return false;
> +
> +       new_entry = new0(struct queue_entry, 1);
> +       if (!new_entry)
> +               return false;
> +
> +       new_entry->data = data;
> +       new_entry->next = qentry->next;
> +
> +       if (!qentry->next)
> +               queue->tail = new_entry;
> +
> +       qentry->next = new_entry;
> +       queue->entries++;
> +
> +       return true;
> +}
> +
>  void *queue_pop_head(struct queue *queue)
>  {
>         struct queue_entry *entry;
> diff --git a/src/shared/queue.h b/src/shared/queue.h
> index 709590b..6ddc889 100644
> --- a/src/shared/queue.h
> +++ b/src/shared/queue.h
> @@ -32,6 +32,7 @@ void queue_destroy(struct queue *queue, queue_destroy_func_t destroy);
>
>  bool queue_push_tail(struct queue *queue, void *data);
>  bool queue_push_head(struct queue *queue, void *data);
> +bool queue_insert_after(struct queue *queue, void *entry, void *data);

I guess naming it queue_push_after would be better here.

>  void *queue_pop_head(struct queue *queue);
>  void *queue_peek_head(struct queue *queue);
>  void *queue_peek_tail(struct queue *queue);
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
