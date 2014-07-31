Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406644169-31298-1-git-send-email-luiz.dentz@gmail.com>
References: <1406644169-31298-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 31 Jul 2014 11:18:48 +0300
Message-ID: <CABBYNZK9046moHEjj-m+BA_RYqnDzbqDEkiALUUkSy4VYi5dpQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/queue: Fix not allowing to remove NULL entries
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 29, 2014 at 5:29 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> queue_remove should not check the data pointer since both queue_push_head
> and queue_push_tail don't check it is possible to have NULL pointers in
> the queue therefore queue_remove shall be able to remove them.
> ---
>  src/shared/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/queue.c b/src/shared/queue.c
> index 3bdc1ec..3ca3ca6 100644
> --- a/src/shared/queue.c
> +++ b/src/shared/queue.c
> @@ -238,7 +238,7 @@ bool queue_remove(struct queue *queue, void *data)
>  {
>         struct queue_entry *entry, *prev;
>
> -       if (!queue || !data)
> +       if (!queue)
>                 return false;
>
>         for (entry = queue->head, prev = NULL; entry;
> --
> 1.9.3

Applied.


-- 
Luiz Augusto von Dentz
