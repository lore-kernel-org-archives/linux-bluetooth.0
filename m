Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418429258-32358-1-git-send-email-luiz.dentz@gmail.com>
References: <1418429258-32358-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 15 Dec 2014 12:37:52 +0200
Message-ID: <CABBYNZL0wk_+ih3qtdVCCs8t-pujJMZ2=5inGspUyPsXO-DdLw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-client: Remove unnecessary code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Dec 13, 2014 at 2:07 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This flags were added because calling function like queue_foreach were
> not safe as the callbacks may remove or destroy the queue before
> returning but this has been fixed and it is now safe to do that.
> ---
>  src/shared/att.c | 94 ++++----------------------------------------------------
>  1 file changed, 6 insertions(+), 88 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 26b6c5b..447863d 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -66,12 +66,7 @@ struct bt_att {
>         bool writer_active;
>
>         struct queue *notify_list;      /* List of registered callbacks */
> -       bool in_notify;
> -       bool need_notify_cleanup;
> -
>         struct queue *disconn_list;     /* List of disconnect handlers */
> -       bool in_disconn;
> -       bool need_disconn_cleanup;
>
>         bool in_req;                    /* There's a pending incoming request */
>
> @@ -216,7 +211,6 @@ static void cancel_att_send_op(struct att_send_op *op)
>  struct att_notify {
>         unsigned int id;
>         uint16_t opcode;
> -       bool removed;
>         bt_att_notify_func_t callback;
>         bt_att_destroy_func_t destroy;
>         void *user_data;
> @@ -240,20 +234,6 @@ static bool match_notify_id(const void *a, const void *b)
>         return notify->id == id;
>  }
>
> -static bool match_notify_removed(const void *a, const void *b)
> -{
> -       const struct att_notify *notify = a;
> -
> -       return notify->removed;
> -}
> -
> -static void mark_notify_removed(void *data, void *user_data)
> -{
> -       struct att_notify *notify = data;
> -
> -       notify->removed = true;
> -}
> -
>  struct att_disconn {
>         unsigned int id;
>         bool removed;
> @@ -280,20 +260,6 @@ static bool match_disconn_id(const void *a, const void *b)
>         return disconn->id == id;
>  }
>
> -static bool match_disconn_removed(const void *a, const void *b)
> -{
> -       const struct att_disconn *disconn = a;
> -
> -       return disconn->removed;
> -}
> -
> -static void mark_disconn_removed(void *data, void *user_data)
> -{
> -       struct att_disconn *disconn = data;
> -
> -       disconn->removed = true;
> -}
> -
>  static bool encode_pdu(struct att_send_op *op, const void *pdu,
>                                                 uint16_t length, uint16_t mtu)
>  {
> @@ -557,16 +523,7 @@ static bool disconnect_cb(struct io *io, void *user_data)
>         bt_att_cancel_all(att);
>
>         bt_att_ref(att);
> -       att->in_disconn = true;
>         queue_foreach(att->disconn_list, disconn_handler, NULL);
> -       att->in_disconn = false;
> -
> -       if (att->need_disconn_cleanup) {
> -               queue_remove_all(att->disconn_list, match_disconn_removed, NULL,
> -                                                       destroy_att_disconn);
> -               att->need_disconn_cleanup = false;
> -       }
> -
>         bt_att_unregister_all(att);
>         bt_att_unref(att);
>
> @@ -680,9 +637,6 @@ static void notify_handler(void *data, void *user_data)
>         struct att_notify *notify = data;
>         struct notify_data *not_data = user_data;
>
> -       if (notify->removed)
> -               return;
> -
>         if (!opcode_match(notify->opcode, not_data->opcode))
>                 return;
>
> @@ -712,7 +666,6 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>         struct notify_data data;
>
>         bt_att_ref(att);
> -       att->in_notify = true;
>
>         memset(&data, 0, sizeof(data));
>         data.opcode = opcode;
> @@ -724,14 +677,6 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>
>         queue_foreach(att->notify_list, notify_handler, &data);
>
> -       att->in_notify = false;
> -
> -       if (att->need_notify_cleanup) {
> -               queue_remove_all(att->notify_list, match_notify_removed, NULL,
> -                                                       destroy_att_notify);
> -               att->need_notify_cleanup = false;
> -       }
> -
>         bt_att_unref(att);
>
>         /*
> @@ -1038,15 +983,8 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id)
>         if (!disconn)
>                 return false;
>
> -       if (!att->in_disconn) {
> -               queue_remove(att->disconn_list, disconn);
> -               destroy_att_disconn(disconn);
> -               return true;
> -       }
> -
> -       disconn->removed = true;
> -       att->need_disconn_cleanup = true;
> -
> +       queue_remove(att->disconn_list, disconn);
> +       destroy_att_disconn(disconn);
>         return true;
>  }
>
> @@ -1263,15 +1201,8 @@ bool bt_att_unregister(struct bt_att *att, unsigned int id)
>         if (!notify)
>                 return false;
>
> -       if (!att->in_notify) {
> -               queue_remove(att->notify_list, notify);
> -               destroy_att_notify(notify);
> -               return true;
> -       }
> -
> -       notify->removed = true;
> -       att->need_notify_cleanup = true;
> -
> +       queue_remove(att->notify_list, notify);
> +       destroy_att_notify(notify);
>         return true;
>  }
>
> @@ -1280,21 +1211,8 @@ bool bt_att_unregister_all(struct bt_att *att)
>         if (!att)
>                 return false;
>
> -       if (att->in_notify) {
> -               queue_foreach(att->notify_list, mark_notify_removed, NULL);
> -               att->need_notify_cleanup = true;
> -       } else {
> -               queue_remove_all(att->notify_list, NULL, NULL,
> -                                                       destroy_att_notify);
> -       }
> -
> -       if (att->in_disconn) {
> -               queue_foreach(att->disconn_list, mark_disconn_removed, NULL);
> -               att->need_disconn_cleanup = true;
> -       } else {
> -               queue_remove_all(att->disconn_list, NULL, NULL,
> -                                                       destroy_att_disconn);
> -       }
> +       queue_remove_all(att->notify_list, NULL, NULL, destroy_att_notify);
> +       queue_remove_all(att->disconn_list, NULL, NULL, destroy_att_disconn);
>
>         return true;
>  }
> --
> 1.9.3

Applied.


-- 
Luiz Augusto von Dentz
