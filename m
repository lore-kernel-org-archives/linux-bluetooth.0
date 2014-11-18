Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416235257-12804-1-git-send-email-luiz.dentz@gmail.com>
References: <1416235257-12804-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 18 Nov 2014 16:36:34 +0200
Message-ID: <CABBYNZJi9zoVW-nYeNh19JYLALdwGLUqx61zqqts6G1iChAc-g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/queue: Simplify queue_remove_all
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 17, 2014 at 4:40 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of queue_remove_if if possible.
> ---
>  src/shared/queue.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/src/shared/queue.c b/src/shared/queue.c
> index 3ca3ca6..6bfe995 100644
> --- a/src/shared/queue.c
> +++ b/src/shared/queue.c
> @@ -312,31 +312,19 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
>         entry = queue->head;
>
>         if (function) {
> -               struct queue_entry *prev = NULL;
> -
>                 while (entry) {
> -                       if (function(entry->data, user_data)) {
> -                               struct queue_entry *tmp = entry;
> -
> -                               if (prev)
> -                                       prev->next = entry->next;
> -                               else
> -                                       queue->head = entry->next;
> -
> -                               if (!entry->next)
> -                                       queue->tail = prev;
> +                       void *data;
>
> +                       data = queue_remove_if(queue, function, user_data);
> +                       if (data) {
>                                 entry = entry->next;
>
>                                 if (destroy)
> -                                       destroy(tmp->data);
> +                                       destroy(data);
>
> -                               free(tmp);
>                                 count++;
> -                       } else {
> -                               prev = entry;
> +                       } else
>                                 entry = entry->next;
> -                       }
>                 }
>
>                 queue->entries -= count;
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
