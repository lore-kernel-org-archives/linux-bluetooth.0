Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413234602-20566-2-git-send-email-armansito@chromium.org>
References: <1413234602-20566-1-git-send-email-armansito@chromium.org>
	<1413234602-20566-2-git-send-email-armansito@chromium.org>
Date: Tue, 14 Oct 2014 13:37:14 +0300
Message-ID: <CABBYNZLYLDmjM0h2C9-sYOAxsRt4usdgr323bVmj=rF8byvjEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] shared/att: Drop the connection if a request is
 received while one is pending.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Oct 14, 2014 at 12:09 AM, Arman Uguray <armansito@chromium.org> wrote:
> With this patch, when bt_att is being used for the server role, it now makes
> sure that a second request drops the connection unless a response for a previous
> request has been sent.
> ---
>  src/shared/att.c | 101 +++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 61 insertions(+), 40 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index de35aef..96f34a3 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -64,6 +64,8 @@ struct bt_att {
>         bool in_disconn;
>         bool need_disconn_cleanup;
>
> +       bool in_req;                    /* There's a pending incoming request */
> +
>         uint8_t *buf;
>         uint16_t mtu;
>
> @@ -460,6 +462,9 @@ static bool can_write_data(struct io *io, void *user_data)
>         case ATT_OP_TYPE_IND:
>                 att->pending_ind = op;
>                 break;
> +       case ATT_OP_TYPE_RSP:
> +               /* Set in_req to false to indicate that no request is pending */
> +               att->in_req = false;
>         default:
>                 destroy_att_send_op(op);
>                 return true;
> @@ -604,6 +609,46 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>         bt_att_unref(att);
>  }
>
> +static void disconn_handler(void *data, void *user_data)
> +{
> +       struct att_disconn *disconn = data;
> +
> +       if (disconn->removed)
> +               return;
> +
> +       if (disconn->callback)
> +               disconn->callback(disconn->user_data);
> +}
> +
> +static bool disconnect_cb(struct io *io, void *user_data)
> +{
> +       struct bt_att *att = user_data;
> +
> +       io_destroy(att->io);
> +       att->io = NULL;
> +
> +       util_debug(att->debug_callback, att->debug_data,
> +                                               "Physical link disconnected");
> +
> +       bt_att_ref(att);
> +       att->in_disconn = true;
> +       queue_foreach(att->disconn_list, disconn_handler, NULL);
> +       att->in_disconn = false;
> +
> +       if (att->need_disconn_cleanup) {
> +               queue_remove_all(att->disconn_list, match_disconn_removed, NULL,
> +                                                       destroy_att_disconn);
> +               att->need_disconn_cleanup = false;
> +       }
> +
> +       bt_att_cancel_all(att);
> +       bt_att_unregister_all(att);
> +
> +       bt_att_unref(att);
> +
> +       return false;
> +}
> +
>  static bool can_read_data(struct io *io, void *user_data)
>  {
>         struct bt_att *att = user_data;
> @@ -635,6 +680,22 @@ static bool can_read_data(struct io *io, void *user_data)
>                 util_debug(att->debug_callback, att->debug_data,
>                                 "ATT opcode cannot be handled: 0x%02x", opcode);
>                 break;
> +       case ATT_OP_TYPE_REQ:
> +               /* If a request is currently pending, then the sequential
> +                * protocol was violated. Disconnect the bearer and notify the
> +                * upper-layer.
> +                */

It seems this code is not following our coding style regarding multi
line comments, check doc/coding-style.txt(M2: Multiple line comment)
the first line should be empty.

> +               if (att->in_req) {
> +                       util_debug(att->debug_callback, att->debug_data,
> +                                       "Received request while another is "
> +                                       "pending: 0x%02x", opcode);
> +                       disconnect_cb(att->io, att);
> +                       return false;
> +               }
> +
> +               att->in_req = true;
> +
> +               /* Fall through to the next case */

This might cause a problem with our own code when connecting to each
other if bt_att_cancel is used, apparently bt_att_cancel does not send
anything to the remote side which seems to enable sending a new
request without waiting any response for the first one.

>         default:
>                 /* For all other opcodes notify the upper layer of the PDU and
>                  * let them act on it.
> @@ -648,46 +709,6 @@ static bool can_read_data(struct io *io, void *user_data)
>         return true;
>  }
>
> -static void disconn_handler(void *data, void *user_data)
> -{
> -       struct att_disconn *disconn = data;
> -
> -       if (disconn->removed)
> -               return;
> -
> -       if (disconn->callback)
> -               disconn->callback(disconn->user_data);
> -}
> -
> -static bool disconnect_cb(struct io *io, void *user_data)
> -{
> -       struct bt_att *att = user_data;
> -
> -       io_destroy(att->io);
> -       att->io = NULL;
> -
> -       util_debug(att->debug_callback, att->debug_data,
> -                                               "Physical link disconnected");
> -
> -       bt_att_ref(att);
> -       att->in_disconn = true;
> -       queue_foreach(att->disconn_list, disconn_handler, NULL);
> -       att->in_disconn = false;
> -
> -       if (att->need_disconn_cleanup) {
> -               queue_remove_all(att->disconn_list, match_disconn_removed, NULL,
> -                                                       destroy_att_disconn);
> -               att->need_disconn_cleanup = false;
> -       }
> -
> -       bt_att_cancel_all(att);
> -       bt_att_unregister_all(att);
> -
> -       bt_att_unref(att);
> -
> -       return false;
> -}
> -
>  struct bt_att *bt_att_new(int fd)
>  {
>         struct bt_att *att;
> --
> 2.1.0.rc2.206.gedb03e5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
