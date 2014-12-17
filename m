Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418741945-6012-1-git-send-email-szymon.janc@tieto.com>
References: <1418741945-6012-1-git-send-email-szymon.janc@tieto.com>
Date: Wed, 17 Dec 2014 03:23:33 +0200
Message-ID: <CABBYNZJijS2i7WK980GrdC8SYAH1tE6FfycZ2b14W10Bbu17MA@mail.gmail.com>
Subject: Re: [PATCH] shared/att: Remove not needed NULL assignments
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Dec 16, 2014 at 4:59 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> There is no need to NULL memebers in bt_att_unref casue att if freed
> at the end of function.
> ---
>  src/shared/att.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 956fa8c..08bf2b2 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -860,17 +860,12 @@ void bt_att_unref(struct bt_att *att)
>                 destroy_att_send_op(att->pending_ind);
>
>         io_destroy(att->io);
> -       att->io = NULL;
>
>         queue_destroy(att->req_queue, NULL);
>         queue_destroy(att->ind_queue, NULL);
>         queue_destroy(att->write_queue, NULL);
>         queue_destroy(att->notify_list, NULL);
>         queue_destroy(att->disconn_list, NULL);
> -       att->req_queue = NULL;
> -       att->ind_queue = NULL;
> -       att->write_queue = NULL;
> -       att->notify_list = NULL;
>
>         if (att->timeout_destroy)
>                 att->timeout_destroy(att->timeout_data);
> @@ -879,7 +874,6 @@ void bt_att_unref(struct bt_att *att)
>                 att->debug_destroy(att->debug_data);
>
>         free(att->buf);
> -       att->buf = NULL;
>
>         free(att);
>  }
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
