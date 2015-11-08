Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1446635058-14865-1-git-send-email-luiz.dentz@gmail.com>
References: <1446635058-14865-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 8 Nov 2015 21:20:02 +0200
Message-ID: <CABBYNZ+SY=Unoaiy=opH5HS-P3dZjTj6k6w74wgd6RoNdefrHA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/queue: Remove reference count from queue_entry
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 4, 2015 at 1:04 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Since the queue itself has support for reference and queue_foreach
> actually make use of it to prevent crashes when queue_destroy is
> called from the callback.
>
> Note: The intention of reference count was to protect the entry itself
> in queue_foreach, it may still be possible to have a crash if the next
> entry if freed but that should be considered an implementation bug.
> ---
>  src/shared/queue.c | 36 ++++++------------------------------
>  src/shared/queue.h |  1 -
>  2 files changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/src/shared/queue.c b/src/shared/queue.c
> index 1a2ffc8..5ddb832 100644
> --- a/src/shared/queue.c
> +++ b/src/shared/queue.c
> @@ -75,24 +75,6 @@ void queue_destroy(struct queue *queue, queue_destroy_func_t destroy)
>         queue_unref(queue);
>  }
>
> -static struct queue_entry *queue_entry_ref(struct queue_entry *entry)
> -{
> -       if (!entry)
> -               return NULL;
> -
> -       __sync_fetch_and_add(&entry->ref_count, 1);
> -
> -       return entry;
> -}
> -
> -static void queue_entry_unref(struct queue_entry *entry)
> -{
> -       if (__sync_sub_and_fetch(&entry->ref_count, 1))
> -               return;
> -
> -       free(entry);
> -}
> -
>  static struct queue_entry *queue_entry_new(void *data)
>  {
>         struct queue_entry *entry;
> @@ -100,7 +82,7 @@ static struct queue_entry *queue_entry_new(void *data)
>         entry = new0(struct queue_entry, 1);
>         entry->data = data;
>
> -       return queue_entry_ref(entry);
> +       return entry;
>  }
>
>  bool queue_push_tail(struct queue *queue, void *data)
> @@ -196,7 +178,7 @@ void *queue_pop_head(struct queue *queue)
>
>         data = entry->data;
>
> -       queue_entry_unref(entry);
> +       free(entry);
>         queue->entries--;
>
>         return data;
> @@ -234,14 +216,8 @@ void queue_foreach(struct queue *queue, queue_foreach_func_t function,
>         while (entry && queue->head && queue->ref_count > 1) {
>                 struct queue_entry *next;
>
> -               queue_entry_ref(entry);
> -
> -               function(entry->data, user_data);
> -
>                 next = entry->next;
> -
> -               queue_entry_unref(entry);
> -
> +               function(entry->data, user_data);
>                 entry = next;
>         }
>         queue_unref(queue);
> @@ -290,7 +266,7 @@ bool queue_remove(struct queue *queue, void *data)
>                 if (!entry->next)
>                         queue->tail = prev;
>
> -               queue_entry_unref(entry);
> +               free(entry);
>                 queue->entries--;
>
>                 return true;
> @@ -323,7 +299,7 @@ void *queue_remove_if(struct queue *queue, queue_match_func_t function,
>
>                         data = entry->data;
>
> -                       queue_entry_unref(entry);
> +                       free(entry);
>                         queue->entries--;
>
>                         return data;
> @@ -374,7 +350,7 @@ unsigned int queue_remove_all(struct queue *queue, queue_match_func_t function,
>                         if (destroy)
>                                 destroy(tmp->data);
>
> -                       queue_entry_unref(tmp);
> +                       free(tmp);
>                         count++;
>                 }
>         }
> diff --git a/src/shared/queue.h b/src/shared/queue.h
> index 3bc8d2e..8cd817c 100644
> --- a/src/shared/queue.h
> +++ b/src/shared/queue.h
> @@ -28,7 +28,6 @@ typedef void (*queue_destroy_func_t)(void *data);
>  struct queue;
>
>  struct queue_entry {
> -       int ref_count;
>         void *data;
>         struct queue_entry *next;
>  };
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
