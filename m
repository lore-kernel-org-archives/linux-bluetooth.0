Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418645599-20169-1-git-send-email-luiz.dentz@gmail.com>
References: <1418645599-20169-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 16 Dec 2014 14:28:34 +0200
Message-ID: <CABBYNZL1G2LgNFfYxcX5pR=cmdA3XBLqb97bSgSHhmieKsfTJw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/att: Use queue_remove_if
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 15, 2014 at 2:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This make use of queue_remove_if instead of queue_find + queue_remove
> whenever possible.
> ---
>  src/shared/att.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 447863d..ba3d204 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -978,12 +978,11 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id)
>         if (!att || !id)
>                 return false;
>
> -       disconn = queue_find(att->disconn_list, match_disconn_id,
> +       disconn = queue_remove_if(att->disconn_list, match_disconn_id,
>                                                         UINT_TO_PTR(id));
>         if (!disconn)
>                 return false;
>
> -       queue_remove(att->disconn_list, disconn);
>         destroy_att_disconn(disconn);
>         return true;
>  }
> @@ -1196,12 +1195,11 @@ bool bt_att_unregister(struct bt_att *att, unsigned int id)
>         if (!att || !id)
>                 return false;
>
> -       notify = queue_find(att->notify_list, match_notify_id,
> +       notify = queue_remove_if(att->notify_list, match_notify_id,
>                                                         UINT_TO_PTR(id));
>         if (!notify)
>                 return false;
>
> -       queue_remove(att->notify_list, notify);
>         destroy_att_notify(notify);
>         return true;
>  }
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz
